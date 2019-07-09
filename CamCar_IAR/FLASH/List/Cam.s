///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      06/Jul/2019  22:02:01
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\Cam.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EWFC08.tmp
//        (E:\IARworkspace\CamCar_IAR\source\Cam.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\Cam.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Servo_Output
        EXTERN __aeabi_cdcmple
        EXTERN __aeabi_cdrcmple
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_i2d
        EXTERN motor_x

        PUBLIC Cam_2_line
        PUBLIC Cam_Algorithm
        PUBLIC Cam_Con_2_line
        PUBLIC Cam_Con_k
        PUBLIC Cam_Cont_Init
        PUBLIC Cam_Init
        PUBLIC Cam_k
        PUBLIC DMA0_IRQHandler
        PUBLIC PORTC_IRQHandler
        PUBLIC Speed_k
        PUBLIC WID
        PUBLIC cam_buffer
        PUBLIC cam_row
        PUBLIC dir
        PUBLIC img_row
        PUBLIC kd_dir
        PUBLIC kp_dir
        PUBLIC left_white
        PUBLIC mid
        PUBLIC right_white
        PUBLIC road
        PUBLIC road_value
        PUBLIC thr

// E:\IARworkspace\CamCar_IAR\source\Cam.c
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
        LDR.W    R1,??DataTable12  ;; 0xe000e100
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
        LDR.W    R2,??DataTable11  ;; 0xe000e400
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        STRB     R1,[R2, R0]
        B.N      ??__NVIC_SetPriority_1
??__NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable12_1  ;; 0xe000ed18
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
//    9 // ====== Variables ======
//   10 // ---- Global ----

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   11 u8 cam_buffer[IMG_ROWS][IMG_COLS];
cam_buffer:
        DS8 8192

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   12 ROAD road[ROAD_SIZE];
road:
        DS8 600
//   13 // ---- Local ----

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   14 u8 cam_row = 0, img_row = 0;
cam_row:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
img_row:
        DS8 1

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//   15 int thr = 65;
thr:
        DC32 65
//   16 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   17 u8 left_white, right_white;
left_white:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
right_white:
        DS8 1
//   18 

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        DATA
//   19 u8 WID = 104;
WID:
        DC8 104

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        DATA
//   20 u8 kp_dir = 30;
kp_dir:
        DC8 30

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        DATA
//   21 u8 kd_dir = 10;
kd_dir:
        DC8 10

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   22 int dir=0;
dir:
        DS8 4
//   23 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//   24 u16 mid;  
mid:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   25 static int e;
e:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   26 static int last_e;
last_e:
        DS8 4
//   27 
//   28 extern int motor_x;
//   29 // ====== 
//   30 
//   31 /*
//   32 void Cam_Algorithm(){
//   33   static u8 img_row_used = 0;
//   34   while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
//   35   
//   36   // -- Handle the row --
//   37   
//   38   
//   39   
//   40   
//   41   //  -- The row is used --
//   42   img_row_used++;
//   43   img_row_used%=IMG_ROWS;
//   44 }
//   45 */
//   46 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   47 void Cam_Cont_Init(){
//   48   for(int i = 0; i < ROAD_SIZE ; i++)
Cam_Cont_Init:
        MOVS     R0,#+0
        B.N      ??Cam_Cont_Init_0
//   49   {
//   50     road[i].left = WID/2;
??Cam_Cont_Init_1:
        LDR.W    R1,??DataTable11_1
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        LDR.W    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R0
        STR      R1,[R2, R3]
