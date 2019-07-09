#ifndef FLASH_H
#define FLASH_H

#include "typedef.h"


// ===== Settings =====

  // ADDR : the address to save data
#define ADDR 0x0003C000

  // SECTOR_SIZE : sector is the minimal unit of flash to be writen.
#define SECTOR_SIZE 0x200

  // DATA_NUM : the num of datas(U16 or S16) you need.
#define DATA_NUM 16


// ===== Global Variables =====

extern U16 data[DATA_NUM];

  // data[0] is reserved. 
  // Every time writting to the Flash, data_flag is set to 1.
  // So when it's not 1, it means the Flash lose its datas.
#define data_flag                   data[0]

  // define aliases for your datas ( Here's mine for example)
#define KF_switch                   data[1]
#define balance_deform              data[2]
#define balance_K                   data[3]
#define balance_P                   data[4]
#define balance_D                   data[5]
#define balance_dt                  data[6]
#define accZ_offset                 data[7]
#define P_speed                     data[8]
#define D_speed                     data[9]
#define PWM_DZL                     data[10]
#define PWM_DZR                     data[11]
#define wheel_P                     data[12]
#define wheel_I                     data[13]
#define wheel_D                     data[14]
#define I_speed                     data[15]


// ======= APIs =======

  // Write data[] to certain sector of flash.
void Flash_Write(U16 sector);

  // Read certain data of certain sector in flash.
U16 Flash_Read(U16 sector,U16 data_index);

  // Load data_initial[] to data[], then write to flash in sector 0.
void Flash_Data_Reset(void);

  // Load datas in sector 0 of flash to data[]
void Flash_Data_Update(U16 sector);

  // Init
void Flash_Init(void);



// ======= Basic Drivers ======

  // Erase certain sector
U8 Flash_Erase(U16);

U8 Flash_Program(U16, U16 WriteCounter, U16 *DataSource);

static U8 FlashCMD(void);


  //Flash命令宏定义
#define RD1BLK    0x00   // 读整块Flash
#define RD1SEC    0x01   // 读整个扇区
#define PGMCHK    0x02   // 写入检查
#define RDRSRC    0x03   // 读目标数据
#define PGM4      0x06   // 写入长字
#define ERSBLK    0x08   // 擦除整块Flash
#define ERSSCR    0x09   // 擦除Flash扇区
#define PGMSEC    0x0B   // 写入扇区
#define RD1ALL    0x40   // 读所有的块
#define RDONCE    0x41   // 只读一次
#define PGMONCE   0x43   // 只写一次
#define ERSALL    0x44   // 擦除所有块
#define VFYKEY    0x45   // 验证后门访问钥匙
#define PGMPART   0x80   // 写入分区
#define SETRAM    0x81   // 设定FlexRAM功能


#endif
