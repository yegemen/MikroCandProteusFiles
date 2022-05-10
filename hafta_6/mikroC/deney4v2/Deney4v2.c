/*
Deney 4 Versiyon 2

� Versiyon 1�deki devre aynen kullan�l�yor fakat Port B'ye ba�l� 8 LED�in �nce ilk yar�s�n�n
ard�ndan ikinci yar�s�n�n yanmas�n� sa�layaca��z.
� Bir de TMR0 yerine TMR1 kullanaca��z.

*/

unsigned short cnt;

void interrupt(){

     cnt++;
     
     PIR1.TMR1IF = 0;
     
     TMR1H = 0x80;
     TMR1L = 0x00;

}

void main() {

     ANSEL = 0;
     ANSELH = 0;
     
     PORTB = 0xF0; // Ba�lang��ta ledlerin yar�s� yans�n.
     TRISB = 0;
     
     T1CON = 1; // TMR1ON = 1 yani TMR1 aktifle�tirilir.
     
     PIR1.TMR1IF = 0; // TMR1 Kesme bayra�� s�f�rlan�r.
     
     // 1000 0000 0000 0000 = 2^15 = 32768'den ba�la saymaya
     TMR1H = 0x80; // 1000 0000
     TMR1L = 0x00; // 0000 0000
     
     PIE1.TMR1IE = 1; // TMR1 Ta�t���nda kesme olu�sun

     cnt = 0;
     
     INTCON = 0xC0; // 1100 0000 -> GIE = 1, PEIE = 1 demektir. bunu tek sat�rda yazmak daha pratik.

     do{
     
     if(cnt == 76){
     
        PORTB = ~PORTB; // Di�er d�rt LED yans�n
        
        cnt = 0;
     }

     }
     while(1);
}