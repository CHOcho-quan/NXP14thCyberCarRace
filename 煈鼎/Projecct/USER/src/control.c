#include "control.h"

// =========== Extern Variables ===========
int category = 0;
int dir_cam;
int last_dir_cam;

int circle_dir=0;

// =========== Local Variables ============
//============Motor_PID==============
static s16 last_errL = 0, last_errR = 0, motor_outL = 0, motor_outR = 0, errL2 = 0, errR2 = 0, errL = 0, errR = 0;
float Kp_MotorL = 2.05, Kp_MotorR = 1.85, Ki_MotorL = 0.0000001, Ki_MotorR = 0.0000001, Kd_MotorL = 0.0, Kd_MotorR = 0.0;
int errL_sum = 0, errR_sum = 0, cnt = 0;

int see_line;



s16 max(s16 a, s16 b)
{
  if (a > b) return a;
  else return b;
}

void pidL(s16 xL)
{
  errL = (s16)(xL - (s16)(tacho0 * 0.25));

  if (errL_sum > 50000) errL_sum = 50000;
  else if (errL_sum < -50000) errL_sum = -50000;

  errL_sum += errL;

  motor_outL = (s16)(Kp_MotorL * errL + Ki_MotorL * errL_sum + Kd_MotorL * (errL - last_errL));
  
  last_errL = errL;

  MotorL_Output(motor_outL);
}

void pidR(s16 xR)
{
  errR = (s16)(xR - (s16)(tacho1 * 0.25));

  if (errR_sum > 50000) errR_sum = 50000;
  else if (errR_sum < -50000) errR_sum = -50000;

  errR_sum += errR;

  motor_outR = (s16)(Kp_MotorR * errR + Ki_MotorR * errR_sum + Kd_MotorR * (errR - last_errR));
  
  last_errR = errR;

  MotorR_Output(motor_outR);
}

void diffSpeed(s16 ave_speed, s16 dir)
{
  double k;
  k = (-3.645E-9)*pow(dir,3)-(2.95E-7)*pow(dir,2)-(5.6E-4)*dir-0.01;
  s16 xL = (s16)(ave_speed * (1-k));
  s16 xR = (s16)(ave_speed * (1+k));
  pidL(xL);
  pidR(xR);
}

//==========Servo_PD========
float Kp_Servo = 0.8, Kd_Servo = 2.1;
//========Mag_Control=====
static s16 last_err_mag,  err_mag; 
s16 dir_mag;
static s16 last_dir_mag;
static int left_right;
static int lost = 0;

static int delta = 0, last_magT0 = 0, last_magT5 = 0;


void blind_run(int left_or_right){
  if(pit_1_cnt<=4)Servo_Output(220*left_or_right);
  else if(pit_1_cnt>4 && pit_1_cnt<13)Servo_Output(-240*left_or_right);
  else {pit_1_cnt = 0;blind=0;}
  
}


float Kp_line = 4.8;
float Kd_line = 1.2;

void ServoControl_Line(){
    static float e_line;
    static float last_e_line=0;
    int line_diff=0;
    
    int i;
    int mid_clear = 0;
    for(i=0;i<WID;++i){
      if(dis_image[see_line][i]>image_threshold){
        mid_clear+=i;
        break;
      }
    }
    for(i=WID-1;i>=0;--i){
      if(dis_image[see_line][i]>image_threshold){
        mid_clear+=i;
        break;
      }
    }
    
    if(mid_clear!=0)
    {
      mid_clear /=2;
      e_line = mid_clear - WID/2;
      dir_cam = (int)(Kp_line*e_line + Kd_line*(e_line-last_e_line));
      last_e_line = e_line;
      Servo_Output(-dir_cam);
    }
    else{
      e_line = last_e_line;
      dir_cam = (int)(Kp_line*e_line + Kd_line*(e_line-last_e_line));
      Servo_Output(-dir_cam);
    }
}

void change_speed(){
  if(add_or_sub){
  if(!Key1())speed_base_line++;
  if(!Key2())speed_base_turn++;
  //if(!Key3())if(see_line<64)see_line++;
  if(!Key3())white_len_tune++;
  }
  else{
    if(!Key1())speed_base_line--;
  if(!Key2())speed_base_turn--;
  //if(!Key3())if(see_line>0)see_line--;
  if(!Key3())white_len_tune--;
  }
}

void init_speed_base(){
  speed_base_line=180;  //180
  speed_base_turn=170;  //170
  white_len_tune = 35;  
  see_line = 54;
  speed_current = speed_base_line;
}

