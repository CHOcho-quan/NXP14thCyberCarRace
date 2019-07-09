///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      06/Jul/2019  22:02:02
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\OLED_UI.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EWFE82.tmp
//        (E:\IARworkspace\CamCar_IAR\source\OLED_UI.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\OLED_UI.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Oled_DrawBMP
        EXTERN Oled_Putnum
        EXTERN Oled_Putstr
        EXTERN accx
        EXTERN battery
        EXTERN cam_buffer
        EXTERN pit0_time
        EXTERN pit1_time
        EXTERN tacho0
        EXTERN tacho1
        EXTERN thr

        PUBLIC UI_Graph
        PUBLIC UI_SystemInfo
        PUBLIC displayCamera
        PUBLIC drawCam
        PUBLIC isWhite

// E:\IARworkspace\CamCar_IAR\source\OLED_UI.c
//    1 
//    2 #include "includes.h"
//    3 extern int thr;
//    4   /*
//    5   UI_Page homepage;
//    6   UI_Page subpage0;
//    7   homepage.sub_type = (enum Item_Type *) malloc (4*2);
//    8   homepage.sub_type[0] = Item_Type_Menu;
//    9   homepage.sub = (void **)malloc (4*2); // (void **)(UI_Page **)
//   10   *((UI_Page **)(homepage.sub)+0) = (UI_Page *) &subpage0;
//   11   subpage0.parent = (void *) &homepage;
//   12   
//   13   subpage0.sub = (void **)123;
//   14   Oled_Putnum(0,0,(s16)((*((UI_Page **)homepage.sub+0))->sub));
//   15   */
//   16   //free(homepage.sub);
//   17   //free(homepage.sub_type);
//   18 
//   19 
//   20 enum Item_Type{
//   21     Item_Type_Menu,
//   22     Item_Type_Para,
//   23     Item_Type_Show,
//   24     Item_Type_Func,
//   25 };
//   26 
//   27 typedef struct {
//   28   void * parent;   // UI_Page *
//   29   enum Item_Type * sub_type; 
//   30   void ** sub;  // UI_Page **
//   31 }UI_Page;
//   32 
//   33 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 void UI_SystemInfo(){
UI_SystemInfo:
        PUSH     {R7,LR}
//   35   Oled_Putstr(0,0,"Car Type"); Oled_Putnum(0,11,CAR_TYPE);
        LDR.N    R2,??DataTable2
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_Putstr
        MOVS     R2,#+0
        MOVS     R1,#+11
        MOVS     R0,#+0
        BL       Oled_Putnum
