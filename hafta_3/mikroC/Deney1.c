/* Deney 1: Port B'ye baðlanan 8 adet LED'in birer aralýklarla yakýlmasý

   MCU: PIC16F8877
   OSC: 8MHz
         
             */
             /*
void main() {

     ANSEL = 0; // Portlardaki tüm giriþ çýkýþlar dijital olsun
     ANSELH= 0;
     
     PORTB = 0b01010101; // B Portunun LED'lere baðlý bacaklarý sýrasýyla yakýlýr.
     
     TRISB = 0; // B Portunun tüm bacaklarý çýktý/çýkýþ olarak ayarlanýr.

}             */

// Deney 1 Versiyon 2:

/*
MCU ilk çalýþtýðýnda tüm LED’ler 1 snyanýk kalsýn. 
•Ardýndan aralýklý olarak tüm LED’ler sönüp yanmaya devam etsin. 
•Yani LED’ler 100ms yanacak, 500ms sönük kalacak þekilde olsun.
•Bu iþlem 20 defa tekrarlansýn. 
•Son olarak LED’ler deneyin ilk versiyonundaki hale gelsin. 
•Sonsuza kadar bu LED’lerden yananlar ile yanmayanlar 200ms’de 1 yer deðiþtirsin.

   MCU: PIC16F8877
   OSC: 8MHz

*/

int k;

void main()
{
     ANSEL = 0;
     ANSELH= 0;

     PORTB = 0xFF; // Port B nin tamamýný yanacak þekilde ayarladýk

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
             PORTB = ~PORTB; // tümleyeni
             
             delay_ms(200);
     }
}