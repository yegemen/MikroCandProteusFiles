/*

Deney 7 deki ADC input de�eri LCD ekranda g�sterilir.

MCU: 16F887
OSC: 8MHz

library manager den lcd k�t�phanesinin ekli olmas� gerekiyor.

*/

//proteus i�in pin ba�lant�lar�
// lcd nin bacaklar�n�n nereye ba�l� oldu�unu belirtiyoruz sbit ile
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

// ba�lant�lar�n y�nleri
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

/*//uni-ds6 i�in pin ba�lant�lar�
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

     INTCON = 0; // T�m kesmeler deaktif edilir. (sebebini bilmiyorum dedi)
     
     ANSEL = 0x04;
     TRISA = 0x04;
     
     ANSELH = 0;
     
     Lcd_Init(); //lcd yi ba�lat.
     
     Lcd_Cmd(_LCD_CURSOR_OFF); // lcd deki cursor u kapatt�k (yan�p s�nen imle� gibi)
     
     Lcd_Cmd(_LCD_CLEAR); // lcd nin i�eri�ini temizliyor.
     
     text = "mikroElektronika"; // 16 karakterlik, daha fazla yazarsak ekrana s��maz.
     
     Lcd_Out(1,1,text); // ilk sat�r ilk s�tundan yazd�rmaya ba�layaca��z.
     
     text = "LCD example"; // yeni yaz� yazd�k
     
     Lcd_Out(2,1,text); // alt sat�r�n ilk s�tunundan yazd�rmaya ba�l�yoruz.
     
     delay_ms(2000); // 2 sn beklesin yaz�lar.
     
     text = "voltage:";
     
     while(1){

              adc_rd = ADC_Read(2); // 2. kanaldan okuyoruz.
              
              Lcd_Out(2,1,text);
              
              // �rne�in port umuzdan 3.75V al�yoruz. (�rnekleyerek anlat�l�yor bu k�s�m)
              // 0-5V aras� 0-1023 aras�na indirgenmesi sonucu
              // ADC nin kar��l��� 767 de�eridir (0<767<1023)
              // Bu aral��� 0-5000mV a �ekmek amac�yla 0-1023 aral���n� 5000 ile geni�letelim: 0-5115mV olur.
              // tlong = 767 * 5 * 1000 = 3835000
              // sonucun mV d�zeyinde i�leme al�nmas�n� sa�lar.
              tlong = (long)adc_rd * 5 * 1000;
              
              // tlong / 1023 =~ 3748,77mV oldu (0-5000mV aral���nda)
              tlong = tlong / 1023;
              
              // �nce ondal�k k�sm�n� alal�m.
              // tlong / 1000  = 3 (integer alta yuvarlan�r)
              ch = tlong / 1000;
              
              Lcd_Chr(2,9,48+ch); // voltage: 3 (48 ascii 0 a denk geliyor. onun �st�ne ch koyarsak ch nin rakam de�eri yazar.)
              
              Lcd_Chr_CP('.'); // voltage: 3. (3 ten sonra nokta koymas� i�in) CP - current position (cursor un bulundu�u yer)
              
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