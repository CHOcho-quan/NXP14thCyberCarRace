/*
Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
Date : 2015/12/01
License : MIT
*/


#include "includes.h"


U8 ADC0_enabled = 0;
U8 ADC1_enabled = 0;

s16 err_motorL = 0, last_err_motorL = 0, motor_outL = 0, motor_outR = 0, err_motorR = 0, last_err_motorR = 0;
int motor_xL = 100, motor_xR = 100;

void main (void)
{
  
  // --- System Initiate ---
  
  __disable_irq();
  
  HMI_Init();
  PIT0_Init(PIT0_PERIOD_US);
  PIT1_Init(PIT1_PERIOD_US);
  PIT2_Init();
  
  Flash_Init();
  
  UART_Init(115200);
  
  Motor_Init();
  Tacho_Init();
  Servo_Init();
  Oled_Init();
  
#if (CAR_TYPE==0)   // Magnet and Balance
  
  Mag_Init();
  LPLD_MMA8451_Init();
  Gyro_Init();
  
#elif (CAR_TYPE==1)     // Only Camera
  
  Cam_Init();
  Cam_Cont_Init();
  LPLD_MMA8451_Init();
  
#else               // Camera
  Mag_Init();
  LPLD_MMA8451_Init();
  Cam_Init();
  Cam_Cont_Init();
  
#endif
  
  //-- Press Key 1 to Continue --
  Oled_Putstr(6,1,"Press Key1 to go on");
  //while (Key1());
  Oled_Clear();
  
  
  ////// System Initiated ////
  
  
  // --- Flash test --- 
  // To use this test, turn off Switch 1 first
  __disable_irq();
  Oled_Putstr(0,0,"data[1] in flash is:");
  Oled_Putstr(2,0,"data[1] in flash is:");
  Oled_Putnum(1,11,Flash_Read(0,1));
  data[1] = Flash_Read(0,1)+1;
  Flash_Write(0);
  __disable_irq();
  Oled_Putnum(3,11,Flash_Read(0,1));
  //-- Press Key 1 to Continue --
  Oled_Putstr(6,1,"Key1 LiFe is best");
  while (Key1());
  Oled_Clear();
  ///// Flash test End///
 
  
  __enable_irq(); 
  
  while(1)
  {
    //BELL(1);
    // Don't use oled or sensors' functions here !!!
   
#if (CAR_TYPE==0)
    
  Servo_Output(-Mag_Control());    // this might be blocked , so put here instead of interrupt
  err_motorL = motor_xL - tacho0 * 15;
  err_motorR = motor_xR + tacho1 * 15;
  
  
  motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
  motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
  //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
  last_err_motorL = err_motorL;
  last_err_motorR = err_motorR;
  
  MotorR_Output(0);
  MotorL_Output(0);
  //accy = Accy();
  //accz = Accz();
  
#elif (CAR_TYPE==1)
  road_value();
  Cam_Con_2_line();
  //Cam_Con_k();
  err_motorL = motor_xL + tacho0 * 15;
  err_motorR = motor_xR + tacho1 * 15;
  
  
  motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
  motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
  //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
  last_err_motorL = err_motorL;
  last_err_motorR = err_motorR;
  
  MotorR_Output(motor_outR);
  MotorL_Output(motor_outL);
  //MotorL_Output(motor_out);
    
#elif (CAR_TYPE==2)
  Mixed_Control();
  //Speed_k();
  err_motorL = motor_xL + tacho0 * 15;
  err_motorR = motor_xR + tacho1 * 15;
  
  
  motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
  motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
  //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
  last_err_motorL = err_motorL;
  last_err_motorR = err_motorR;
  
  MotorR_Output(motor_outR);
  MotorL_Output(motor_outL);
#endif
    
    
    
  } 
}






// ===== System Interrupt Handler  ==== ( No Need to Edit )

void BusFault_Handler(){
  Oled_Clear();
  Oled_Putstr(1,5,"Bus Fault");
  Oled_Putstr(4,1,"press Key1 to goon");
  while(Key1());
  
  return;
}


void NMI_Handler(){
  Oled_Clear();
  Oled_Putstr(1,5,"NMI Fault");
  Oled_Putstr(4,1,"press Key1 to goon");
  while(Key1());
  
  return;
}

void HardFault_Handler(void)
{
  Oled_Clear();
  Oled_Putstr(1,5,"Hard Fault");
  Oled_Putstr(4,1,"press Key1 to goon");
  while(Key1());
  
  return;
}


void DefaultISR(void)
{
  Oled_Clear();
  Oled_Putstr(1,5,"Default ISR");
  Oled_Putstr(4,2,"press Key1 to goon");
  while(Key1());

  return;
}
