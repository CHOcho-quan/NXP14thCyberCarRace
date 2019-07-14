#include "headfile.h"
#include "typedef.h"

// ===== Setting =====
#define SERVO_MID 5830 // (g_bus_clock/64*15/10000)  Adjust it according to your mech

// ===== Variables =====

// --- Global ----
S16 tacho0, tacho1;
// --- Local ---
U16 tacho1_tmp,tacho0_tmp,ftm1cnt_last;
U16 tacho1_last,tacho0_last;
U8 tacho0_dir;


//---- Tacho dir ----
u8 Tacho0_Dir(void){
  return (PTA->PDIR>>14)&1;
}
u8 Tacho1_Dir(void){
  return (PTA->PDIR>>15)&1;
}

// ------- Tacho -----

void Tacho0_Get(){
  u16 tmp = Tacho0_Renew();
  tacho0 = tmp - tacho0_last;
  tacho0_last = tmp;
}

u16 Tacho0_Renew(){
  if(tacho0_dir){
    tacho0_tmp -= FTM1->CNT-ftm1cnt_last;
    ftm1cnt_last = FTM1->CNT;
  }
  else{
    tacho0_tmp += FTM1->CNT-ftm1cnt_last;
    ftm1cnt_last = FTM1->CNT;
  }
  return tacho0_tmp;
}

void Tacho1_Get(){
  u16 tmp = tacho1_tmp;
  tacho1 = tmp - tacho1_last;
  tacho1_last = tmp;
}

void MotorL_Output(short x){
  if (x > 1000) x = 1000;
  if (x < -1000) x = -1000;
  
  if (x > 0)
  {
    ftm_pwm_duty(ftm0, ftm_ch4, x);
    ftm_pwm_duty(ftm0, ftm_ch5, 0);
  }
  else {
    ftm_pwm_duty(ftm0, ftm_ch4, 0);
    ftm_pwm_duty(ftm0, ftm_ch5, -x);
  }

}

void MotorR_Output(short x){
  if (x > 1000) x = 1000;
  if (x < -1000) x = -1000;
  
  if (x > 0)
  {
    ftm_pwm_duty(ftm0, ftm_ch6, 0);
    ftm_pwm_duty(ftm0, ftm_ch7, x);
  }
  else {
    ftm_pwm_duty(ftm0, ftm_ch6, -x);
    ftm_pwm_duty(ftm0, ftm_ch7, 0);
  }

}

void MotorL_Enable(u8 x){
  if(x)
    gpio_set(D2, 1);
  else
    gpio_set(D2, 0);
}
void MotorR_Enable(u8 x){
  if(x)
    gpio_set(D3, 1);
  else
    gpio_set(D3, 0);
}

void Servo_Output(s16 x)
{
  if(x>400) x = 400;
  if(x<-400) x = -400;
  FTM2->CONTROLS[0].CnV=SERVO_MID + x;
}

// --- INIT ---

void Motor_Init(){
  ftm_pwm_init(ftm0, ftm_ch4, 10000, 0);
    ftm_pwm_init(ftm0, ftm_ch5, 10000, 0);
    ftm_pwm_init(ftm0, ftm_ch6, 10000, 0);
    ftm_pwm_init(ftm0, ftm_ch7, 10000, 0);
    gpio_init(D2, GPO, 1);
    gpio_init(D3, GPO, 1);
    
    MotorL_Enable(1);
    MotorR_Enable(1);
}

void Servo_Init() {
  SIM->SCGC3|=SIM_SCGC3_FTM2_MASK;
  FTM2->SC|=FTM_SC_CLKS(1)|FTM_SC_PS(6);//PS16,System Clock /64
  FTM2->MOD=8000;//Max Value
  FTM2->CONTROLS[0].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
  FTM2->CONTROLS[0].CnV=SERVO_MID;
  FTM2->POL = 0xff;
  PORTB->PCR[18]|=PORT_PCR_MUX(3);

  Servo_Output(0);
}

