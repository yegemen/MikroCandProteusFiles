/* Deney 2:

   MCU: PIC16F8877
   OSC: 8MHz
   
   •Deney 1’deki devrenin aynýsýný kullanmaya devam edelim.
   •Amacýmýz LED’lerin daha yavaþ bir þekilde yanýp sönmesi.
   •Elbette bunu delay_msfonksiyonunun parametresini deðiþtirerek yapabiliriz.
   •Ancak bu deneyde harici osilatör yerine dahili osilatör’den faydalanacaðýz.
   •Önce harici osilatörü8MHz olarak kullanýp, sonra dahili osilatöregeçip 31kHZ’lik frekansla bu iþi yapacaðýz.
   •Hatta osilatör seçimini de C dili içinde assemblykodu kullanarak yapacaðýz.

*/

int k=0;
char saveBank; //status içeriðimizi saklayacak.

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
     
     // STATUS bitinin þu anki 5 ve 6 nolu bitleri saklansýn.
     // STATUS = xxxxxxxx -> saveBank = 0xx00000
     saveBank = STATUS & 0b01100000; // RP1 ve RP0 biti (Bit 5 ve 6)
     
     // C dili içinde assembly kodu yazmaya baþlýyoruz.
     asm{

         // OSCCON register'ýnýn bulunduðu Bank 1 seçilir.
         // RP1 RP0 = 01 (Bank 1)
         bsf STATUS, RP0
         bcf STATUS, RP1
         
         // RPCF2 RPCF1 RPCF0 = 0 0 0 Dahili osilatör (LFINTOSC) seçilir
         bcf OSCCON, 6 // IRFC2= 0
         bcf OSCCON, 5 // IRFC1= 0
         bcf OSCCON, 4 // IRFC0= 0
         
         bsf OSCCON, 0 // SCS (0 no'lu bit) 1 yapýlýr. Dahili OSC(osilatör) seçilir.

     }
     // assembly kodundan çýktýk
     
     // STATUS bitinin ASM kodundan önceki 5 ve 6 nolu bitlerinin deðerleri geri yüklensin
     STATUS &= 0b10011111; // STATUS = yyyyyyyy & 10011111 = y00yyyyy
     STATUS |= saveBank;   // STATUS = y00yyyyy | 0xx00000 = yxxyyyyy
     //bank seçimi önceden ne ise þimdi de o oldu.
     
     do{
     
        PORTB = ~PORTB;
        
        delay_ms(10);
     
        k++;

     }while(k<20);

     // ms yi düþürmemize raðmen frekans dan dolayý daha yavaþ yanýp sönüyor.
}