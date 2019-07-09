///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      09/Jul/2019  18:06:22
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\Mag.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EW502B.tmp
//        (E:\IARworkspace\CamCar_IAR\source\Mag.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\Mag.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ADC1_enabled
        EXTERN Cam_2_line
        EXTERN Cam_k
        EXTERN Servo_Output
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_dmul
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_fmul
        EXTERN __aeabi_i2d
        EXTERN __aeabi_i2f
        EXTERN dir

        PUBLIC Circle_Con
        PUBLIC Mag1
        PUBLIC Mag2
        PUBLIC Mag3
        PUBLIC Mag4
        PUBLIC Mag5
        PUBLIC Mag6
        PUBLIC Mag_Control
        PUBLIC Mag_Init
        PUBLIC Mag_Sample
        PUBLIC Mixed_Control
        PUBLIC circle_dep_left
        PUBLIC circle_dep_right
        PUBLIC huandao
        PUBLIC left_right
        PUBLIC lost
        PUBLIC mag_val

// E:\IARworkspace\CamCar_IAR\source\Mag.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 #include "includes.h"
//    8 
//    9 
//   10 // ===== Global Variables =====

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   11 U16 mag_val[6];
mag_val:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   12 int left_right = 0;
left_right:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        DATA
//   13 boolean lost=0;
lost:
        DS8 1
//   14 extern int dir;
//   15 
//   16 /*
//   17 0 @@@
//   18 1 @@@@
//   19 2 @@@
//   20 3 @@@
//   21 */

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   22 int huandao = 0;
huandao:
        DS8 4
//   23 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//   24 float circle_dep_left=1.0, circle_dep_right=1.0;
circle_dep_left:
        DC32 3F800000H

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
circle_dep_right:
        DC32 3F800000H
//   25 
//   26 // ===== Function Realization =====
//   27 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void Mag_Sample(){
Mag_Sample:
        PUSH     {R4,LR}
