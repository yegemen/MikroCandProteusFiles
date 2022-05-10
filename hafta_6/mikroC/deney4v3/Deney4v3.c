/*

Deney 4 Versiyon 3

• Bu versiyonda TMR2'nin 0'dan baþlayarak taþma olduðunda interrupt
fonksiyonundaki iþin yapýlmasýný saðlamak yoluyla birer aralýklý LED'ler
karþýlýklý yanýp söner.
• Ayrýca replace adýnda bir fonksiyon da ilave edilmiþtir.

*/

unsigned short cnt;

void replace(){

     PORTB = ~PORTB;

}

void interrupt(){


     // TMR2 den kesme geldiyse
     if(PIR1.TMR2IF)
     {
     
                    cnt++;
                    
                    PIR1.TMR2IF = 0;
                    
                    TMR2 = 0;

     }

}

void main() {

     cnt = 0;
     
     ANSEL = 0;
     ANSELH = 0;
     
     PORTB = 0b10101010;
     TRISB = 0;
     
     T2CON = 0xFF; // TMR2ON = 1, 1:16 prescaler rate,
                   // postscaler rate = 1:16
                   
     PIE1.TMR2IE = 1;
     INTCON = 0xC0; // 1000 0000 -> GIE = 1, PEIE = 1
     
     while(1){
     
              if(cnt == 30){
              
                     cnt = 0;

                     replace();
              
              }
     
     }

}