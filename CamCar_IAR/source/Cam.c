/*
Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
Date : 2015/12/01
License : MIT
*/

#include "includes.h"

// ====== Variables ======
// ---- Global ----
u8 cam_buffer[IMG_ROWS][IMG_COLS];
ROAD road[ROAD_SIZE];
// ---- Local ----
u8 cam_row = 0, img_row = 0;
int thr = 65;

u8 left_white, right_white;

u8 WID = 104;
u8 kp_dir = 30;
u8 kd_dir = 10;
int dir=0;

u16 mid;  
static int e;
static int last_e;

extern int motor_x;
// ====== 

/*
void Cam_Algorithm(){
  static u8 img_row_used = 0;
  while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
  
  // -- Handle the row --
  
  
  
  
  //  -- The row is used --
  img_row_used++;
  img_row_used%=IMG_ROWS;
}
*/

void Cam_Cont_Init(){
  for(int i = 0; i < ROAD_SIZE ; i++)
  {
    road[i].left = WID/2;
    road[i].mid =  WID/2 + 1;
    road[i].right = WID/2 + 2;
  }
  mid = 0;
  e =  0;
  last_e = 0;
}

//根据远近两条线调整
void Cam_Con_2_line(){
  mid = road[28].mid * 0.8 + road[40].mid * 0.2;
  e = mid  - WID/2;
  dir = kp_dir * e + kd_dir * (e-last_e);
  last_e = e;
  Servo_Output(-dir);
}

int Cam_2_line(){
  mid = road[28].mid * 0.8 + road[40].mid * 0.2;
  e = mid  - WID/2;
  dir = kp_dir * e + kd_dir * (e-last_e);
  last_e = e;
  return -dir;
}

int Cam_k(){
  double k1,k2,k3;
  k1 = (road[20].mid - road[0].mid) / 20;
  k2 = (road[35].mid - road[15].mid) / 20;
  k3 = (road[45].mid - road[30].mid) / 20;
  
  mid = (k1*k2 + k2*k3 + k1*k3 + 6 * k1 + 4*k2 + 2*k3)/2 + road[28].mid; 
  
  e = mid  - WID/2;
  dir = kp_dir * e + kd_dir * (e-last_e);
  last_e = e;
  return -dir;
}


//根据赛道中线斜率调整
void Cam_Con_k(){
  double k1,k2,k3;
  k1 = (road[20].mid - road[0].mid) / 20;
  k2 = (road[35].mid - road[15].mid) / 20;
  k3 = (road[45].mid - road[30].mid) / 20;
  
  mid = (k1*k2 + k2*k3 + k1*k3 + 6 * k1 + 4*k2 + 2*k3)/2 + road[28].mid; 
  
  e = mid  - WID/2;
  dir = kp_dir * e + kd_dir * (e-last_e);
  last_e = e;
  Servo_Output(-dir);
}

//根据赛道中线斜率调整速度
void Speed_k(){
  double k1,k2,k3;
  k1 = (road[20].mid - road[0].mid)/20;
  k2 = (road[35].mid - road[15].mid)/20;
  k3 = (road[45].mid - road[30].mid)/20;
  
  if(abs(dir)<50) motor_x =170;
  if(abs(dir)>=50 && abs(dir)<150) motor_x = 150;
  if(abs(dir)>150) motor_x = 140;
  
  if(abs(k1)<0.2 && abs(k2)<0.2 && abs(k3)<0.2)motor_x += 10;
  else if(abs(k1)<0.3 && abs(k2)<0.3 && abs(k3)<0.3)motor_x += 5;
  else motor_x += 0;
  
}



void road_value()
{
  for( int i = 0; i < ROAD_SIZE ; i++)
  {
    int j;
    for(j = road[i].mid ; j> 5 ;j--)
    {
      if(cam_buffer[i][j]< thr && cam_buffer[i][j - 1]< thr && cam_buffer[i][j - 2]< thr) break;
    }
    road[i].left = j;
    
    for(j = road[i].mid ; j< 115 ;j++)
    {
      if(cam_buffer[i][j] < thr && cam_buffer[i][j + 1]< thr && cam_buffer[i][j + 2]< thr) break;
    }
    road[i].right = j;
    road[i].mid = (road[i].left + road[i].right) / 2;
  }
}

void Cam_Algorithm(){
  static u8 img_row_used = 0;
  while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
  
  // -- Handle the row --
  
  //  -- The row is used --
  img_row_used++;
  img_row_used%=IMG_ROWS;
}

// ====== Basic Drivers ======

void PORTC_IRQHandler(){
  if((PORTC->ISFR)&PORT_ISFR_ISF(1 << 8)){  //CS
    PORTC->ISFR |= PORT_ISFR_ISF(1 << 8);
    
    if(img_row < IMG_ROWS && cam_row % IMG_STEP == 0 ){
      DMA0->TCD[0].DADDR = (u32)&cam_buffer[img_row][0];
      DMA0->ERQ |= DMA_ERQ_ERQ0_MASK; //Enable DMA0
      ADC0->SC1[0] |= ADC_SC1_ADCH(4); //Restart ADC
      DMA0->TCD[0].CSR |= DMA_CSR_START_MASK; //Start
	}
	cam_row++;
  }
  else if(PORTC->ISFR&PORT_ISFR_ISF(1 << 9)){   //VS
    PORTC->ISFR |= PORT_ISFR_ISF(1 << 9);
    
    cam_row = img_row = 0;
    
  }
}

