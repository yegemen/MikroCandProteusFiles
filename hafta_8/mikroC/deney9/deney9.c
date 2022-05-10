/*

            Deney 9
� 0�dan 99�a kadar ondal�kl� sayma yapan program.
� Onlar ve birler basama��n� maskeleyip portlara g�nderece�iz.
� Hem sayma hem multiplexing yap�lacak, bu y�zden TMR0�� say�c� olarak kullan�p her ta�ma oldu�unda kesme rutinine
girip multplexing yap�lacak.

MCU: 16F887
OSC: 8MHz

Not: proteus da bu program� y�kleyince sa�l�kl� �al��maz ama deneysetinde y�kleyince sorunsuz �al���r.

*/

unsigned short i, digit, digit1, digit10, digit_no;

unsigned short mask(unsigned short num);

void interrupt(){

     if(digit_no == 0){ // Birler basama�� display i �al��acak.
     
                 PORTA = 0;
                 
                 PORTD = digit1;
                 
                 PORTA = 1; // 01 (RA0'� aktifle�tir)
                 
                 digit_no = 1; // Bir sonraki kesmede di�er display �al��s�n
     
     }
     else{ // Onlar basama�� display i �al��acak.
     
           PORTA = 0;
           
           PORTD = digit10;
           
           PORTA = 2; // 10 (RA1'i aktifle�tirir)
           
           digit_no = 0; // Bir sonraki kesmede di�er display �al��s�n.

     }
     
     TMR0 = 0;
     
     INTCON = 0x20; // Ta�ma bayra��n� s�f�rla

}

void main() {

     OPTION_REG = 0x80; // TMR0 i�in gerekli
     
     TMR0 = 0;
     
     INTCON = 0xA0; // T�m unmasked kesmeler ile TMR0 kesmesi aktifle�tirilir. (GIE ve T0IE)
     
     PORTA = 0;
     TRISA = 0;
     
     PORTD = 0;
     TRISD = 0;
     
     do{
     
        for(i=0;i<=99;i++){

        digit = i % 10u; // birler basama��n� ald�k. unsigned olsun diye 10u �eklinde yaz�lm��.
        
        digit1 = mask(digit);
        
        digit = (char)(i / 10u) % 10u;                 //bellekte char olarak saklan�yormu�.
        
        digit10 = mask(digit);
        
        delay_ms(1000);
        
        }
     
     }while(1);

}