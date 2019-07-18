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
  //if(huandao==3)return 0;
  if(blind)return 0;
  int i,j;
  int up_has_white = 0;
  int miss = 0;
  for(i=0;i<LEN/2;++i){
    for(j=0;j<WID;++j)if(dis_image[i][j]>image_threshold)++up_has_white;
  }
  
  int bot_has_white = 0;
  for(i=LEN/2;i<LEN;++i){
    for(j=0;j<WID;++j)if(dis_image[i][j]>image_threshold)++bot_has_white;
  }
  
  int left_seg=0,right_seg=0;
  for(i=1;i<LEN;++i){
    if((dis_image[i-1][0]-image_threshold)*(dis_image[i][0]-image_threshold)<0)++left_seg;
    if((dis_image[i-1][WID-1]-image_threshold)*(dis_image[i][WID-1]-image_threshold)<0)++right_seg;
  }
  
  left_seg /= 2;
  right_seg /= 2;
  
  int left_beg=0,right_beg=0;
  for(i=0;i<LEN;++i){
    if(dis_image[i][0]>image_threshold){
      left_beg = i;
      break;
    }
  }
  for(i=0;i<LEN;++i){
    if(dis_image[i][WID-1]>image_threshold){
      right_beg = i;
      break;
    }
  }
  
  int left_end = 0, right_end = 0;
  for(i=LEN-1;i>=0;--i){
    if(dis_image[i][0]>image_threshold){
      left_end = i;
      break;
    }
  }
  for(i=LEN-1;i>=0;--i){
    if(dis_image[i][WID-1]>image_threshold){
      right_end = i;
      break;
    }
  }
  
  int left_len = left_end - left_beg;
  int right_len = right_end - right_beg;
  
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
  
  //if(!up_has_white && bot_has_white && abs(mid_clear-WID/2)<4 && ((left_seg==0 && right_seg==0)||((left_beg > 40 && left_len<20 && right_len==0) || (right_beg>40 && right_len<20 && left_len==0))))miss = 1; 
  
    int bot_area=0;
    for(i=LEN/2;i<LEN;++i){
      for(j=0;j<WID;++j){
        if(dis_image[i][j]>image_threshold)++bot_area;
      }
    }
    
    
    
    if(!up_has_white && bot_area>2500 && (left_seg==0 && right_seg==0 && abs(mid_clear-WID/2)<4))miss=1;
  
  if(miss){
    BELL(1);
    if(last_miss!=miss)++first_or_second;
    if(first_or_second==1)if(!SW1())return 2;else return 1;
    if(first_or_second==2)if(!SW1())return 1;else return 2;
  }
  else BELL(0);
  
  last_miss = miss;
  return miss;
}

void check_out(){
  int i,j;
  int bai_cnt = 0;
  for(i=0;i<LEN;++i){
    for(j=0;j<WID;++j){
      if(dis_image[i][j]>image_threshold)++bai_cnt;
    }
  }
  if(bai_cnt>3500)only_mag=0;
}

void begin_line_detect(){
  int i;
  int change_cnt=0;
  for(i=1;i<WID;++i){
    if((dis_image[see_line][i-1]-image_threshold)*(dis_image[see_line][i]-image_threshold)<0)++change_cnt;
  }
  if(change_cnt>14){
    if(begin_line_state==0){
        first_time_begin++;
        begin_line_state = 1;
      }
    }
  else begin_line_state=0;
}
