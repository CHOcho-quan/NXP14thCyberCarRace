#include "HMI.h"

void HMI_Init()
{
  // ======== LED =========
  gpio_init(A6, GPO, 1);
  gpio_init(A7, GPO, 1);
  
  // ======== KEY =========
  gpio_init(A8, GPI, 1);
  gpio_init(A9, GPI, 1);
  gpio_init(A10, GPI, 1);
  
  // ======== SW =========
  gpio_init(E8, GPI, 1);
  gpio_init(E9, GPI, 1);
  gpio_init(E10, GPI, 1);
  gpio_init(E11, GPI, 1);
  
  // ======== BELL ========
  gpio_init(D15, GPO, 0);
}

void LED1(u8 x)
{
  if (x) gpio_set(A6, 1);
  else gpio_set(A6, 0);
}

void LED2(u8 x)
{
  if (x) gpio_set(A7, 1);
  else gpio_set(A7, 0);
}

void BELL(u8 x)
{
  if (x) gpio_set(D15, 1);
  else gpio_set(D15, 0);
}

u8 SW4()
{
  return gpio_get(E8);
}

u8 SW3()
{
  return gpio_get(E9);
}

u8 SW2()
{
  return gpio_get(E10);
}

u8 SW1()
{
  return gpio_get(E11);
}

u8 Key1()
{
  return gpio_get(A8);
}

u8 Key2()
{
  return gpio_get(A9);
}

u8 Key3()
{
  return gpio_get(A10);
}