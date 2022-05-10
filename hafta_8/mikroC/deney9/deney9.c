/*

            Deney 9
• 0’dan 99’a kadar ondalýklý sayma yapan program.
• Onlar ve birler basamaðýný maskeleyip portlara göndereceðiz.
• Hem sayma hem multiplexing yapýlacak, bu yüzden TMR0’ý sayýcý olarak kullanýp her taþma olduðunda kesme rutinine
girip multplexing yapýlacak.

MCU: 16F887
OSC: 8MHz

Not: proteus da bu programý yükleyince saðlýklý çalýþmaz ama deneysetinde yükleyince sorunsuz çalýþýr.

*/

unsigned short i, digit, digit1, digit10, digit_no;

unsigned short mask(unsigned short num);

void interrupt(){

     if(digit_no == 0){ // Birler basamaðý display i çalýþacak.
     
                 PORTA = 0;
                 
                 PORTD = digit1;
                 
                 PORTA = 1; // 01 (RA0'ý aktifleþtir)
                 
                 digit_no = 1; // Bir sonraki kesmede diðer display çalýþsýn
     
     }
     else{ // Onlar basamaðý display i çalýþacak.
     
           PORTA = 0;
           
           PORTD = digit10;
           
           PORTA = 2; // 10 (RA1'i aktifleþtirir)
           
           digit_no = 0; // Bir sonraki kesmede diðer display çalýþsýn.

     }
     
     TMR0 = 0;
     
     INTCON = 0x20; // Taþma bayraðýný sýfýrla

}

void main() {

     OPTION_REG = 0x80; // TMR0 için gerekli
     
     TMR0 = 0;
     
     INTCON = 0xA0; // Tüm unmasked kesmeler ile TMR0 kesmesi aktifleþtirilir. (GIE ve T0IE)
     
     PORTA = 0;
     TRISA = 0;
     
     PORTD = 0;
     TRISD = 0;
     
     do{
     
        for(i=0;i<=99;i++){

        digit = i % 10u; // birler basamaðýný aldýk. unsigned olsun diye 10u þeklinde yazýlmýþ.
        
        digit1 = mask(digit);
        
        digit = (char)(i / 10u) % 10u;                 //bellekte char olarak saklanýyormuþ.
        
        digit10 = mask(digit);
        
        delay_ms(1000);
        
        }
     
     }while(1);

}