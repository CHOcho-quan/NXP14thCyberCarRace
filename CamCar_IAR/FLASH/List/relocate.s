///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.20.1.14183/W32 for ARM      06/Jul/2019  19:41:19
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  E:\IARworkspace\CamCar_IAR\common\relocate.c
//    Command line =  
//        -f C:\Users\57416\AppData\Local\Temp\EW2AE5.tmp
//        (E:\IARworkspace\CamCar_IAR\common\relocate.c -lCN
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
//    List file    =  E:\IARworkspace\CamCar_IAR\FLASH\List\relocate.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        SECTION `.bss`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data_init`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocate:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocateRam:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        EXTERN __VECTOR_RAM
        EXTERN __VECTOR_TABLE

        PUBLIC common_relocate

// E:\IARworkspace\CamCar_IAR\common\relocate.c
//    1 /**
//    2  * @file relocate.c
//    3  * @version 3.0[By LPLD]
//    4  * @date 2013-06-18
//    5  * @brief Kinetisͨ�����ݴ���Ǩ�ƺ���
//    6  *
//    7  * ���Ľ���:�������޸�
//    8  *
//    9  * ʵ�����ݡ�������ROM��RAMǨ�ƵĹ���
//   10  *
//   11  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//   12  * http://www.lpld.cn
//   13  * mail:support@lpld.cn
//   14  *
//   15  * @par
//   16  * ����������������[LPLD]������ά������������ʹ���߿���Դ���롣
//   17  * �����߿���������ʹ�û��Դ���롣�����μ�����ע��Ӧ���Ա�����
//   18  * ���ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߡ�
//   19  * ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
//   20  * �������²���������ʹ�ñ��������������κ��¹ʡ��������λ���ز���Ӱ�졣
//   21  * ����������������͡�˵��������ľ���ԭ�����ܡ�ʵ�ַ�����
//   22  * ������������[LPLD]��Ȩ�������߲��ý�������������ҵ��Ʒ��
//   23  */
//   24 
//   25 #include "common.h"
//   26 
//   27 #if defined(__IAR_SYSTEMS_ICC__)
//   28   #pragma section = ".data"
//   29   #pragma section = ".data_init"
//   30   #pragma section = ".bss"
//   31   #pragma section = "CodeRelocate"
//   32   #pragma section = "CodeRelocateRam"
//   33 #endif
//   34    
//   35 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   36 void common_relocate(void)
//   37 {
//   38     #ifndef __IAR_SYSTEMS_ICC__
//   39       #warning @IAR@@@@@@@@@@
//   40       extern char __START_BSS[];
//   41       extern char __END_BSS[];
//   42       extern uint32 __DATA_ROM[];
//   43       extern uint32 __DATA_RAM[];
//   44       extern char __DATA_END[];
//   45     #endif
//   46   
//   47   /* @@@@@@@@@@@@@@@ */
//   48   uint32 n;
//   49   
//   50   /* @@@@@@@@@@@@
//   51   * @@@@@@@@@@@@@@@@@@
//   52   */
//   53   uint8 * data_ram, * data_rom, * data_rom_end;
//   54   uint8 * bss_start, * bss_end;
//   55   
//   56   
//   57   /* @@@@@@@@VECTOR_TABLE@VECTOR_RAM@@@ */
//   58   extern uint32 __VECTOR_TABLE[];
//   59   extern uint32 __VECTOR_RAM[];
//   60   
//   61   /* @@@@@@@@@RAM@ */
//   62   if (__VECTOR_RAM != __VECTOR_TABLE)
common_relocate:
        LDR.N    R0,??common_relocate_0
        LDR.N    R1,??common_relocate_0+0x4
        CMP      R0,R1
        BEQ.N    ??common_relocate_1
//   63   {
//   64     for (n = 0; n < 0x410; n++)
        MOVS     R0,#+0
        B.N      ??common_relocate_2