void turn_speed(){
  if(white_len>white_len_tune){speed_current = speed_base_line;BELL(0);}
  else {speed_current = speed_base_turn;BELL(0);}
}

void turn_speed_Mag(){
  if(dir_mag>-45 && dir_mag<45)speed_current = 130;  //170
  else speed_current = 110;                        //160
}

void cho_dada_mag(){
  s16 f1 = mag_val[0] - mag_val[5];
  s16 f2 = mag_val[1] - mag_val[4];
  s16 f3 = mag_val[2] - mag_val[3];
  err_mag = f2 * 2.1 + f3 * 1.0; //+ f1 * 0.2;// + f1 * 0.05;
  float prop = 1.0;
  
  int MAX1 = -1, MAX2 = -1, max_id1 = 1, max_id2 = 1;
  int i = 0;
  for (i;i < 6;i++)
  {
	if ((int)(mag_val[i]) > MAX1)
	{
          MAX2 = MAX1;
          max_id2 = max_id1;
          
          MAX1 = (int)(mag_val[i]);
          max_id1 = i;
	}
        else if ((int)(mag_val[i]) > MAX2)
        {
          MAX2 = (int)(mag_val[i]);
          max_id2 = i;
        }
  }
  
  if (mag_val[0] > 50 || mag_val[5] > 50) 
  {
    if (mag_val[0] > 50 && mag_val[5] > 50 && circle == 0)// ???
    {
      prop *= 0.3;
    }
    else prop *= 1.2;
  }
  else if (mag_val[0] < 50 && mag_val[5] < 50) prop *=  0.3;

  switch (max_id1){
  case 1:{
    if (max_id2 == 2)
    {
      // ????λ???????
      prop *= 1.2;
    }
    else if (max_id2 == 0) prop *= 1.4;
    break;
  }
  case 2:{
      if (max_id2 == 1)
      {
        // ????λ?????
        if (mag_val[max_id1] - mag_val[max_id2] < 15) prop *= 1.3;
        else prop *= 1;
      }
      else if (max_id2 == 3)
      {
        // ????λ??????
        prop *= 0.2;
      }
      break;
  }
  case 3:{
      if (max_id2 == 4)
      {
        if (mag_val[max_id1] - mag_val[max_id2] < 15) prop *= 1.3;
        else prop *= 1;
      }
      else if (max_id2 == 2)
      {
        prop *= 0.2;
      }
      break;
  }
  case 4:{
      if (max_id2 == 3)
      {
        prop *= 1.2;
      }
      else if (max_id2 == 5) prop *= 1.4;
      break;
  }
 }
  
 /*
    s16 bc = 0;
    if (f1 > 40) {
      bc = (s16)f1 * 0.3;
    }
    else if (f1 < -40) {
      bc = (s16)f1 * 0.3;
    }
    
  err_mag += bc;*/
  
  dir_mag = prop*(err_mag * Kp_Servo + (err_mag - last_err_mag) * Kd_Servo);// + bc;
 // dir_mag = 0.8 * dir_mag + 0.2 * last_dir_mag;
  last_dir_mag = dir_mag;
  
  if (dir_mag > 280) dir_mag = 280;
  else if (dir_mag < -280) dir_mag = -280;

  if(mag_val[2]<30 && mag_val[3]<30 && mag_val[1]<60 && mag_val[4]<60){dir_mag = left_right*300;lost=1;}
  else lost = 0;
  if(!lost){
    left_right = (dir_mag>0? 1:-1); 
    //return dir;
  }
  Servo_Output(dir_mag);
  last_err_mag = err_mag;
}

void circle_run(){
  if(pit_circle_cnt<=3)ServoControl_Line();
  else if(pit_circle_cnt>3 && pit_circle_cnt<=11)Servo_Output(-240*circle_dir);
  else if(pit_circle_cnt>11 && pit_circle_cnt<50)cho_dada_mag();
  else {pit_circle_cnt = 0;circle=0;}
}

void detect_circle(){
  int magSum = 0;
  if (mag_val[1] > 130) magSum++;
  if (mag_val[2] > 130) magSum++;
  if (mag_val[3] > 130) magSum++;
  if (mag_val[4] > 130) magSum++;
  
  
  if (magSum >= 3 && (mag_val[0] > 75 || mag_val[5] > 75) && circle==0) {
    circle = 1;
    if (mag_val[0] > mag_val[5]) circle_dir = -1; 
    else circle_dir = 1; 
  }
}