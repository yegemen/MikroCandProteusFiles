  /*
  
  Deney 3:
  
  • Þimdiye kadar yaptýðýmýz deneylerden farklý olarak dýþarýdan MCU’ya bir buton baðlanarak girdi (input) alacaðýz.
  • Çoðu MCU uygulamasýnda bu þekilde girdiler sensörlerden alýnýr.
  • Butona her basýldýðýnda sayma iþlemi gerçekleþecek.
  • Yani TMR0’yu sayýcý (counter) olarak kullanacaðýz.
  • Dolayýsýyla butona her basýldýðýnda TMR0 bir darbeyi (pulse) sayacak.
  • Sayýlan deðer 5’e ulaþtýðýnda MCU’ya baðlý bir RÖLE’yi aktifleþtirecek.
  • Simülasyondan elde edilen sonucun görselliðini artýrmak için röle bir
    lambayý çalýþtýracak þekilde baðlandý ve lambanýn yanmasý saðlandý.
  
  */


void main() {

     char TEST = 5;
     
     enum outputs {RELAY = 3}; // HEATER = 4, PUMP = 7 etc.

     ANSEL = ANSELH = 0;
     
     PORTA = 0;
     TRISA = 0XFF; // RA4 yani T0CKI bacaðý input yapýlýr.
     
     PORTD = 0;
     TRISD = 0b11110111; // RD3 bacaðý output yapýlýr.
     
     OPTION_REG.F5 = 1; // T0CKI bacaðýndan clock pulse alýnmasý. (T0CS = 1)
     
     OPTION_REG.F3 = 1; // Prescaler  WDT'ye atanarak TMR0'ýn 1:1 olarak scale edilmesi saðlanýr (PSA = 1)
     
     TMR0 = 0; // Timer 0'ýn içeriði sýfýrlansýn yani 0 deðerinden saymaya baþlayacaðýz.
     
     do{
     
        if(TMR0 == TEST){
        
                PORTD.RELAY = 1; // RD4 bacaðý 0'dan 1'e deðiþir ve Röle (Relay) çalýþýr.
                
        }
     
     }while(1);

}