//   51     road[i].mid =  WID/2 + 1;
        LDR.W    R1,??DataTable11_1
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADDS     R1,R1,#+1
        LDR.W    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R0
        ADD      R2,R2,R3
        STR      R1,[R2, #+4]
//   52     road[i].right = WID/2 + 2;
        LDR.W    R1,??DataTable11_1
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADDS     R1,R1,#+2
        LDR.W    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R0
        ADD      R2,R2,R3
        STR      R1,[R2, #+8]
//   53   }
        ADDS     R0,R0,#+1
??Cam_Cont_Init_0:
        CMP      R0,#+50
        BLT.N    ??Cam_Cont_Init_1
//   54   mid = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_2
        STRH     R0,[R1, #+0]
//   55   e =  0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_3
        STR      R0,[R1, #+0]
//   56   last_e = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_4
        STR      R0,[R1, #+0]
//   57 }
        BX       LR               ;; return
//   58 
//   59 //@@@@@@@@@

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 void Cam_Con_2_line(){
Cam_Con_2_line:
        PUSH     {R3-R5,LR}
//   61   mid = road[28].mid * 0.8 + road[40].mid * 0.2;
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+340]
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_6  ;; 0x3fe99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+484]
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_7  ;; 0x3fc99999
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable12_2
        STRH     R0,[R1, #+0]
//   62   e = mid  - WID/2;
        LDR.W    R0,??DataTable12_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable11_1
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+2
        SDIV     R0,R0,R2
        SUBS     R1,R1,R0
        LDR.W    R0,??DataTable12_3
        STR      R1,[R0, #+0]
//   63   dir = kp_dir * e + kd_dir * (e-last_e);
        LDR.W    R0,??DataTable12_8
        LDRB     R1,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R2,[R0, #+0]
        LDR.W    R0,??DataTable12_9
        LDRB     R3,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R4,[R0, #+0]
        LDR.W    R0,??DataTable12_4
        LDR      R0,[R0, #+0]
        SUBS     R4,R4,R0
        MULS     R3,R4,R3
        MLA      R1,R2,R1,R3
        LDR.W    R0,??DataTable12_10
        STR      R1,[R0, #+0]
//   64   last_e = e;
        LDR.W    R0,??DataTable12_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable12_4
        STR      R0,[R1, #+0]
//   65   Servo_Output(-dir);
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       Servo_Output
//   66 }
        POP      {R0,R4,R5,PC}    ;; return
//   67 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   68 int Cam_2_line(){
Cam_2_line:
        PUSH     {R3-R5,LR}
//   69   mid = road[28].mid * 0.8 + road[40].mid * 0.2;
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+340]
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_6  ;; 0x3fe99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+484]
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_7  ;; 0x3fc99999
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable12_2
        STRH     R0,[R1, #+0]
//   70   e = mid  - WID/2;
        LDR.W    R0,??DataTable12_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable11_1
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+2
        SDIV     R0,R0,R2
        SUBS     R1,R1,R0
        LDR.W    R0,??DataTable12_3
        STR      R1,[R0, #+0]
//   71   dir = kp_dir * e + kd_dir * (e-last_e);
        LDR.W    R0,??DataTable12_8
        LDRB     R1,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R2,[R0, #+0]
        LDR.W    R0,??DataTable12_9
        LDRB     R3,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R4,[R0, #+0]
        LDR.W    R0,??DataTable12_4
        LDR      R0,[R0, #+0]
        SUBS     R4,R4,R0
        MULS     R3,R4,R3
        MLA      R1,R2,R1,R3
        LDR.W    R0,??DataTable12_10
        STR      R1,[R0, #+0]
//   72   last_e = e;
        LDR.W    R0,??DataTable12_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable12_4
        STR      R0,[R1, #+0]
//   73   return -dir;
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//   74 }
//   75 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 int Cam_k(){
Cam_k:
        PUSH     {R3-R11,LR}
//   77   double k1,k2,k3;
//   78   k1 = (road[20].mid - road[0].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+244]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+4]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R6,R0
        MOVS     R7,R1
//   79   k2 = (road[35].mid - road[15].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+424]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+184]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R4,R0
        MOVS     R5,R1
//   80   k3 = (road[45].mid - road[30].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+544]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+364]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOV      R10,R0
        MOV      R11,R1
//   81   
//   82   mid = (k1*k2 + k2*k3 + k1*k3 + 6 * k1 + 4*k2 + 2*k3)/2 + road[28].mid; 
        MOVS     R2,R4
        MOVS     R3,R5
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        MOV      R2,R10
        MOV      R3,R11
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        MOV      R2,R10
        MOV      R3,R11
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_11  ;; 0x40180000
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOVS     R6,R0
        MOVS     R7,R1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_12  ;; 0x40100000
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,#+0
        MOVS     R1,#+1073741824
        MOV      R2,R10
        MOV      R3,R11
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+340]
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable12_2
        STRH     R0,[R1, #+0]
//   83   
//   84   e = mid  - WID/2;
        LDR.W    R0,??DataTable12_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable11_1
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+2
        SDIV     R0,R0,R2
        SUBS     R1,R1,R0
        LDR.W    R0,??DataTable12_3
        STR      R1,[R0, #+0]
//   85   dir = kp_dir * e + kd_dir * (e-last_e);
        LDR.W    R0,??DataTable12_8
        LDRB     R1,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R2,[R0, #+0]
        LDR.W    R0,??DataTable12_9
        LDRB     R3,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R4,[R0, #+0]
        LDR.W    R0,??DataTable12_4
        LDR      R0,[R0, #+0]
        SUBS     R4,R4,R0
        MULS     R3,R4,R3
        MLA      R1,R2,R1,R3
        LDR.W    R0,??DataTable12_10
        STR      R1,[R0, #+0]
//   86   last_e = e;
        LDR.W    R0,??DataTable12_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable12_4
        STR      R0,[R1, #+0]
//   87   return -dir;
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        POP      {R1,R4-R11,PC}   ;; return
//   88 }
//   89 
//   90 
//   91 //@@@@@@@@@@

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void Cam_Con_k(){
Cam_Con_k:
        PUSH     {R3-R11,LR}
//   93   double k1,k2,k3;
//   94   k1 = (road[20].mid - road[0].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+244]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+4]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R6,R0
        MOVS     R7,R1
//   95   k2 = (road[35].mid - road[15].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+424]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+184]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R4,R0
        MOVS     R5,R1
//   96   k3 = (road[45].mid - road[30].mid) / 20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+544]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+364]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOV      R10,R0
        MOV      R11,R1
//   97   
//   98   mid = (k1*k2 + k2*k3 + k1*k3 + 6 * k1 + 4*k2 + 2*k3)/2 + road[28].mid; 
        MOVS     R2,R4
        MOVS     R3,R5
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        MOV      R2,R10
        MOV      R3,R11
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        MOV      R2,R10
        MOV      R3,R11
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_11  ;; 0x40180000
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOVS     R6,R0
        MOVS     R7,R1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable12_12  ;; 0x40100000
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,#+0
        MOVS     R1,#+1073741824
        MOV      R2,R10
        MOV      R3,R11
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+340]
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable12_2
        STRH     R0,[R1, #+0]
//   99   
//  100   e = mid  - WID/2;
        LDR.W    R0,??DataTable12_2
        LDRH     R1,[R0, #+0]
        LDR.W    R0,??DataTable11_1
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+2
        SDIV     R0,R0,R2
        SUBS     R1,R1,R0
        LDR.W    R0,??DataTable12_3
        STR      R1,[R0, #+0]
//  101   dir = kp_dir * e + kd_dir * (e-last_e);
        LDR.W    R0,??DataTable12_8
        LDRB     R1,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R2,[R0, #+0]
        LDR.W    R0,??DataTable12_9
        LDRB     R3,[R0, #+0]
        LDR.W    R0,??DataTable12_3
        LDR      R4,[R0, #+0]
        LDR.W    R0,??DataTable12_4
        LDR      R0,[R0, #+0]
        SUBS     R4,R4,R0
        MULS     R3,R4,R3
        MLA      R1,R2,R1,R3
        LDR.W    R0,??DataTable12_10
        STR      R1,[R0, #+0]
//  102   last_e = e;
        LDR.W    R0,??DataTable12_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable12_4
        STR      R0,[R1, #+0]
//  103   Servo_Output(-dir);
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       Servo_Output
//  104 }
        POP      {R0,R4-R11,PC}   ;; return
//  105 
//  106 //@@@@@@@@@@@@

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 void Speed_k(){
Speed_k:
        PUSH     {R3-R9,LR}
//  108   double k1,k2,k3;
//  109   k1 = (road[20].mid - road[0].mid)/20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+244]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+4]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R6,R0
        MOVS     R7,R1
//  110   k2 = (road[35].mid - road[15].mid)/20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+424]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+184]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R4,R0
        MOVS     R5,R1
//  111   k3 = (road[45].mid - road[30].mid)/20;
        LDR.W    R0,??DataTable11_2
        LDR      R1,[R0, #+544]
        LDR.W    R0,??DataTable11_2
        LDR      R0,[R0, #+364]
        SUBS     R1,R1,R0
        MOVS     R0,#+20
        SDIV     R0,R1,R0
        BL       __aeabi_i2d
        MOV      R8,R0
        MOV      R9,R1
//  112   
//  113   if(abs(dir)<50) motor_x =170;
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Speed_k_0
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        B.N      ??Speed_k_1
??Speed_k_0:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Speed_k_1:
        CMP      R0,#+50
        BGE.N    ??Speed_k_2
        MOVS     R0,#+170
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
//  114   if(abs(dir)>=50 && abs(dir)<150) motor_x = 150;
??Speed_k_2:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Speed_k_3
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        B.N      ??Speed_k_4
??Speed_k_3:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Speed_k_4:
        CMP      R0,#+50
        BLT.N    ??Speed_k_5
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Speed_k_6
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        B.N      ??Speed_k_7
??Speed_k_6:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Speed_k_7:
        CMP      R0,#+150
        BGE.N    ??Speed_k_5
        MOVS     R0,#+150
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
//  115   if(abs(dir)>150) motor_x = 140;
??Speed_k_5:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Speed_k_8
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        B.N      ??Speed_k_9
??Speed_k_8:
        LDR.W    R0,??DataTable12_10
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Speed_k_9:
        CMP      R0,#+151
        BLT.N    ??Speed_k_10
        MOVS     R0,#+140
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
//  116   
//  117   if(abs(k1)<0.2 && abs(k2)<0.2 && abs(k3)<0.2)motor_x += 10;
??Speed_k_10:
        MOVS     R0,R6
        MOVS     R1,R7
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_11
        MOVS     R0,R6
        MOVS     R1,R7
        B.N      ??Speed_k_12
??Speed_k_11:
        MOVS     R0,R6
        MOVS     R1,R7
        EORS     R1,R1,#0x80000000
??Speed_k_12:
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_7  ;; 0x3fc99999
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_13
        MOVS     R0,R4
        MOVS     R1,R5
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_14
        MOVS     R0,R4
        MOVS     R1,R5
        B.N      ??Speed_k_15
??Speed_k_14:
        MOVS     R0,R4
        MOVS     R1,R5
        EORS     R1,R1,#0x80000000
??Speed_k_15:
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_7  ;; 0x3fc99999
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_13
        MOV      R0,R8
        MOV      R1,R9
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_16
        MOV      R0,R8
        MOV      R1,R9
        B.N      ??Speed_k_17
??Speed_k_16:
        MOV      R0,R8
        MOV      R1,R9
        EORS     R1,R1,#0x80000000
??Speed_k_17:
        LDR.W    R2,??DataTable12_5  ;; 0x9999999a
        LDR.W    R3,??DataTable12_7  ;; 0x3fc99999
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_13
        LDR.W    R0,??DataTable12_13
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+10
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
        B.N      ??Speed_k_18
//  118   else if(abs(k1)<0.3 && abs(k2)<0.3 && abs(k3)<0.3)motor_x += 5;
??Speed_k_13:
        MOVS     R0,R6
        MOVS     R1,R7
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_19
        MOVS     R0,R6
        MOVS     R1,R7
        B.N      ??Speed_k_20
??Speed_k_19:
        EORS     R7,R7,#0x80000000
        MOVS     R0,R6
        MOVS     R1,R7
??Speed_k_20:
        MOVS     R2,#+858993459
        LDR.W    R3,??DataTable12_14  ;; 0x3fd33333
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_21
        MOVS     R0,R4
        MOVS     R1,R5
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_22
        MOVS     R0,R4
        MOVS     R1,R5
        B.N      ??Speed_k_23
??Speed_k_22:
        EORS     R5,R5,#0x80000000
        MOVS     R0,R4
        MOVS     R1,R5
??Speed_k_23:
        MOVS     R2,#+858993459
        LDR.W    R3,??DataTable12_14  ;; 0x3fd33333
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_21
        MOV      R0,R8
        MOV      R1,R9
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??Speed_k_24
        MOV      R0,R8
        MOV      R1,R9
        B.N      ??Speed_k_25
??Speed_k_24:
        EORS     R9,R9,#0x80000000
        MOV      R0,R8
        MOV      R1,R9
??Speed_k_25:
        MOVS     R2,#+858993459
        LDR.W    R3,??DataTable12_14  ;; 0x3fd33333
        BL       __aeabi_cdcmple
        BCS.N    ??Speed_k_21
        LDR.W    R0,??DataTable12_13
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+5
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
        B.N      ??Speed_k_18
//  119   else motor_x += 0;
??Speed_k_21:
        LDR.W    R0,??DataTable12_13
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable12_13
        STR      R0,[R1, #+0]
//  120   
//  121 }
??Speed_k_18:
        POP      {R0,R4-R9,PC}    ;; return
//  122 
//  123 
//  124 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 void road_value()
//  126 {
//  127   for( int i = 0; i < ROAD_SIZE ; i++)
road_value:
        MOVS     R1,#+0
        B.N      ??road_value_0
//  128   {
//  129     int j;
//  130     for(j = road[i].mid ; j> 5 ;j--)
//  131     {
//  132       if(cam_buffer[i][j]< thr && cam_buffer[i][j - 1]< thr && cam_buffer[i][j - 2]< thr) break;
//  133     }
//  134     road[i].left = j;
//  135     
//  136     for(j = road[i].mid ; j< 115 ;j++)
??road_value_1:
        ADDS     R0,R0,#+1
??road_value_2:
        CMP      R0,#+115
        BGE.N    ??road_value_3
//  137     {
//  138       if(cam_buffer[i][j] < thr && cam_buffer[i][j + 1]< thr && cam_buffer[i][j + 2]< thr) break;
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        LDRB     R2,[R2, R0]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_1
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        ADD      R2,R2,R0
        LDRB     R2,[R2, #+1]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_1
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        ADD      R2,R2,R0
        LDRB     R2,[R2, #+2]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_1
//  139     }
//  140     road[i].right = j;
??road_value_3:
        LDR.N    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        STR      R0,[R2, #+8]
//  141     road[i].mid = (road[i].left + road[i].right) / 2;
        LDR.N    R0,??DataTable11_2
        MOVS     R2,#+12
        MUL      R2,R2,R1
        LDR      R2,[R0, R2]
        LDR.N    R0,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R1
        ADD      R0,R0,R3
        LDR      R0,[R0, #+8]
        ADDS     R2,R0,R2
        MOVS     R0,#+2
        SDIV     R0,R2,R0
        LDR.N    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        STR      R0,[R2, #+4]
        ADDS     R1,R1,#+1
??road_value_0:
        CMP      R1,#+50
        BGE.N    ??road_value_4
        LDR.N    R0,??DataTable11_2
        MOVS     R2,#+12
        MUL      R2,R2,R1
        ADD      R0,R0,R2
        LDR      R0,[R0, #+4]
        B.N      ??road_value_5
??road_value_6:
        SUBS     R0,R0,#+1
??road_value_5:
        CMP      R0,#+6
        BLT.N    ??road_value_7
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        LDRB     R2,[R2, R0]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_6
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        ADD      R2,R2,R0
        LDRB     R2,[R2, #-1]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_6
        LDR.W    R2,??DataTable12_15
        MOVS     R3,#+128
        MUL      R3,R3,R1
        ADD      R2,R2,R3
        ADD      R2,R2,R0
        LDRB     R2,[R2, #-2]
        LDR.W    R3,??DataTable12_16
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??road_value_6
??road_value_7:
        LDR.N    R2,??DataTable11_2
        MOVS     R3,#+12
        MUL      R3,R3,R1
        STR      R0,[R2, R3]
        LDR.N    R0,??DataTable11_2
        MOVS     R2,#+12
        MUL      R2,R2,R1
        ADD      R0,R0,R2
        LDR      R0,[R0, #+4]
        B.N      ??road_value_2
//  142   }
//  143 }
??road_value_4:
        BX       LR               ;; return
//  144 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  145 void Cam_Algorithm(){
//  146   static u8 img_row_used = 0;
//  147   while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
Cam_Algorithm:
??Cam_Algorithm_0:
        LDR.N    R0,??DataTable12_17
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+64
        LDR.N    R2,??DataTable12_18
        LDRB     R2,[R2, #+0]
        SDIV     R3,R0,R1
        MLS      R0,R1,R3,R0
        CMP      R2,R0
        BEQ.N    ??Cam_Algorithm_0
//  148   
//  149   // -- Handle the row --
//  150   
//  151   //  -- The row is used --
//  152   img_row_used++;
        LDR.N    R0,??DataTable12_18
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable12_18
        STRB     R0,[R1, #+0]
//  153   img_row_used%=IMG_ROWS;
        LDR.N    R0,??DataTable12_18
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+64
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        LDR.N    R1,??DataTable12_18
        STRB     R0,[R1, #+0]
//  154 }
        BX       LR               ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
`Cam_Algorithm::img_row_used`:
        DS8 1
//  155 
//  156 // ====== Basic Drivers ======
//  157 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 void PORTC_IRQHandler(){
//  159   if((PORTC->ISFR)&PORT_ISFR_ISF(1 << 8)){  //CS
PORTC_IRQHandler:
        LDR.N    R0,??DataTable12_19  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+23
        BPL.N    ??PORTC_IRQHandler_0
//  160     PORTC->ISFR |= PORT_ISFR_ISF(1 << 8);
        LDR.N    R0,??DataTable12_19  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable12_19  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  161     
//  162     if(img_row < IMG_ROWS && cam_row % IMG_STEP == 0 ){
        LDR.N    R0,??DataTable12_17
        LDRB     R0,[R0, #+0]
        CMP      R0,#+64
        BGE.N    ??PORTC_IRQHandler_1
        LDR.N    R0,??DataTable12_20
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        CMP      R0,#+0
        BNE.N    ??PORTC_IRQHandler_1
//  163       DMA0->TCD[0].DADDR = (u32)&cam_buffer[img_row][0];
        LDR.N    R1,??DataTable12_15
        LDR.N    R0,??DataTable12_17
        LDRB     R2,[R0, #+0]
        MOVS     R0,#+128
        MULS     R2,R0,R2
        ADD      R0,R1,R2
        LDR.N    R1,??DataTable12_21  ;; 0x40009010
        STR      R0,[R1, #+0]
//  164       DMA0->ERQ |= DMA_ERQ_ERQ0_MASK; //Enable DMA0
        LDR.N    R0,??DataTable12_22  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable12_22  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  165       ADC0->SC1[0] |= ADC_SC1_ADCH(4); //Restart ADC
        LDR.N    R0,??DataTable12_23  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable12_23  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  166       DMA0->TCD[0].CSR |= DMA_CSR_START_MASK; //Start
        LDR.N    R0,??DataTable12_24  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable12_24  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  167 	}
//  168 	cam_row++;
??PORTC_IRQHandler_1:
        LDR.N    R0,??DataTable12_20
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable12_20
        STRB     R0,[R1, #+0]
        B.N      ??PORTC_IRQHandler_2
//  169   }
//  170   else if(PORTC->ISFR&PORT_ISFR_ISF(1 << 9)){   //VS
??PORTC_IRQHandler_0:
        LDR.N    R0,??DataTable12_19  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+22
        BPL.N    ??PORTC_IRQHandler_2
//  171     PORTC->ISFR |= PORT_ISFR_ISF(1 << 9);
        LDR.N    R0,??DataTable12_19  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200
        LDR.N    R1,??DataTable12_19  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  172     
//  173     cam_row = img_row = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_17
        STRB     R0,[R1, #+0]
        LDR.N    R0,??DataTable12_17
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??DataTable12_20
        STRB     R0,[R1, #+0]
//  174     
//  175   }
//  176 }
??PORTC_IRQHandler_2:
        BX       LR               ;; return
//  177 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  178 void DMA0_IRQHandler(){
//  179   DMA0->CINT &= ~DMA_CINT_CINT(7); //Clear DMA0 Interrupt Flag
DMA0_IRQHandler:
        LDR.N    R0,??DataTable12_25  ;; 0x4000801f
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xF8
        LDR.N    R1,??DataTable12_25  ;; 0x4000801f
        STRB     R0,[R1, #+0]
//  180   
//  181   img_row++; 
        LDR.N    R0,??DataTable12_17
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable12_17
        STRB     R0,[R1, #+0]
//  182 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     WID

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     road
//  183 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  184 void Cam_Init(){
Cam_Init:
        PUSH     {R7,LR}
//  185   
//  186   // --- IO ---
//  187   
//  188   PORTC->PCR[8] |= PORT_PCR_MUX(1); //cs
        LDR.N    R0,??DataTable12_26  ;; 0x4004b020
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable12_26  ;; 0x4004b020
        STR      R0,[R1, #+0]
//  189   PORTC->PCR[9] |= PORT_PCR_MUX(1); //vs
        LDR.N    R0,??DataTable12_27  ;; 0x4004b024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable12_27  ;; 0x4004b024
        STR      R0,[R1, #+0]
//  190   PORTC->PCR[11] |= PORT_PCR_MUX(1);    //oe
        LDR.N    R0,??DataTable12_28  ;; 0x4004b02c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable12_28  ;; 0x4004b02c
        STR      R0,[R1, #+0]
//  191   PTC->PDDR &=~(3<<8);
        LDR.N    R0,??DataTable12_29  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x300
        LDR.N    R1,??DataTable12_29  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  192   PTC->PDDR &=~(1<<11);
        LDR.N    R0,??DataTable12_29  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x800
        LDR.N    R1,??DataTable12_29  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  193   PORTC->PCR[8] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
        LDR.N    R0,??DataTable12_26  ;; 0x4004b020
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xA0000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable12_26  ;; 0x4004b020
        STR      R0,[R1, #+0]
//  194   PORTC->PCR[9] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(9);  // rising edge
        LDR.N    R0,??DataTable12_27  ;; 0x4004b024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x90000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable12_27  ;; 0x4004b024
        STR      R0,[R1, #+0]
//  195   PORTC->PCR[11] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
        LDR.N    R0,??DataTable12_28  ;; 0x4004b02c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable12_28  ;; 0x4004b02c
        STR      R0,[R1, #+0]
//  196   
//  197   NVIC_EnableIRQ(PORTC_IRQn);
        MOVS     R0,#+89
        BL       __NVIC_EnableIRQ
//  198   NVIC_SetPriority(PORTC_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+89
        BL       __NVIC_SetPriority
//  199   
//  200   // --- AD ---
//  201   
//  202   /*
//  203   SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK;  //ADC1 Clock Enable
//  204   ADC0->CFG1 |= 0
//  205              //|ADC_CFG1_ADLPC_MASK
//  206              | ADC_CFG1_ADICLK(1)
//  207              | ADC_CFG1_MODE(0);     // 8 bits
//  208              //| ADC_CFG1_ADIV(0);
//  209   ADC0->CFG2 |= //ADC_CFG2_ADHSC_MASK |
//  210                 ADC_CFG2_MUXSEL_MASK |  // b
//  211                 ADC_CFG2_ADACKEN_MASK; 
//  212   
//  213   ADC0->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
//  214   
//  215   ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA
//  216   
//  217   ADC0->SC3 |= ADC_SC3_ADCO_MASK; // continuous
//  218   
//  219   //PORTC->PCR[2]|=PORT_PCR_MUX(0);//adc1-4a
//  220   
//  221   ADC0->SC1[0] |= ADC_SC1_ADCH(4);
//  222   */
//  223   
//  224   SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK; //ADC1 Clock Enable
        LDR.N    R0,??DataTable12_30  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable12_30  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  225   ADC0->SC1[0] &= ~ADC_SC1_AIEN_MASK; //ADC1A
        LDR.N    R0,??DataTable12_23  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable12_23  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  226   ADC0->SC1[0] = 0x00000000; //Clear
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_23  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  227   ADC0->SC1[0] |= ADC_SC1_ADCH(4); //ADC1_5->Input, Single Pin, No interrupt
        LDR.N    R0,??DataTable12_23  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable12_23  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  228   ADC0->SC1[1] &= ~ADC_SC1_AIEN_MASK; //ADC1B
        LDR.N    R0,??DataTable12_31  ;; 0x4003b004
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable12_31  ;; 0x4003b004
        STR      R0,[R1, #+0]
//  229   ADC0->SC1[1] |= ADC_SC1_ADCH(4); //ADC1_5b
        LDR.N    R0,??DataTable12_31  ;; 0x4003b004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable12_31  ;; 0x4003b004
        STR      R0,[R1, #+0]
//  230   ADC0->SC2 &= 0x00000000; //Clear all.
        LDR.N    R0,??DataTable12_32  ;; 0x4003b020
        LDR      R0,[R0, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_32  ;; 0x4003b020
        STR      R0,[R1, #+0]
//  231   ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA, SoftWare
        LDR.N    R0,??DataTable12_32  ;; 0x4003b020
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable12_32  ;; 0x4003b020
        STR      R0,[R1, #+0]
//  232   ADC0->SC3 &= (~ADC_SC3_AVGE_MASK&~ADC_SC3_AVGS_MASK); //hardware average disabled
        LDR.N    R0,??DataTable12_33  ;; 0x4003b024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+3
        LSLS     R0,R0,#+3
        LDR.N    R1,??DataTable12_33  ;; 0x4003b024
        STR      R0,[R1, #+0]
//  233   ADC0->SC3 |= ADC_SC3_ADCO_MASK; //Continuous conversion enable
        LDR.N    R0,??DataTable12_33  ;; 0x4003b024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable12_33  ;; 0x4003b024
        STR      R0,[R1, #+0]
//  234   ADC0->CFG1|=ADC_CFG1_ADICLK(1)|ADC_CFG1_MODE(0)|ADC_CFG1_ADIV(0);//InputClk, ShortTime, 8bits, Bus
        LDR.N    R0,??DataTable12_34  ;; 0x4003b008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable12_34  ;; 0x4003b008
        STR      R0,[R1, #+0]
//  235   ADC0->CFG2 |= ADC_CFG2_MUXSEL_MASK; //ADC1  b
        LDR.N    R0,??DataTable12_35  ;; 0x4003b00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable12_35  ;; 0x4003b00c
        STR      R0,[R1, #+0]
//  236   ADC0->CFG2 |= ADC_CFG2_ADACKEN_MASK; //OutputClock
        LDR.N    R0,??DataTable12_35  ;; 0x4003b00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable12_35  ;; 0x4003b00c
        STR      R0,[R1, #+0]
//  237     
//  238   // --- DMA ---
//  239   
//  240   SIM->SCGC6 |= SIM_SCGC6_DMAMUX_MASK; //DMAMUX Clock Enable
        LDR.N    R0,??DataTable12_30  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable12_30  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  241   SIM->SCGC7 |= SIM_SCGC7_DMA_MASK; //DMA Clock Enable
        LDR.N    R0,??DataTable12_36  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable12_36  ;; 0x40048040
        STR      R0,[R1, #+0]
//  242   DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_SOURCE(40); //DMA0->No.40 request, ADC0
        LDR.N    R0,??DataTable12_37  ;; 0x40021000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable12_37  ;; 0x40021000
        STRB     R0,[R1, #+0]
//  243   DMA0->TCD[0].SADDR = (uint32_t) & (ADC0->R[0]); //Source Address 0x400B_B010h
        LDR.N    R0,??DataTable12_38  ;; 0x4003b010
        LDR.N    R1,??DataTable12_39  ;; 0x40009000
        STR      R0,[R1, #+0]
//  244   DMA0->TCD[0].SOFF = 0; //Source Fixed
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_40  ;; 0x40009004
        STRH     R0,[R1, #+0]
//  245   DMA0->TCD[0].ATTR = DMA_ATTR_SSIZE(0) | DMA_ATTR_DSIZE(0); //Source 8 bits, Aim 8 bits
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_41  ;; 0x40009006
        STRH     R0,[R1, #+0]
//  246   DMA0->TCD[0].NBYTES_MLNO = DMA_NBYTES_MLNO_NBYTES(1); //one byte each
        MOVS     R0,#+1
        LDR.N    R1,??DataTable12_42  ;; 0x40009008
        STR      R0,[R1, #+0]
//  247   DMA0->TCD[0].SLAST = 0; //Last Source fixed
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_43  ;; 0x4000900c
        STR      R0,[R1, #+0]
//  248   DMA0->TCD[0].DADDR = (u32)cam_buffer;
        LDR.N    R0,??DataTable12_15
        LDR.N    R1,??DataTable12_21  ;; 0x40009010
        STR      R0,[R1, #+0]
//  249   DMA0->TCD[0].DOFF = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable12_44  ;; 0x40009014
        STRH     R0,[R1, #+0]
//  250   DMA0->TCD[0].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(IMG_COLS);
        MOVS     R0,#+128
        LDR.N    R1,??DataTable12_45  ;; 0x40009016
        STRH     R0,[R1, #+0]
//  251   DMA0->TCD[0].DLAST_SGA = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_46  ;; 0x40009018
        STR      R0,[R1, #+0]
//  252   DMA0->TCD[0].BITER_ELINKNO = DMA_BITER_ELINKNO_BITER(IMG_COLS);
        MOVS     R0,#+128
        LDR.N    R1,??DataTable12_47  ;; 0x4000901e
        STRH     R0,[R1, #+0]
//  253   DMA0->TCD[0].CSR = 0x00000000; //Clear
        MOVS     R0,#+0
        LDR.N    R1,??DataTable12_24  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  254   DMA0->TCD[0].CSR |= DMA_CSR_DREQ_MASK; //Auto Clear
        LDR.N    R0,??DataTable12_24  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable12_24  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  255   DMA0->TCD[0].CSR |= DMA_CSR_INTMAJOR_MASK; //Enable Major Loop Int
        LDR.N    R0,??DataTable12_24  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable12_24  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  256   DMA0->INT |= DMA_INT_INT0_MASK; //Open Interrupt
        LDR.N    R0,??DataTable12_48  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable12_48  ;; 0x40008024
        STR      R0,[R1, #+0]
//  257   //DMA->ERQ&=~DMA_ERQ_ERQ0_MASK;//Clear Disable
//  258   DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_ENBL_MASK; //Enable
        LDR.N    R0,??DataTable12_37  ;; 0x40021000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable12_37  ;; 0x40021000
        STRB     R0,[R1, #+0]
//  259   
//  260   NVIC_EnableIRQ(DMA0_IRQn);
        MOVS     R0,#+0
        BL       __NVIC_EnableIRQ
//  261   NVIC_SetPriority(DMA0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+0
        BL       __NVIC_SetPriority
//  262   
//  263 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_1:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_2:
        DC32     mid

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_3:
        DC32     e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_4:
        DC32     last_e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_5:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_6:
        DC32     0x3fe99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_7:
        DC32     0x3fc99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_8:
        DC32     kp_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_9:
        DC32     kd_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_10:
        DC32     dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_11:
        DC32     0x40180000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_12:
        DC32     0x40100000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_13:
        DC32     motor_x

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_14:
        DC32     0x3fd33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_15:
        DC32     cam_buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_16:
        DC32     thr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_17:
        DC32     img_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_18:
        DC32     `Cam_Algorithm::img_row_used`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_19:
        DC32     0x4004b0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_20:
        DC32     cam_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_21:
        DC32     0x40009010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_22:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_23:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_24:
        DC32     0x4000901c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_25:
        DC32     0x4000801f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_26:
        DC32     0x4004b020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_27:
        DC32     0x4004b024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_28:
        DC32     0x4004b02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_29:
        DC32     0x400ff094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_30:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_31:
        DC32     0x4003b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_32:
        DC32     0x4003b020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_33:
        DC32     0x4003b024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_34:
        DC32     0x4003b008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_35:
        DC32     0x4003b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_36:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_37:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_38:
        DC32     0x4003b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_39:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_40:
        DC32     0x40009004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_41:
        DC32     0x40009006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_42:
        DC32     0x40009008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_43:
        DC32     0x4000900c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_44:
        DC32     0x40009014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_45:
        DC32     0x40009016

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_46:
        DC32     0x40009018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_47:
        DC32     0x4000901e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_48:
        DC32     0x40008024

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
// 8 811 bytes in section .bss
//     7 bytes in section .data
// 3 032 bytes in section .text
// 
// 3 032 bytes of CODE memory
// 8 818 bytes of DATA memory
//
//Errors: none
//Warnings: 4
