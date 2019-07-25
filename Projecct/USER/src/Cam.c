#include "Cam.h"

#include "math.h"

#define GrayScale  255
#define WID 128
#define LEN 64

#define REDSCALE_LOW 15
#define REDSCALE_HIGH 19
#define BLUESCALE_LOW 20
#define BLUESCALE_HIGH 25
#define WHITESCALE 80

int image_threshold = 110;  //图像阈值

uint8 dis_image[64][128];

int white_len_tune;
int last_miss;
int first_or_second=0;
int begin_line_state=0;
int first_time_begin=0;

void otsuThreshold(uint8 *image, uint16 col, uint16 row)
{
    uint16 width = col;
    uint16 height = row;
    int pixelCount[GrayScale];
    float pixelPro[GrayScale];
    int i, j, pixelSum = width * height;
    uint8 threshold = 0;
    uint8* data = image;  //指向像素数据的指针
    for (i = 0; i < GrayScale; i++)
    {
        pixelCount[i] = 0;
        pixelPro[i] = 0;
    }

    //统计灰度级中每个像素在整幅图像中的个数  
    for (i = 0; i < height; i++)
    {
        for (j = 0; j < width; j++)
        {
            pixelCount[(int)data[i * width + j]]++;  //将像素值作为计数数组的下标
        }
    }

    //计算每个像素在整幅图像中的比例  
    float maxPro = 0.0;
    for (i = 0; i < GrayScale; i++)
    {
        pixelPro[i] = (float)pixelCount[i] / pixelSum;
        if (pixelPro[i] > maxPro)
        {
            maxPro = pixelPro[i];
        }
    }

    //遍历灰度级[0,255]  
    float w0, w1, u0tmp, u1tmp, u0, u1, u, deltaTmp, deltaMax = 0;
    for (i = 0; i < GrayScale; i++)     // i作为阈值
    {
        w0 = w1 = u0tmp = u1tmp = u0 = u1 = u = deltaTmp = 0;
        for (j = 0; j < GrayScale; j++)
        {
            if (j <= i)   //背景部分  
            {
                w0 += pixelPro[j];
                u0tmp += j * pixelPro[j];
            }
            else   //前景部分  
            {
                w1 += pixelPro[j];
                u1tmp += j * pixelPro[j];
            }
        }
        u0 = u0tmp / w0;
        u1 = u1tmp / w1;
        u = u0tmp + u1tmp;
        deltaTmp = w0 * pow((u0 - u), 2) + w1 * pow((u1 - u), 2);
        if (deltaTmp > deltaMax)
        {
            deltaMax = deltaTmp;
            threshold = i;
        }
    }

    image_threshold =  threshold;
}

int pendu_len(){
  int i;
  for(i=63;i>=0;--i){
    if(dis_image[i][WID/2]<image_threshold)break;
  }
  return 63-i;
}

int miss_road_type(){
  if(circle==1)return 0;
  if(blind)return 0;
  if(only_mag)return 0;
  
  int i,j;
  
  int miss = 0;
  
  int mid_clear = 0;
    for(i=0;i<WID;++i){
      if(dis_image[see_line][i]>image_threshold){
        mid_clear+=i;
        break;
      }
    }
    for(i=WID-1;i>=0;--i){
      if(dis_image[see_line][i]>image_threshold){
        mid_clear+=i;
        break;
      }
    }
    
    mid_clear /=2;
  
    int cut_row=0;
    for(i=61;i>=0;--i){
      if(dis_image[i][mid_clear]<image_threshold){
        cut_row = i+1;
        break;
      }
    }
    
    int cut_beg=0,cut_end=WID-1;
    for(i=0;i<WID;++i){
      if(dis_image[cut_row+2][i]>image_threshold){
        cut_beg=i;
        break;
      }
    }
    for(i=WID-1;i>=0;--i){
      if(dis_image[cut_row+2][i]>image_threshold){
        cut_end = i;
        break;
      }
    }
    
    int up_area = 0;
    for(i=0;i<LEN/4;++i){
      for(j=0;j<WID;++j){
        if(dis_image[i][j]>image_threshold)++up_area;
      }
    }

    int left_area=0,mid_area=0,right_area=0;
    
    for(i=LEN/4;i<cut_row-2;++i){                     // -2 means to avoid noise.
      for(j=0;j<cut_beg;++j){
        if(dis_image[i][j]>image_threshold)++left_area;
      }
      for(j=cut_beg;j<cut_end;++j){
        if(dis_image[i][j]>image_threshold)++mid_area;
      }
      for(j=cut_end;j<WID;++j){
        if(dis_image[i][j]>image_threshold)++right_area;
      }
    }
   
    int else_sum = WID*LEN/4-(cut_row-LEN/4)*(cut_end-cut_beg);
    
    
    if(mid_area==0 && cut_row>LEN*2/5 && left_area + up_area + right_area < else_sum/3  && abs(mid_clear-WID/2)<8 )miss=1;
    
    //if( abs(dir_cam)<100 &&cut_row>LEN*2/5 && abs(mid_clear-WID/2)<4) miss=1;
    
  if(miss){
    BELL(1);
    if(last_miss!=miss && miss==1)++first_or_second;
    if(first_or_second==1)return 2;
    if(first_or_second >1)return 1;
  }
  else BELL(0);
  
  last_miss = miss;
  return miss;
}


void check_out(){
  int i,j;
  int bai_cnt = 0;
  for(i=LEN/3;i<LEN;++i){
    for(j=0;j<WID;++j){
      if(dis_image[i][j]>image_threshold)++bai_cnt;
    }
  }
  if(bai_cnt>2730){only_mag=0;BELL(1);}
  else{BELL(0);}
}


void begin_line_detect(){
  int i;
  int change_cnt=0;
  for(i=1;i<WID;++i){
    if((dis_image[see_line][i-1]-image_threshold)*(dis_image[see_line][i]-image_threshold)<0)++change_cnt;
  }
  if(change_cnt>18){ //14
    if(begin_line_state==0){
        BELL(1);
        first_time_begin++;
        begin_line_state = 1;
      }
      else BELL(0);
    }
  else begin_line_state=0;
}
