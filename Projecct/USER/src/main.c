
#include "headfile.h"
#include <string.h>
//s16 angle=0;

int main(void)
{
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
    init_speed_base();
        
        //OLED_P6x8Str(1,1,"LQDada");
 
        __enable_irq();
        /*
        while (Key1())
        {
          Mag_Sample();
          ServoControl_Mag();
          //if (!SW1()) BELL(1);
        }
        */
        //BELL(0);
       
        //testing
        //while (Key2())
        //{
         // LED1(1);
          //MotorL_Output(40);
          //MotorR_Output(40);
          
        //}
    
     // Program Main
    while (1)
    {
       //Mag_Sample();
       
       
       //ServoControl_Cam();
       //diffSpeed(50, dir_cam);
      
      
    }
}

