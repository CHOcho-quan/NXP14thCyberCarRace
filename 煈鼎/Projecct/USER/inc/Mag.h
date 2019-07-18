#include "headfile.h"
#include "typedef.h"

extern u16 mag_val[6];

//==============APIs=================
void Mag_Init();
void Mag_sample();
u16 Mag1();
u16 Mag2();
u16 Mag3();
u16 Mag4();
s16 Mag5();
u16 Mag6();
extern int in;
extern int last_category;
extern int circle;