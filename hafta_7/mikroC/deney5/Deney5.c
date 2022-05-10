   /*
   
   Deney 5
� WDT (Watch-Dog-Timer) kullan�m�.
� Normalde WDT��n kullan�m� diye bir durum yok!
� WDT��n �al��mas�n�n anla��lmas�na yard�mc� olan bir deney olacak.
� Deney 1�deki devre aynen kullan�lacak.
� LED�ler yine iki blok halinde s�rayla g�z k�rpacak (blink) �ekilde aral�kl�
olarak �al��acak.
� Program sonsuz bir d�ng�de hi�bir �ey yapmadan bekleyecek,
bakal�m WDT �al��acak m�?
� NOT: Project->Edit Project->Watchdog Timer=Enabled olmal�.

MCU: PIC16F887
OSC: 8Mhz
   
   */


void main() {

     OPTION_REG = 0x0E; // 0000 1110 Bit3=PSA=1 Prescaler WDT'ye atand�. PS2 PS1 PS0 (Bit2Bit1Bit0) 110 -> Prescaler 1:64
     
     asm CLRWDT; // WDT'nin s�f�rlanmas�n� engelle
     
     PORTB = 0x0F;
     TRISB = 0;
     
     delay_ms(300);
     
     PORTB = 0xF0;
     
     while(1); //wdt �n otomatik olarak ta�mas�n� ve program�m�z� resetlemesini bekliyoruz.
     

}