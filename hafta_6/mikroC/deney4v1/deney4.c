/*

  Deney 1'deki devrenin delay_ms kullanarak yapt��� i�i, timer ve kesme
kullanarak yapan bir program tasarlayaca��z. Port B�de saklanan
ondal�k de�eri ikili olarak g�stermek i�in 8 LED�i kullanaca��z. Her
kesme oldu�unda bu de�eri art�raca��z. Led�ler de ona g�re yanacak.
Aradaki zaman farklar�n� da TMR0'� say�c� olarak kullanarak
olu�turaca��z.

8 tane led bizim timer0 �n i�inde saklad��� de�er olacak. 0 de�eri oldu�unda hi�bir led yanmayacak,
1 de�eri oldu�u zaman 0. led yazacak. binary olarak artarak gidecek. 255 oldu�u anda otomatik s�f�rlanacak
ve kesmeyi y�nlendirmi� olaca��z.
TMR0 96 dan 255 e geldi�inde de�eri 0 a d�n�yor bir interrupt yap�yor. interrupt fonksiyonu �al���yor. cnt 1 art�r�l�yor.
400 kere tekrar etti�inde portb 1 art�r�l�yor. burada zaman fark� oluyor, yani delay_ms kullanmak yerine bunu yap�yoruz.

MCU: PIC16F887
OSC: 8MHz

*/

unsigned cnt;

void interrupt(){

     cnt++;
     
     TMR0 = 96;
     
     INTCON = 0x20; // T0IE = 1 yani 0010 0000
                    // T0IF = 0 yap�yoruz. bi sonraki kesmenin olu�mas�n� bekliyoruz
                    // TMR0 yeniden aktifle�tirilir.

}


void main() {

     OPTION_REG = 0x84; // 1000 0100 -> RBPU = 1, PORTB Pull-Up disable.
                        // PSA=0, PS2 PS1 PS0 = 100 
                        // PRESCELER=1:32
                        
     ANSEL = 0;
     ANSELH = 0;
     
     TRISB = 0;
     PORTB = 0x0; // 0000 0000
     
     TMR0 = 96; // 96 ile 255 aras� sayma yapaca��z.
     
     INTCON = 0xA0; // 1010 0000 -> GIE = 1, TOIE = 1
     
     cnt = 0; // Her ta�ma oldu�unda bu de�er art�r�lacak.
     
     do{

        if(cnt == 400){ // TMR0 400 kez ta�t���nda

               PORTB = PORTB++;

               cnt = 0;

        }
        
        }while(1);

}