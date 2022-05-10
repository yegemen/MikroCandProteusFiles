/*

Deney 7 deki ADC input deðeri LCD ekranda gösterilir.

MCU: 16F887
OSC: 8MHz

library manager den lcd kütüphanesinin ekli olmasý gerekiyor.

*/

//proteus için pin baðlantýlarý
// lcd nin bacaklarýnýn nereye baðlý olduðunu belirtiyoruz sbit ile
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

// baðlantýlarýn yönleri
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

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

char *text;

unsigned char ch;

unsigned int adc_rd;

long tlong;

void main() {

     INTCON = 0; // Tüm kesmeler deaktif edilir. (sebebini bilmiyorum dedi)
     
     ANSEL = 0x04;
     TRISA = 0x04;
     
     ANSELH = 0;
     
     Lcd_Init(); //lcd yi baþlat.
     
     Lcd_Cmd(_LCD_CURSOR_OFF); // lcd deki cursor u kapattýk (yanýp sönen imleç gibi)
     
     Lcd_Cmd(_LCD_CLEAR); // lcd nin içeriðini temizliyor.
     
     text = "mikroElektronika"; // 16 karakterlik, daha fazla yazarsak ekrana sýðmaz.
     
     Lcd_Out(1,1,text); // ilk satýr ilk sütundan yazdýrmaya baþlayacaðýz.
     
     text = "LCD example"; // yeni yazý yazdýk
     
     Lcd_Out(2,1,text); // alt satýrýn ilk sütunundan yazdýrmaya baþlýyoruz.
     
     delay_ms(2000); // 2 sn beklesin yazýlar.
     
     text = "voltage:";
     
     while(1){

              adc_rd = ADC_Read(2); // 2. kanaldan okuyoruz.
              
              Lcd_Out(2,1,text);
              
              // Örneðin port umuzdan 3.75V alýyoruz. (örnekleyerek anlatýlýyor bu kýsým)
              // 0-5V arasý 0-1023 arasýna indirgenmesi sonucu
              // ADC nin karþýlýðý 767 deðeridir (0<767<1023)
              // Bu aralýðý 0-5000mV a çekmek amacýyla 0-1023 aralýðýný 5000 ile geniþletelim: 0-5115mV olur.
              // tlong = 767 * 5 * 1000 = 3835000
              // sonucun mV düzeyinde iþleme alýnmasýný saðlar.
              tlong = (long)adc_rd * 5 * 1000;
              
              // tlong / 1023 =~ 3748,77mV oldu (0-5000mV aralýðýnda)
              tlong = tlong / 1023;
              
              // Önce ondalýk kýsmýný alalým.
              // tlong / 1000  = 3 (integer alta yuvarlanýr)
              ch = tlong / 1000;
              
              Lcd_Chr(2,9,48+ch); // voltage: 3 (48 ascii 0 a denk geliyor. onun üstüne ch koyarsak ch nin rakam deðeri yazar.)
              
              Lcd_Chr_CP('.'); // voltage: 3. (3 ten sonra nokta koymasý için) CP - current position (cursor un bulunduðu yer)
              
              // tlong =~ 3748,77 idi
              // ch = (3748,77 / 100) % 10 = 7 olur
              ch = (tlong/100)%10;
              
              Lcd_Chr_CP(48+ch); // voltage: 3.7

              // ch = (3748,77 / 10) % 10 = 4 olur
              ch = (tlong / 10)%10;
              
              Lcd_Chr_CP(48+ch); // voltage: 3.74
              
              // ch = 3748,77 % 10 = 8 olur
              ch = tlong%10;
              
              Lcd_Chr_CP(48+ch); // voltage: 3.748
              
              Lcd_Chr_CP('V');
              
              delay_ms(1);

     }

}