/*
Deney 4 Versiyon 2

• Versiyon 1’deki devre aynen kullanýlýyor fakat Port B'ye baðlý 8 LED’in önce ilk yarýsýnýn
ardýndan ikinci yarýsýnýn yanmasýný saðlayacaðýz.
• Bir de TMR0 yerine TMR1 kullanacaðýz.

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
     
     PORTB = 0xF0; // Baþlangýçta ledlerin yarýsý yansýn.
     TRISB = 0;
     
     T1CON = 1; // TMR1ON = 1 yani TMR1 aktifleþtirilir.
     
     PIR1.TMR1IF = 0; // TMR1 Kesme bayraðý sýfýrlanýr.
     
     // 1000 0000 0000 0000 = 2^15 = 32768'den baþla saymaya
     TMR1H = 0x80; // 1000 0000
     TMR1L = 0x00; // 0000 0000
     
     PIE1.TMR1IE = 1; // TMR1 Taþtýðýnda kesme oluþsun

     cnt = 0;
     
     INTCON = 0xC0; // 1100 0000 -> GIE = 1, PEIE = 1 demektir. bunu tek satýrda yazmak daha pratik.

     do{
     
     if(cnt == 76){
     
        PORTB = ~PORTB; // Diðer dört LED yansýn
        
        cnt = 0;
     }

     }
     while(1);
}