//   36   Oled_Putstr(1,0,"battery"); Oled_Putnum(1,11,battery);
        LDR.N    R2,??DataTable2_1
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_2
        LDRSH    R0,[R0, #+0]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       Oled_Putnum
//   37   Oled_Putstr(3,0,"pit0 time"); Oled_Putnum(3,11,(s16)pit0_time);
        LDR.N    R2,??DataTable2_3
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_4
        LDR      R0,[R0, #+0]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+3
        BL       Oled_Putnum
//   38   Oled_Putstr(4,0,"pit1 time"); Oled_Putnum(4,11,(s16)pit1_time);
        LDR.N    R2,??DataTable2_5
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_6
        LDR      R0,[R0, #+0]
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+4
        BL       Oled_Putnum
//   39   Oled_Putstr(5,0,"tacho0"); Oled_Putnum(5,11,tacho0);
        LDR.N    R2,??DataTable2_7
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_8
        LDRSH    R2,[R0, #+0]
        MOVS     R1,#+11
        MOVS     R0,#+5
        BL       Oled_Putnum
//   40   Oled_Putstr(6,0,"tacho1"); Oled_Putnum(6,11,tacho1);
        LDR.N    R2,??DataTable2_9
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_10
        LDRSH    R2,[R0, #+0]
        MOVS     R1,#+11
        MOVS     R0,#+6
        BL       Oled_Putnum
//   41 
//   42 #if (CAR_TYPE==0)   // Magnet and Balance
//   43   
//   44   Oled_Putstr(7,0,"accx"); Oled_Putnum(7,11,accx);
        LDR.N    R2,??DataTable2_11
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       Oled_Putstr
        LDR.N    R0,??DataTable2_12
        LDRSH    R2,[R0, #+0]
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//   45   
//   46 #elif (CAR_TYPE==1)     // CCD
//   47   
//   48   
//   49 #else               // Camera
//   50   
//   51   Oled_Putstr(7,0,"cam"); Oled_Putnum(7,11,cam_buffer[20][40]);
//   52   
//   53 #endif
//   54 }
        POP      {R0,PC}          ;; return
//   55 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 void UI_Graph(u8* data){
//   57   
//   58 }
UI_Graph:
        BX       LR               ;; return
//   59 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 void displayCamera()
//   61 {
displayCamera:
        PUSH     {R7,LR}
//   62   drawCam(isWhite);
        ADR.W    R0,isWhite
        BL       drawCam
//   63 }
        POP      {R0,PC}          ;; return
//   64 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   65 void drawCam(boolean(*isTarget)(u8 x)) {
drawCam:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+1024
        SUB      SP,SP,#+4
        MOVS     R4,R0
//   66   int row, col, i;
//   67   u8 buf[IMG_COLS * IMG_ROWS /8];
//   68   u8 *p = buf;
        ADD      R5,SP,#+4
//   69     
//   70   for (row = IMG_ROWS-1; row >= 0; row -= 8) {
        MOVS     R6,#+63
        B.N      ??drawCam_0
??drawCam_1:
        SUBS     R6,R6,#+8
??drawCam_0:
        CMP      R6,#+0
        BMI.N    ??drawCam_2
//   71     for (col = IMG_COLS-1; col >= 0 ; col--) {
        MOVS     R7,#+127
        B.N      ??drawCam_3
//   72       u8 tmp = 0;
//   73       for (i = 0; i < 8; i++) {
//   74         tmp <<= 1;
??drawCam_4:
        LSLS     R9,R9,#+1
//   75         if (isTarget(cam_buffer[row-i][col]))
        LDR.N    R1,??DataTable2_13
        SUBS     R2,R6,R8
        MOVS     R0,#+128
        MULS     R2,R0,R2
        ADD      R0,R1,R2
        LDRB     R0,[R0, R7]
        BLX      R4
        CMP      R0,#+0
        BEQ.N    ??drawCam_5
//   76           tmp |= 0x01;
        ORRS     R9,R9,#0x1
//   77       }
??drawCam_5:
        ADDS     R8,R8,#+1
??drawCam_6:
        CMP      R8,#+8
        BLT.N    ??drawCam_4
//   78       *p++ = tmp;
        STRB     R9,[R5, #+0]
        ADDS     R5,R5,#+1
        SUBS     R7,R7,#+1
??drawCam_3:
        CMP      R7,#+0
        BMI.N    ??drawCam_1
        MOVS     R9,#+0
        MOVS     R8,#+0
        B.N      ??drawCam_6
//   79     }
//   80   }
//   81   Oled_DrawBMP(0, 0,IMG_COLS, IMG_ROWS, buf);
??drawCam_2:
        ADD      R0,SP,#+4
        STR      R0,[SP, #+0]
        MOVS     R3,#+64
        MOVS     R2,#+128
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_DrawBMP
//   82 }
        ADD      SP,SP,#+1024
        ADD      SP,SP,#+4
        POP      {R4-R9,PC}       ;; return
//   83 
//   84 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   85 boolean isWhite(u8 x)
//   86 {     //@@@@@@@@@@@@@@@@
//   87   return x > thr;
isWhite:
        LDR.N    R1,??DataTable2_14
        LDR      R1,[R1, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R1,R0
        BGE.N    ??isWhite_0
        MOVS     R0,#+1
        B.N      ??isWhite_1
??isWhite_0:
        MOVS     R0,#+0
??isWhite_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//   88 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     battery

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     pit0_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     pit1_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     ?_6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     accx

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     cam_buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_14:
        DC32     thr

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_0:
        DC8 "Car Type"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_1:
        DC8 "battery"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_2:
        DC8 "pit0 time"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_3:
        DC8 "pit1 time"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_4:
        DC8 "tacho0"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_5:
        DC8 "tacho1"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_6:
        DC8 "accx"
        DC8 0, 0, 0

        END
//   89 
//   90 
//   91 
//   92 
//   93 
//   94 
//   95 
//   96 
//   97 
//   98 
//   99 
//  100 
//  101 
//  102 
//  103 
//  104 
//  105 
// 
//  68 bytes in section .rodata
// 386 bytes in section .text
// 
// 386 bytes of CODE  memory
//  68 bytes of CONST memory
//
//Errors: none
//Warnings: none
