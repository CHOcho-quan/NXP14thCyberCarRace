///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      08/Jul/2019  15:30:48
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\PIT.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EW870A.tmp
//        (E:\IARworkspace\CamCar_IAR\source\PIT.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\PIT.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Battery
        EXTERN Bell_Service
        EXTERN LED1_Tog
        EXTERN Mag_Sample
        EXTERN Oled_Clear
        EXTERN Oled_Putnum
        EXTERN Oled_Putstr
        EXTERN Tacho0_Get
        EXTERN Tacho1_Get
        EXTERN battery
        EXTERN displayCamera
        EXTERN g_bus_clock
        EXTERN huandao
        EXTERN mag_val
        EXTERN tacho0
        EXTERN tacho1
        EXTERN ui_operation_cnt

        PUBLIC PIT0_IRQHandler
        PUBLIC PIT0_Init
        PUBLIC PIT1_IRQHandler
        PUBLIC PIT1_Init
        PUBLIC PIT2_Init
        PUBLIC pit0_time
        PUBLIC pit1_time
        PUBLIC pit1_time_tmp
        PUBLIC time_us

// E:\IARworkspace\CamCar_IAR\source\PIT.c
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
        LDR.W    R1,??DataTable6  ;; 0xe000e100
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
        LDR.W    R2,??DataTable6_1  ;; 0xe000e400
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        STRB     R1,[R2, R0]
        B.N      ??__NVIC_SetPriority_1
??__NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable6_2  ;; 0xe000ed18
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
//   10 // ========= Variables =========
//   11 
//   12 //--- global ---

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   13 U32 time_us = 0;
time_us:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   14 U32 pit0_time;
pit0_time:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   15 U32 pit1_time; 
pit1_time:
        DS8 4
//   16 
//   17 //--- local ---

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   18 U32 pit1_time_tmp;
pit1_time_tmp:
        DS8 4
//   19 extern int dir;
//   20 extern u16 mid;
//   21 extern int left_right;
//   22 // =========== PIT 1 ISR =========== 
//   23 // ====  UI Refreshing Loop  ==== ( Low priority ) 
//   24 
//   25 
//   26 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   27 void PIT1_IRQHandler(){
PIT1_IRQHandler:
        PUSH     {R7,LR}
//   28   PIT->CHANNEL[1].TFLG |= PIT_TFLG_TIF_MASK;
        LDR.N    R0,??DataTable6_3  ;; 0x4003711c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_3  ;; 0x4003711c
        STR      R0,[R1, #+0]
//   29   
//   30   pit1_time_tmp = PIT2_VAL();
        LDR.N    R0,??DataTable6_4  ;; 0x40037124
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_5
        STR      R0,[R1, #+0]
//   31   
//   32   //------------------------
//   33   
//   34   LED1_Tog();
        BL       LED1_Tog
//   35   
//   36   //UI_Operation_Service();
//   37   
//   38   Bell_Service();
        BL       Bell_Service
//   39   
//   40   //Oled_Clear();
//   41   /*
//   42   Oled_Putstr(0,0,"0"); Oled_Putnum(0,11,mag_val[0]);
//   43   Oled_Putstr(1,0,"1"); Oled_Putnum(1,11,mag_val[1]);
//   44   Oled_Putstr(3,0,"2"); Oled_Putnum(3,11,mag_val[2]);
//   45   Oled_Putstr(4,0,"3"); Oled_Putnum(4,11,mag_val[3]);
//   46   Oled_Putstr(5,0,"4"); Oled_Putnum(5,11,mag_val[4]);
//   47   Oled_Putstr(6,0,"5"); Oled_Putnum(6,11,mag_val[5]);
//   48   */
//   49   //Oled_Putstr(0,0,"last_dir"); Oled_Putnum(0,11,left_right);
//   50   //Oled_Putstr(0,0,"left white"); Oled_Putnum(0,11,left_white);
//   51   //Oled_Putstr(1,0,"right white"); Oled_Putnum(1,11,right_white);
//   52    //Oled_Putstr(1,0,"mid: "); Oled_Putnum(1,11,mid);
//   53   //Oled_Putstr(1,0,"dir: "); Oled_Putnum(1,11,dir);
//   54 
//   55   if(!SW1())
        LDR.N    R0,??DataTable6_6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BNE.N    ??PIT1_IRQHandler_0
//   56   {
//   57     Oled_Clear();
        BL       Oled_Clear
//   58     /*
//   59     Oled_Putstr(0,0,"Dir: "); Oled_Putnum(0,6,dir);
//   60     Oled_Putstr(2,0,"Mid: "); Oled_Putnum(2,6,mid);
//   61     */
//   62     Oled_Putstr(0,0,"0"); Oled_Putnum(0,11,mag_val[0]);
        ADR.N    R2,??DataTable4  ;; "0"
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+0]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+0
        BL       Oled_Putnum
//   63     Oled_Putstr(1,0,"1"); Oled_Putnum(1,11,mag_val[1]);
        ADR.N    R2,??DataTable4_1  ;; "1"
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+2]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       Oled_Putnum
//   64     Oled_Putstr(2,0,"2"); Oled_Putnum(2,11,mag_val[2]);
        ADR.N    R2,??DataTable4_2  ;; "2"
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+4]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+2
        BL       Oled_Putnum
