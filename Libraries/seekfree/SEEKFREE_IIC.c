/*********************************************************************************************************************
 * COPYRIGHT NOTICE
 * Copyright (c) 2016,��ɿƼ�
 * All rights reserved.
 * ��������QQȺ��179029047
 *
 * �����������ݰ�Ȩ������ɿƼ����У�δ��������������ҵ��;��
 * ��ӭ��λʹ�ò������������޸�����ʱ���뱣����ɿƼ��İ�Ȩ������
 *
 * @file       		SEEKFREE_IIC.c
 * @brief      		ģ��IIC������
 * @company	   		�ɶ���ɿƼ����޹�˾
 * @author     		Go For It(1325536866)
 * @version    		v1.0
 * @Software 		IAR 7.7 or MDK 5.17
 * @Target core		MK60DN512VLL10
 * @Taobao   		https://seekfree.taobao.com/
 * @date       		2016-02-25
 * @note	
					ģ��IIC���߶���
					------------------------------------ 
						SDA                 C17
						SCL                 C16
					------------------------------------ 
 ********************************************************************************************************************/



#include "SEEKFREE_IIC.h"


#define SDA             gpio_get (SEEKFREE_SDA)
#define SDA0()          gpio_set (SEEKFREE_SDA, 0)		//IO������͵�ƽ
#define SDA1()          gpio_set (SEEKFREE_SDA, 1)		//IO������ߵ�ƽ  
#define SCL0()          gpio_set (SEEKFREE_SCL, 0)		//IO������͵�ƽ
#define SCL1()          gpio_set (SEEKFREE_SCL, 1)		//IO������ߵ�ƽ
#define DIR_OUT()       gpio_ddr (SEEKFREE_SDA, GPO)    //�������
#define DIR_IN()        gpio_ddr (SEEKFREE_SDA, GPI)    //���뷽��


//�ڲ����ݶ���
uint8 IIC_ad_main; //�����ӵ�ַ	    
uint8 IIC_ad_sub;  //�����ӵ�ַ	   
uint8 *IIC_buf;    //����|�������ݻ�����	    
uint8 IIC_num;     //����|�������ݸ���	     

#define ack 1      //��Ӧ��
#define no_ack 0   //��Ӧ��	 



//-------------------------------------------------------------------------------------------------------------------
//  @brief      ģ��IIC��ʱ
//  @return     void						
//  @since      v1.0
//  Sample usage:				���IICͨѶʧ�ܿ��Գ�������j��ֵ
//-------------------------------------------------------------------------------------------------------------------
void simiic_delay(void)
{
	//64Ϊ100K������(busƵ��Ϊ100M)
	//�ر���ʾOV7725��ͨ�����ʲ���̫�ߣ����50K���ң�j����Ϊ120ͨ������Ϊ60K��60K��ʱ���������ͨ��
	//����IIC����һ�����400K��ͨ������
	uint16 j=400;   
	while(j--);
}


//�ڲ�ʹ�ã��û��������
void IIC_start(void)
{
	SDA1();
	SCL1();
	simiic_delay();
	SDA0();
	simiic_delay();
	SCL0();
}

//�ڲ�ʹ�ã��û��������
void IIC_stop(void)
{
	SDA0();
	SCL0();
	simiic_delay();
	SCL1();
	simiic_delay();
	SDA1();
	simiic_delay();
}

//��Ӧ��(����ack:SDA=0��no_ack:SDA=0)
//�ڲ�ʹ�ã��û��������
void I2C_SendACK(unsigned char ack_dat)
{
    SCL0();
	simiic_delay();
	if(ack_dat) SDA0();
    else    	SDA1();

    SCL1();
    simiic_delay();
    SCL0();
    simiic_delay();
}


static int SCCB_WaitAck(void)
{
    SCL0();
	DIR_IN();
	simiic_delay();
	
	SCL1();
    simiic_delay();
	
    if(SDA)           //Ӧ��Ϊ�ߵ�ƽ���쳣��ͨ��ʧ��
    {
        DIR_OUT();
        SCL0();
        return 0;
    }
    DIR_OUT();
    SCL0();
	simiic_delay();
    return 1;
}

