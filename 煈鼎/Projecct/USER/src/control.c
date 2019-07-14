#include "control.h"

// =========== Extern Variables ===========
int category = 0;

// =========== Local Variables ============
static s16 last_errL = 0, last_errR = 0, motor_outL = 0, motor_outR = 0;
float Kp = 0.8, Ki = 0.01;

s16 max(s16 a, s16 b)
{
  if (a > b) return a;
  else return b;
}

void SpeedControl(s16 xL, s16 xR)
{
  s16 errL = (s16)(xL - (s16)(tacho0 * 0.25)), errR = (s16)(xR - (s16)(tacho1 * 0.25));
  
  motor_outL += (s16)((errL - last_errL) * Kp + Ki * errL);
  motor_outR += (s16)((errR - last_errR) * Kp + Ki * errR);
  motor_outL = max(0, motor_outL);
  motor_outR = max(0, motor_outR);
  last_errL = errL;
  last_errR = errR;
  
  MotorL_Output(motor_outL);
  MotorR_Output(motor_outR);
}