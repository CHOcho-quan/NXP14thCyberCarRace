#include "PIT.h"

U32 time_us = 0;
U32 pit0_time;
U32 pit1_time; 

int pit_1_cnt=0;

int pit_circle_cnt = 0;

//--- local ---
U32 pit1_time_tmp;
U32 num = 0;
s16 angle=0;
int blind=0;
int circle = 0;
int only_mag = 0;

int speed_base_line;
int speed_base_turn;
int speed_current;
int white_len = 0;
int add_or_sub = 0;

int control_type = 0;

void PIT1_IRQHandler(){
  PIT->CHANNEL[1].TFLG |= PIT_TFLG_TIF_MASK;
  //LED2(0);
  pit1_time_tmp = PIT2_VAL();
  //otsuThreshold(dis_image[0],128,64);
  //if(category == 7 && obs_or_cut()==2)blind = 1;
  if(blind)pit_1_cnt++;
  if(circle)pit_circle_cnt++;
  change_speed();
  /*
  if(circle==1){
    circle_cnt++;
    if(circle_cnt==100)circle = 0;
  }
*/
  //------------------------
  if ((SW1() && SW2() && SW3() && SW4()) || (SW1() && SW2() && !SW3() && !SW4()) || (!SW1() && SW2() && SW3() && SW4()))
  {
    OLED_Fill(0x00);
      OLED_P6x8Str(1, 1, "SW1 : LZ or DL");
  OLED_P6x8Str(1, 2, "SW2 : Line Speed");
  OLED_P6x8Str(1, 3, "SW3 : Turn Speed");
  OLED_P6x8Str(1, 4, "SW4 : Cam Threshold");
  OLED_P6x8Str(1, 5, "SW23 : Show Cam");
  OLED_P6x8Str(1, 6, "SW34 : Sunshine");
  }
  
    if (!SW2() && SW3() && SW4())
    {
      OLED_Fill(0x00);
      OLED_P6x8Str(1, 1, "Straight Line Speed");
      OLED_Print_Num1(1, 2, speed_base_line);
      if (!Key1())
      {
        add_or_sub = 1;
        speed_base_line++;
      }
      if (!Key2())
      {
        add_or_sub = 0;
        speed_base_line--;
      }
    }
    
    if (SW2() && !SW3() && SW4())
    {
      OLED_Fill(0x00);
      OLED_P6x8Str(1, 1, "Turn Speed");
      OLED_Print_Num1(1, 2, speed_base_turn);
      if (!Key1())
      {
        speed_base_turn++;
      }
      if (!Key2())
      {
        speed_base_turn--;
      }
    }
    
    if (SW2() && SW3() && !SW4())
    {
      OLED_Fill(0x00);
      OLED_P6x8Str(1, 1, "Camera Threshold");
      OLED_Print_Num1(1, 2, image_threshold);
      if (!Key1())
      {
        image_threshold++;
      }
      if (!Key2())
      {
        image_threshold--;
      }
    }
    
    if (!SW2() && !SW3() && SW4())
    {
      OLED_Fill(0x00);
  dis_bmp(64,128,dis_image[0],image_threshold);
    }
    
    if (!SW2 && !SW4() && SW3())
    {
      OLED_Fill(0x00);
      OLED_Print_Num1(1, 1, mag_val[0]);OLED_Print_Num1(60, 1, circle_dir);
    OLED_Print_Num1(1, 2, mag_val[1]);OLED_Print_Num1(60, 2, control_type);
    OLED_Print_Num1(1, 3, mag_val[2]);OLED_Print_Num1(60, 3, only_mag);
    OLED_Print_Num1(1, 4, mag_val[3]);OLED_Print_Num1(60, 4, blind);
    OLED_Print_Num1(1, 5, mag_val[4]);OLED_Print_Num1(60, 5, speed_current);
    OLED_Print_Num1(1, 6, mag_val[5]);OLED_Print_Num1(60, 6, first_time_begin);
    OLED_Print_Num1(1, 7, circle);   OLED_Print_Num1(60, 7, pit_circle_cnt);
    }
    
//OLED_Print_Num1(1, 3, angle);
  
  
  //------------ Other -------------
  
  pit1_time_tmp = pit1_time_tmp - PIT2_VAL();
  pit1_time_tmp = pit1_time_tmp / (bus_clk_mhz * 100); //100us
  pit1_time = pit1_time_tmp;
  
}

//============ PIT 0 ISR  ==========
// ====  Control  ==== ( High priority )
void PIT0_IRQHandler(){
  PIT->CHANNEL[0].TFLG |= PIT_TFLG_TIF_MASK;
  
  time_us += PIT0_PERIOD_US;
  
  LED1(0);
  
  //-------- System info -----
  
  pit0_time = PIT2_VAL();
  
  //-------- Get Sensers -----.
  

  Tacho0_Get();
  Tacho1_Get();
  
  Mag_Sample();
  
  
  detect_circle();
  

          if(mt9v032_finish_flag)
        {
            mt9v032_finish_flag = 0;
			for(num=0; num<64; num++)
			{
				memcpy(dis_image[num],&image[num][30],128);
			}
        }
        
  
   white_len = pendu_len();
   
   begin_line_detect();
   
   
   control_type = miss_road_type();
   
   if(control_type==2)blind=1;
   
   if(control_type==1){
     only_mag = 1;
   }
   
   if(blind==1){
     diffSpeed(120,dir_cam);
     blind_run(1);
   }
   else{
     if(only_mag){
       cho_dada_mag();
       turn_speed_Mag();
       diffSpeed(speed_current,dir_mag);
       check_out();
     }
     else{
       if(circle==0){
         ServoControl_Line();
          turn_speed();
          if(first_time_begin==2)diffSpeed(0,dir_cam);
          else diffSpeed(speed_current,dir_cam);
       }
       else{
         diffSpeed(110,dir_mag);
        circle_run();
       }
     }
   }
 
   
  pit0_time = pit0_time - PIT2_VAL();
  pit0_time = pit0_time / (bus_clk_mhz); //us
}

void PIT0_Init(u32 period_us)
{
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT0_IRQn); 
  NVIC_SetPriority(PIT0_IRQn, NVIC_EncodePriority(5, 1, 2));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[0].LDVAL |= period_us/100*(bus_clk_mhz*1000)/10-1; 
  
  PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
}

void PIT1_Init(u32 period_us)
{ 
                   
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  
  PIT->MCR = 0x00;
 
  NVIC_EnableIRQ(PIT1_IRQn); 
  NVIC_SetPriority(PIT1_IRQn, NVIC_EncodePriority(5, 3, 0));

  //period = (period_ns/bus_period_ns)-1
  PIT->CHANNEL[1].LDVAL |= period_us/100*(bus_clk_mhz*1000)/10-1; 
  
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