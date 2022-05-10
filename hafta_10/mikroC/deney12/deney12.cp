#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_10/mikroC/deney12/deney12.c"
#line 24 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_10/mikroC/deney12/deney12.c"
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

const unsigned short TEMP_RESOLUTION = 12;
char *text = "000.0000";

void Display_Temperature(unsigned int temp2write){

 const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
 char temp_whole;
 unsigned int temp_fraction;


 if(temp2write & 0x8000){
 text[0] = '-';
 temp2write = ~temp2write + 1;
 }

 temp_whole = temp2write >> RES_SHIFT;


 if(temp_whole/100)
 text[0] = temp_whole/100 + 48;
 else
 text[0] = '0';

 text[1] = (temp_whole/10)%10 + 48;
 text[2] = temp_whole%10 + 48;


 temp_fraction = temp2write << (4-RES_SHIFT);
 temp_fraction &= 0x000F;
 temp_fraction *= 625;


 text[4] = temp_fraction/1000 + 48;
 text[5] = (temp_fraction/100)%10 + 48;
 text[6] = (temp_fraction/10)%10 + 48;
 text[7] = temp_fraction%10 + 48;


 Lcd_Out(2, 5, text);

}

unsigned int temp;

void main() {

 ANSEL = 0;
 ANSELH = 0;

 C1ON_bit = 0;
 C2ON_bit = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Temperature: ");

 Lcd_Chr(2, 13, 223);
 Lcd_Chr(2, 14, 'C');

 do{

 Ow_Reset(&PORTE, 2);

 Ow_Write(&PORTE, 2, 0xCC);

 Ow_Write(&PORTE, 2, 0x44);

 Delay_ms(750);

 Ow_Reset(&PORTE, 2);

 Ow_Write(&PORTE, 2, 0xCC);

 Ow_Write(&PORTE, 2, 0xBE);



 temp = Ow_Read(&PORTE, 2);

 temp = (Ow_Read(&PORTE, 2) << 8) + temp ;

 Display_Temperature(temp);

 Delay_ms(500);

 }while(1);
}
