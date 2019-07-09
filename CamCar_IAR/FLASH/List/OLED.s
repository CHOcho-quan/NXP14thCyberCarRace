///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      06/Jul/2019  22:02:01
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\source\OLED.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EWFE42.tmp
//        (E:\IARworkspace\CamCar_IAR\source\OLED.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\OLED.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC F6x8
        PUBLIC Oled_Clear
        PUBLIC Oled_DC
        PUBLIC Oled_DLY_ms
        PUBLIC Oled_DrawBMP
        PUBLIC Oled_Init
        PUBLIC Oled_Putnum
        PUBLIC Oled_Putstr
        PUBLIC Oled_RST
        PUBLIC Oled_SCL
        PUBLIC Oled_SDA
        PUBLIC Oled_Set_Pos
        PUBLIC Oled_Setxy
        PUBLIC Oled_WrCmd
        PUBLIC Oled_WrDat

// E:\IARworkspace\CamCar_IAR\source\OLED.c
//    1 /*
//    2     Basic of Oled
//    3 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    4 Date : 2015/12/01
//    5 
//    6 */
//    7 
//    8 
//    9 #include "includes.h"
//   10 
//   11 
//   12 
//   13 // ===== Variables =====
//   14 
//   15 // --- Local ---
//   16 const uint8 F6x8[][6];
//   17 #define XLevelL		0x00
//   18 #define XLevelH		0x10
//   19 #define XLevel		((XLevelH&0x0F)*16+XLevelL)
//   20 #define OLED_COL	128
//   21 #define Max_Row		  64
//   22 #define	Brightness	0xCF 
//   23 
//   24 #define X_WIDTH 128
//   25 #define Y_WIDTH 64
//   26 
//   27 
//   28 
//   29 // ===== Functions Declare =====
//   30 
//   31 // --- Local --- ( No need for user to use ! )
//   32 
//   33   // Basic Driver 
//   34 void Oled_WrDat(uint8 data);
//   35 void Oled_WrCmd(uint8 cmd);
//   36 void Oled_DLY_ms(uint16 ms);
//   37 void Oled_Set_Pos(uint8 x, uint8 y);
//   38 
//   39   // Hardware Interface
//   40 void Oled_SCL(u8 x);
//   41 void Oled_SDA(u8 x);
//   42 void Oled_RST(u8 x);
//   43 void Oled_DC(u8 x);
//   44 
//   45 
//   46 
//   47 
//   48 
//   49 // ===== APIs Realization =====
//   50 
//   51 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 void Oled_Putstr(u8 y,u8 x,u8 ch[])
//   53 {
Oled_Putstr:
        PUSH     {R4-R8,LR}
        MOVS     R3,R0
        MOVS     R4,R1
        MOVS     R5,R2
//   54   uint8 c=0,i=0,j=0,t=0; 
        MOVS     R0,#+0
        MOVS     R0,#+0
        MOVS     R0,#+0
        MOVS     R6,#+0
        B.N      ??Oled_Putstr_0
//   55   while (ch[t]!='\0')
//   56     t++;
??Oled_Putstr_1:
        ADDS     R6,R6,#+1
??Oled_Putstr_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDRB     R0,[R5, R6]
        CMP      R0,#+0
        BNE.N    ??Oled_Putstr_1
//   57   Oled_Set_Pos(21-x-t,7-y);
        RSBS     R3,R3,#+7
        MOVS     R1,R3
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        RSBS     R4,R4,#+21
        SUBS     R4,R4,R6
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_Set_Pos
//   58   for(j=0;j<t;j++){   
        MOVS     R4,#+0
        B.N      ??Oled_Putstr_2
