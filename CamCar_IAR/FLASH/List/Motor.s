///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      08/Jul/2019  15:37:13
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\Motor.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EW68A7.tmp
//        (E:\IARworkspace\CamCar_IAR\source\Motor.c -lCN
//        E:\IARworkspace\CamCar_IAR\FLASH\List -lB
//        E:\IARworkspace\CamCar_IAR\FLASH\List -o
//        E:\IARworkspace\CamCar_IAR\FLASH\Obj --no_cse --no_unroll --no_inline
//        --no_code_motion --no_tbaa --no_clustering --no_scheduling --debug
//        --endian=little --cpu=Cortex-M4 -e --char_is_signed --fpu=None
//        --dlib_config "D:\Program
//        Files(x86)\IAR\arm\INC\c\DLib_Config_Normal.h" -I
//        E:\IARworkspace\CamCar_IAR\source\ -I
//        E:\IARworkspace\CamCar_IAR\common\ -I
//        E:\IARworkspace\CamCar_IAR\LPLD\ -I
//        E:\IARworkspace\CamCar_IAR\LPLD\HW\ -I
//        E:\IARworkspace\CamCar_IAR\LPLD\DEV\ -Ol -I "D:\Program
//        Files(x86)\IAR\arm\CMSIS\Include\" -D ARM_MATH_CM4)
//    Locale       =  C
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\Motor.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC MotorL_Enable
        PUBLIC MotorL_Output
        PUBLIC MotorR_Enable
        PUBLIC MotorR_Output
        PUBLIC Motor_Init
        PUBLIC PORTA_IRQHandler
        PUBLIC Servo_Init
        PUBLIC Servo_Output
        PUBLIC Tacho0_Dir
        PUBLIC Tacho0_Get
        PUBLIC Tacho0_Renew
        PUBLIC Tacho1_Dir
        PUBLIC Tacho1_Get
        PUBLIC Tacho_Init
        PUBLIC ftm1cnt_last
        PUBLIC tacho0
        PUBLIC tacho0_dir
        PUBLIC tacho0_last
        PUBLIC tacho0_tmp
        PUBLIC tacho1
        PUBLIC tacho1_last
        PUBLIC tacho1_tmp

