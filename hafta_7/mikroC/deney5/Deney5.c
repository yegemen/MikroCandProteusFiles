   /*
   
   Deney 5
• WDT (Watch-Dog-Timer) kullanýmý.
• Normalde WDT’ýn kullanýmý diye bir durum yok!
• WDT’ýn çalýþmasýnýn anlaþýlmasýna yardýmcý olan bir deney olacak.
• Deney 1’deki devre aynen kullanýlacak.
• LED’ler yine iki blok halinde sýrayla göz kýrpacak (blink) þekilde aralýklý
olarak çalýþacak.
• Program sonsuz bir döngüde hiçbir þey yapmadan bekleyecek,
bakalým WDT çalýþacak mý?
• NOT: Project->Edit Project->Watchdog Timer=Enabled olmalý.

MCU: PIC16F887
OSC: 8Mhz
   
   */


void main() {

     OPTION_REG = 0x0E; // 0000 1110 Bit3=PSA=1 Prescaler WDT'ye atandý. PS2 PS1 PS0 (Bit2Bit1Bit0) 110 -> Prescaler 1:64
     
     asm CLRWDT; // WDT'nin sýfýrlanmasýný engelle
     
     PORTB = 0x0F;
     TRISB = 0;
     
     delay_ms(300);
     
     PORTB = 0xF0;
     
     while(1); //wdt ýn otomatik olarak taþmasýný ve programýmýzý resetlemesini bekliyoruz.
     

}