void Tacho_Init(){
  SIM->SCGC6 |= SIM_SCGC6_FTM1_MASK;
  /* // Input Cap
  FTM1->SC|=FTM_SC_CLKS(1)|FTM_SC_PS(7);//PS16,System Clock /128
  FTM1->SC &= (~FTM_SC_CPWMS_MASK);
  FTM1->CONTROLS[0].CnSC=1<<2;
  FTM1->CONTROLS[1].CnSC=1<<2;
  PORTA->PCR[12] |= PORT_PCR_MUX(3);
  PORTA->PCR[13] |= PORT_PCR_MUX(3);
  */
  
  // QD for phase0
  PORTA->PCR[12]|=PORT_PCR_MUX(7);
  FTM1->MODE|=FTM_MODE_WPDIS_MASK;//Write protection disable
  FTM1->QDCTRL|=FTM_QDCTRL_QUADMODE_MASK;
  FTM1->CNTIN=0;
  FTM1->MOD=0XFFFF;
  FTM1->QDCTRL|=FTM_QDCTRL_QUADEN_MASK;
  FTM1->MODE|=FTM_MODE_FTMEN_MASK;//let all registers available for use
  FTM1->CNT=0;
  
  // IO interrupt for phase1
  PORTA->PCR[13]|=PORT_PCR_MUX(1);
  PTA->PDDR &=~(1<<13);
  PORTA->PCR[13] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
  NVIC_EnableIRQ(PORTA_IRQn);
  NVIC_SetPriority(PORTA_IRQn, NVIC_EncodePriority(5, 0, 2));
  
  //==== Tacho DIR ===
  PORTA->PCR[14] |= PORT_PCR_MUX(1);
  PORTA->PCR[15] |= PORT_PCR_MUX(1);
  PTA->PDDR &=~(3<<14);
  PORTA->PCR[14] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(11);	//PULLUP | either edge
  PORTA->PCR[15] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
  
  tacho0_dir = Tacho0_Dir();
  
  
  /*
  SIM->SCGC5|=SIM_SCGC5_LPTIMER_MASK;
  PORTC->PCR[5] = PORT_PCR_MUX(4);
  //PORTA->PCR[19] = PORT_PCR_MUX(6);
  LPTMR0->PSR = LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK; 
  LPTMR0->CSR = LPTMR_CSR_TPS(2);
  LPTMR0->CSR = LPTMR_CSR_TMS_MASK;
  LPTMR0->CSR |= LPTMR_CSR_TFC_MASK;
  
  LPTMR0->CSR |= LPTMR_CSR_TEN_MASK;*/
}


void PORTA_IRQHandler(void)
{
  //LED1(0);
    
        //tacho0++;
        if((PORTA->ISFR)&PORT_ISFR_ISF(1 << 13)){// phase 1 
          PORTA->ISFR |= PORT_ISFR_ISF(1 << 13);
          if(Tacho1_Dir())
            tacho1_tmp --;
          else
            tacho1_tmp ++;
        }
        else if((PORTA->ISFR)&PORT_ISFR_ISF(1 << 14)){     // phase 0 dir 
          PORTA->ISFR |= PORT_ISFR_ISF(1 << 14);
          if(Tacho0_Dir()){
            tacho0_dir = 1;
            tacho0_tmp += FTM1->CNT-ftm1cnt_last;
            ftm1cnt_last = FTM1->CNT;
          }
          else{       //  falling
            tacho0_dir = 0;
            tacho0_tmp -= FTM1->CNT-ftm1cnt_last;
            ftm1cnt_last = FTM1->CNT;
    }
  }
  //清除中断标志第一种方法直接操作寄存器，每一位对应一个引脚
	PORTA->ISFR = 0xffffffff;
	//使用我们编写的宏定义清除发生中断的引脚
	PORTA_FLAG_CLR(A1);
        VSYNC();
  
}