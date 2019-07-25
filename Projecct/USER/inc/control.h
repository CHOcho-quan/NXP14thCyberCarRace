#include "headfile.h"

extern int category;
extern s16 dir_mag;

extern int blind_dir, blind_1_time, blind_2_time;

extern int dir_cam;

extern int huandao, categoryH; //-1 没进，3可以

extern int see_line;

extern int circle_dir;

void diffSpeed(s16 speed_ave, s16 dir);

void blind_run();

void ServoControl_Line();
void pidL(s16 xL);
void pidR(s16 xR);

void turn_speed();
void init_speed_base();
void cho_dada_mag();

void circle_run();
void circle_run2();
void detect_circle();
void stop(int dir);