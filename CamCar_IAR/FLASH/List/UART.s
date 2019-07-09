///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      06/Jul/2019  22:02:02
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\UART.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EWFF3F.tmp
//        (E:\IARworkspace\CamCar_IAR\source\UART.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\UART.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN g_bus_clock

        PUBLIC UART3_IRQHandler
        PUBLIC UART_GetChar
        PUBLIC UART_Init
        PUBLIC UART_SendChar
        PUBLIC UART_SendData
        PUBLIC UART_SendDataHead

// E:\IARworkspace\CamCar_IAR\source\UART.c
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
        LDR.N    R1,??DataTable6  ;; 0xe000e100
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
        LDR.N    R2,??DataTable6_1  ;; 0xe000e400
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        STRB     R1,[R2, R0]
        B.N      ??__NVIC_SetPriority_1
??__NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.N    R2,??DataTable6_2  ;; 0xe000ed18
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
//   10 
//   11 // === Receive ISR ===

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   12 void UART3_IRQHandler(void){
UART3_IRQHandler:
        PUSH     {R7,LR}
//   13   uint8 tmp = UART_GetChar();
        BL       UART_GetChar
//   14   
//   15   if(tmp<100){
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+100
        BLT.N    ??UART3_IRQHandler_0
//   16     
//   17   }
//   18   else if(tmp==101){ //tilt to front
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+101
        BEQ.N    ??UART3_IRQHandler_0
//   19     
//   20   }
//   21   else if(tmp==102){ //tilt to back
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+102
//   22     
//   23   }
//   24   else if(tmp==103){
//   25     
//   26   }
//   27 }
??UART3_IRQHandler_0:
        POP      {R0,PC}          ;; return
//   28 
//   29 
//   30 
//   31 // ======== APIs ======
//   32 
//   33 // ---- Ayano's Format ----
//   34 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 void UART_SendDataHead(){
//   36   while(!(UART3->S1 & UART_S1_TDRE_MASK));
UART_SendDataHead:
??UART_SendDataHead_0:
        LDR.N    R0,??DataTable6_3  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART_SendDataHead_0
//   37   UART3->D = 127;
        MOVS     R0,#+127
        LDR.N    R1,??DataTable6_4  ;; 0x4006d007
        STRB     R0,[R1, #+0]
//   38 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 void UART_SendData(s16 data){
//   40   uint8 neg=0;
UART_SendData:
        MOVS     R1,#+0
//   41   uint8 num;
//   42   if(data<0){
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??UART_SendData_0
//   43     neg = 1;
        MOVS     R1,#+1
//   44     data = -data;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        RSBS     R0,R0,#+0
//   45   }
//   46   num = data%100;
??UART_SendData_0:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R3,#+100
        SDIV     R2,R0,R3
        MLS      R2,R3,R2,R0
//   47   
//   48   while(!(UART3->S1 & UART_S1_TDRE_MASK));
??UART_SendData_1:
        LDR.N    R3,??DataTable6_3  ;; 0x4006d004
        LDRB     R3,[R3, #+0]
        LSLS     R3,R3,#+24
        BPL.N    ??UART_SendData_1
//   49   UART3->D = neg?(49-data/100):(50+data/100);
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??UART_SendData_2
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        RSBS     R0,R0,#+49
        B.N      ??UART_SendData_3
??UART_SendData_2:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+50
??UART_SendData_3:
        LDR.N    R1,??DataTable6_4  ;; 0x4006d007
        STRB     R0,[R1, #+0]
//   50   
//   51   while(!(UART3->S1 & UART_S1_TDRE_MASK));
??UART_SendData_4:
        LDR.N    R0,??DataTable6_3  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART_SendData_4
//   52   UART3->D = num;
        LDR.N    R0,??DataTable6_4  ;; 0x4006d007
        STRB     R2,[R0, #+0]
//   53 }
        BX       LR               ;; return
//   54 
//   55 
//   56 
//   57 // ----- Basic Functions -----
//   58 
//   59 // Read 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 int8 UART_GetChar(){
//   61   while(!(UART3->S1 & UART_S1_RDRF_MASK));
UART_GetChar:
??UART_GetChar_0:
        LDR.N    R0,??DataTable6_3  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART_GetChar_0
//   62   return UART3->D;
        LDR.N    R0,??DataTable6_4  ;; 0x4006d007
        LDRSB    R0,[R0, #+0]
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//   63 }
//   64 
//   65 // Send

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 void UART_SendChar(uint8 data){
//   67   while(!(UART3->S1 & UART_S1_TDRE_MASK));
UART_SendChar:
??UART_SendChar_0:
        LDR.N    R1,??DataTable6_3  ;; 0x4006d004
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??UART_SendChar_0
//   68   UART3->D = data;
        LDR.N    R1,??DataTable6_4  ;; 0x4006d007
        STRB     R0,[R1, #+0]
//   69 }
        BX       LR               ;; return
//   70 
//   71 // Init

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void UART_Init(u32 baud){
UART_Init:
        PUSH     {R4,LR}
//   73   //UART3
//   74   
//   75   uint16 sbr;
//   76   uint32 busclock = g_bus_clock;
        LDR.N    R1,??DataTable6_5
        LDR      R1,[R1, #+0]
//   77 
//   78   SIM->SCGC4 |= SIM_SCGC4_UART3_MASK;
        LDR.N    R2,??DataTable6_6  ;; 0x40048034
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x2000
        LDR.N    R3,??DataTable6_6  ;; 0x40048034
        STR      R2,[R3, #+0]
//   79   
//   80   PORTE->PCR[4] = PORT_PCR_MUX(3);
        MOV      R2,#+768
        LDR.N    R3,??DataTable6_7  ;; 0x4004d010
        STR      R2,[R3, #+0]
//   81   PORTE->PCR[5] = PORT_PCR_MUX(3);
        MOV      R2,#+768
        LDR.N    R3,??DataTable6_8  ;; 0x4004d014
        STR      R2,[R3, #+0]
//   82   UART3->C2 &= ~(UART_C2_TE_MASK | UART_C2_RE_MASK );  // DISABLE UART FIRST
        LDR.N    R2,??DataTable6_9  ;; 0x4006d003
        LDRB     R2,[R2, #+0]
        ANDS     R2,R2,#0xF3
        LDR.N    R3,??DataTable6_9  ;; 0x4006d003
        STRB     R2,[R3, #+0]
//   83   UART3->C1 = 0;  // NONE PARITY CHECK
        MOVS     R2,#+0
        LDR.N    R3,??DataTable6_10  ;; 0x4006d002
        STRB     R2,[R3, #+0]
//   84   
//   85   //UART baud rate = UART module clock / (16 × (SBR[12:0] + BRFD))
//   86   // BRFD = BRFA/32; fraction
//   87   sbr = (uint16)(busclock/(16*baud));
        LSLS     R2,R0,#+4
        UDIV     R2,R1,R2
//   88   UART3->BDH = (UART3->BDH & 0XC0)|(uint8)((sbr & 0X1F00)>>8);
        LDR.N    R3,??DataTable6_11  ;; 0x4006d000
        LDRB     R3,[R3, #+0]
        ANDS     R3,R3,#0xC0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R4,R2
        ASRS     R4,R4,#+8
        ANDS     R4,R4,#0x1F
        ORRS     R3,R4,R3
        LDR.N    R4,??DataTable6_11  ;; 0x4006d000
        STRB     R3,[R4, #+0]
//   89   UART3->BDL = (uint8)(sbr & 0XFF);
        LDR.N    R3,??DataTable6_12  ;; 0x4006d001
        STRB     R2,[R3, #+0]
//   90   
//   91   UART3->C4 = (UART3->C4 & 0XE0)|(uint8)((32*busclock)/(16*baud)-sbr*32); 
        LDR.N    R3,??DataTable6_13  ;; 0x4006d00a
        LDRB     R3,[R3, #+0]
        ANDS     R3,R3,#0xE0
        LSLS     R1,R1,#+5
        LSLS     R0,R0,#+4
        UDIV     R1,R1,R0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSLS     R0,R2,#+5
        SUBS     R1,R1,R0
        ORRS     R3,R1,R3
        LDR.N    R0,??DataTable6_13  ;; 0x4006d00a
        STRB     R3,[R0, #+0]
//   92 
//   93   UART3->C2 |=  UART_C2_RIE_MASK;
        LDR.N    R0,??DataTable6_9  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable6_9  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   94   
//   95   UART3->C2 |= UART_C2_RE_MASK;
        LDR.N    R0,??DataTable6_9  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable6_9  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   96   
//   97   UART3->C2 |= UART_C2_TE_MASK; 
        LDR.N    R0,??DataTable6_9  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable6_9  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   98   
//   99   NVIC_EnableIRQ(UART3_RX_TX_IRQn); 
        MOVS     R0,#+51
        BL       __NVIC_EnableIRQ
//  100   NVIC_SetPriority(UART3_RX_TX_IRQn, NVIC_EncodePriority(NVIC_GROUP, 2, 2));
        MOVS     R2,#+2
        MOVS     R1,#+2
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+51
        BL       __NVIC_SetPriority
//  101 }
        POP      {R4,PC}          ;; return

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
        DC32     0x4006d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     0x4006d007

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     0x4006d003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     0x4006d002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     0x4006d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     0x4006d001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     0x4006d00a

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
// 508 bytes in section .text
// 
// 508 bytes of CODE memory
//
//Errors: none
//Warnings: none