//�ֽڷ��ͳ���
//����c(����������Ҳ���ǵ�ַ)���������մ�Ӧ��
//�����Ǵ�Ӧ��λ
//�ڲ�ʹ�ã��û��������
void send_ch(uint8 c)
{
	uint8 i = 8;
    while(i--)
    {
        if(c & 0x80)	SDA1();//SDA �������
        else			SDA0();
        c <<= 1;
        simiic_delay();
        SCL1();                //SCL ���ߣ��ɼ��ź�
        simiic_delay();
        SCL0();                //SCL ʱ��������
    }
	SCCB_WaitAck();
}

//�ֽڽ��ճ���
//�����������������ݣ��˳���Ӧ���|��Ӧ����|IIC_ack_main()ʹ��
//�ڲ�ʹ�ã��û��������
uint8 read_ch(void)
{
    uint8 i;
    uint8 c;
    c=0;
    SCL0();
    simiic_delay();
    SDA1();             //��������Ϊ���뷽ʽ
    DIR_IN();
    for(i=0;i<8;i++)
    {
        simiic_delay();
        SCL0();         //��ʱ����Ϊ�ͣ�׼����������λ
        simiic_delay();
        SCL1();         //��ʱ����Ϊ�ߣ�ʹ��������������Ч
        simiic_delay();
        c<<=1;
        if(SDA) c+=1;   //������λ�������յ����ݴ�c
    }
    DIR_OUT();
	SCL0();
	simiic_delay();
	I2C_SendACK(no_ack);
	
    return c;
}

//-------------------------------------------------------------------------------------------------------------------
//  @brief      ģ��IICд���ݵ��豸�Ĵ�������
//  @param      dev_add			�豸��ַ(����λ��ַ)
//  @param      reg				�Ĵ�����ַ
//  @param      dat				д�������
//  @return     void						
//  @since      v1.0
//  Sample usage:				
//-------------------------------------------------------------------------------------------------------------------
void simiic_write_reg(uint8 dev_add, uint8 reg, uint8 dat)
{
	IIC_start();
    send_ch( (dev_add<<1) | 0x00);   //����������ַ��дλ
	send_ch( reg );   				 //���ʹӻ��Ĵ�����ַ
	send_ch( dat );   				 //������Ҫд�������
	IIC_stop();
}


//-------------------------------------------------------------------------------------------------------------------
//  @brief      ģ��IIC���豸�Ĵ�����ȡ����
//  @param      dev_add			�豸��ַ(����λ��ַ)
//  @param      reg				�Ĵ�����ַ
//  @param      type			ѡ��ͨ�ŷ�ʽ��IIC  ���� SCCB
//  @return     uint8			���ؼĴ���������			
//  @since      v1.0
//  Sample usage:				
//-------------------------------------------------------------------------------------------------------------------
uint8 simiic_read_reg(uint8 dev_add, uint8 reg, IIC_type type)
{
	uint8 dat;
	IIC_start();
    send_ch( (dev_add<<1) | 0x00);  //����������ַ��дλ
	send_ch( reg );   				//���ʹӻ��Ĵ�����ַ
	if(type == SCCB)IIC_stop();
	
	IIC_start();
	send_ch( (dev_add<<1) | 0x01);  //����������ַ�Ӷ�λ
	dat = read_ch();   				//������Ҫд�������
	IIC_stop();
	
	return dat;
}

//-------------------------------------------------------------------------------------------------------------------
//  @brief      ģ��IIC�˿ڳ�ʼ��
//  @param      NULL
//  @return     void	
//  @since      v1.0
//  Sample usage:				
//-------------------------------------------------------------------------------------------------------------------
void IIC_init(void)
{
	gpio_init (SEEKFREE_SCL, GPO,1);
	gpio_init (SEEKFREE_SDA, GPO,1);
	
	
	port_init_NoAlt (SEEKFREE_SCL, ODO | PULLUP);//ODO
	port_init_NoAlt (SEEKFREE_SDA, ODO | PULLUP);
}

