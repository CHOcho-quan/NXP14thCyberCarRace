#ifndef OLED_UI_H
#define OLED_UI_H



void UI_SystemInfo();
void displayCamera();
void drawCam(boolean(*isTarget)(u8 x));
boolean isWhite(u8 x);

#endif