//   29   mag_val[0] = Mag1();
        BL       Mag1
        LDR.W    R1,??DataTable10
        STRH     R0,[R1, #+0]
//   30   mag_val[1] = Mag2();
        BL       Mag2
        LDR.W    R1,??DataTable10
        STRH     R0,[R1, #+2]
//   31   mag_val[2] = Mag3();
        BL       Mag3
        LDR.W    R1,??DataTable10
        STRH     R0,[R1, #+4]
//   32   mag_val[3] = Mag4();
        BL       Mag4
        LDR.W    R1,??DataTable10
        STRH     R0,[R1, #+6]
//   33   mag_val[5] = Mag6();
        BL       Mag6
        LDR.W    R1,??DataTable10
        STRH     R0,[R1, #+10]
//   34   mag_val[4] = mag_val[5] - Mag5();
        LDR.W    R0,??DataTable10
        LDRH     R4,[R0, #+10]
        BL       Mag5
        SUBS     R4,R4,R0
        LDR.W    R0,??DataTable10
        STRH     R4,[R0, #+8]
//   35 }
        POP      {R4,PC}          ;; return
//   36 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 u16 Mag1(){
//   38   ADC1->SC1[0] = ADC_SC1_ADCH(4);
Mag1:
        MOVS     R0,#+4
        LDR.W    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   39   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag1_0:
        LDR.W    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag1_0
//   40   return ADC1->R[0];
        LDR.W    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   41 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   42 u16 Mag2(){
//   43   ADC1->SC1[0] = ADC_SC1_ADCH(5);
Mag2:
        MOVS     R0,#+5
        LDR.W    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   44   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag2_0:
        LDR.W    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag2_0
//   45   return ADC1->R[0];
        LDR.W    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   46 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   47 u16 Mag3(){
//   48   ADC1->SC1[0] = ADC_SC1_ADCH(6);
Mag3:
        MOVS     R0,#+6
        LDR.W    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   49   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag3_0:
        LDR.W    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag3_0
//   50   return ADC1->R[0];
        LDR.W    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   51 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 u16 Mag4(){
//   53   ADC1->SC1[0] = ADC_SC1_ADCH(7);
Mag4:
        MOVS     R0,#+7
        LDR.W    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   54   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag4_0:
        LDR.W    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag4_0
//   55   return ADC1->R[0];
        LDR.W    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   56 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   57 s16 Mag5(){
//   58   ADC1->SC1[0] = ADC_SC1_DIFF_MASK | ADC_SC1_ADCH(3);
Mag5:
        MOVS     R0,#+35
        LDR.N    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   59   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag5_0:
        LDR.N    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag5_0
//   60   return ADC1->R[0];
        LDR.N    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   61   //ADC1->SC1[0] &= ~ADC_SC1_DIFF_MASK;
//   62 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   63 u16 Mag6(){
//   64   ADC1->SC1[0] = ADC_SC1_ADCH(3);
Mag6:
        MOVS     R0,#+3
        LDR.N    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//   65   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??Mag6_0:
        LDR.N    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??Mag6_0
//   66   return ADC1->R[0];
        LDR.N    R0,??DataTable10_2  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//   67 }
//   68 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 int Mag_Control(){
Mag_Control:
        PUSH     {R3-R7,LR}
//   70   int f1,f2,f3;
//   71   int dir, err_mag;
//   72   static int last_err_mag = 0;
//   73   static int hdCnt = 0;
//   74   
//   75   float pow = 0.0;
        MOVS     R6,#+0
//   76 
//   77   f1 = mag_val[0] - mag_val[5];
        LDR.N    R0,??DataTable10
        LDRH     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+10]
        SUBS     R0,R1,R0
//   78   f2 = mag_val[1] - mag_val[4];
        LDR.N    R0,??DataTable10
        LDRH     R1,[R0, #+2]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+8]
        SUBS     R0,R1,R0
//   79   f3 = mag_val[2] - mag_val[3];
        LDR.N    R1,??DataTable10
        LDRH     R1,[R1, #+4]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR.N    R2,??DataTable10
        LDRH     R7,[R2, #+6]
        SUBS     R7,R1,R7
//   80   
//   81   /*
//   82   if (mag_val[2] + mag_val[3] > 2500 && ((0 < f1 && f1 < 150) || (f1 < 0 && f1 > -150)))
//   83   {
//   84     // @@@@@
//   85     hdCnt = f1;
//   86     huandao = 1;
//   87   }
//   88   
//   89   if (huandao == 1)
//   90   {
//   91     if (mag_val[2] + mag_val[3] < 1000) huandao = 2;
//   92     else return (f1>0 ? 1:-1) * 200;
//   93   }
//   94   
//   95   if (huandao == 2)
//   96   {
//   97     if (f1 > 500 || f1 < -500) huandao = 0;
//   98   }
//   99   
//  100   if (mag_val[2] + mag_val[3] - mag_val[1] - mag_val[4] < 300)
//  101   {
//  102     pow = 1.3;
//  103   }
//  104   else 
//  105   {
//  106     pow = 0.8;
//  107   }
//  108   */
//  109   err_mag = f2 * 0.2 + f3 * 0.3;
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable10_3  ;; 0x9999999a
        LDR.N    R3,??DataTable10_4  ;; 0x3fc99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,R7
        BL       __aeabi_i2d
        MOVS     R2,#+858993459
        LDR.N    R3,??DataTable10_5  ;; 0x3fd33333
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        MOVS     R7,R0
//  110   
//  111   dir = err_mag * 1.2 + (err_mag - last_err_mag) * 0.4;
        MOVS     R0,R7
        BL       __aeabi_i2d
        MOVS     R2,#+858993459
        LDR.N    R3,??DataTable10_6  ;; 0x3ff33333
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.N    R0,??DataTable10_7
        LDR      R0,[R0, #+0]
        SUBS     R0,R7,R0
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable10_3  ;; 0x9999999a
        LDR.N    R3,??DataTable10_8  ;; 0x3fd99999
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
//  112   
//  113   last_err_mag = err_mag;
        LDR.N    R1,??DataTable10_7
        STR      R7,[R1, #+0]
//  114   
//  115   if(dir<0)left_right = -1;
        CMP      R0,#+0
        BPL.N    ??Mag_Control_0
        MOVS     R1,#-1
        LDR.N    R2,??DataTable10_9
        STR      R1,[R2, #+0]
//  116   if(dir>0)left_right = 1;
??Mag_Control_0:
        CMP      R0,#+1
        BLT.N    ??Mag_Control_1
        MOVS     R1,#+1
        LDR.N    R2,??DataTable10_9
        STR      R1,[R2, #+0]
//  117   if(mag_val[2]<200 && mag_val[3]<200 && mag_val[1]<650 && mag_val[4]<650){dir = left_right*800;lost=1;}
??Mag_Control_1:
        LDR.N    R1,??DataTable10
        LDRH     R1,[R1, #+4]
        CMP      R1,#+200
        BGE.N    ??Mag_Control_2
        LDR.N    R1,??DataTable10
        LDRH     R1,[R1, #+6]
        CMP      R1,#+200
        BGE.N    ??Mag_Control_2
        LDR.N    R1,??DataTable10
        LDRH     R1,[R1, #+2]
        MOVW     R2,#+650
        CMP      R1,R2
        BGE.N    ??Mag_Control_2
        LDR.N    R1,??DataTable10
        LDRH     R1,[R1, #+8]
        MOVW     R2,#+650
        CMP      R1,R2
        BGE.N    ??Mag_Control_2
        LDR.N    R0,??DataTable10_9
        LDR      R0,[R0, #+0]
        MOV      R1,#+800
        MULS     R0,R1,R0
        MOVS     R1,#+1
        LDR.N    R2,??DataTable10_10
        STRB     R1,[R2, #+0]
        B.N      ??Mag_Control_3
//  118   else lost = 0;
??Mag_Control_2:
        MOVS     R1,#+0
        LDR.N    R2,??DataTable10_10
        STRB     R1,[R2, #+0]
//  119   if(!lost){
??Mag_Control_3:
        LDR.N    R1,??DataTable10_10
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BNE.N    ??Mag_Control_4
//  120     left_right = (dir>0? 1:-1); 
        CMP      R0,#+1
        BLT.N    ??Mag_Control_5
        MOVS     R1,#+1
        LDR.N    R2,??DataTable10_9
        STR      R1,[R2, #+0]
        B.N      ??Mag_Control_6
??Mag_Control_5:
        MOVS     R1,#-1
        LDR.N    R2,??DataTable10_9
        STR      R1,[R2, #+0]
//  121     return (int)(dir * pow);
??Mag_Control_6:
        BL       __aeabi_i2f
        MOVS     R1,R6
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        B.N      ??Mag_Control_7
//  122   }
//  123   else return left_right*800;
??Mag_Control_4:
        LDR.N    R0,??DataTable10_9
        LDR      R0,[R0, #+0]
        MOV      R1,#+800
        MULS     R0,R1,R0
??Mag_Control_7:
        POP      {R1,R4-R7,PC}    ;; return
//  124 }

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
`Mag_Control::last_err_mag`:
        DS8 4
//  125 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  126 void Mixed_Control(){
Mixed_Control:
        PUSH     {R4-R6,LR}
//  127   int mixed_dir = (Mag_Control()*0.9 + Cam_2_line()*0.8 + Cam_k()*0.4);
        BL       Mag_Control
        MOVS     R4,R0
        BL       Cam_2_line
        MOVS     R6,R0
        MOVS     R0,R4
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable10_11  ;; 0xcccccccd
        LDR.N    R3,??DataTable10_12  ;; 0x3feccccc
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,R6
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable10_3  ;; 0x9999999a
        LDR.N    R3,??DataTable10_13  ;; 0x3fe99999
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        BL       Cam_k
        BL       __aeabi_i2d
        LDR.N    R2,??DataTable10_3  ;; 0x9999999a
        LDR.N    R3,??DataTable10_8  ;; 0x3fd99999
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        MOVS     R4,R0
//  128   Circle_Con();
        BL       Circle_Con
//  129   mixed_dir *= (mixed_dir>0?circle_dep_left:circle_dep_right);
        CMP      R4,#+1
        BLT.N    ??Mixed_Control_0
        LDR.N    R0,??DataTable10_14
        LDR      R5,[R0, #+0]
        B.N      ??Mixed_Control_1
??Mixed_Control_0:
        LDR.N    R0,??DataTable10_15
        LDR      R5,[R0, #+0]
??Mixed_Control_1:
        MOVS     R0,R4
        BL       __aeabi_i2f
        MOVS     R1,R5
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
//  130   dir = mixed_dir;
        LDR.N    R1,??DataTable10_16
        STR      R0,[R1, #+0]
//  131   Servo_Output(-mixed_dir);
        RSBS     R0,R0,#+0
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       Servo_Output
//  132 }
        POP      {R4-R6,PC}       ;; return
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void Circle_Con(){
//  135   static int circle_cnt=0;
//  136   if(mag_val[2]>600 && mag_val[3]>600 && mag_val[0]>700 && mag_val[5] == 0){circle_dep_right=0.2;circle_cnt+=1;}
Circle_Con:
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+4]
        MOVW     R1,#+601
        CMP      R0,R1
        BLT.N    ??Circle_Con_0
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+6]
        MOVW     R1,#+601
        CMP      R0,R1
        BLT.N    ??Circle_Con_0
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+701
        CMP      R0,R1
        BLT.N    ??Circle_Con_0
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+10]
        CMP      R0,#+0
        BNE.N    ??Circle_Con_0
        LDR.N    R0,??DataTable10_17  ;; 0x3e4ccccd
        LDR.N    R1,??DataTable10_15
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable10_18
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_18
        STR      R0,[R1, #+0]
        B.N      ??Circle_Con_1
//  137   else if(circle_cnt >10){circle_dep_right = 1.0;circle_cnt = 0;}
??Circle_Con_0:
        LDR.N    R0,??DataTable10_18
        LDR      R0,[R0, #+0]
        CMP      R0,#+11
        BLT.N    ??Circle_Con_1
        MOVS     R0,#+1065353216
        LDR.N    R1,??DataTable10_15
        STR      R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_18
        STR      R0,[R1, #+0]
//  138   if(mag_val[2]>600 && mag_val[3]>600 && mag_val[5]>700 && mag_val[0] == 0){circle_dep_left=0.2;circle_cnt += 1;}
??Circle_Con_1:
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+4]
        MOVW     R1,#+601
        CMP      R0,R1
        BLT.N    ??Circle_Con_2
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+6]
        MOVW     R1,#+601
        CMP      R0,R1
        BLT.N    ??Circle_Con_2
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+10]
        MOVW     R1,#+701
        CMP      R0,R1
        BLT.N    ??Circle_Con_2
        LDR.N    R0,??DataTable10
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Circle_Con_2
        LDR.N    R0,??DataTable10_17  ;; 0x3e4ccccd
        LDR.N    R1,??DataTable10_14
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable10_18
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_18
        STR      R0,[R1, #+0]
        B.N      ??Circle_Con_3
//  139   else if(circle_cnt>10){circle_dep_left = 1.0;circle_cnt = 0;}
??Circle_Con_2:
        LDR.N    R0,??DataTable10_18
        LDR      R0,[R0, #+0]
        CMP      R0,#+11
        BLT.N    ??Circle_Con_3
        MOVS     R0,#+1065353216
        LDR.N    R1,??DataTable10_14
        STR      R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_18
        STR      R0,[R1, #+0]
//  140 }
??Circle_Con_3:
        BX       LR               ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
`Circle_Con::circle_cnt`:
        DS8 4
//  141 
//  142 
//  143 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  144 void Mag_Init(){
//  145   
//  146   if(!ADC1_enabled){
Mag_Init:
        LDR.N    R0,??DataTable10_19
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Mag_Init_0
//  147     SIM->SCGC3 |= SIM_SCGC3_ADC1_MASK;  //ADC1 Clock Enable
        LDR.N    R0,??DataTable10_20  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable10_20  ;; 0x40048030
        STR      R0,[R1, #+0]
//  148     ADC1->CFG1 |= 0
//  149                //|ADC_CFG1_ADLPC_MASK
//  150                | ADC_CFG1_ADICLK(1)
//  151                | ADC_CFG1_MODE(1)
//  152                | ADC_CFG1_ADIV(0);
        LDR.N    R0,??DataTable10_21  ;; 0x400bb008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x5
        LDR.N    R1,??DataTable10_21  ;; 0x400bb008
        STR      R0,[R1, #+0]
//  153     ADC1->CFG2 |= //ADC_CFG2_ADHSC_MASK |
//  154                   ADC_CFG2_ADACKEN_MASK;
        LDR.N    R0,??DataTable10_22  ;; 0x400bb00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_22  ;; 0x400bb00c
        STR      R0,[R1, #+0]
//  155     
//  156     ADC1->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
        LDR.N    R0,??DataTable10_1  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable10_1  ;; 0x400bb000
        STR      R0,[R1, #+0]
//  157     ADC1_enabled = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_19
        STRB     R0,[R1, #+0]
//  158   }
//  159   
//  160   PORTE->PCR[0]|=PORT_PCR_MUX(0);//adc1-4a
??Mag_Init_0:
        LDR.N    R0,??DataTable10_23  ;; 0x4004d000
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable10_23  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  161   PORTE->PCR[1]|=PORT_PCR_MUX(0);//adc1-5a
        LDR.N    R0,??DataTable10_24  ;; 0x4004d004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable10_24  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  162   PORTE->PCR[2]|=PORT_PCR_MUX(0);//adc1-6a
        LDR.N    R0,??DataTable10_25  ;; 0x4004d008
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable10_25  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  163   PORTE->PCR[3]|=PORT_PCR_MUX(0);//adc1-7a
        LDR.N    R0,??DataTable10_26  ;; 0x4004d00c
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable10_26  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  164 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     mag_val

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     0x400bb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x400bb010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     0x3fc99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     0x3fd33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     0x3ff33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     `Mag_Control::last_err_mag`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0x3fd99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_9:
        DC32     left_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_10:
        DC32     lost

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_11:
        DC32     0xcccccccd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_12:
        DC32     0x3feccccc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_13:
        DC32     0x3fe99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_14:
        DC32     circle_dep_left

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_15:
        DC32     circle_dep_right

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_16:
        DC32     dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_17:
        DC32     0x3e4ccccd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_18:
        DC32     `Circle_Con::circle_cnt`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_19:
        DC32     ADC1_enabled

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_20:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_21:
        DC32     0x400bb008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_22:
        DC32     0x400bb00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_23:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_24:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_25:
        DC32     0x4004d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_26:
        DC32     0x4004d00c

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
//    29 bytes in section .bss
//     8 bytes in section .data
// 1 020 bytes in section .text
// 
// 1 020 bytes of CODE memory
//    37 bytes of DATA memory
//
//Errors: none
//Warnings: 8
