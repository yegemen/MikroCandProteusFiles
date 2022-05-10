/*

    DS18B20 Sýcaklýk sensöründen alýnan ortam sýcaklýðý deðerinin lcd ekranda gösterilmesi.
    dijital sensördür. çoðu sensör analog çalýþýr ama bu dijital.

*/

/*//uni-ds6 için pin baðlantýlarý
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;   */

//proteus için gerekli olanlar.
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

     // check if temperature is negative
     if(temp2write & 0x8000){
     text[0] = '-';
     temp2write = ~temp2write + 1;
     }
     // extract temp_whole
     temp_whole = temp2write >> RES_SHIFT;
     
     // convert temp_whole to characters
     if(temp_whole/100)
     text[0] = temp_whole/100 + 48;
     else
     text[0] = '0';
     
     text[1] = (temp_whole/10)%10 + 48; // Extract tens digit
     text[2] = temp_whole%10 + 48; // Extract ones digit
     
     // Extract temp_fraction and convert it to unsigned int
     temp_fraction = temp2write << (4-RES_SHIFT);
     temp_fraction &= 0x000F;
     temp_fraction *= 625;
     
     // convert temp_fraction to characters
     text[4] = temp_fraction/1000 + 48;
     text[5] = (temp_fraction/100)%10 + 48;
     text[6] = (temp_fraction/10)%10 + 48;
     text[7] = temp_fraction%10 + 48;
     
     // Display temperature on LCD
     Lcd_Out(2, 5, text);

}

unsigned int temp; // iki byte okumak için. 16 bit deðiþken.

void main() {

     ANSEL = 0;
     ANSELH = 0;

     C1ON_bit = 0;
     C2ON_bit = 0;

     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1, 1, "Temperature: ");

     Lcd_Chr(2, 13, 223); // Derece Simgesi icin
     Lcd_Chr(2, 14, 'C');

     do{

        Ow_Reset(&PORTE, 2); //sensöre reset komutu gönderilecek. sensörün çalýþmasýný tetikliyor.

        Ow_Write(&PORTE, 2, 0xCC); // SKIP_ROM komutu. datasheet lerde varmýþ içeriði. çok karýþýk açýklama yapmýyorum dedi.

        Ow_Write(&PORTE, 2, 0x44); // CONVERT_T komutu. dýþ ortamdan aldýðý sýcaklýk deðerinin dönüþümünü yapýyor. 9 bitlik dönüþümün yapýlmasý için.

        Delay_ms(750);

        Ow_Reset(&PORTE, 2);

        Ow_Write(&PORTE, 2, 0xCC); // SKIP_ROM

        Ow_Write(&PORTE, 2, 0xBE); // READ_SCRAATCHPAD (açýklamadý)
        
        //her seferinde bir sýcaklýk verisi alacaðýmýz zaman bu yukarýdaki komutlar fix göndermemiz gerekiyor.

        temp = Ow_Read(&PORTE, 2); // ilk byte LSB (8-bit) okundu

        temp = (Ow_Read(&PORTE, 2) << 8) + temp ; // ikinci byte MSB okundu. bunu okuyup hemen kaydýrýyoruz 8 bit. nedenini açýklamadý.

        Display_Temperature(temp); // temp deðeri lcd de okunabilecek hale dönüþtürülüyor.

        Delay_ms(500);

     }while(1);
}