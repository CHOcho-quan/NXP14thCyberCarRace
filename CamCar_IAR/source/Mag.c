/*
Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
Date : 2015/12/01
License : MIT
*/

#include "includes.h"


// ===== Global Variables =====
U16 mag_val[6];
int left_right = 0;
boolean lost=0;
extern int dir;

/*
0 没环岛
1 进入环岛
2 环岛中
3 出环岛
*/
int huandao = 0;

float circle_dep_left=1.0, circle_dep_right=1.0;

// ===== Function Realization =====

void Mag_Sample(){
  mag_val[0] = Mag1();
  mag_val[1] = Mag2();
  mag_val[2] = Mag3();
  mag_val[3] = Mag4();
  mag_val[5] = Mag6();
  mag_val[4] = mag_val[5] - Mag5();
}

u16 Mag1(){
  ADC1->SC1[0] = ADC_SC1_ADCH(4);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
}
u16 Mag2(){
  ADC1->SC1[0] = ADC_SC1_ADCH(5);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
}
u16 Mag3(){
  ADC1->SC1[0] = ADC_SC1_ADCH(6);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
}
u16 Mag4(){
  ADC1->SC1[0] = ADC_SC1_ADCH(7);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
}
s16 Mag5(){
  ADC1->SC1[0] = ADC_SC1_DIFF_MASK | ADC_SC1_ADCH(3);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
  //ADC1->SC1[0] &= ~ADC_SC1_DIFF_MASK;
}
u16 Mag6(){
  ADC1->SC1[0] = ADC_SC1_ADCH(3);
  while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
  return ADC1->R[0];
}

int Mag_Control(){
  int f1,f2,f3;
  int dir, err_mag;
  static int last_err_mag = 0;
  static int hdCnt = 0;
  
  float pow = 0.0;

  f1 = mag_val[0] - mag_val[5];
  f2 = mag_val[1] - mag_val[4];
  f3 = mag_val[2] - mag_val[3];
  
  /*
  if (mag_val[2] + mag_val[3] > 2500 && ((0 < f1 && f1 < 150) || (f1 < 0 && f1 > -150)))
  {
    // 进入环岛！
    hdCnt = f1;
    huandao = 1;
  }
  
  if (huandao == 1)
  {
    if (mag_val[2] + mag_val[3] < 1000) huandao = 2;
    else return (f1>0 ? 1:-1) * 200;
  }
  
  if (huandao == 2)
  {
    if (f1 > 500 || f1 < -500) huandao = 0;
  }
  
  if (mag_val[2] + mag_val[3] - mag_val[1] - mag_val[4] < 300)
  {
    pow = 1.3;
  }
  else 
  {
    pow = 0.8;
  }
  */
  err_mag = f2 * 0.2 + f3 * 0.3;
  
  dir = err_mag * 1.2 + (err_mag - last_err_mag) * 0.4;
  
  last_err_mag = err_mag;
  
  if(dir<0)left_right = -1;
  if(dir>0)left_right = 1;
  if(mag_val[2]<200 && mag_val[3]<200 && mag_val[1]<650 && mag_val[4]<650){dir = left_right*800;lost=1;}
  else lost = 0;
  if(!lost){
    left_right = (dir>0? 1:-1); 
    return (int)(dir * pow);
  }
  else return left_right*800;
}

void Mixed_Control(){
  int mixed_dir = (Mag_Control()*0.9 + Cam_2_line()*0.8 + Cam_k()*0.4);
  Circle_Con();
  mixed_dir *= (mixed_dir>0?circle_dep_left:circle_dep_right);
  dir = mixed_dir;
  Servo_Output(-mixed_dir);
}

void Circle_Con(){
  static int circle_cnt=0;
  if(mag_val[2]>600 && mag_val[3]>600 && mag_val[0]>700 && mag_val[5] == 0){circle_dep_right=0.2;circle_cnt+=1;}
  else if(circle_cnt >10){circle_dep_right = 1.0;circle_cnt = 0;}
  if(mag_val[2]>600 && mag_val[3]>600 && mag_val[5]>700 && mag_val[0] == 0){circle_dep_left=0.2;circle_cnt += 1;}
  else if(circle_cnt>10){circle_dep_left = 1.0;circle_cnt = 0;}
}



void Mag_Init(){
  
  if(!ADC1_enabled){
    SIM->SCGC3 |= SIM_SCGC3_ADC1_MASK;  //ADC1 Clock Enable
    ADC1->CFG1 |= 0
               //|ADC_CFG1_ADLPC_MASK
               | ADC_CFG1_ADICLK(1)
               | ADC_CFG1_MODE(1)
               | ADC_CFG1_ADIV(0);
    ADC1->CFG2 |= //ADC_CFG2_ADHSC_MASK |
                  ADC_CFG2_ADACKEN_MASK;
    
    ADC1->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
    ADC1_enabled = 1;
  }
  
  PORTE->PCR[0]|=PORT_PCR_MUX(0);//adc1-4a
  PORTE->PCR[1]|=PORT_PCR_MUX(0);//adc1-5a
  PORTE->PCR[2]|=PORT_PCR_MUX(0);//adc1-6a
  PORTE->PCR[3]|=PORT_PCR_MUX(0);//adc1-7a
}