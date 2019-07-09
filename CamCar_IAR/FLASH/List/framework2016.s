///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      09/Jul/2019  18:03:26
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\framework2016.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EWA29A.tmp
//        (E:\IARworkspace\CamCar_IAR\source\framework2016.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\framework2016.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Flash_Init
        EXTERN Flash_Read
        EXTERN Flash_Write
        EXTERN Gyro_Init
        EXTERN HMI_Init
        EXTERN LPLD_MMA8451_Init
        EXTERN Mag_Control
        EXTERN Mag_Init
        EXTERN MotorL_Output
        EXTERN MotorR_Output
        EXTERN Motor_Init
        EXTERN Oled_Clear
        EXTERN Oled_Init
        EXTERN Oled_Putnum
        EXTERN Oled_Putstr
        EXTERN PIT0_Init
        EXTERN PIT1_Init
        EXTERN PIT2_Init
        EXTERN Servo_Init
        EXTERN Servo_Output
        EXTERN Tacho_Init
        EXTERN UART_Init
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_dmul
        EXTERN __aeabi_i2d
        EXTERN `data`
        EXTERN tacho0
        EXTERN tacho1

        PUBLIC ADC0_enabled
        PUBLIC ADC1_enabled
        PUBLIC BusFault_Handler
        PUBLIC DefaultISR
        PUBLIC HardFault_Handler
        PUBLIC NMI_Handler
        PUBLIC err_motorL
        PUBLIC err_motorR
        PUBLIC last_err_motorL
        PUBLIC last_err_motorR
        PUBLIC main
        PUBLIC motor_outL
        PUBLIC motor_outR
        PUBLIC motor_xL
        PUBLIC motor_xR

// E:\IARworkspace\CamCar_IAR\source\framework2016.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 
//    8 #include "includes.h"
//    9 
//   10 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   11 U8 ADC0_enabled = 0;
ADC0_enabled:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   12 U8 ADC1_enabled = 0;
ADC1_enabled:
        DS8 1
//   13 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//   14 s16 err_motorL = 0, last_err_motorL = 0, motor_outL = 0, motor_outR = 0, err_motorR = 0, last_err_motorR = 0;
err_motorL:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
last_err_motorL:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
motor_outL:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
motor_outR:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
err_motorR:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
last_err_motorR:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//   15 int motor_xL = 100, motor_xR = 100;
motor_xL:
        DC32 100

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
motor_xR:
        DC32 100
//   16 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 void main (void)
//   18 {
main:
        PUSH     {R4-R6,LR}
//   19   
//   20   // --- System Initiate ---
//   21   
//   22   __disable_irq();
        CPSID    I
//   23   
//   24   HMI_Init();
        BL       HMI_Init
//   25   PIT0_Init(PIT0_PERIOD_US);
        MOVW     R0,#+2500
        BL       PIT0_Init
//   26   PIT1_Init(PIT1_PERIOD_US);
        MOVW     R0,#+20000
        BL       PIT1_Init
//   27   PIT2_Init();
        BL       PIT2_Init
//   28   
//   29   Flash_Init();
        BL       Flash_Init
//   30   
//   31   UART_Init(115200);
        MOVS     R0,#+115200
        BL       UART_Init
//   32   
//   33   Motor_Init();
        BL       Motor_Init
//   34   Tacho_Init();
        BL       Tacho_Init
//   35   Servo_Init();
        BL       Servo_Init
//   36   Oled_Init();
        BL       Oled_Init
//   37   
//   38 #if (CAR_TYPE==0)   // Magnet and Balance
//   39   
//   40   Mag_Init();
        BL       Mag_Init
//   41   LPLD_MMA8451_Init();
        BL       LPLD_MMA8451_Init
//   42   Gyro_Init();
        BL       Gyro_Init
//   43   
//   44 #elif (CAR_TYPE==1)     // Only Camera
//   45   
//   46   Cam_Init();
//   47   Cam_Cont_Init();
//   48   LPLD_MMA8451_Init();
//   49   
//   50 #else               // Camera
//   51   Mag_Init();
//   52   LPLD_MMA8451_Init();
//   53   Cam_Init();
//   54   Cam_Cont_Init();
//   55   
//   56 #endif
//   57   
//   58   //-- Press Key 1 to Continue --
//   59   Oled_Putstr(6,1,"Press Key1 to go on");
        LDR.N    R2,??DataTable4
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       Oled_Putstr
//   60   //while (Key1());
//   61   Oled_Clear();
        BL       Oled_Clear
//   62   
//   63   
//   64   ////// System Initiated ////
//   65   
//   66   
//   67   // --- Flash test --- 
//   68   // To use this test, turn off Switch 1 first
//   69   __disable_irq();
        CPSID    I
