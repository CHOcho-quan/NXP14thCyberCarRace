/********************************************
逐飞科技 总钻风-摄像头  历程
Designed by Fly Sir
软件版本:V1.1
最后更新:2016年5月3日
相关信息参考下列地址：
淘宝店：https://seekfree.taobao.com/
------------------------------------
软件版本： IAR 7.2 or MDK 5.17
目标核心： MK60DN512VLL10
============================================
MT9V032接线定义：
------------------------------------ 
    模块管脚            单片机管脚
    SDA(51的RX)         C17
    SCL(51的TX)         C16
	场中断              C6
    行中断				未使用，因此不接
    像素中断            C18            
    数据口              C8-C15 
	
    OLED液晶                
    D0                  A15
    D1                  A16            
    RES                 A14    
    DC                  B16
============================================

分辨率是                188*120
摄像头参数设置可以到    SEEKFREE-->h_file-->SEEKFREE_MT9V032.h

总钻风-摄像头测试步骤：
1.下载程序到开发板
2.插上串口线或者USB转TTL
3.接好MT9V032模块接线
4.通电在TFT液晶上即可观看    
*********************************************/  
#include "headfile.h"
#include <string.h>

int main(void)
{
    uint8 num;
    
    get_clk();//上电后必须运行一次这个函数，获取各个频率信息，便于后面各个模块的参数设置
    //uart_init (uart2, 115200);                          //初始换串口与电脑通信
    camera_init();
    Motor_Init();
    PIT0_Init(PIT0_PERIOD_US);
    PIT1_Init(PIT1_PERIOD_US);
    PIT2_Init();
    Tacho_Init();
    HMI_Init();
    Mag_Init();
	//lcd_init();
    OLED_Init();
    Servo_Init();
        
        
        OLED_P6x8Str(1,1,"LQZZZNB");
 
        __enable_irq();
        while (Key1())
        {
          
          if (!SW1()) BELL(1);
        }
        BELL(0);
       
        //testing
        while (Key2())
        {
          LED1(1);
          //MotorL_Output(40);
          //MotorR_Output(40);
          SpeedControl(200, 200);
        }
    
     // Program Main
    while (1)
	{
		
	}
}

