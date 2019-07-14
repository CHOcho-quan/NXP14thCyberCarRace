#include "headfile.h"
#include "typedef.h"

void PIT0_Init(u32 period_us);
void PIT1_Init(u32 period_us);
void PIT2_Init();

#define PIT1_PERIOD_US (u32)20000

  // PIT0 is used for Control
  // Its period determined the control rate.
  // Suggest 2500
#define PIT0_PERIOD_US (u32)2500
#define PIT2_VAL() (PIT->CHANNEL[2].CVAL)