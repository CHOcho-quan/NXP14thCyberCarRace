#include "PIT.h"

U32 time_us = 0;
U32 pit0_time;
U32 pit1_time; 

//--- local ---
U32 pit1_time_tmp;
U32 num = 0;

void PIT1_IRQHandler(){
  PIT->CHANNEL[1].TFLG |= PIT_TFLG_TIF_MASK;
  //LED2(0);
  pit1_time_tmp = PIT2_VAL();
  
  //------------------------
  if (!SW3())
  {
    OLED_Print_Num1(1, 1, 1);OLED_Print_Num1(6, 1, mag_val[0]);
      OLED_Print_Num1(1, 2, 2);OLED_Print_Num1(6, 2, mag_val[1]);
        OLED_Print_Num1(1, 3, 3);OLED_Print_Num1(6, 3, mag_val[2]);
          OLED_Print_Num1(1, 4, 4);OLED_Print_Num1(6, 4, mag_val[3]);
            OLED_Print_Num1(1, 5, 5);OLED_Print_Num1(6, 5, mag_val[4]);
              OLED_Print_Num1(1, 6, 6);OLED_Print_Num1(6, 6, mag_val[5]);
  }
  if (!SW2())
  {
   // tacho0 = gpio_get(A12);
   // tacho1 = gpio_get(A13);
    OLED_Print_Num1(1, 3, tacho0);
    OLED_Print_Num1(1, 2, tacho1);
  }
  
if (!SW4())
{
  OLED_Fill(0x00);
  dis_bmp(64,128,dis_image[0],110);
}
  
  
  //------------ Other -------------
  
  pit1_time_tmp = pit1_time_tmp - PIT2_VAL();
  pit1_time_tmp = pit1_time_tmp / (-1ul/10000); //100us
  pit1_time = pit1_time_tmp;
  
}

//============ PIT 0 ISR  ==========
// ====  Control  ==== ( High priority )
void PIT0_IRQHandler(){
  PIT->CHANNEL[0].TFLG |= PIT_TFLG_TIF_MASK;
  
  time_us += PIT0_PERIOD_US;
  
  //-------- System info -----
  
  pit0_time = PIT2_VAL();
  
  //-------- Get Sensers -----
  Tacho0_Get();
  Tacho1_Get();
  
  //Mag
  Mag_Sample();
          if(mt9v032_finish_flag)
        {
            mt9v032_finish_flag = 0;
			//displayimage032(image[0]);
            //seekfree_sendimg_032();
            //dui 数据进行抽点然后在显示
			for(num=0; num<64; num++)
			{
				memcpy(dis_image[num],&image[num][30],128);
			}
			
        }
  // Camera
  
  pit0_time = pit0_time - PIT2_VAL();
  pit0_time = pit0_time / (-1ul/1000000); //us
  
}

void PIT0_Init(u32 period_us)
{
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT0_IRQn); 
  NVIC_SetPriority(PIT0_IRQn, NVIC_EncodePriority(5, 1, 2));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[0].LDVAL |= period_us/100*(-1ul/1000)/10-1; 
  
  PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
}

void PIT1_Init(u32 period_us)
{ 
                   
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT1_IRQn); 
  NVIC_SetPriority(PIT1_IRQn, NVIC_EncodePriority(5, 3, 0));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[1].LDVAL |= period_us/100*(-1ul/1000)/10-1; 
  
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