//   59     c = ch[t-1-j]-32;
//   60     for(i=0;i<6;i++)     
//   61       Oled_WrDat(F6x8[c][5-i]);  
??Oled_Putstr_3:
        LDR.W    R0,??DataTable5
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MOVS     R1,#+6
        MUL      R1,R1,R7
        ADD      R0,R0,R1
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        RSBS     R1,R8,#+0
        ADD      R0,R0,R1
        LDRB     R0,[R0, #+5]
        BL       Oled_WrDat
        ADDS     R8,R8,#+1
??Oled_Putstr_4:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+6
        BLT.N    ??Oled_Putstr_3
        ADDS     R4,R4,#+1
??Oled_Putstr_2:
        MOVS     R0,R4
        MOVS     R1,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BCS.N    ??Oled_Putstr_5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SUBS     R0,R6,#+1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        SUBS     R0,R0,R4
        LDRB     R0,[R5, R0]
        SUBS     R7,R0,#+32
        MOVS     R8,#+0
        B.N      ??Oled_Putstr_4
//   62   }
//   63 }
??Oled_Putstr_5:
        POP      {R4-R8,PC}       ;; return
//   64 /*
//   65 void print_curse(u8 col,u8 sel){   
//   66   uint8 i;
//   67   for(i=0;i<8;++i){
//   68     if (col == i) {
//   69       if (sel == 0) Oled_Putstr(col,0,">");
//   70       else Oled_Putstr(col,0,"*");
//   71     }
//   72     else Oled_Putstr(i,0," "); 
//   73   }
//   74 }
//   75 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 void Oled_Putnum(u8 x,u8 y,s16 c){      
Oled_Putnum:
        PUSH     {R1-R5,LR}
//   77   uint8 cha[7],temp,sig=0;
        MOVS     R3,#+0
//   78   
//   79   if (c<0){
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        CMP      R2,#+0
        BPL.N    ??Oled_Putnum_0
//   80     sig=1;
        MOVS     R3,#+1
//   81     c = -c;
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        RSBS     R2,R2,#+0
//   82   }
//   83   
//   84   cha[0]=' ';
??Oled_Putnum_0:
        MOVS     R4,#+32
        STRB     R4,[SP, #+0]
//   85   
//   86   temp=c/10000;
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVW     R4,#+10000
        SDIV     R4,R2,R4
//   87   if(temp==0) cha[1]=' ';
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??Oled_Putnum_1
        MOVS     R4,#+32
        STRB     R4,[SP, #+1]
        B.N      ??Oled_Putnum_2
//   88   else cha[1]=temp+48;
??Oled_Putnum_1:
        ADDS     R4,R4,#+48
        STRB     R4,[SP, #+1]
//   89   
//   90   temp=c%10000/1000;
??Oled_Putnum_2:
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVW     R4,#+10000
        SDIV     R5,R2,R4
        MLS      R4,R4,R5,R2
        MOV      R5,#+1000
        SDIV     R4,R4,R5
//   91   if(temp==0 && cha[1]==' ') cha[2]=' ';
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??Oled_Putnum_3
        LDRB     R5,[SP, #+1]
        CMP      R5,#+32
        BNE.N    ??Oled_Putnum_3
        MOVS     R4,#+32
        STRB     R4,[SP, #+2]
        B.N      ??Oled_Putnum_4
//   92   else cha[2]=temp+48;
??Oled_Putnum_3:
        ADDS     R4,R4,#+48
        STRB     R4,[SP, #+2]
//   93   
//   94   temp=c%1000/100;
??Oled_Putnum_4:
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOV      R4,#+1000
        SDIV     R5,R2,R4
        MLS      R4,R4,R5,R2
        MOVS     R5,#+100
        SDIV     R4,R4,R5
//   95   if(temp==0 && cha[2]==' ') cha[3]=' ';
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??Oled_Putnum_5
        LDRB     R5,[SP, #+2]
        CMP      R5,#+32
        BNE.N    ??Oled_Putnum_5
        MOVS     R4,#+32
        STRB     R4,[SP, #+3]
        B.N      ??Oled_Putnum_6
//   96   else cha[3]=temp+48;
??Oled_Putnum_5:
        ADDS     R4,R4,#+48
        STRB     R4,[SP, #+3]
//   97   
//   98   temp=c%100/10;
??Oled_Putnum_6:
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R4,#+100
        SDIV     R5,R2,R4
        MLS      R4,R4,R5,R2
        MOVS     R5,#+10
        SDIV     R4,R4,R5
//   99   if(temp==0 && cha[3]==' ') cha[4]=' ';
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??Oled_Putnum_7
        LDRB     R5,[SP, #+3]
        CMP      R5,#+32
        BNE.N    ??Oled_Putnum_7
        MOVS     R4,#+32
        STRB     R4,[SP, #+4]
        B.N      ??Oled_Putnum_8
//  100   else cha[4]=temp+48; 
??Oled_Putnum_7:
        ADDS     R4,R4,#+48
        STRB     R4,[SP, #+4]
//  101   
//  102   temp=c%10;
??Oled_Putnum_8:
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R4,#+10
        SDIV     R5,R2,R4
        MLS      R2,R4,R5,R2
//  103   cha[5]=temp+48;  
        ADDS     R2,R2,#+48
        STRB     R2,[SP, #+5]
//  104   cha[6]='\0';
        MOVS     R2,#+0
        STRB     R2,[SP, #+6]
//  105   if(sig){
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BEQ.N    ??Oled_Putnum_9
//  106     temp=6;
        MOVS     R2,#+6
        B.N      ??Oled_Putnum_10
//  107     while(cha[temp]!=' ')
//  108       temp--;
??Oled_Putnum_11:
        SUBS     R2,R2,#+1
??Oled_Putnum_10:
        MOV      R3,SP
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDRB     R3,[R3, R2]
        CMP      R3,#+32
        BNE.N    ??Oled_Putnum_11
//  109     cha[temp]='-';
        MOVS     R3,#+45
        MOV      R4,SP
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        STRB     R3,[R4, R2]
//  110   }
//  111   Oled_Putstr(x,y+1,cha);
??Oled_Putnum_9:
        MOV      R2,SP
        ADDS     R1,R1,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_Putstr
//  112 }
        POP      {R0-R2,R4,R5,PC}  ;; return
//  113 
//  114 
//  115 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  116 void Oled_Clear(void)
//  117 {
Oled_Clear:
        PUSH     {R3-R5,LR}
//  118 	uint8 y,x;	
//  119 	for(y=0;y<8;y++)
        MOVS     R4,#+0
        B.N      ??Oled_Clear_0
//  120 	{
//  121 		Oled_WrCmd(0xb0+y);
//  122 		Oled_WrCmd(0x01);
//  123 		Oled_WrCmd(0x10); 
//  124 		for(x=0;x<X_WIDTH;x++)
//  125 			Oled_WrDat(0);
??Oled_Clear_1:
        MOVS     R0,#+0
        BL       Oled_WrDat
        ADDS     R5,R5,#+1
??Oled_Clear_2:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+128
        BLT.N    ??Oled_Clear_1
        ADDS     R4,R4,#+1
??Oled_Clear_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??Oled_Clear_3
        SUBS     R0,R4,#+80
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
        MOVS     R0,#+1
        BL       Oled_WrCmd
        MOVS     R0,#+16
        BL       Oled_WrCmd
        MOVS     R5,#+0
        B.N      ??Oled_Clear_2
//  126 	}
//  127 }
??Oled_Clear_3:
        POP      {R0,R4,R5,PC}    ;; return
//  128 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 void Oled_Setxy(u8 x, u8 y)     //OLED @@@@  
//  130 {   
Oled_Setxy:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  131   Oled_WrCmd(0xb0+y);  
        SUBS     R0,R1,#+80
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  132   Oled_WrCmd(((x&0xf0)>>4)|0x10);  
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+4
        ORRS     R0,R0,#0x10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  133   Oled_WrCmd((x&0x0f)|0x01);   
        ANDS     R4,R4,#0xF
        ORRS     R4,R4,#0x1
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  134 }  
        POP      {R4,PC}          ;; return
//  135 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  136 void Oled_DrawBMP(u8 x0,u8 y0,u8 x1,u8 y1,u8 BMP[])//@@@@BMP@@128×64@@@@@(x,y),x@@@0@127@y@@@@@0@7*  
//  137 {     
Oled_DrawBMP:
        PUSH     {R4-R10,LR}
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R7,R2
//  138  unsigned int j=0;  
        MOVS     R4,#+0
//  139  unsigned char x,y;  
//  140     
//  141   if(y1%8==0)  
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R0,#+8
        SDIV     R1,R3,R0
        MLS      R0,R0,R1,R3
        CMP      R0,#+0
        BNE.N    ??Oled_DrawBMP_0
//  142      y1=y1/8;        
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R0,#+8
        SDIV     R8,R3,R0
        B.N      ??Oled_DrawBMP_1
//  143   else   
//  144      y1=y1/8+1;  
??Oled_DrawBMP_0:
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R0,#+8
        SDIV     R8,R3,R0
        ADDS     R8,R8,#+1
??Oled_DrawBMP_1:
        LDR      R9,[SP, #+32]
//  145   for(y=y0;y<y1;y++)  
        B.N      ??Oled_DrawBMP_2
//  146   {  
//  147      Oled_Setxy(x0,y);                
//  148      for(x=x0;x<x1;x++)  
//  149      {        
//  150         Oled_WrDat(BMP[j++]);            
??Oled_DrawBMP_3:
        LDRB     R0,[R9, R4]
        BL       Oled_WrDat
        ADDS     R4,R4,#+1
//  151      }  
        ADDS     R10,R10,#+1
??Oled_DrawBMP_4:
        MOV      R0,R10
        MOVS     R1,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BCC.N    ??Oled_DrawBMP_3
        ADDS     R6,R6,#+1
??Oled_DrawBMP_2:
        MOVS     R0,R6
        MOV      R1,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BCS.N    ??Oled_DrawBMP_5
        MOVS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_Setxy
        MOV      R10,R5
        B.N      ??Oled_DrawBMP_4
//  152   }  
//  153 }
??Oled_DrawBMP_5:
        POP      {R4-R10,PC}      ;; return
//  154 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  155 void Oled_Init(void)        
//  156 {  
Oled_Init:
        PUSH     {R7,LR}
//  157   PORTC->PCR[12] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable5_1  ;; 0x4004b030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable5_1  ;; 0x4004b030
        STR      R0,[R1, #+0]
//  158   PORTC->PCR[13] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable5_2  ;; 0x4004b034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable5_2  ;; 0x4004b034
        STR      R0,[R1, #+0]
//  159   PORTC->PCR[14] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable5_3  ;; 0x4004b038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable5_3  ;; 0x4004b038
        STR      R0,[R1, #+0]
//  160   PORTC->PCR[15] |= PORT_PCR_MUX(1);
        LDR.N    R0,??DataTable5_4  ;; 0x4004b03c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable5_4  ;; 0x4004b03c
        STR      R0,[R1, #+0]
//  161   PTC->PDDR |= (1<<12);
        LDR.N    R0,??DataTable5_5  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable5_5  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  162   PTC->PDDR |= (1<<13);
        LDR.N    R0,??DataTable5_5  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable5_5  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  163   PTC->PDDR |= (1<<14);
        LDR.N    R0,??DataTable5_5  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable5_5  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  164   PTC->PDDR |= (1<<15);
        LDR.N    R0,??DataTable5_5  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable5_5  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  165   
//  166   Oled_SCL(1);
        MOVS     R0,#+1
        BL       Oled_SCL
//  167   //Oled_CS(1);	 	
//  168 	
//  169   Oled_RST(0);
        MOVS     R0,#+0
        BL       Oled_RST
//  170   Oled_DLY_ms(50);
        MOVS     R0,#+50
        BL       Oled_DLY_ms
//  171   Oled_RST(1);
        MOVS     R0,#+1
        BL       Oled_RST
//  172 
//  173   Oled_WrCmd(0xae);//--turn off oled panel
        MOVS     R0,#+174
        BL       Oled_WrCmd
//  174   Oled_WrCmd(0x00);//---set low column address
        MOVS     R0,#+0
        BL       Oled_WrCmd
//  175   Oled_WrCmd(0x10);//---set high column address
        MOVS     R0,#+16
        BL       Oled_WrCmd
//  176   Oled_WrCmd(0x40);//--set start line address  Set Mapping RAM Display Start Line (0x00~0x3F)
        MOVS     R0,#+64
        BL       Oled_WrCmd
//  177   Oled_WrCmd(0x81);//--set contrast control register
        MOVS     R0,#+129
        BL       Oled_WrCmd
//  178   Oled_WrCmd(0xcf); // Set SEG Output Current Brightness
        MOVS     R0,#+207
        BL       Oled_WrCmd
//  179   Oled_WrCmd(0xa1);//--Set SEG/Column Mapping     0xa0@@@@ 0xa1@@
        MOVS     R0,#+161
        BL       Oled_WrCmd
//  180   Oled_WrCmd(0xc8);//Set COM/Row Scan Direction   0xc0@@@@ 0xc8@@
        MOVS     R0,#+200
        BL       Oled_WrCmd
//  181   Oled_WrCmd(0xa6);//--set normal display
        MOVS     R0,#+166
        BL       Oled_WrCmd
//  182   Oled_WrCmd(0xa8);//--set multiplex ratio(1 to 64)
        MOVS     R0,#+168
        BL       Oled_WrCmd
//  183   Oled_WrCmd(0x3f);//--1/64 duty
        MOVS     R0,#+63
        BL       Oled_WrCmd
//  184   Oled_WrCmd(0xd3);//-set display offset	Shift Mapping RAM Counter (0x00~0x3F)
        MOVS     R0,#+211
        BL       Oled_WrCmd
//  185   Oled_WrCmd(0x00);//-not offset
        MOVS     R0,#+0
        BL       Oled_WrCmd
//  186   Oled_WrCmd(0xd5);//--set display clock divide ratio/oscillator frequency
        MOVS     R0,#+213
        BL       Oled_WrCmd
//  187   Oled_WrCmd(0xf0);//--set divide ratio, Set Clock as 100 Frames/Sec
        MOVS     R0,#+240
        BL       Oled_WrCmd
//  188   Oled_WrCmd(0xd9);//--set pre-charge period
        MOVS     R0,#+217
        BL       Oled_WrCmd
//  189   Oled_WrCmd(0xf1);//Set Pre-Charge as 15 Clocks & Discharge as 1 Clock
        MOVS     R0,#+241
        BL       Oled_WrCmd
//  190   Oled_WrCmd(0xda);//--set com pins hardware configuration
        MOVS     R0,#+218
        BL       Oled_WrCmd
//  191   Oled_WrCmd(0x12);
        MOVS     R0,#+18
        BL       Oled_WrCmd
//  192   Oled_WrCmd(0xdb);//--set vcomh
        MOVS     R0,#+219
        BL       Oled_WrCmd
//  193   Oled_WrCmd(0x40);//Set VCOM Deselect Level
        MOVS     R0,#+64
        BL       Oled_WrCmd
//  194   Oled_WrCmd(0x20);//-Set Page Addressing Mode (0x00/0x01/0x02)
        MOVS     R0,#+32
        BL       Oled_WrCmd
//  195   Oled_WrCmd(0x02);//
        MOVS     R0,#+2
        BL       Oled_WrCmd
//  196   Oled_WrCmd(0x8d);//--set Charge Pump enable/disable
        MOVS     R0,#+141
        BL       Oled_WrCmd
//  197   Oled_WrCmd(0x14);//--set(0x10) disable
        MOVS     R0,#+20
        BL       Oled_WrCmd
//  198   Oled_WrCmd(0xa4);// Disable Entire Display On (0xa4/0xa5)
        MOVS     R0,#+164
        BL       Oled_WrCmd
//  199   Oled_WrCmd(0xa6);// Disable Inverse Display On (0xa6/a7) 
        MOVS     R0,#+166
        BL       Oled_WrCmd
//  200   Oled_WrCmd(0xaf);//--turn on oled panel
        MOVS     R0,#+175
        BL       Oled_WrCmd
//  201   Oled_Clear(); 
        BL       Oled_Clear
//  202   Oled_Set_Pos(0,0);  
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_Set_Pos
//  203 	
//  204 
//  205 } 
        POP      {R0,PC}          ;; return
//  206 
//  207 
//  208 
//  209 // --- Basic Driver ---
//  210 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  211 void Oled_DLY_ms(uint16 ms)
//  212 {                         
Oled_DLY_ms:
        B.N      ??Oled_DLY_ms_0
//  213   uint16 a;
//  214   while(ms)
//  215   {
//  216     a=1335;
??Oled_DLY_ms_1:
        MOVW     R2,#+1335
//  217     while(a--);
??Oled_DLY_ms_2:
        MOVS     R1,R2
        SUBS     R2,R1,#+1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??Oled_DLY_ms_2
//  218     ms--;
        SUBS     R0,R0,#+1
//  219   }
??Oled_DLY_ms_0:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??Oled_DLY_ms_1
//  220   return;
        BX       LR               ;; return
//  221 }
//  222 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  223 void Oled_WrDat(uint8 data)
//  224 {
Oled_WrDat:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  225   uint8 i=8;
        MOVS     R5,#+8
//  226   //Oled_CS(0);;
//  227   Oled_DC(1);;
        MOVS     R0,#+1
        BL       Oled_DC
//  228   Oled_SCL(0);;   ;
        MOVS     R0,#+0
        BL       Oled_SCL
        B.N      ??Oled_WrDat_0
//  229   while(i--)
//  230   {
//  231     if(data&1){
//  232       Oled_SDA(1);asm("nop");asm("nop");
//  233     }
//  234     else{
//  235       Oled_SDA(0);asm("nop");asm("nop");
??Oled_WrDat_1:
        MOVS     R0,#+0
        BL       Oled_SDA
        nop
        nop
        B.N      ??Oled_WrDat_2
//  236     }
??Oled_WrDat_3:
        LSLS     R0,R4,#+31
        BPL.N    ??Oled_WrDat_1
        MOVS     R0,#+1
        BL       Oled_SDA
        nop
        nop
//  237     Oled_SCL(1); 
??Oled_WrDat_2:
        MOVS     R0,#+1
        BL       Oled_SCL
//  238     asm("nop");asm("nop");asm("nop");asm("nop");        
        nop
        nop
        nop
        nop
//  239     Oled_SCL(0);; 
        MOVS     R0,#+0
        BL       Oled_SCL
//  240     asm("nop");asm("nop");
        nop
        nop
//  241     data>>=1;;    
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSRS     R4,R4,#+1
//  242   }
??Oled_WrDat_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??Oled_WrDat_3
//  243   //Oled_CS=1;
//  244 }
??Oled_WrDat_4:
        POP      {R0,R4,R5,PC}    ;; return
//  245 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  246 void Oled_WrCmd(uint8 cmd)
//  247 {
Oled_WrCmd:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  248   uint8 i=8;
        MOVS     R5,#+8
//  249   
//  250   //Oled_CS(0);;
//  251   Oled_DC(0);;
        MOVS     R0,#+0
        BL       Oled_DC
//  252   Oled_SCL(0);;
        MOVS     R0,#+0
        BL       Oled_SCL
        B.N      ??Oled_WrCmd_0
//  253   //asm("nop");   
//  254   while(i--)
//  255   {
//  256     if(cmd&0x80){Oled_SDA(1);;}
//  257     else{Oled_SDA(0);;}
??Oled_WrCmd_1:
        MOVS     R0,#+0
        BL       Oled_SDA
        B.N      ??Oled_WrCmd_2
??Oled_WrCmd_3:
        LSLS     R0,R4,#+24
        BPL.N    ??Oled_WrCmd_1
        MOVS     R0,#+1
        BL       Oled_SDA
//  258     Oled_SCL(1);;
??Oled_WrCmd_2:
        MOVS     R0,#+1
        BL       Oled_SCL
//  259     asm("nop");asm("nop");     
        nop
        nop
//  260     Oled_SCL(0);;    
        MOVS     R0,#+0
        BL       Oled_SCL
//  261     cmd<<=1;;   
        LSLS     R4,R4,#+1
//  262   }
??Oled_WrCmd_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??Oled_WrCmd_3
//  263   //Oled_CS=1;
//  264 }
??Oled_WrCmd_4:
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  265 void Oled_Set_Pos(uint8 x, uint8 y)
//  266 { 
Oled_Set_Pos:
        PUSH     {R3-R5,LR}
//  267   uint8 xt,msb,lsb;
//  268   //Oled_WrCmd(0xb0+y);
//  269   //Oled_WrCmd(((x&0xf0)>>4)|0x10);
//  270   //Oled_WrCmd((x&0x0f)|0x01); 
//  271   xt = 1 + x * 6;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+6
        MULS     R0,R2,R0
        ADDS     R0,R0,#+1
//  272   lsb = xt % 16;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+16
        SDIV     R5,R0,R2
        MLS      R5,R2,R5,R0
//  273   msb = xt / 16 + 0x10;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+16
        SDIV     R4,R0,R2
        ADDS     R4,R4,#+16
//  274   Oled_WrCmd(0xb0 + y);
        SUBS     R0,R1,#+80
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  275   Oled_WrCmd(lsb);
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  276   Oled_WrCmd(msb); 
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_WrCmd
//  277 } 
        POP      {R0,R4,R5,PC}    ;; return
//  278 
//  279 // --- Hardware Interface ---
//  280 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  281 void Oled_SCL(u8 x){                     //d0
//  282   if(x)
Oled_SCL:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??Oled_SCL_0
//  283     PTC->PSOR |= 1<<15;
        LDR.N    R0,??DataTable5_6  ;; 0x400ff084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable5_6  ;; 0x400ff084
        STR      R0,[R1, #+0]
        B.N      ??Oled_SCL_1
//  284   else
//  285     PTC->PCOR |= 1<<15;
??Oled_SCL_0:
        LDR.N    R0,??DataTable5_7  ;; 0x400ff088
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable5_7  ;; 0x400ff088
        STR      R0,[R1, #+0]
//  286 }
??Oled_SCL_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  287 void Oled_SDA(u8 x){                             //d1
//  288   if(x)
Oled_SDA:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??Oled_SDA_0
//  289     PTC->PSOR |= 1<<14;
        LDR.N    R0,??DataTable5_6  ;; 0x400ff084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable5_6  ;; 0x400ff084
        STR      R0,[R1, #+0]
        B.N      ??Oled_SDA_1
//  290   else
//  291     PTC->PCOR |= 1<<14;
??Oled_SDA_0:
        LDR.N    R0,??DataTable5_7  ;; 0x400ff088
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000
        LDR.N    R1,??DataTable5_7  ;; 0x400ff088
        STR      R0,[R1, #+0]
//  292 }
??Oled_SDA_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  293 void Oled_RST(u8 x){                     //res
//  294   if(x)
Oled_RST:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??Oled_RST_0
//  295     PTC->PSOR |= 1<<13;
        LDR.N    R0,??DataTable5_6  ;; 0x400ff084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable5_6  ;; 0x400ff084
        STR      R0,[R1, #+0]
        B.N      ??Oled_RST_1
//  296   else
//  297     PTC->PCOR |= 1<<13;
??Oled_RST_0:
        LDR.N    R0,??DataTable5_7  ;; 0x400ff088
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable5_7  ;; 0x400ff088
        STR      R0,[R1, #+0]
//  298 }
??Oled_RST_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  299 void Oled_DC(u8 x){                      //dc
//  300   if(x)
Oled_DC:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??Oled_DC_0
//  301     PTC->PSOR |= 1<<12;
        LDR.N    R0,??DataTable5_6  ;; 0x400ff084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable5_6  ;; 0x400ff084
        STR      R0,[R1, #+0]
        B.N      ??Oled_DC_1
//  302   else
//  303     PTC->PCOR |= 1<<12;
??Oled_DC_0:
        LDR.N    R0,??DataTable5_7  ;; 0x400ff088
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable5_7  ;; 0x400ff088
        STR      R0,[R1, #+0]
//  304 }
??Oled_DC_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     F6x8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x4004b030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x4004b034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0x4004b038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     0x4004b03c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x400ff094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x400ff084

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x400ff088
//  305 
//  306 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
//  307 const uint8 F6x8[][6] =
F6x8:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 7, 0, 7, 0, 0, 20, 127
        DC8 20, 127, 20, 0, 36, 42, 127, 42, 18, 0, 98, 100, 8, 19, 35, 0, 54
        DC8 73, 85, 34, 80, 0, 0, 5, 3, 0, 0, 0, 0, 28, 34, 65, 0, 0, 0, 65, 34
        DC8 28, 0, 0, 20, 8, 62, 8, 20, 0, 8, 8, 62, 8, 8, 0, 0, 0, 160, 96, 0
        DC8 0, 8, 8, 8, 8, 8, 0, 0, 96, 96, 0, 0, 0, 32, 16, 8, 4, 2, 0, 62, 81
        DC8 73, 69, 62, 0, 0, 66, 127, 64, 0, 0, 66, 97, 81, 73, 70, 0, 33, 65
        DC8 69, 75, 49, 0, 24, 20, 18, 127, 16, 0, 39, 69, 69, 69, 57, 0, 60
        DC8 74, 73, 73, 48, 0, 1, 113, 9, 5, 3, 0, 54, 73, 73, 73, 54, 0, 6, 73
        DC8 73, 41, 30, 0, 0, 54, 54, 0, 0, 0, 0, 86, 54, 0, 0, 0, 8, 20, 34
        DC8 65, 0, 0, 20, 20, 20, 20, 20, 0, 0, 65, 34, 20, 8, 0, 2, 1, 81, 9
        DC8 6, 0, 50, 73, 89, 81, 62, 0, 124, 18, 17, 18, 124, 0, 127, 73, 73
        DC8 73, 54, 0, 62, 65, 65, 65, 34, 0, 127, 65, 65, 34, 28, 0, 127, 73
        DC8 73, 73, 65, 0, 127, 9, 9, 9, 1, 0, 62, 65, 73, 73, 122, 0, 127, 8
        DC8 8, 8, 127, 0, 0, 65, 127, 65, 0, 0, 32, 64, 65, 63, 1, 0, 127, 8
        DC8 20, 34, 65, 0, 127, 64, 64, 64, 64, 0, 127, 2, 12, 2, 127, 0, 127
        DC8 4, 8, 16, 127, 0, 62, 65, 65, 65, 62, 0, 127, 9, 9, 9, 6, 0, 62, 65
        DC8 81, 33, 94, 0, 127, 9, 25, 41, 70, 0, 70, 73, 73, 73, 49, 0, 1, 1
        DC8 127, 1, 1, 0, 63, 64, 64, 64, 63, 0, 31, 32, 64, 32, 31, 0, 63, 64
        DC8 56, 64, 63, 0, 99, 20, 8, 20, 99, 0, 7, 8, 112, 8, 7, 0, 97, 81, 73
        DC8 69, 67, 0, 0, 127, 65, 65, 0, 0, 85, 42, 85, 42, 85, 0, 0, 65, 65
        DC8 127, 0, 0, 4, 2, 1, 2, 4, 0, 64, 64, 64, 64, 64, 0, 0, 1, 2, 4, 0
        DC8 0, 32, 84, 84, 84, 120, 0, 127, 72, 68, 68, 56, 0, 56, 68, 68, 68
        DC8 32, 0, 56, 68, 68, 72, 127, 0, 56, 84, 84, 84, 24, 0, 8, 126, 9, 1
        DC8 2, 0, 24, 164, 164, 164, 124, 0, 127, 8, 4, 4, 120, 0, 0, 68, 125
        DC8 64, 0, 0, 64, 128, 132, 125, 0, 0, 127, 16, 40, 68, 0, 0, 0, 65
        DC8 127, 64, 0, 0, 124, 4, 24, 4, 120, 0, 124, 8, 4, 4, 120, 0, 56, 68
        DC8 68, 68, 56, 0, 252, 36, 36, 36, 24, 0, 24, 36, 36, 24, 252, 0, 124
        DC8 8, 4, 4, 8, 0, 72, 84, 84, 84, 32, 0, 4, 63, 68, 64, 32, 0, 60, 64
        DC8 64, 32, 124, 0, 28, 32, 64, 32, 28, 0, 60, 64, 48, 64, 60, 0, 68
        DC8 40, 16, 40, 68, 0, 28, 160, 160, 160, 124, 0, 68, 100, 84, 76, 68
        DC8 20, 20, 20, 20, 20, 20

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  308 {
//  309     { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },   // sp
//  310     { 0x00, 0x00, 0x00, 0x2f, 0x00, 0x00 },   // !
//  311     { 0x00, 0x00, 0x07, 0x00, 0x07, 0x00 },   // "
//  312     { 0x00, 0x14, 0x7f, 0x14, 0x7f, 0x14 },   // #
//  313     { 0x00, 0x24, 0x2a, 0x7f, 0x2a, 0x12 },   // $
//  314     { 0x00, 0x62, 0x64, 0x08, 0x13, 0x23 },   // %
//  315     { 0x00, 0x36, 0x49, 0x55, 0x22, 0x50 },   // &
//  316     { 0x00, 0x00, 0x05, 0x03, 0x00, 0x00 },   // '
//  317     { 0x00, 0x00, 0x1c, 0x22, 0x41, 0x00 },   // (
//  318     { 0x00, 0x00, 0x41, 0x22, 0x1c, 0x00 },   // )
//  319     { 0x00, 0x14, 0x08, 0x3E, 0x08, 0x14 },   // *
//  320     { 0x00, 0x08, 0x08, 0x3E, 0x08, 0x08 },   // +
//  321     { 0x00, 0x00, 0x00, 0xA0, 0x60, 0x00 },   // ,
//  322     { 0x00, 0x08, 0x08, 0x08, 0x08, 0x08 },   // -
//  323     { 0x00, 0x00, 0x60, 0x60, 0x00, 0x00 },   // .
//  324     { 0x00, 0x20, 0x10, 0x08, 0x04, 0x02 },   // /
//  325     { 0x00, 0x3E, 0x51, 0x49, 0x45, 0x3E },   // 0 16
//  326     { 0x00, 0x00, 0x42, 0x7F, 0x40, 0x00 },   // 1
//  327     { 0x00, 0x42, 0x61, 0x51, 0x49, 0x46 },   // 2
//  328     { 0x00, 0x21, 0x41, 0x45, 0x4B, 0x31 },   // 3
//  329     { 0x00, 0x18, 0x14, 0x12, 0x7F, 0x10 },   // 4
//  330     { 0x00, 0x27, 0x45, 0x45, 0x45, 0x39 },   // 5
//  331     { 0x00, 0x3C, 0x4A, 0x49, 0x49, 0x30 },   // 6
//  332     { 0x00, 0x01, 0x71, 0x09, 0x05, 0x03 },   // 7
//  333     { 0x00, 0x36, 0x49, 0x49, 0x49, 0x36 },   // 8
//  334     { 0x00, 0x06, 0x49, 0x49, 0x29, 0x1E },   // 9
//  335     { 0x00, 0x00, 0x36, 0x36, 0x00, 0x00 },   // :
//  336     { 0x00, 0x00, 0x56, 0x36, 0x00, 0x00 },   // ;
//  337     { 0x00, 0x08, 0x14, 0x22, 0x41, 0x00 },   // <
//  338     { 0x00, 0x14, 0x14, 0x14, 0x14, 0x14 },   // =
//  339     { 0x00, 0x00, 0x41, 0x22, 0x14, 0x08 },   // >
//  340     { 0x00, 0x02, 0x01, 0x51, 0x09, 0x06 },   // ?
//  341     { 0x00, 0x32, 0x49, 0x59, 0x51, 0x3E },   // @
//  342     { 0x00, 0x7C, 0x12, 0x11, 0x12, 0x7C },   // A
//  343     { 0x00, 0x7F, 0x49, 0x49, 0x49, 0x36 },   // B
//  344     { 0x00, 0x3E, 0x41, 0x41, 0x41, 0x22 },   // C
//  345     { 0x00, 0x7F, 0x41, 0x41, 0x22, 0x1C },   // D
//  346     { 0x00, 0x7F, 0x49, 0x49, 0x49, 0x41 },   // E
//  347     { 0x00, 0x7F, 0x09, 0x09, 0x09, 0x01 },   // F
//  348     { 0x00, 0x3E, 0x41, 0x49, 0x49, 0x7A },   // G
//  349     { 0x00, 0x7F, 0x08, 0x08, 0x08, 0x7F },   // H
//  350     { 0x00, 0x00, 0x41, 0x7F, 0x41, 0x00 },   // I
//  351     { 0x00, 0x20, 0x40, 0x41, 0x3F, 0x01 },   // J
//  352     { 0x00, 0x7F, 0x08, 0x14, 0x22, 0x41 },   // K
//  353     { 0x00, 0x7F, 0x40, 0x40, 0x40, 0x40 },   // L
//  354     { 0x00, 0x7F, 0x02, 0x0C, 0x02, 0x7F },   // M
//  355     { 0x00, 0x7F, 0x04, 0x08, 0x10, 0x7F },   // N
//  356     { 0x00, 0x3E, 0x41, 0x41, 0x41, 0x3E },   // O
//  357     { 0x00, 0x7F, 0x09, 0x09, 0x09, 0x06 },   // P
//  358     { 0x00, 0x3E, 0x41, 0x51, 0x21, 0x5E },   // Q
//  359     { 0x00, 0x7F, 0x09, 0x19, 0x29, 0x46 },   // R
//  360     { 0x00, 0x46, 0x49, 0x49, 0x49, 0x31 },   // S
//  361     { 0x00, 0x01, 0x01, 0x7F, 0x01, 0x01 },   // T
//  362     { 0x00, 0x3F, 0x40, 0x40, 0x40, 0x3F },   // U
//  363     { 0x00, 0x1F, 0x20, 0x40, 0x20, 0x1F },   // V
//  364     { 0x00, 0x3F, 0x40, 0x38, 0x40, 0x3F },   // W
//  365     { 0x00, 0x63, 0x14, 0x08, 0x14, 0x63 },   // X
//  366     { 0x00, 0x07, 0x08, 0x70, 0x08, 0x07 },   // Y
//  367     { 0x00, 0x61, 0x51, 0x49, 0x45, 0x43 },   // Z
//  368     { 0x00, 0x00, 0x7F, 0x41, 0x41, 0x00 },   // [
//  369     { 0x00, 0x55, 0x2A, 0x55, 0x2A, 0x55 },   // 55
//  370     { 0x00, 0x00, 0x41, 0x41, 0x7F, 0x00 },   // ]
//  371     { 0x00, 0x04, 0x02, 0x01, 0x02, 0x04 },   // ^
//  372     { 0x00, 0x40, 0x40, 0x40, 0x40, 0x40 },   // _
//  373     { 0x00, 0x00, 0x01, 0x02, 0x04, 0x00 },   // '
//  374     { 0x00, 0x20, 0x54, 0x54, 0x54, 0x78 },   // a
//  375     { 0x00, 0x7F, 0x48, 0x44, 0x44, 0x38 },   // b
//  376     { 0x00, 0x38, 0x44, 0x44, 0x44, 0x20 },   // c
//  377     { 0x00, 0x38, 0x44, 0x44, 0x48, 0x7F },   // d
//  378     { 0x00, 0x38, 0x54, 0x54, 0x54, 0x18 },   // e
//  379     { 0x00, 0x08, 0x7E, 0x09, 0x01, 0x02 },   // f
//  380     { 0x00, 0x18, 0xA4, 0xA4, 0xA4, 0x7C },   // g
//  381     { 0x00, 0x7F, 0x08, 0x04, 0x04, 0x78 },   // h
//  382     { 0x00, 0x00, 0x44, 0x7D, 0x40, 0x00 },   // i
//  383     { 0x00, 0x40, 0x80, 0x84, 0x7D, 0x00 },   // j
//  384     { 0x00, 0x7F, 0x10, 0x28, 0x44, 0x00 },   // k
//  385     { 0x00, 0x00, 0x41, 0x7F, 0x40, 0x00 },   // l
//  386     { 0x00, 0x7C, 0x04, 0x18, 0x04, 0x78 },   // m
//  387     { 0x00, 0x7C, 0x08, 0x04, 0x04, 0x78 },   // n
//  388     { 0x00, 0x38, 0x44, 0x44, 0x44, 0x38 },   // o
//  389     { 0x00, 0xFC, 0x24, 0x24, 0x24, 0x18 },   // p
//  390     { 0x00, 0x18, 0x24, 0x24, 0x18, 0xFC },   // q
//  391     { 0x00, 0x7C, 0x08, 0x04, 0x04, 0x08 },   // r
//  392     { 0x00, 0x48, 0x54, 0x54, 0x54, 0x20 },   // s
//  393     { 0x00, 0x04, 0x3F, 0x44, 0x40, 0x20 },   // t
//  394     { 0x00, 0x3C, 0x40, 0x40, 0x20, 0x7C },   // u
//  395     { 0x00, 0x1C, 0x20, 0x40, 0x20, 0x1C },   // v
//  396     { 0x00, 0x3C, 0x40, 0x30, 0x40, 0x3C },   // w
//  397     { 0x00, 0x44, 0x28, 0x10, 0x28, 0x44 },   // x
//  398     { 0x00, 0x1C, 0xA0, 0xA0, 0xA0, 0x7C },   // y
//  399     { 0x00, 0x44, 0x64, 0x54, 0x4C, 0x44 },   // z
//  400     { 0x14, 0x14, 0x14, 0x14, 0x14, 0x14 }    // horiz lines
//  401 };
// 
//   552 bytes in section .rodata
// 1 334 bytes in section .text
// 
// 1 334 bytes of CODE  memory
//   552 bytes of CONST memory
//
//Errors: none
//Warnings: none