//   65     Oled_Putstr(3,0,"3"); Oled_Putnum(3,11,mag_val[3]);
        ADR.N    R2,??DataTable4_3  ;; "3"
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+6]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+3
        BL       Oled_Putnum
//   66     Oled_Putstr(4,0,"4"); Oled_Putnum(4,11,mag_val[4]);
        ADR.N    R2,??DataTable5  ;; "4"
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+8]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+4
        BL       Oled_Putnum
//   67     Oled_Putstr(5,0,"5"); Oled_Putnum(5,11,mag_val[5]);
        ADR.N    R2,??DataTable5_1  ;; "5"
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_7
        LDRSH    R0,[R0, #+10]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+5
        BL       Oled_Putnum
//   68     Oled_Putstr(6,0,"huandao"); Oled_Putnum(6,11,huandao);
        LDR.N    R2,??DataTable6_8
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_9
        LDR      R2,[R0, #+0]
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+6
        BL       Oled_Putnum
//   69   }
//   70   if(!SW2())
??PIT1_IRQHandler_0:
        LDR.N    R0,??DataTable6_6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BNE.N    ??PIT1_IRQHandler_1
//   71   {
//   72     Oled_Clear();
        BL       Oled_Clear
//   73     displayCamera();
        BL       displayCamera
//   74   }
//   75   if(!SW3())
??PIT1_IRQHandler_1:
        LDR.N    R0,??DataTable6_6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+6,#+1
        CMP      R0,#+0
        BNE.N    ??PIT1_IRQHandler_2
//   76     Oled_Clear();
        BL       Oled_Clear
//   77   if(!SW4())
??PIT1_IRQHandler_2:
        LDR.N    R0,??DataTable6_6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+7,#+1
        CMP      R0,#+0
        BNE.N    ??PIT1_IRQHandler_3
//   78   {
//   79     Oled_Clear();
        BL       Oled_Clear
//   80     Oled_Putstr(1,0,"tacho: "); Oled_Putnum(1,6,tacho0);
        LDR.N    R2,??DataTable6_10
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_11
        LDRSH    R2,[R0, #+0]
        MOVS     R1,#+6
        MOVS     R0,#+1
        BL       Oled_Putnum
//   81     Oled_Putstr(2,0,"tacho1: "); Oled_Putnum(2,6,tacho1);
        LDR.N    R2,??DataTable6_12
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       Oled_Putstr
        LDR.N    R0,??DataTable6_13
        LDRSH    R2,[R0, #+0]
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       Oled_Putnum
//   82   }
//   83   
//   84   
//   85   //------------ Other -------------
//   86   
//   87   pit1_time_tmp = pit1_time_tmp - PIT2_VAL();
??PIT1_IRQHandler_3:
        LDR.N    R0,??DataTable6_5
        LDR      R1,[R0, #+0]
        LDR.N    R0,??DataTable6_4  ;; 0x40037124
        LDR      R0,[R0, #+0]
        SUBS     R1,R1,R0
        LDR.N    R0,??DataTable6_5
        STR      R1,[R0, #+0]
//   88   pit1_time_tmp = pit1_time_tmp / (g_bus_clock/10000); //100us
        LDR.N    R0,??DataTable6_14
        LDR      R0,[R0, #+0]
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable6_5
        LDR      R1,[R1, #+0]
        UDIV     R0,R1,R0
        LDR.N    R1,??DataTable6_5
        STR      R0,[R1, #+0]
//   89   pit1_time = pit1_time_tmp;
        LDR.N    R0,??DataTable6_5
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_15
        STR      R0,[R1, #+0]
//   90   
//   91 }
        POP      {R0,PC}          ;; return
//   92 
//   93 
//   94 
//   95 //============ PIT 0 ISR  ==========
//   96 // ====  Control  ==== ( High priority )
//   97 
//   98 
//   99 
//  100 
//  101 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  102 void PIT0_IRQHandler(){
PIT0_IRQHandler:
        PUSH     {R7,LR}
//  103   PIT->CHANNEL[0].TFLG |= PIT_TFLG_TIF_MASK;
        LDR.N    R0,??DataTable6_16  ;; 0x4003710c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_16  ;; 0x4003710c
        STR      R0,[R1, #+0]
//  104   
//  105   time_us += PIT0_PERIOD_US;
        LDR.N    R0,??DataTable6_17
        LDR      R0,[R0, #+0]
        ADDW     R0,R0,#+2500
        LDR.N    R1,??DataTable6_17
        STR      R0,[R1, #+0]
//  106 
//  107   //LED2_Tog();
//  108   
//  109   //-------- System info -----
//  110   
//  111   pit0_time = PIT2_VAL();
        LDR.N    R0,??DataTable6_4  ;; 0x40037124
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_18
        STR      R0,[R1, #+0]
//  112     
//  113   battery = Battery();
        BL       Battery
        LDR.N    R1,??DataTable6_19
        STRH     R0,[R1, #+0]
//  114   
//  115   
//  116   
//  117   
//  118   //-------- Get Sensers -----
//  119   
//  120   
//  121   // Tacho
//  122   Tacho0_Get();
        BL       Tacho0_Get
//  123   Tacho1_Get();
        BL       Tacho1_Get
//  124   
//  125   
//  126   // UI operation input
//  127   ui_operation_cnt += tacho0;  // use tacho0 or tacho1
        LDR.N    R0,??DataTable6_20
        LDRH     R1,[R0, #+0]
        LDR.N    R0,??DataTable6_11
        LDRSH    R0,[R0, #+0]
        ADDS     R1,R0,R1
        LDR.N    R0,??DataTable6_20
        STRH     R1,[R0, #+0]
//  128     
//  129     
//  130   
//  131 #if (CAR_TYPE==0)   // Magnet and Balance
//  132   
//  133   Mag_Sample();
        BL       Mag_Sample
//  134 
//  135   //gyro1 = Gyro1();
//  136   //gyro2 = Gyro2();
//  137   
//  138   
//  139   
//  140 #elif (CAR_TYPE==1)     // CCD
//  141   
//  142   //CCD1_GetLine();
//  143   //CCD2_GetLine();
//  144   
//  145   
//  146   
//  147   
//  148 #else               // Camera & Mag
//  149   
//  150   // Results of camera are automatically put in cam_buffer[].
//  151   Mag_Sample();
//  152   
//  153   
//  154 #endif
//  155   
//  156   
//  157   
//  158   // -------- Sensor Algorithm --------- ( Users need to realize this )
//  159   
//  160   // mag example : dir_error = Mag_Algorithm(mag_val);
//  161   // ccd example : dir_error = CCD_Algorithm(ccd1_line,ccd2_line);
//  162   // cam is complex. realize it in Cam_Algorithm() in Cam.c
//  163   
//  164   //-------- Controller --------
//  165   
//  166   
//  167   // not balance example : dir_output = Dir_PIDController(dir_error);
//  168   // example : get 'motorL_output' and  'motorR_output'
//  169   
//  170   
//  171   // ------- Output -----
//  172   
//  173   
//  174   // not balance example : Servo_Output(dir_output);  
//  175   // example : MotorL_Output(motorL_output); MotorR_Output(motorR_output);
//  176   
//  177   
//  178   
//  179   // ------- UART ---------
//  180   
//  181   
//  182   //UART_SendDataHead();
//  183   //UART_SendData(battery);
//  184   
//  185   
//  186   
//  187   // ------- other --------
//  188   
//  189   pit0_time = pit0_time - PIT2_VAL();
        LDR.N    R0,??DataTable6_18
        LDR      R1,[R0, #+0]
        LDR.N    R0,??DataTable6_4  ;; 0x40037124
        LDR      R0,[R0, #+0]
        SUBS     R1,R1,R0
        LDR.N    R0,??DataTable6_18
        STR      R1,[R0, #+0]
//  190   pit0_time = pit0_time / (g_bus_clock/1000000); //us
        LDR.N    R0,??DataTable6_14
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_21  ;; 0xf4240
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable6_18
        LDR      R1,[R1, #+0]
        UDIV     R0,R1,R0
        LDR.N    R1,??DataTable6_18
        STR      R0,[R1, #+0]
//  191   
//  192 }
        POP      {R0,PC}          ;; return
//  193 
//  194 
//  195 
//  196 
//  197 // ======= INIT ========
//  198 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  199 void PIT0_Init(u32 period_us)
//  200 { 
PIT0_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  201                    
//  202   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
        LDR.N    R0,??DataTable6_22  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable6_22  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  203   
//  204   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_23  ;; 0x40037000
        STR      R0,[R1, #+0]
//  205  
//  206   NVIC_EnableIRQ(PIT0_IRQn); 
        MOVS     R0,#+68
        BL       __NVIC_EnableIRQ
//  207   NVIC_SetPriority(PIT0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+68
        BL       __NVIC_SetPriority
//  208 
//  209   //period = (period_ns/bus_period_ns)-1
//  210   PIT->CHANNEL[0].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
        LDR.N    R0,??DataTable6_24  ;; 0x40037100
        LDR      R1,[R0, #+0]
        MOVS     R0,#+100
        UDIV     R2,R4,R0
        LDR.N    R0,??DataTable6_14
        LDR      R0,[R0, #+0]
        MOV      R3,#+1000
        UDIV     R0,R0,R3
        MULS     R2,R0,R2
        MOVS     R0,#+10
        UDIV     R0,R2,R0
        SUBS     R0,R0,#+1
        ORRS     R1,R0,R1
        LDR.N    R0,??DataTable6_24  ;; 0x40037100
        STR      R1,[R0, #+0]
//  211   
//  212   PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable6_25  ;; 0x40037108
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable6_25  ;; 0x40037108
        STR      R0,[R1, #+0]
//  213 
//  214 };
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC8      "0",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC8      "1",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC8      "2",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC8      "3",0x0,0x0
//  215 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  216 void PIT1_Init(u32 period_us)
//  217 { 
PIT1_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  218                    
//  219   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
        LDR.N    R0,??DataTable6_22  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable6_22  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  220   
//  221   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_23  ;; 0x40037000
        STR      R0,[R1, #+0]
//  222  
//  223   NVIC_EnableIRQ(PIT1_IRQn); 
        MOVS     R0,#+69
        BL       __NVIC_EnableIRQ
//  224   NVIC_SetPriority(PIT1_IRQn, NVIC_EncodePriority(NVIC_GROUP, 3, 0));
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+69
        BL       __NVIC_SetPriority
//  225 
//  226   //period = (period_ns/bus_period_ns)-1
//  227   PIT->CHANNEL[1].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
        LDR.N    R0,??DataTable6_26  ;; 0x40037110
        LDR      R1,[R0, #+0]
        MOVS     R0,#+100
        UDIV     R2,R4,R0
        LDR.N    R0,??DataTable6_14
        LDR      R0,[R0, #+0]
        MOV      R3,#+1000
        UDIV     R0,R0,R3
        MULS     R2,R0,R2
        MOVS     R0,#+10
        UDIV     R0,R2,R0
        SUBS     R0,R0,#+1
        ORRS     R1,R0,R1
        LDR.N    R0,??DataTable6_26  ;; 0x40037110
        STR      R1,[R0, #+0]
//  228   
//  229   PIT->CHANNEL[1].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable6_27  ;; 0x40037118
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable6_27  ;; 0x40037118
        STR      R0,[R1, #+0]
//  230 
//  231 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC8      "4",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC8      "5",0x0,0x0
//  232 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  233 void PIT2_Init()
//  234 { 
//  235                    
//  236   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
PIT2_Init:
        LDR.N    R0,??DataTable6_22  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable6_22  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  237   
//  238   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_23  ;; 0x40037000
        STR      R0,[R1, #+0]
//  239 
//  240   //period = (period_ns/bus_period_ns)-1
//  241   PIT->CHANNEL[2].LDVAL = 0xffffffff; 
        MOVS     R0,#-1
        LDR.N    R1,??DataTable6_28  ;; 0x40037120
        STR      R0,[R1, #+0]
//  242   
//  243   PIT->CHANNEL[2].TCTRL |= PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable6_29  ;; 0x40037128
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_29  ;; 0x40037128
        STR      R0,[R1, #+0]
//  244 
//  245 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x4003711c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     0x40037124

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     pit1_time_tmp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     0x400ff090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     mag_val

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     huandao

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     ?_7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     ?_8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_14:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_15:
        DC32     pit1_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_16:
        DC32     0x4003710c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_17:
        DC32     time_us

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_18:
        DC32     pit0_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_19:
        DC32     battery

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_20:
        DC32     ui_operation_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_21:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_22:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_23:
        DC32     0x40037000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_24:
        DC32     0x40037100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_25:
        DC32     0x40037108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_26:
        DC32     0x40037110

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_27:
        DC32     0x40037118

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_28:
        DC32     0x40037120

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_29:
        DC32     0x40037128

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "3"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "4"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "5"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_6:
        DC8 "huandao"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_7:
        DC8 "tacho: "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_8:
        DC8 "tacho1: "
        DC8 0, 0, 0

        END
// 
//    16 bytes in section .bss
//    40 bytes in section .rodata
// 1 002 bytes in section .text
// 
// 1 002 bytes of CODE  memory
//    40 bytes of CONST memory
//    16 bytes of DATA  memory
//
//Errors: none
//Warnings: 2
