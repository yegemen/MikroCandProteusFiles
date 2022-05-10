/* Deney 2:

   MCU: PIC16F8877
   OSC: 8MHz
   
   �Deney 1�deki devrenin ayn�s�n� kullanmaya devam edelim.
   �Amac�m�z LED�lerin daha yava� bir �ekilde yan�p s�nmesi.
   �Elbette bunu delay_msfonksiyonunun parametresini de�i�tirerek yapabiliriz.
   �Ancak bu deneyde harici osilat�r yerine dahili osilat�r�den faydalanaca��z.
   ��nce harici osilat�r�8MHz olarak kullan�p, sonra dahili osilat�rege�ip 31kHZ�lik frekansla bu i�i yapaca��z.
   �Hatta osilat�r se�imini de C dili i�inde assemblykodu kullanarak yapaca��z.

*/

int k=0;
char saveBank; //status i�eri�imizi saklayacak.

void main() {

     ANSEL = 0;
     ANSELH = 0;
     
     PORTB = 0;
     TRISB = 0;
     
     do{
     
        k++;
        
        PORTB = ~PORTB;
        
        delay_ms(100);
        
     }while(k<20);
     
     k=0;
     
     // STATUS bitinin �u anki 5 ve 6 nolu bitleri saklans�n.
     // STATUS = xxxxxxxx -> saveBank = 0xx00000
     saveBank = STATUS & 0b01100000; // RP1 ve RP0 biti (Bit 5 ve 6)
     
     // C dili i�inde assembly kodu yazmaya ba�l�yoruz.
     asm{

         // OSCCON register'�n�n bulundu�u Bank 1 se�ilir.
         // RP1 RP0 = 01 (Bank 1)
         bsf STATUS, RP0
         bcf STATUS, RP1
         
         // RPCF2 RPCF1 RPCF0 = 0 0 0 Dahili osilat�r (LFINTOSC) se�ilir
         bcf OSCCON, 6 // IRFC2= 0
         bcf OSCCON, 5 // IRFC1= 0
         bcf OSCCON, 4 // IRFC0= 0
         
         bsf OSCCON, 0 // SCS (0 no'lu bit) 1 yap�l�r. Dahili OSC(osilat�r) se�ilir.

     }
     // assembly kodundan ��kt�k
     
     // STATUS bitinin ASM kodundan �nceki 5 ve 6 nolu bitlerinin de�erleri geri y�klensin
     STATUS &= 0b10011111; // STATUS = yyyyyyyy & 10011111 = y00yyyyy
     STATUS |= saveBank;   // STATUS = y00yyyyy | 0xx00000 = yxxyyyyy
     //bank se�imi �nceden ne ise �imdi de o oldu.
     
     do{
     
        PORTB = ~PORTB;
        
        delay_ms(10);
     
        k++;

     }while(k<20);

     // ms yi d���rmemize ra�men frekans dan dolay� daha yava� yan�p s�n�yor.
}