void DMA0_IRQHandler(){
  DMA0->CINT &= ~DMA_CINT_CINT(7); //Clear DMA0 Interrupt Flag
  
  img_row++; 
}

void Cam_Init(){
  
  // --- IO ---
  
  PORTC->PCR[8] |= PORT_PCR_MUX(1); //cs
  PORTC->PCR[9] |= PORT_PCR_MUX(1); //vs
  PORTC->PCR[11] |= PORT_PCR_MUX(1);    //oe
  PTC->PDDR &=~(3<<8);
  PTC->PDDR &=~(1<<11);
  PORTC->PCR[8] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
  PORTC->PCR[9] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(9);  // rising edge
  PORTC->PCR[11] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
  
  NVIC_EnableIRQ(PORTC_IRQn);
  NVIC_SetPriority(PORTC_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
  
  // --- AD ---
  
  /*
  SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK;  //ADC1 Clock Enable
  ADC0->CFG1 |= 0
             //|ADC_CFG1_ADLPC_MASK
             | ADC_CFG1_ADICLK(1)
             | ADC_CFG1_MODE(0);     // 8 bits
             //| ADC_CFG1_ADIV(0);
  ADC0->CFG2 |= //ADC_CFG2_ADHSC_MASK |
                ADC_CFG2_MUXSEL_MASK |  // b
                ADC_CFG2_ADACKEN_MASK; 
  
  ADC0->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
  
  ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA
  
  ADC0->SC3 |= ADC_SC3_ADCO_MASK; // continuous
  
  //PORTC->PCR[2]|=PORT_PCR_MUX(0);//adc1-4a
  
  ADC0->SC1[0] |= ADC_SC1_ADCH(4);
  */
  
  SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK; //ADC1 Clock Enable
  ADC0->SC1[0] &= ~ADC_SC1_AIEN_MASK; //ADC1A
  ADC0->SC1[0] = 0x00000000; //Clear
  ADC0->SC1[0] |= ADC_SC1_ADCH(4); //ADC1_5->Input, Single Pin, No interrupt
  ADC0->SC1[1] &= ~ADC_SC1_AIEN_MASK; //ADC1B
  ADC0->SC1[1] |= ADC_SC1_ADCH(4); //ADC1_5b
  ADC0->SC2 &= 0x00000000; //Clear all.
  ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA, SoftWare
  ADC0->SC3 &= (~ADC_SC3_AVGE_MASK&~ADC_SC3_AVGS_MASK); //hardware average disabled
  ADC0->SC3 |= ADC_SC3_ADCO_MASK; //Continuous conversion enable
  ADC0->CFG1|=ADC_CFG1_ADICLK(1)|ADC_CFG1_MODE(0)|ADC_CFG1_ADIV(0);//InputClk, ShortTime, 8bits, Bus
  ADC0->CFG2 |= ADC_CFG2_MUXSEL_MASK; //ADC1  b
  ADC0->CFG2 |= ADC_CFG2_ADACKEN_MASK; //OutputClock
    
  // --- DMA ---
  
  SIM->SCGC6 |= SIM_SCGC6_DMAMUX_MASK; //DMAMUX Clock Enable
  SIM->SCGC7 |= SIM_SCGC7_DMA_MASK; //DMA Clock Enable
  DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_SOURCE(40); //DMA0->No.40 request, ADC0
  DMA0->TCD[0].SADDR = (uint32_t) & (ADC0->R[0]); //Source Address 0x400B_B010h
  DMA0->TCD[0].SOFF = 0; //Source Fixed
  DMA0->TCD[0].ATTR = DMA_ATTR_SSIZE(0) | DMA_ATTR_DSIZE(0); //Source 8 bits, Aim 8 bits
  DMA0->TCD[0].NBYTES_MLNO = DMA_NBYTES_MLNO_NBYTES(1); //one byte each
  DMA0->TCD[0].SLAST = 0; //Last Source fixed
  DMA0->TCD[0].DADDR = (u32)cam_buffer;
  DMA0->TCD[0].DOFF = 1;
  DMA0->TCD[0].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(IMG_COLS);
  DMA0->TCD[0].DLAST_SGA = 0;
  DMA0->TCD[0].BITER_ELINKNO = DMA_BITER_ELINKNO_BITER(IMG_COLS);
  DMA0->TCD[0].CSR = 0x00000000; //Clear
  DMA0->TCD[0].CSR |= DMA_CSR_DREQ_MASK; //Auto Clear
  DMA0->TCD[0].CSR |= DMA_CSR_INTMAJOR_MASK; //Enable Major Loop Int
  DMA0->INT |= DMA_INT_INT0_MASK; //Open Interrupt
  //DMA->ERQ&=~DMA_ERQ_ERQ0_MASK;//Clear Disable
  DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_ENBL_MASK; //Enable
  
  NVIC_EnableIRQ(DMA0_IRQn);
  NVIC_SetPriority(DMA0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
  
}