// E:\IARworkspace\CamCar_IAR\source\Motor.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 #include "includes.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void __NVIC_EnableIRQ(IRQn_Type)
__NVIC_EnableIRQ:
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BMI.N    ??__NVIC_EnableIRQ_0
        MOVS     R2,#+1
        ANDS     R1,R0,#0x1F
        LSLS     R2,R2,R1
        LDR.W    R1,??DataTable15  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R2,[R1, R0, LSL #+2]
??__NVIC_EnableIRQ_0:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void __NVIC_SetPriority(IRQn_Type, uint32_t)
__NVIC_SetPriority:
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BMI.N    ??__NVIC_SetPriority_0
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable15_1  ;; 0xe000e400
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        STRB     R1,[R2, R0]
        B.N      ??__NVIC_SetPriority_1
??__NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable15_2  ;; 0xe000ed18
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        ANDS     R0,R0,#0xF
        ADD      R0,R2,R0
        STRB     R1,[R0, #-4]
??__NVIC_SetPriority_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp uint32_t NVIC_EncodePriority(uint32_t, uint32_t, uint32_t)
NVIC_EncodePriority:
        PUSH     {R4}
        ANDS     R0,R0,#0x7
        RSBS     R3,R0,#+7
        CMP      R3,#+5
        BCC.N    ??NVIC_EncodePriority_0
        MOVS     R3,#+4
        B.N      ??NVIC_EncodePriority_1
??NVIC_EncodePriority_0:
        RSBS     R3,R0,#+7
??NVIC_EncodePriority_1:
        ADDS     R4,R0,#+4
        CMP      R4,#+7
        BCS.N    ??NVIC_EncodePriority_2
        MOVS     R0,#+0
        B.N      ??NVIC_EncodePriority_3
??NVIC_EncodePriority_2:
        SUBS     R0,R0,#+3
??NVIC_EncodePriority_3:
        MOVS     R4,#+1
        LSLS     R3,R4,R3
        SUBS     R3,R3,#+1
        ANDS     R1,R3,R1
        LSLS     R1,R1,R0
        MOVS     R3,#+1
        LSLS     R0,R3,R0
        SUBS     R0,R0,#+1
        ANDS     R0,R0,R2
        ORRS     R0,R0,R1
        POP      {R4}
        BX       LR               ;; return
//    8 
//    9 
//   10 // ===== Setting =====
//   11 #define SERVO_MID 6830 // (g_bus_clock/64*15/10000)  Adjust it according to your mech
//   12 
//   13 
//   14 // ===== Variables =====
//   15 
//   16 // --- Global ----

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//   17 S16 tacho0, tacho1;
tacho0:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
tacho1:
        DS8 2
//   18 
//   19 // --- Local ---

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//   20 U16 tacho1_tmp,tacho0_tmp,ftm1cnt_last;
tacho1_tmp:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
tacho0_tmp:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
ftm1cnt_last:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//   21 U16 tacho1_last,tacho0_last;
tacho1_last:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
tacho0_last:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   22 U8 tacho0_dir;
tacho0_dir:
        DS8 1
//   23 
//   24 // ===== Local Function Decelaration =====
//   25 
//   26 u8 Tacho0_Dir();
//   27 u8 Tacho1_Dir();
//   28 
//   29 
//   30 // ===== APIs Realization =====
//   31 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   32 void Servo_Output(s16 x){
//   33   if(x>400) x = 400;
Servo_Output:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVW     R1,#+401
        CMP      R0,R1
        BLT.N    ??Servo_Output_0
        MOV      R0,#+400
//   34   if(x<-400) x = -400;
??Servo_Output_0:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMN      R0,#+400
        BGE.N    ??Servo_Output_1
        LDR.W    R0,??DataTable15_3  ;; 0xfffffe70
//   35   FTM2->CONTROLS[0].CnV=SERVO_MID + x;
??Servo_Output_1:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        ADD      R0,R0,#+6656
        ADDS     R0,R0,#+174
        LDR.W    R1,??DataTable15_4  ;; 0x400b8010
        STR      R0,[R1, #+0]
//   36 }
        BX       LR               ;; return
//   37 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   38 void MotorL_Output(s16 x){
//   39   if(x>1000) x=1000;
MotorL_Output:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVW     R1,#+1001
        CMP      R0,R1
        BLT.N    ??MotorL_Output_0
        MOV      R0,#+1000
//   40   if(x<-1000) x=-1000;
??MotorL_Output_0:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMN      R0,#+1000
        BGE.N    ??MotorL_Output_1
        LDR.W    R0,??DataTable15_5  ;; 0xfffffc18
//   41   if(x<0){
??MotorL_Output_1:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??MotorL_Output_2
//   42     FTM0->CONTROLS[5].CnV = 0;
        MOVS     R1,#+0
        LDR.W    R2,??DataTable15_6  ;; 0x40038038
        STR      R1,[R2, #+0]
//   43     FTM0->CONTROLS[4].CnV = -x;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        RSBS     R0,R0,#+0
        LDR.W    R1,??DataTable15_7  ;; 0x40038030
        STR      R0,[R1, #+0]
        B.N      ??MotorL_Output_3
//   44   }
//   45   else if(x>0){
??MotorL_Output_2:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BLT.N    ??MotorL_Output_4
//   46     FTM0->CONTROLS[5].CnV = x;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable15_6  ;; 0x40038038
        STR      R0,[R1, #+0]
//   47     FTM0->CONTROLS[4].CnV = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_7  ;; 0x40038030
        STR      R0,[R1, #+0]
        B.N      ??MotorL_Output_3
//   48   }
//   49   else{
//   50     FTM0->CONTROLS[4].CnV = 0;
??MotorL_Output_4:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_7  ;; 0x40038030
        STR      R0,[R1, #+0]
//   51     FTM0->CONTROLS[5].CnV = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_6  ;; 0x40038038
        STR      R0,[R1, #+0]
//   52   }
//   53 }
??MotorL_Output_3:
        BX       LR               ;; return
//   54 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   55 void MotorR_Output(s16 x){
//   56   if(x>1000) x=1000;
MotorR_Output:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVW     R1,#+1001
        CMP      R0,R1
        BLT.N    ??MotorR_Output_0
        MOV      R0,#+1000
//   57   if(x<-1000) x=-1000;
??MotorR_Output_0:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMN      R0,#+1000
        BGE.N    ??MotorR_Output_1
        LDR.W    R0,??DataTable15_5  ;; 0xfffffc18
//   58   if(x>0){
??MotorR_Output_1:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BLT.N    ??MotorR_Output_2
//   59     FTM0->CONTROLS[6].CnV = x;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable15_8  ;; 0x40038040
        STR      R0,[R1, #+0]
//   60     FTM0->CONTROLS[7].CnV = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_9  ;; 0x40038048
        STR      R0,[R1, #+0]
        B.N      ??MotorR_Output_3
//   61   }
//   62   else if(x<0){
??MotorR_Output_2:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??MotorR_Output_4
//   63     FTM0->CONTROLS[6].CnV = 0;
        MOVS     R1,#+0
        LDR.W    R2,??DataTable15_8  ;; 0x40038040
        STR      R1,[R2, #+0]
//   64     FTM0->CONTROLS[7].CnV = -x;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        RSBS     R0,R0,#+0
        LDR.W    R1,??DataTable15_9  ;; 0x40038048
        STR      R0,[R1, #+0]
        B.N      ??MotorR_Output_3
//   65   }
//   66   else{
//   67     FTM0->CONTROLS[6].CnV = 0;
??MotorR_Output_4:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_8  ;; 0x40038040
        STR      R0,[R1, #+0]
//   68     FTM0->CONTROLS[7].CnV = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable15_9  ;; 0x40038048
        STR      R0,[R1, #+0]
//   69   }
//   70 }
??MotorR_Output_3:
        BX       LR               ;; return
//   71 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void MotorL_Enable(u8 x){
//   73   if(x)
MotorL_Enable:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??MotorL_Enable_0
//   74     PTD->PSOR |= 1<<2;
        LDR.W    R0,??DataTable15_10  ;; 0x400ff0c4
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.W    R1,??DataTable15_10  ;; 0x400ff0c4
        STR      R0,[R1, #+0]
        B.N      ??MotorL_Enable_1
//   75   else
//   76     PTD->PCOR |= 1<<2;
??MotorL_Enable_0:
        LDR.W    R0,??DataTable15_11  ;; 0x400ff0c8
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.W    R1,??DataTable15_11  ;; 0x400ff0c8
        STR      R0,[R1, #+0]
//   77 }
??MotorL_Enable_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 void MotorR_Enable(u8 x){
//   79   if(x)
MotorR_Enable:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??MotorR_Enable_0
//   80     PTD->PSOR |= 1<<3;
        LDR.W    R0,??DataTable15_10  ;; 0x400ff0c4
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable15_10  ;; 0x400ff0c4
        STR      R0,[R1, #+0]
        B.N      ??MotorR_Enable_1
//   81   else
//   82     PTD->PCOR |= 1<<3;
??MotorR_Enable_0:
        LDR.W    R0,??DataTable15_11  ;; 0x400ff0c8
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable15_11  ;; 0x400ff0c8
        STR      R0,[R1, #+0]
//   83 }
??MotorR_Enable_1:
        BX       LR               ;; return
//   84 
//   85 // ------- Tacho -----
//   86 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   87 void Tacho0_Get(){
Tacho0_Get:
        PUSH     {R7,LR}
//   88   u16 tmp = Tacho0_Renew();
        BL       Tacho0_Renew
//   89   tacho0 = tmp - tacho0_last;
        LDR.W    R1,??DataTable15_12
        LDRSH    R1,[R1, #+0]
        SUBS     R1,R0,R1
        LDR.W    R2,??DataTable15_13
        STRH     R1,[R2, #+0]
//   90   tacho0_last = tmp;
        LDR.W    R1,??DataTable15_12
        STRH     R0,[R1, #+0]
//   91 }
        POP      {R0,PC}          ;; return
//   92 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 u16 Tacho0_Renew(){
//   94   if(tacho0_dir){
Tacho0_Renew:
        LDR.W    R0,??DataTable15_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Tacho0_Renew_0
//   95     tacho0_tmp -= FTM1->CNT-ftm1cnt_last;
        LDR.W    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable15_16
        LDRH     R1,[R1, #+0]
        LDR.W    R2,??DataTable15_17
        LDRH     R2,[R2, #+0]
        SUBS     R0,R2,R0
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable15_17
        STRH     R0,[R1, #+0]
//   96     ftm1cnt_last = FTM1->CNT;
        LDR.W    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable15_16
        STRH     R0,[R1, #+0]
        B.N      ??Tacho0_Renew_1
//   97   }
//   98   else{
//   99     tacho0_tmp += FTM1->CNT-ftm1cnt_last;
??Tacho0_Renew_0:
        LDR.W    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable15_16
        LDRH     R1,[R1, #+0]
        LDR.W    R2,??DataTable15_17
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable15_17
        STRH     R0,[R1, #+0]
//  100     ftm1cnt_last = FTM1->CNT;
        LDR.W    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable15_16
        STRH     R0,[R1, #+0]
//  101   }
//  102   return tacho0_tmp;
??Tacho0_Renew_1:
        LDR.W    R0,??DataTable15_17
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
//  103 }
//  104 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  105 void Tacho1_Get(){
//  106   u16 tmp = tacho1_tmp;
Tacho1_Get:
        LDR.W    R0,??DataTable15_18
        LDRH     R0,[R0, #+0]
//  107   tacho1 = tmp - tacho1_last;
        LDR.W    R1,??DataTable15_19
        LDRSH    R1,[R1, #+0]
        SUBS     R1,R0,R1
        LDR.W    R2,??DataTable15_20
        STRH     R1,[R2, #+0]
//  108   tacho1_last = tmp;
        LDR.W    R1,??DataTable15_19
        STRH     R0,[R1, #+0]
//  109 }
        BX       LR               ;; return
//  110 
//  111 
//  112 
//  113 // --- INIT ---
//  114 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  115 void Motor_Init(){
Motor_Init:
        PUSH     {R7,LR}
//  116   
//  117   // Motor FTM 
//  118   SIM->SCGC6|=SIM_SCGC6_FTM0_MASK;
        LDR.W    R0,??DataTable15_21  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.W    R1,??DataTable15_21  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  119   FTM0->SC|=FTM_SC_CLKS(1)|FTM_SC_PS(0);//PS16,System Clock
        LDR.W    R0,??DataTable15_22  ;; 0x40038000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable15_22  ;; 0x40038000
        STR      R0,[R1, #+0]
//  120   FTM0->MOD=1000;//Max Value
        MOV      R0,#+1000
        LDR.N    R1,??DataTable15_23  ;; 0x40038008
        STR      R0,[R1, #+0]
//  121   FTM0->CONTROLS[4].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable15_24  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable15_24  ;; 0x4003802c
        STR      R0,[R1, #+0]
//  122   FTM0->CONTROLS[5].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable15_25  ;; 0x40038034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable15_25  ;; 0x40038034
        STR      R0,[R1, #+0]
//  123   FTM0->CONTROLS[6].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable15_26  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable15_26  ;; 0x4003803c
        STR      R0,[R1, #+0]
//  124   FTM0->CONTROLS[7].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable15_27  ;; 0x40038044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable15_27  ;; 0x40038044
        STR      R0,[R1, #+0]
//  125   FTM0->CONTROLS[4].CnV=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_7  ;; 0x40038030
        STR      R0,[R1, #+0]
//  126   FTM0->CONTROLS[5].CnV=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_6  ;; 0x40038038
        STR      R0,[R1, #+0]
//  127   FTM0->CONTROLS[6].CnV=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_8  ;; 0x40038040
        STR      R0,[R1, #+0]
//  128   FTM0->CONTROLS[7].CnV=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_9  ;; 0x40038048
        STR      R0,[R1, #+0]
//  129   FTM0->POL = 0xff;
        MOVS     R0,#+255
        LDR.N    R1,??DataTable15_28  ;; 0x40038070
        STR      R0,[R1, #+0]
//  130   
//  131   PORTD->PCR[4]|=PORT_PCR_MUX(4);
        LDR.N    R0,??DataTable15_29  ;; 0x4004c010
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.N    R1,??DataTable15_29  ;; 0x4004c010
        STR      R0,[R1, #+0]
//  132   PORTD->PCR[5]|=PORT_PCR_MUX(4);
        LDR.N    R0,??DataTable15_30  ;; 0x4004c014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.N    R1,??DataTable15_30  ;; 0x4004c014
        STR      R0,[R1, #+0]
//  133   PORTD->PCR[6]|=PORT_PCR_MUX(4);
        LDR.N    R0,??DataTable15_31  ;; 0x4004c018
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.N    R1,??DataTable15_31  ;; 0x4004c018
        STR      R0,[R1, #+0]
//  134   PORTD->PCR[7]|=PORT_PCR_MUX(4);
        LDR.N    R0,??DataTable15_32  ;; 0x4004c01c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.N    R1,??DataTable15_32  ;; 0x4004c01c
        STR      R0,[R1, #+0]
//  135   
//  136   // Motor enable
//  137   PORTD->PCR[2] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable15_33  ;; 0x4004c008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable15_33  ;; 0x4004c008
        STR      R0,[R1, #+0]
//  138   PORTD->PCR[3] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable15_34  ;; 0x4004c00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable15_34  ;; 0x4004c00c
        STR      R0,[R1, #+0]
//  139   PTD->PDDR |= (3<<2);
        LDR.N    R0,??DataTable15_35  ;; 0x400ff0d4
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0xC
        LDR.N    R1,??DataTable15_35  ;; 0x400ff0d4
        STR      R0,[R1, #+0]
//  140   PTD->PDOR |= (3<<2);
        LDR.N    R0,??DataTable15_36  ;; 0x400ff0c0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0xC
        LDR.N    R1,??DataTable15_36  ;; 0x400ff0c0
        STR      R0,[R1, #+0]
//  141   
//  142   
//  143   // enable
//  144   MotorL_Enable(1);
        MOVS     R0,#+1
        BL       MotorL_Enable
//  145   MotorR_Enable(1);
        MOVS     R0,#+1
        BL       MotorR_Enable
//  146 }
        POP      {R0,PC}          ;; return
//  147 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  148 void Tacho_Init(){
Tacho_Init:
        PUSH     {R7,LR}
//  149   SIM->SCGC6 |= SIM_SCGC6_FTM1_MASK;
        LDR.N    R0,??DataTable15_21  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable15_21  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  150   /* // Input Cap
//  151   FTM1->SC|=FTM_SC_CLKS(1)|FTM_SC_PS(7);//PS16,System Clock /128
//  152   FTM1->SC &= (~FTM_SC_CPWMS_MASK);
//  153   FTM1->CONTROLS[0].CnSC=1<<2;
//  154   FTM1->CONTROLS[1].CnSC=1<<2;
//  155   PORTA->PCR[12] |= PORT_PCR_MUX(3);
//  156   PORTA->PCR[13] |= PORT_PCR_MUX(3);
//  157   */
//  158   
//  159   // QD for phase0
//  160   PORTA->PCR[12]|=PORT_PCR_MUX(7);
        LDR.N    R0,??DataTable15_37  ;; 0x40049030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x700
        LDR.N    R1,??DataTable15_37  ;; 0x40049030
        STR      R0,[R1, #+0]
//  161   FTM1->MODE|=FTM_MODE_WPDIS_MASK;//Write protection disable
        LDR.N    R0,??DataTable15_38  ;; 0x40039054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable15_38  ;; 0x40039054
        STR      R0,[R1, #+0]
//  162   FTM1->QDCTRL|=FTM_QDCTRL_QUADMODE_MASK;
        LDR.N    R0,??DataTable15_39  ;; 0x40039080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable15_39  ;; 0x40039080
        STR      R0,[R1, #+0]
//  163   FTM1->CNTIN=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_40  ;; 0x4003904c
        STR      R0,[R1, #+0]
//  164   FTM1->MOD=0XFFFF;
        MOVW     R0,#+65535
        LDR.N    R1,??DataTable15_41  ;; 0x40039008
        STR      R0,[R1, #+0]
//  165   FTM1->QDCTRL|=FTM_QDCTRL_QUADEN_MASK;
        LDR.N    R0,??DataTable15_39  ;; 0x40039080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable15_39  ;; 0x40039080
        STR      R0,[R1, #+0]
//  166   FTM1->MODE|=FTM_MODE_FTMEN_MASK;//let all registers available for use
        LDR.N    R0,??DataTable15_38  ;; 0x40039054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable15_38  ;; 0x40039054
        STR      R0,[R1, #+0]
//  167   FTM1->CNT=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_15  ;; 0x40039004
        STR      R0,[R1, #+0]
//  168   
//  169   // IO interrupt for phase1
//  170   PORTA->PCR[13]|=PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable15_42  ;; 0x40049034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable15_42  ;; 0x40049034
        STR      R0,[R1, #+0]
//  171   PTA->PDDR &=~(1<<13);
        LDR.N    R0,??DataTable15_43  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2000
        LDR.N    R1,??DataTable15_43  ;; 0x400ff014
        STR      R0,[R1, #+0]
//  172   PORTA->PCR[13] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
        LDR.N    R0,??DataTable15_42  ;; 0x40049034
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xA0000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable15_42  ;; 0x40049034
        STR      R0,[R1, #+0]
//  173   NVIC_EnableIRQ(PORTA_IRQn);
        MOVS     R0,#+87
        BL       __NVIC_EnableIRQ
//  174   NVIC_SetPriority(PORTA_IRQn, NVIC_EncodePriority(NVIC_GROUP, 0, 2));
        MOVS     R2,#+2
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+87
        BL       __NVIC_SetPriority
//  175   
//  176   //==== Tacho DIR ===
//  177   PORTA->PCR[14] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable15_44  ;; 0x40049038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable15_44  ;; 0x40049038
        STR      R0,[R1, #+0]
//  178   PORTA->PCR[15] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable15_45  ;; 0x4004903c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable15_45  ;; 0x4004903c
        STR      R0,[R1, #+0]
//  179   PTA->PDDR &=~(3<<14);
        LDR.N    R0,??DataTable15_43  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0xC000
        LDR.N    R1,??DataTable15_43  ;; 0x400ff014
        STR      R0,[R1, #+0]
//  180   PORTA->PCR[14] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(11);	//PULLUP | either edge
        LDR.N    R0,??DataTable15_44  ;; 0x40049038
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xB0000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable15_44  ;; 0x40049038
        STR      R0,[R1, #+0]
//  181   PORTA->PCR[15] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
        LDR.N    R0,??DataTable15_45  ;; 0x4004903c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable15_45  ;; 0x4004903c
        STR      R0,[R1, #+0]
//  182   
//  183   tacho0_dir = Tacho0_Dir();
        BL       Tacho0_Dir
        LDR.N    R1,??DataTable15_14
        STRB     R0,[R1, #+0]
//  184   
//  185   /*
//  186   SIM->SCGC5|=SIM_SCGC5_LPTIMER_MASK;
//  187   PORTC->PCR[5] = PORT_PCR_MUX(4);
//  188   //PORTA->PCR[19] = PORT_PCR_MUX(6);
//  189   LPTMR0->PSR = LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK; 
//  190   LPTMR0->CSR = LPTMR_CSR_TPS(2);
//  191   LPTMR0->CSR = LPTMR_CSR_TMS_MASK;
//  192   LPTMR0->CSR |= LPTMR_CSR_TFC_MASK;
//  193   
//  194   LPTMR0->CSR |= LPTMR_CSR_TEN_MASK;*/
//  195 }
        POP      {R0,PC}          ;; return
//  196 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 void Servo_Init(){
Servo_Init:
        PUSH     {R7,LR}
//  198   SIM->SCGC3|=SIM_SCGC3_FTM2_MASK;
        LDR.N    R0,??DataTable15_46  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.N    R1,??DataTable15_46  ;; 0x40048030
        STR      R0,[R1, #+0]
//  199   FTM2->SC|=FTM_SC_CLKS(1)|FTM_SC_PS(6);//PS16,System Clock /64
        LDR.N    R0,??DataTable15_47  ;; 0x400b8000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0xE
        LDR.N    R1,??DataTable15_47  ;; 0x400b8000
        STR      R0,[R1, #+0]
//  200   FTM2->MOD=8000;//Max Value
        MOV      R0,#+8000
        LDR.N    R1,??DataTable15_48  ;; 0x400b8008
        STR      R0,[R1, #+0]
//  201   FTM2->CONTROLS[0].CnSC|=FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable15_49  ;; 0x400b800c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable15_49  ;; 0x400b800c
        STR      R0,[R1, #+0]
//  202   FTM2->CONTROLS[0].CnV=SERVO_MID;
        MOVW     R0,#+6830
        LDR.N    R1,??DataTable15_4  ;; 0x400b8010
        STR      R0,[R1, #+0]
//  203   FTM2->POL = 0xff;
        MOVS     R0,#+255
        LDR.N    R1,??DataTable15_50  ;; 0x400b8070
        STR      R0,[R1, #+0]
//  204   PORTB->PCR[18]|=PORT_PCR_MUX(3);
        LDR.N    R0,??DataTable15_51  ;; 0x4004a048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x300
        LDR.N    R1,??DataTable15_51  ;; 0x4004a048
        STR      R0,[R1, #+0]
//  205 
//  206   Servo_Output(0);
        MOVS     R0,#+0
        BL       Servo_Output
//  207 }
        POP      {R0,PC}          ;; return
//  208 
//  209 
//  210 
//  211 
//  212 
//  213 // ======== Basic Drivers ========
//  214 
//  215 //---- Tacho dir ----

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  216 u8 Tacho0_Dir(void){
//  217   return (PTA->PDIR>>14)&1;
Tacho0_Dir:
        LDR.N    R0,??DataTable15_52  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+14
        ANDS     R0,R0,#0x1
        BX       LR               ;; return
//  218 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  219 u8 Tacho1_Dir(void){
//  220   return (PTA->PDIR>>15)&1;
Tacho1_Dir:
        LDR.N    R0,??DataTable15_52  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+15
        ANDS     R0,R0,#0x1
        BX       LR               ;; return
//  221 }
//  222 
//  223 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 void PORTA_IRQHandler(){
PORTA_IRQHandler:
        PUSH     {R7,LR}
//  225   if((PORTA->ISFR)&PORT_ISFR_ISF(1 << 13)){     // phase 1 
        LDR.N    R0,??DataTable15_53  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+18
        BPL.N    ??PORTA_IRQHandler_0
//  226     PORTA->ISFR |= PORT_ISFR_ISF(1 << 13);
        LDR.N    R0,??DataTable15_53  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable15_53  ;; 0x400490a0
        STR      R0,[R1, #+0]
//  227     if(Tacho1_Dir())
        BL       Tacho1_Dir
        CMP      R0,#+0
        BEQ.N    ??PORTA_IRQHandler_1
//  228       tacho1_tmp ++;
        LDR.N    R0,??DataTable15_18
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable15_18
        STRH     R0,[R1, #+0]
        B.N      ??PORTA_IRQHandler_2
//  229     else
//  230       tacho1_tmp --;
??PORTA_IRQHandler_1:
        LDR.N    R0,??DataTable15_18
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable15_18
        STRH     R0,[R1, #+0]
        B.N      ??PORTA_IRQHandler_2
//  231   }
//  232   else if((PORTA->ISFR)&PORT_ISFR_ISF(1 << 14)){     // phase 0 dir 
??PORTA_IRQHandler_0:
        LDR.N    R0,??DataTable15_53  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+17
        BPL.N    ??PORTA_IRQHandler_2
//  233     PORTA->ISFR |= PORT_ISFR_ISF(1 << 14);
        LDR.N    R0,??DataTable15_53  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable15_53  ;; 0x400490a0
        STR      R0,[R1, #+0]
//  234     if(Tacho0_Dir()){
        BL       Tacho0_Dir
        CMP      R0,#+0
        BEQ.N    ??PORTA_IRQHandler_3
//  235       tacho0_dir = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable15_14
        STRB     R0,[R1, #+0]
//  236       tacho0_tmp += FTM1->CNT-ftm1cnt_last;
        LDR.N    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15_16
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??DataTable15_17
        LDRH     R2,[R2, #+0]
        ADDS     R0,R0,R2
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable15_17
        STRH     R0,[R1, #+0]
//  237       ftm1cnt_last = FTM1->CNT;
        LDR.N    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15_16
        STRH     R0,[R1, #+0]
        B.N      ??PORTA_IRQHandler_2
//  238     }
//  239     else{       //  falling
//  240       tacho0_dir = 0;
??PORTA_IRQHandler_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable15_14
        STRB     R0,[R1, #+0]
//  241       tacho0_tmp -= FTM1->CNT-ftm1cnt_last;
        LDR.N    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15_16
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??DataTable15_17
        LDRH     R2,[R2, #+0]
        SUBS     R0,R2,R0
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable15_17
        STRH     R0,[R1, #+0]
//  242       ftm1cnt_last = FTM1->CNT;
        LDR.N    R0,??DataTable15_15  ;; 0x40039004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15_16
        STRH     R0,[R1, #+0]
//  243     }
//  244   }
//  245 }
??PORTA_IRQHandler_2:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_1:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_2:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_3:
        DC32     0xfffffe70

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_4:
        DC32     0x400b8010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_5:
        DC32     0xfffffc18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_6:
        DC32     0x40038038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_7:
        DC32     0x40038030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_8:
        DC32     0x40038040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_9:
        DC32     0x40038048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_10:
        DC32     0x400ff0c4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_11:
        DC32     0x400ff0c8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_12:
        DC32     tacho0_last

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_13:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_14:
        DC32     tacho0_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_15:
        DC32     0x40039004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_16:
        DC32     ftm1cnt_last

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_17:
        DC32     tacho0_tmp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_18:
        DC32     tacho1_tmp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_19:
        DC32     tacho1_last

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_20:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_21:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_22:
        DC32     0x40038000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_23:
        DC32     0x40038008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_24:
        DC32     0x4003802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_25:
        DC32     0x40038034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_26:
        DC32     0x4003803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_27:
        DC32     0x40038044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_28:
        DC32     0x40038070

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_29:
        DC32     0x4004c010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_30:
        DC32     0x4004c014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_31:
        DC32     0x4004c018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_32:
        DC32     0x4004c01c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_33:
        DC32     0x4004c008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_34:
        DC32     0x4004c00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_35:
        DC32     0x400ff0d4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_36:
        DC32     0x400ff0c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_37:
        DC32     0x40049030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_38:
        DC32     0x40039054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_39:
        DC32     0x40039080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_40:
        DC32     0x4003904c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_41:
        DC32     0x40039008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_42:
        DC32     0x40049034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_43:
        DC32     0x400ff014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_44:
        DC32     0x40049038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_45:
        DC32     0x4004903c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_46:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_47:
        DC32     0x400b8000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_48:
        DC32     0x400b8008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_49:
        DC32     0x400b800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_50:
        DC32     0x400b8070

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_51:
        DC32     0x4004a048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_52:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15_53:
        DC32     0x400490a0

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
//    15 bytes in section .bss
// 1 538 bytes in section .text
// 
// 1 538 bytes of CODE memory
//    15 bytes of DATA memory
//
//Errors: none
//Warnings: 4
