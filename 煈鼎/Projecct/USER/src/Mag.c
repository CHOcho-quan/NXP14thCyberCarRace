#include "Mag.h"

//============extern Variables=============
// Extern declaration please turn to Mag.h
U16 mag_val[6];

//============local Variables==============

void Mag_Init()
{
    adc_init(ADC1_SE4a);
    adc_init(ADC1_SE5a);
    adc_init(ADC1_SE6a);
    adc_init(ADC1_SE7a);
    adc_init(ADC1_DM0);
    adc_init(ADC1_DP3);
}

void Mag_Sample()
{
  mag_val[0] = adc_once(ADC1_SE4a, ADC_8bit);
  mag_val[1] = adc_once(ADC1_SE5a, ADC_8bit);
  mag_val[2] = adc_once(ADC1_SE6a, ADC_8bit);
  mag_val[3] = adc_once(ADC1_SE7a, ADC_8bit);
  mag_val[5] = adc_once(ADC1_DP3, ADC_8bit);
  mag_val[4] = mag_val[5] - adc_once(ADC1_DM0, ADC_8bit);
}