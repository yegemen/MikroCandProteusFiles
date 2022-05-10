#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_12/mikroC/deney15/deney15.c"
#line 13 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_12/mikroC/deney15/deney15.c"
char GLCD_Dataport at PORTD;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS at RB2_bit;
sbit GLCD_RW at RB3_bit;
sbit GLCD_EN at RB5_bit;
sbit GLCD_RST at RB4_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB5_bit;
sbit GLCD_RST_Direction at TRISB4_bit;

const char msg1[] = "TOUCHPANEL EXAMPLE";
const char msg2[] = "MIKROELOKTRONIKA";
const char msg3[] = "BUTTON1";
const char msg4[] = "BUTTON2";
const char msg5[] = "RC6 OFF";
const char msg6[] = "RC7 OFF";
const char msg7[] = "RC6 ON";
const char msg8[] = "RC7 ON";

char msg[16];

char *CopyConst2Ram(char *dest, const char *src)
{

 for(;;*dest++ = *src++);

 return dest;
}

long x_coord, y_coord, x_coord128, y_coord64;

unsigned int GetX(){

 PORTC.F0 = 1;

 PORTC.F1 = 0;

 Delay_ms(5);

 return ADC_read(0);

}

unsigned int GetY(){

 PORTC.F0 = 0;

 PORTC.F1 = 1;

 Delay_ms(5);

 return ADC_read(1);

}

void main() {



 ANSEL = 0x03;
 ANSELH = 0;


 PORTC = 0;
 TRISC = 0;

 PORTA = 0;
 TRISA = 0x03;

 Glcd_Init();

 Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32);

 Glcd_Fill(0);



 CopyConst2Ram(msg, msg1);
 Glcd_Write_Text(msg, 10, 0, 1);



 CopyConst2Ram(msg, msg2);
 Glcd_Write_Text(msg, 17, 7, 1);


 Glcd_Rectangle(8, 16, 60, 48, 1);
 Glcd_Box(10, 18, 58, 46, 1);


 Glcd_Rectangle(68, 16, 120, 48, 1);
 Glcd_Box(70, 18, 118, 46, 1);

 CopyConst2Ram(msg, msg3);
 Glcd_Write_Text(msg, 14, 3, 0);

 CopyConst2Ram(msg, msg5);
 Glcd_Write_Text(msg, 14, 4, 0);

 CopyConst2Ram(msg, msg3);
 Glcd_Write_Text(msg, 74, 3, 0);

 CopyConst2Ram(msg, msg5);
 Glcd_Write_Text(msg, 74, 4, 0);


 while(1)
 {

 x_coord = GetX();
 y_coord = GetY();

 x_coord128 = (x_coord * 128) / 1024;
 y_coord64 = 64 - ((y_coord*64) / 1024);


 if((x_coord128 >= 10) && (x_coord128 <= 58) && (y_coord64 >= 18) && (y_coord64 <= 46)){

 if(PORTC.F6 == 0){

 PORTC.F6 = 1;

 CopyConst2Ram(msg, msg7);

 Glcd_Write_Text(msg, 14, 4, 0);

 }
 else{

 PORTC.F6 = 0;

 CopyConst2Ram(msg, msg5);

 Glcd_Write_Text(msg, 14, 4, 0);

 }

 }


 if((x_coord128 >= 70) && (x_coord128 <= 118) && (y_coord64 >= 18) && (y_coord64 <= 46)){

 if(PORTC.F7 == 0){

 PORTC.F6 = 1;

 CopyConst2Ram(msg, msg8);

 Glcd_Write_Text(msg, 74, 4, 0);

 }
 else{

 PORTC.F7 = 0;

 CopyConst2Ram(msg, msg6);

 Glcd_Write_Text(msg, 74, 4, 0);

 }

 }

 }


}
