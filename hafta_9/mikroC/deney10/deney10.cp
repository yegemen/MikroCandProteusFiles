#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_9/mikroC/deney10/deney10.c"
#line 14 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_9/mikroC/deney10/deney10.c"
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;


sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
#line 44 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_9/mikroC/deney10/deney10.c"
char *text;

unsigned char ch;

unsigned int adc_rd;

long tlong;

void main() {

 INTCON = 0;

 ANSEL = 0x04;
 TRISA = 0x04;

 ANSELH = 0;

 Lcd_Init();

 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Cmd(_LCD_CLEAR);

 text = "mikroElektronika";

 Lcd_Out(1,1,text);

 text = "LCD example";

 Lcd_Out(2,1,text);

 delay_ms(2000);

 text = "voltage:";

 while(1){

 adc_rd = ADC_Read(2);

 Lcd_Out(2,1,text);







 tlong = (long)adc_rd * 5 * 1000;


 tlong = tlong / 1023;



 ch = tlong / 1000;

 Lcd_Chr(2,9,48+ch);

 Lcd_Chr_CP('.');



 ch = (tlong/100)%10;

 Lcd_Chr_CP(48+ch);


 ch = (tlong / 10)%10;

 Lcd_Chr_CP(48+ch);


 ch = tlong%10;

 Lcd_Chr_CP(48+ch);

 Lcd_Chr_CP('V');

 delay_ms(1);

 }

}
