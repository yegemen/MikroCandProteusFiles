/* Deney 1: Port B'ye ba�lanan 8 adet LED'in birer aral�klarla yak�lmas�

   MCU: PIC16F8877
   OSC: 8MHz
         
             */
             /*
void main() {

     ANSEL = 0; // Portlardaki t�m giri� ��k��lar dijital olsun
     ANSELH= 0;
     
     PORTB = 0b01010101; // B Portunun LED'lere ba�l� bacaklar� s�ras�yla yak�l�r.
     
     TRISB = 0; // B Portunun t�m bacaklar� ��kt�/��k�� olarak ayarlan�r.

}             */

// Deney 1 Versiyon 2:

/*
MCU ilk �al��t���nda t�m LED�ler 1 snyan�k kals�n. 
�Ard�ndan aral�kl� olarak t�m LED�ler s�n�p yanmaya devam etsin. 
�Yani LED�ler 100ms yanacak, 500ms s�n�k kalacak �ekilde olsun.
�Bu i�lem 20 defa tekrarlans�n. 
�Son olarak LED�ler deneyin ilk versiyonundaki hale gelsin. 
�Sonsuza kadar bu LED�lerden yananlar ile yanmayanlar 200ms�de 1 yer de�i�tirsin.

   MCU: PIC16F8877
   OSC: 8MHz

*/

int k;

void main()
{
     ANSEL = 0;
     ANSELH= 0;

     PORTB = 0xFF; // Port B nin tamam�n� yanacak �ekilde ayarlad�k

     TRISB = 0;
     
     delay_ms(1000); // 1 ms bekle
     
     PORTB = 0;
     
     for(k=0;k<20;k++)
     {
                      switch(PORTB)
                      {
                                   case 0x00: PORTB = 0xFF;
                                   delay_ms(100);
                                   break;
                                   
                                   case 0xFF: PORTB = 0x00;
                                   delay_ms(500);
                                   break;
                      }
     }
     
     PORTB = 0b01010101;
     
     while(1)
     {
             PORTB = ~PORTB; // t�mleyeni
             
             delay_ms(200);
     }
}