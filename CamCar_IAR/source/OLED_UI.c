
#include "includes.h"
extern int thr;
  /*
  UI_Page homepage;
  UI_Page subpage0;
  homepage.sub_type = (enum Item_Type *) malloc (4*2);
  homepage.sub_type[0] = Item_Type_Menu;
  homepage.sub = (void **)malloc (4*2); // (void **)(UI_Page **)
  *((UI_Page **)(homepage.sub)+0) = (UI_Page *) &subpage0;
  subpage0.parent = (void *) &homepage;
  
  subpage0.sub = (void **)123;
  Oled_Putnum(0,0,(s16)((*((UI_Page **)homepage.sub+0))->sub));
  */
  //free(homepage.sub);
  //free(homepage.sub_type);


enum Item_Type{
    Item_Type_Menu,
    Item_Type_Para,
    Item_Type_Show,
    Item_Type_Func,
};

typedef struct {
  void * parent;   // UI_Page *
  enum Item_Type * sub_type; 
  void ** sub;  // UI_Page **
}UI_Page;


void UI_SystemInfo(){
  Oled_Putstr(0,0,"Car Type"); Oled_Putnum(0,11,CAR_TYPE);
  Oled_Putstr(1,0,"battery"); Oled_Putnum(1,11,battery);
  Oled_Putstr(3,0,"pit0 time"); Oled_Putnum(3,11,(s16)pit0_time);
  Oled_Putstr(4,0,"pit1 time"); Oled_Putnum(4,11,(s16)pit1_time);
  Oled_Putstr(5,0,"tacho0"); Oled_Putnum(5,11,tacho0);
  Oled_Putstr(6,0,"tacho1"); Oled_Putnum(6,11,tacho1);

#if (CAR_TYPE==0)   // Magnet and Balance
  
  Oled_Putstr(7,0,"accx"); Oled_Putnum(7,11,accx);
  
#elif (CAR_TYPE==1)     // CCD
  
  
#else               // Camera
  
  Oled_Putstr(7,0,"cam"); Oled_Putnum(7,11,cam_buffer[20][40]);
  
#endif
}

void UI_Graph(u8* data){
  
}

void displayCamera()
{
  drawCam(isWhite);
}

void drawCam(boolean(*isTarget)(u8 x)) {
  int row, col, i;
  u8 buf[IMG_COLS * IMG_ROWS /8];
  u8 *p = buf;
    
  for (row = IMG_ROWS-1; row >= 0; row -= 8) {
    for (col = IMG_COLS-1; col >= 0 ; col--) {
      u8 tmp = 0;
      for (i = 0; i < 8; i++) {
        tmp <<= 1;
        if (isTarget(cam_buffer[row-i][col]))
          tmp |= 0x01;
      }
      *p++ = tmp;
    }
  }
  Oled_DrawBMP(0, 0,IMG_COLS, IMG_ROWS, buf);
}


boolean isWhite(u8 x)
{     //白色阈值，场地理想后好像没什么用
  return x > thr;
}

















