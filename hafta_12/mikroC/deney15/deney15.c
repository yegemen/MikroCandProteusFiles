/*

  GLCD �zerine konumland�r�lm�� dokunmatik ekranda iki adet LED'in a��lmas� veya kapat�lmas� i�in
  bir aray�z tasarlanacak. (proteus da de�il deney setinde uygulanacak)
  
  �nceki uygulamalara g�re mesajlar�n ram de tutulmas�yla ilgili bir farkl�l�k var.
  
  MCU: PIC16F887
  OSC: 8MHz

*/

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

     for(;;*dest++ = *src++); //ilk 0 eleman� aktar�r devam eder

     return dest;
}

long x_coord, y_coord, x_coord128, y_coord64;

unsigned int GetX(){

         PORTC.F0 = 1; // DRIVEA aktifle�tirilir.
         
         PORTC.F1 = 0; // DRIVEB deaktif edilir.
         
         Delay_ms(5);
         
         return ADC_read(0); // B Panelinden RA0 dan analog okunur.(Channel0=RA0)

}

unsigned int GetY(){

         PORTC.F0 = 0; // DRIVEA aktifle�tirilir.

         PORTC.F1 = 1; // DRIVEB deaktif edilir.

         Delay_ms(5);

         return ADC_read(1); // A Panelinden RA1 den analog okunur.(Channel1=RA1)

}

void main() {

     // analog olarak koordinat bilgisi mcu ya gelecek, mcu da dijital olarak d�n���m�n� sa�layacak.
     // RA0 ve RA1 in analog olarak input almas� gerekecek.
     ANSEL = 0x03; // 0000 0011 (RA0 ve RA1 analog input)
     ANSELH = 0;
     
     // RC6 ve RC7 ��kt� olarak ayarl�yoruz,
     PORTC = 0;
     TRISC = 0;
     
     PORTA = 0;
     TRISA = 0x03; // RA0 ve RA1'i input olarak ayarlad�k.

     Glcd_Init();  // ba�latt�k.
     
     Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32); //yaz� tipi
     
     Glcd_Fill(0); // ekran� temizledik
     
     // TOUCH PANEL EXAMPLE yaz�s�
     // const � ram e aktar kopyala
     CopyConst2Ram(msg, msg1); // hedef, kaynak
     Glcd_Write_Text(msg, 10, 0, 1); // msj ve koordinat. mesaj�n yaz�laca�� x koordinat�, page numaras� 0 en �st sat�ra, ve siyah
     //soldan 10 pixel bo�luk b�rak, en �ste ve siyah yaz.
     
     // MIKROELEKTRONIKA yaz�s�
     CopyConst2Ram(msg, msg2);
     Glcd_Write_Text(msg, 17, 7, 1);

     // Button 1'in �izilmesi
     Glcd_Rectangle(8, 16, 60, 48, 1); // x:8, y:16 ba�lang��, x:60, y:48 biti�. di�erleri de ayn� �ekilde.
     Glcd_Box(10, 18, 58, 46, 1);
     
     // Button 2'nin �izilmesi
     Glcd_Rectangle(68, 16, 120, 48, 1);
     Glcd_Box(70, 18, 118, 46, 1);
     
     CopyConst2Ram(msg, msg3); // "BUTTON 1" yaz�s�
     Glcd_Write_Text(msg, 14, 3, 0); // beyaz yaz�lacak
     
     CopyConst2Ram(msg, msg5); // "RC6 OFF" yaz�s�
     Glcd_Write_Text(msg, 14, 4, 0);
     
     CopyConst2Ram(msg, msg3); // "BUTTON 2" yaz�s�
     Glcd_Write_Text(msg, 74, 3, 0);

     CopyConst2Ram(msg, msg5); // "RC7 OFF" yaz�s�
     Glcd_Write_Text(msg, 74, 4, 0);
     
     //dokunmatik ekran k�sm�na ge�iyoruz
     while(1)
     {
     
             x_coord = GetX();
             y_coord = GetY();
             
             x_coord128 = (x_coord * 128) / 1024;
             y_coord64 = 64 - ((y_coord*64) / 1024);
             
             // Button1 e bas�l�p bas�lmad���n�n kontrol�
             if((x_coord128 >= 10) && (x_coord128 <= 58) && (y_coord64 >= 18) && (y_coord64 <= 46)){
             
                            if(PORTC.F6 == 0){ // RC6 ya ba�l� led s�n�k ise
                            
                                        PORTC.F6 = 1; // RC6 ya ba�l� led yans�n
                                        
                                        CopyConst2Ram(msg, msg7); // "RC6 ON" mesaj�
                                        
                                        Glcd_Write_Text(msg, 14, 4, 0);
                            
                            }
                            else{ // RC6 ya ba�l� led yan�yor ise
                            
                                        PORTC.F6 = 0; // RC6 ya ba�l� led s�ns�n

                                        CopyConst2Ram(msg, msg5); // "RC6 OFF" mesaj�

                                        Glcd_Write_Text(msg, 14, 4, 0);
                            
                            }
             
             }
             
             // Button2 ye bas�l�p bas�lmad���n�n kontrol�
             if((x_coord128 >= 70) && (x_coord128 <= 118) && (y_coord64 >= 18) && (y_coord64 <= 46)){

                            if(PORTC.F7 == 0){ // RC7 ye ba�l� led s�n�k ise

                                        PORTC.F6 = 1; // RC7 ye ba�l� led yans�n

                                        CopyConst2Ram(msg, msg8); // "RC7 ON" mesaj�

                                        Glcd_Write_Text(msg, 74, 4, 0);

                            }
                            else{ // RC7 ye ba�l� led yan�yor ise

                                        PORTC.F7 = 0; // RC7 ye ba�l� led s�ns�n

                                        CopyConst2Ram(msg, msg6); // "RC7 OFF" mesaj�

                                        Glcd_Write_Text(msg, 74, 4, 0);

                            }

             }

     }

     
}