#include "headfile.h"
#include "typedef.h"
#define WID 128
#define LEN 64

extern int image_threshold;  //ͼ����ֵ

extern uint8 dis_image[64][128];


extern int white_len_tune;
extern int begin_line_state;
extern int first_time_begin;

void otsuThreshold(uint8 *image, uint16 col, uint16 row);
int pendu_len();
void check_out();
int miss_road_type();
void begin_line_detect();