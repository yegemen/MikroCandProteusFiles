/*

  GLCD üzerine konumlandýrýlmýþ dokunmatik ekranda iki adet LED'in açýlmasý veya kapatýlmasý için
  bir arayüz tasarlanacak. (proteus da deðil deney setinde uygulanacak)
  
  önceki uygulamalara göre mesajlarýn ram de tutulmasýyla ilgili bir farklýlýk var.
  
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

     for(;;*dest++ = *src++); //ilk 0 elemaný aktarýr devam eder

     return dest;
}

long x_coord, y_coord, x_coord128, y_coord64;

unsigned int GetX(){

         PORTC.F0 = 1; // DRIVEA aktifleþtirilir.
         
         PORTC.F1 = 0; // DRIVEB deaktif edilir.
         
         Delay_ms(5);
         
         return ADC_read(0); // B Panelinden RA0 dan analog okunur.(Channel0=RA0)

}

unsigned int GetY(){

         PORTC.F0 = 0; // DRIVEA aktifleþtirilir.

         PORTC.F1 = 1; // DRIVEB deaktif edilir.

         Delay_ms(5);

         return ADC_read(1); // A Panelinden RA1 den analog okunur.(Channel1=RA1)

}

void main() {

     // analog olarak koordinat bilgisi mcu ya gelecek, mcu da dijital olarak dönüþümünü saðlayacak.
     // RA0 ve RA1 in analog olarak input almasý gerekecek.
     ANSEL = 0x03; // 0000 0011 (RA0 ve RA1 analog input)
     ANSELH = 0;
     
     // RC6 ve RC7 çýktý olarak ayarlýyoruz,
     PORTC = 0;
     TRISC = 0;
     
     PORTA = 0;
     TRISA = 0x03; // RA0 ve RA1'i input olarak ayarladýk.

     Glcd_Init();  // baþlattýk.
     
     Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32); //yazý tipi
     
     Glcd_Fill(0); // ekraný temizledik
     
     // TOUCH PANEL EXAMPLE yazýsý
     // const ý ram e aktar kopyala
     CopyConst2Ram(msg, msg1); // hedef, kaynak
     Glcd_Write_Text(msg, 10, 0, 1); // msj ve koordinat. mesajýn yazýlacaðý x koordinatý, page numarasý 0 en üst satýra, ve siyah
     //soldan 10 pixel boþluk býrak, en üste ve siyah yaz.
     
     // MIKROELEKTRONIKA yazýsý
     CopyConst2Ram(msg, msg2);
     Glcd_Write_Text(msg, 17, 7, 1);

     // Button 1'in Çizilmesi
     Glcd_Rectangle(8, 16, 60, 48, 1); // x:8, y:16 baþlangýç, x:60, y:48 bitiþ. diðerleri de ayný þekilde.
     Glcd_Box(10, 18, 58, 46, 1);
     
     // Button 2'nin Çizilmesi
     Glcd_Rectangle(68, 16, 120, 48, 1);
     Glcd_Box(70, 18, 118, 46, 1);
     
     CopyConst2Ram(msg, msg3); // "BUTTON 1" yazýsý
     Glcd_Write_Text(msg, 14, 3, 0); // beyaz yazýlacak
     
     CopyConst2Ram(msg, msg5); // "RC6 OFF" yazýsý
     Glcd_Write_Text(msg, 14, 4, 0);
     
     CopyConst2Ram(msg, msg3); // "BUTTON 2" yazýsý
     Glcd_Write_Text(msg, 74, 3, 0);

     CopyConst2Ram(msg, msg5); // "RC7 OFF" yazýsý
     Glcd_Write_Text(msg, 74, 4, 0);
     
     //dokunmatik ekran kýsmýna geçiyoruz
     while(1)
     {
     
             x_coord = GetX();
             y_coord = GetY();
             
             x_coord128 = (x_coord * 128) / 1024;
             y_coord64 = 64 - ((y_coord*64) / 1024);
             
             // Button1 e basýlýp basýlmadýðýnýn kontrolü
             if((x_coord128 >= 10) && (x_coord128 <= 58) && (y_coord64 >= 18) && (y_coord64 <= 46)){
             
                            if(PORTC.F6 == 0){ // RC6 ya baðlý led sönük ise
                            
                                        PORTC.F6 = 1; // RC6 ya baðlý led yansýn
                                        
                                        CopyConst2Ram(msg, msg7); // "RC6 ON" mesajý
                                        
                                        Glcd_Write_Text(msg, 14, 4, 0);
                            
                            }
                            else{ // RC6 ya baðlý led yanýyor ise
                            
                                        PORTC.F6 = 0; // RC6 ya baðlý led sönsün

                                        CopyConst2Ram(msg, msg5); // "RC6 OFF" mesajý

                                        Glcd_Write_Text(msg, 14, 4, 0);
                            
                            }
             
             }
             
             // Button2 ye basýlýp basýlmadýðýnýn kontrolü
             if((x_coord128 >= 70) && (x_coord128 <= 118) && (y_coord64 >= 18) && (y_coord64 <= 46)){

                            if(PORTC.F7 == 0){ // RC7 ye baðlý led sönük ise

                                        PORTC.F6 = 1; // RC7 ye baðlý led yansýn

                                        CopyConst2Ram(msg, msg8); // "RC7 ON" mesajý

                                        Glcd_Write_Text(msg, 74, 4, 0);

                            }
                            else{ // RC7 ye baðlý led yanýyor ise

                                        PORTC.F7 = 0; // RC7 ye baðlý led sönsün

                                        CopyConst2Ram(msg, msg6); // "RC7 OFF" mesajý

                                        Glcd_Write_Text(msg, 74, 4, 0);

                            }

             }

     }

     
}