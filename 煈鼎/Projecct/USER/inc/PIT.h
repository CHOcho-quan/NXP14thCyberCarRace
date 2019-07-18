#include "headfile.h"
#include "typedef.h"

void PIT0_Init(u32 period_us);
void PIT1_Init(u32 period_us);
void PIT2_Init();
extern s16 angle;
extern int pit_1_cnt;
extern int blind;
extern int circle;
extern int speed_base_line;
extern int speed_base_turn;
extern int speed_current;
extern int white_len;
extern int add_or_sub;
extern int only_mag;
extern int pit_circle_cnt;
#define PIT1_PERIOD_US (u32)100000

  // PIT0 is used for Control
  // Its period determined the control rate.
  // Suggest 2500
#define PIT0_PERIOD_US (u32)38000
#define PIT2_VAL() (PIT->CHANNEL[2].CVAL)