//   65       __VECTOR_RAM[n] = __VECTOR_TABLE[n];
??common_relocate_3:
        LDR.N    R1,??common_relocate_0+0x4
        LDR      R1,[R1, R0, LSL #+2]
        LDR.N    R2,??common_relocate_0
        STR      R1,[R2, R0, LSL #+2]
        ADDS     R0,R0,#+1
??common_relocate_2:
        CMP      R0,#+1040
        BCC.N    ??common_relocate_3
//   66   }
//   67   /* @@@@@@@@@@@@VTOR@@@ */
//   68   write_vtor((uint32)__VECTOR_RAM);
??common_relocate_1:
        LDR.N    R0,??common_relocate_0
        LDR.N    R1,??common_relocate_0+0x8  ;; 0xe000ed08
        STR      R0,[R1, #+0]
//   69   
//   70   /* @@.data@@@@(@@@@@@@@) */
//   71   #if defined(__IAR_SYSTEMS_ICC__)
//   72     data_ram = __section_begin(".data");
        LDR.N    R2,??common_relocate_0+0xC
//   73     data_rom = __section_begin(".data_init");
        LDR.N    R3,??common_relocate_0+0x10
//   74     data_rom_end = __section_end(".data_init");
        LDR.N    R1,??common_relocate_0+0x14
//   75     n = data_rom_end - data_rom;	
        SUBS     R1,R1,R3
        B.N      ??common_relocate_4
//   76   #else
//   77     #warning @IAR@@@@@@@@@@
//   78     data_ram = (uint8 *)__DATA_RAM;
//   79     data_rom = (uint8 *)__DATA_ROM;
//   80     data_rom_end  = (uint8 *)__DATA_END; /* @@@CodeWarrior@@@@@RAM@@ */
//   81     n = data_rom_end - data_rom;
//   82   #endif
//   83   
//   84   /* @ROM@@@@@@@@@@RAM */
//   85   while (n--)
//   86     *data_ram++ = *data_rom++;
??common_relocate_5:
        LDRB     R0,[R3, #+0]
        STRB     R0,[R2, #+0]
        ADDS     R3,R3,#+1
        ADDS     R2,R2,#+1
??common_relocate_4:
        MOVS     R0,R1
        SUBS     R1,R0,#+1
        CMP      R0,#+0
        BNE.N    ??common_relocate_5
//   87   
//   88   
//   89   /* @@.bss@@@@ (@@@@0@@@) */
//   90   #if defined(__IAR_SYSTEMS_ICC__)
//   91   bss_start = __section_begin(".bss");
        LDR.N    R2,??common_relocate_0+0x18
//   92   bss_end = __section_end(".bss");  
        LDR.N    R1,??common_relocate_0+0x1C
//   93   #else
//   94   #warning @IAR@@@@@@@@@@
//   95   bss_start = (uint8 *)__START_BSS;
//   96   bss_end = (uint8 *)__END_BSS;
//   97   #endif
//   98   
//   99   /* @@@@@@0@@@@ */
//  100   n = bss_end - bss_start;
        SUBS     R1,R1,R2
        B.N      ??common_relocate_6
//  101   while(n--)
//  102     *bss_start++ = 0;
??common_relocate_7:
        MOVS     R0,#+0
        STRB     R0,[R2, #+0]
        ADDS     R2,R2,#+1
??common_relocate_6:
        MOVS     R0,R1
        SUBS     R1,R0,#+1
        CMP      R0,#+0
        BNE.N    ??common_relocate_7
//  103   
//  104   /* @@@@@@@ROM@@@RAM@@@@@@@@
//  105   * IAR@@@@@@@@@@@@@@@@@@@@@RAM@@@
//  106   * @@@@@@@@@@@"__ramfunc"@@@@@@@@@@@@RAM@@@@
//  107   * @@:__ramfunc void foo(void);
//  108   */
//  109   #if defined(__IAR_SYSTEMS_ICC__)
//  110   uint8* code_relocate_ram = __section_begin("CodeRelocateRam");
        LDR.N    R2,??common_relocate_0+0x20
//  111   uint8* code_relocate = __section_begin("CodeRelocate");
        LDR.N    R3,??common_relocate_0+0x24
//  112   uint8* code_relocate_end = __section_end("CodeRelocate");
        LDR.N    R1,??common_relocate_0+0x28
//  113   
//  114   /* @@@@ROM@@@RAM */
//  115   n = code_relocate_end - code_relocate;
        SUBS     R1,R1,R3
        B.N      ??common_relocate_8
//  116   while (n--)
//  117     *code_relocate_ram++ = *code_relocate++;
??common_relocate_9:
        LDRB     R0,[R3, #+0]
        STRB     R0,[R2, #+0]
        ADDS     R3,R3,#+1
        ADDS     R2,R2,#+1
??common_relocate_8:
        MOVS     R0,R1
        SUBS     R1,R0,#+1
        CMP      R0,#+0
        BNE.N    ??common_relocate_9
//  118   #endif
//  119 }
        BX       LR               ;; return
        Nop      
        DATA
??common_relocate_0:
        DC32     __VECTOR_RAM
        DC32     __VECTOR_TABLE
        DC32     0xe000ed08
        DC32     SFB(`.data`)
        DC32     SFB(`.data_init`)
        DC32     SFE(`.data_init`)
        DC32     SFB(`.bss`)
        DC32     SFE(`.bss`)
        DC32     SFB(CodeRelocateRam)
        DC32     SFB(CodeRelocate)
        DC32     SFE(CodeRelocate)

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.bss`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data_init`:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocate:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocateRam:DATA:NOALLOC:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  120 /********************************************************************/
// 
// 160 bytes in section .text
// 
// 160 bytes of CODE memory
//
//Errors: none
//Warnings: none