//   70   Oled_Putstr(0,0,"data[1] in flash is:");
        LDR.N    R2,??DataTable4_1
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_Putstr
//   71   Oled_Putstr(2,0,"data[1] in flash is:");
        LDR.N    R2,??DataTable4_1
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       Oled_Putstr
//   72   Oled_Putnum(1,11,Flash_Read(0,1));
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       Flash_Read
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       Oled_Putnum
//   73   data[1] = Flash_Read(0,1)+1;
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       Flash_Read
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_2
        STRH     R0,[R1, #+2]
//   74   Flash_Write(0);
        MOVS     R0,#+0
        BL       Flash_Write
//   75   __disable_irq();
        CPSID    I
//   76   Oled_Putnum(3,11,Flash_Read(0,1));
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       Flash_Read
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+3
        BL       Oled_Putnum
//   77   //-- Press Key 1 to Continue --
//   78   Oled_Putstr(6,1,"Key1 LiFe is best");
        LDR.N    R2,??DataTable4_3
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       Oled_Putstr
//   79   while (Key1());
??main_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??main_0
//   80   Oled_Clear();
        BL       Oled_Clear
//   81   ///// Flash test End///
//   82  
//   83   
//   84   __enable_irq(); 
        CPSIE    I
//   85   
//   86   while(1)
//   87   {
//   88     //BELL(1);
//   89     // Don't use oled or sensors' functions here !!!
//   90    
//   91 #if (CAR_TYPE==0)
//   92     
//   93   Servo_Output(-Mag_Control());    // this might be blocked , so put here instead of interrupt
??main_1:
        BL       Mag_Control
        RSBS     R0,R0,#+0
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       Servo_Output
//   94   err_motorL = motor_xL - tacho0 * 15;
        LDR.N    R0,??DataTable4_5
        LDR      R1,[R0, #+0]
        LDR.N    R0,??DataTable4_6
        LDRSH    R0,[R0, #+0]
        MOVS     R2,#+15
        SMULBB   R0,R0,R2
        SUBS     R1,R1,R0
        LDR.N    R0,??DataTable4_7
        STRH     R1,[R0, #+0]
//   95   err_motorR = motor_xR + tacho1 * 15;
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_9
        LDRSH    R1,[R1, #+0]
        MOVS     R2,#+15
        SMLABB   R0,R1,R2,R0
        LDR.N    R1,??DataTable4_10
        STRH     R0,[R1, #+0]
//   96   
//   97   
//   98   motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
        LDR.N    R0,??DataTable4_11
        LDRH     R6,[R0, #+0]
        LDR.N    R0,??DataTable4_7
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??DataTable4_12
        LDRSH    R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable4_13  ;; 0x9999999a
        LDR.N    R3,??DataTable4_14  ;; 0x3fd99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.N    R0,??DataTable4_7
        LDRSH    R0,[R0, #+0]
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable4_15  ;; 0x47ae147b
        LDR.N    R3,??DataTable4_16  ;; 0x3f847ae1
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        ADDS     R6,R0,R6
        LDR.N    R0,??DataTable4_11
        STRH     R6,[R0, #+0]
//   99   motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
        LDR.N    R0,??DataTable4_17
        LDRH     R6,[R0, #+0]
        LDR.N    R0,??DataTable4_10
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??DataTable4_18
        LDRSH    R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable4_13  ;; 0x9999999a
        LDR.N    R3,??DataTable4_14  ;; 0x3fd99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.N    R0,??DataTable4_10
        LDRSH    R0,[R0, #+0]
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable4_15  ;; 0x47ae147b
        LDR.N    R3,??DataTable4_16  ;; 0x3f847ae1
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        ADDS     R6,R0,R6
        LDR.N    R0,??DataTable4_17
        STRH     R6,[R0, #+0]
//  100   //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
//  101   last_err_motorL = err_motorL;
        LDR.N    R0,??DataTable4_7
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable4_12
        STRH     R0,[R1, #+0]
//  102   last_err_motorR = err_motorR;
        LDR.N    R0,??DataTable4_10
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable4_18
        STRH     R0,[R1, #+0]
//  103   
//  104   MotorR_Output(0);
        MOVS     R0,#+0
        BL       MotorR_Output
//  105   MotorL_Output(0);
        MOVS     R0,#+0
        BL       MotorL_Output
        B.N      ??main_1
//  106   //accy = Accy();
//  107   //accz = Accz();
//  108   
//  109 #elif (CAR_TYPE==1)
//  110   road_value();
//  111   Cam_Con_2_line();
//  112   //Cam_Con_k();
//  113   err_motorL = motor_xL + tacho0 * 15;
//  114   err_motorR = motor_xR + tacho1 * 15;
//  115   
//  116   
//  117   motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
//  118   motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
//  119   //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
//  120   last_err_motorL = err_motorL;
//  121   last_err_motorR = err_motorR;
//  122   
//  123   MotorR_Output(motor_outR);
//  124   MotorL_Output(motor_outL);
//  125   //MotorL_Output(motor_out);
//  126     
//  127 #elif (CAR_TYPE==2)
//  128   Mixed_Control();
//  129   //Speed_k();
//  130   err_motorL = motor_xL + tacho0 * 15;
//  131   err_motorR = motor_xR + tacho1 * 15;
//  132   
//  133   
//  134   motor_outL += (int)(0.4 * (err_motorL - last_err_motorL) + 0.01 * err_motorL); 
//  135   motor_outR += (int)(0.4 * (err_motorR - last_err_motorR) + 0.01 * err_motorR); 
//  136   //motor_out = (int)(0.08 * err_motor + 0.01 * sum_err_motor);
//  137   last_err_motorL = err_motorL;
//  138   last_err_motorR = err_motorR;
//  139   
//  140   MotorR_Output(motor_outR);
//  141   MotorL_Output(motor_outL);
//  142 #endif
//  143     
//  144     
//  145     
//  146   } 
//  147 }
//  148 
//  149 
//  150 
//  151 
//  152 
//  153 
//  154 // ===== System Interrupt Handler  ==== ( No Need to Edit )
//  155 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  156 void BusFault_Handler(){
BusFault_Handler:
        PUSH     {R7,LR}
//  157   Oled_Clear();
        BL       Oled_Clear
//  158   Oled_Putstr(1,5,"Bus Fault");
        LDR.N    R2,??DataTable4_19
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//  159   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_20
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//  160   while(Key1());
??BusFault_Handler_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??BusFault_Handler_0
//  161   
//  162   return;
        POP      {R0,PC}          ;; return
//  163 }
//  164 
//  165 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  166 void NMI_Handler(){
NMI_Handler:
        PUSH     {R7,LR}
//  167   Oled_Clear();
        BL       Oled_Clear
//  168   Oled_Putstr(1,5,"NMI Fault");
        LDR.N    R2,??DataTable4_21
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//  169   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_20
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//  170   while(Key1());
??NMI_Handler_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??NMI_Handler_0
//  171   
//  172   return;
        POP      {R0,PC}          ;; return
//  173 }
//  174 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  175 void HardFault_Handler(void)
//  176 {
HardFault_Handler:
        PUSH     {R7,LR}
//  177   Oled_Clear();
        BL       Oled_Clear
//  178   Oled_Putstr(1,5,"Hard Fault");
        LDR.N    R2,??DataTable4_22
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//  179   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_20
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//  180   while(Key1());
??HardFault_Handler_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??HardFault_Handler_0
//  181   
//  182   return;
        POP      {R0,PC}          ;; return
//  183 }
//  184 
//  185 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  186 void DefaultISR(void)
//  187 {
DefaultISR:
        PUSH     {R7,LR}
//  188   Oled_Clear();
        BL       Oled_Clear
//  189   Oled_Putstr(1,5,"Default ISR");
        LDR.N    R2,??DataTable4_23
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//  190   Oled_Putstr(4,2,"press Key1 to goon");
        LDR.N    R2,??DataTable4_20
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       Oled_Putstr
//  191   while(Key1());
??DefaultISR_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??DefaultISR_0
//  192 
//  193   return;
        POP      {R0,PC}          ;; return
//  194 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     `data`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     motor_xL

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     err_motorL

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     motor_xR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     err_motorR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     motor_outL

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     last_err_motorL

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_14:
        DC32     0x3fd99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_15:
        DC32     0x47ae147b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_16:
        DC32     0x3f847ae1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_17:
        DC32     motor_outR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_18:
        DC32     last_err_motorR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_19:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_20:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_21:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_22:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_23:
        DC32     ?_7

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_0:
        DC8 "Press Key1 to go on"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_1:
        DC8 "data[1] in flash is:"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_2:
        DC8 "Key1 LiFe is best"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_3:
        DC8 "Bus Fault"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_4:
        DC8 "press Key1 to goon"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_5:
        DC8 "NMI Fault"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_6:
        DC8 "Hard Fault"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_7:
        DC8 "Default ISR"

        END
// 
//  14 bytes in section .bss
//   8 bytes in section .data
// 132 bytes in section .rodata
// 674 bytes in section .text
// 
// 674 bytes of CODE  memory
// 132 bytes of CONST memory
//  22 bytes of DATA  memory
//
//Errors: none
//Warnings: none
