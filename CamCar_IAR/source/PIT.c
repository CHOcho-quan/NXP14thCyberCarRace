/*
Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
Date : 2015/12/01
License : MIT
*/

#include "includes.h"


// ========= Variables =========

//--- global ---
U32 time_us = 0;
U32 pit0_time;
U32 pit1_time; 

//--- local ---
U32 pit1_time_tmp;
extern int dir;
extern u16 mid;
extern int left_right;
// =========== PIT 1 ISR =========== 
// ====  UI Refreshing Loop  ==== ( Low priority ) 



void PIT1_IRQHandler(){
  PIT->CHANNEL[1].TFLG |= PIT_TFLG_TIF_MASK;
  
  pit1_time_tmp = PIT2_VAL();
  
  //------------------------
  
  LED1_Tog();
  
  //UI_Operation_Service();
  
  Bell_Service();
  
  //Oled_Clear();
  /*
  Oled_Putstr(0,0,"0"); Oled_Putnum(0,11,mag_val[0]);
  Oled_Putstr(1,0,"1"); Oled_Putnum(1,11,mag_val[1]);
  Oled_Putstr(3,0,"2"); Oled_Putnum(3,11,mag_val[2]);
  Oled_Putstr(4,0,"3"); Oled_Putnum(4,11,mag_val[3]);
  Oled_Putstr(5,0,"4"); Oled_Putnum(5,11,mag_val[4]);
  Oled_Putstr(6,0,"5"); Oled_Putnum(6,11,mag_val[5]);
  */
  //Oled_Putstr(0,0,"last_dir"); Oled_Putnum(0,11,left_right);
  //Oled_Putstr(0,0,"left white"); Oled_Putnum(0,11,left_white);
  //Oled_Putstr(1,0,"right white"); Oled_Putnum(1,11,right_white);
   //Oled_Putstr(1,0,"mid: "); Oled_Putnum(1,11,mid);
  //Oled_Putstr(1,0,"dir: "); Oled_Putnum(1,11,dir);

  if(!SW1())
  {
    Oled_Clear();
    /*
    Oled_Putstr(0,0,"Dir: "); Oled_Putnum(0,6,dir);
    Oled_Putstr(2,0,"Mid: "); Oled_Putnum(2,6,mid);
    */
    Oled_Putstr(0,0,"0"); Oled_Putnum(0,11,mag_val[0]);
    Oled_Putstr(1,0,"1"); Oled_Putnum(1,11,mag_val[1]);
    Oled_Putstr(2,0,"2"); Oled_Putnum(2,11,mag_val[2]);
    Oled_Putstr(3,0,"3"); Oled_Putnum(3,11,mag_val[3]);
    Oled_Putstr(4,0,"4"); Oled_Putnum(4,11,mag_val[4]);
    Oled_Putstr(5,0,"5"); Oled_Putnum(5,11,mag_val[5]);
    Oled_Putstr(6,0,"huandao"); Oled_Putnum(6,11,huandao);
  }
  if(!SW2())
  {
    Oled_Clear();
    displayCamera();
  }
  if(!SW3())
    Oled_Clear();
  if(!SW4())
  {
    Oled_Clear();
    Oled_Putstr(1,0,"tacho: "); Oled_Putnum(1,6,tacho0);
    Oled_Putstr(2,0,"tacho1: "); Oled_Putnum(2,6,tacho1);
  }
  
  
  //------------ Other -------------
  
  pit1_time_tmp = pit1_time_tmp - PIT2_VAL();
  pit1_time_tmp = pit1_time_tmp / (g_bus_clock/10000); //100us
  pit1_time = pit1_time_tmp;
  
}



//============ PIT 0 ISR  ==========
// ====  Control  ==== ( High priority )





void PIT0_IRQHandler(){
  PIT->CHANNEL[0].TFLG |= PIT_TFLG_TIF_MASK;
  
  time_us += PIT0_PERIOD_US;

  //LED2_Tog();
  
  //-------- System info -----
  
  pit0_time = PIT2_VAL();
    
  battery = Battery();
  
  
  
  
  //-------- Get Sensers -----
  
  
  // Tacho
  Tacho0_Get();
  Tacho1_Get();
  
  
  // UI operation input
  ui_operation_cnt += tacho0;  // use tacho0 or tacho1
    
    
  
#if (CAR_TYPE==0)   // Magnet and Balance
  
  Mag_Sample();

  //gyro1 = Gyro1();
  //gyro2 = Gyro2();
  
  
  
#elif (CAR_TYPE==1)     // CCD
  
  //CCD1_GetLine();
  //CCD2_GetLine();
  
  
  
  
#else               // Camera & Mag
  
  // Results of camera are automatically put in cam_buffer[].
  Mag_Sample();
  
  
#endif
  
  
  
  // -------- Sensor Algorithm --------- ( Users need to realize this )
  
  // mag example : dir_error = Mag_Algorithm(mag_val);
  // ccd example : dir_error = CCD_Algorithm(ccd1_line,ccd2_line);
  // cam is complex. realize it in Cam_Algorithm() in Cam.c
  
  //-------- Controller --------
  
  
  // not balance example : dir_output = Dir_PIDController(dir_error);
  // example : get 'motorL_output' and  'motorR_output'
  
  
  // ------- Output -----
  
  
  // not balance example : Servo_Output(dir_output);  
  // example : MotorL_Output(motorL_output); MotorR_Output(motorR_output);
  
  
  
  // ------- UART ---------
  
  
  //UART_SendDataHead();
  //UART_SendData(battery);
  
  
  
  // ------- other --------
  
  pit0_time = pit0_time - PIT2_VAL();
  pit0_time = pit0_time / (g_bus_clock/1000000); //us
  
}




// ======= INIT ========

void PIT0_Init(u32 period_us)
{ 
                   
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT0_IRQn); 
  NVIC_SetPriority(PIT0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[0].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
  
  PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;

};

void PIT1_Init(u32 period_us)
{ 
                   
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT1_IRQn); 
  NVIC_SetPriority(PIT1_IRQn, NVIC_EncodePriority(NVIC_GROUP, 3, 0));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[1].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
  
  PIT->CHANNEL[1].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;

}

void PIT2_Init()
{ 
                   
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[2].LDVAL = 0xffffffff; 
  
  PIT->CHANNEL[2].TCTRL |= PIT_TCTRL_TEN_MASK;

}