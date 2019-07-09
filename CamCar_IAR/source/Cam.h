#ifndef CAM_H
#define CAM_H

// ===== Settings =====
// the camera has about 300 rows and 400 cols ,
// but we can not handle that much ,
// so we get 1 row of image for every IMG_STEP rows of camera ,
// and totally get IMG_ROWS rows.

#define IMG_ROWS 64
#define IMG_COLS 128
#define IMG_STEP 2
#define ROAD_SIZE 50
#define CAM_WID 104

typedef struct
{
  int left;
  int mid;
  int right;
}ROAD;

// ====== Global Variables ======

extern u8 cam_buffer[IMG_ROWS][IMG_COLS];
extern u8 left_white, right_white;
extern ROAD road[ROAD_SIZE];
extern int thr;

// ===== APIs ======

  // write your algorithm in this func
void Cam_Algorithm();
void road_value();
void Cam_Con_2_line();
void Cam_Con_k();
void Cam_Cont_Init();
void Speed_k();
int Cam_2_line();
int Cam_k();

  // Init
void Cam_Init();


#endif