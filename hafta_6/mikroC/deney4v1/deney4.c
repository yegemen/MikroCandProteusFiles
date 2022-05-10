/*

  Deney 1'deki devrenin delay_ms kullanarak yaptýðý iþi, timer ve kesme
kullanarak yapan bir program tasarlayacaðýz. Port B’de saklanan
ondalýk deðeri ikili olarak göstermek için 8 LED’i kullanacaðýz. Her
kesme olduðunda bu deðeri artýracaðýz. Led’ler de ona göre yanacak.
Aradaki zaman farklarýný da TMR0'ý sayýcý olarak kullanarak
oluþturacaðýz.

8 tane led bizim timer0 ýn içinde sakladýðý deðer olacak. 0 deðeri olduðunda hiçbir led yanmayacak,
1 deðeri olduðu zaman 0. led yazacak. binary olarak artarak gidecek. 255 olduðu anda otomatik sýfýrlanacak
ve kesmeyi yönlendirmiþ olacaðýz.
TMR0 96 dan 255 e geldiðinde deðeri 0 a dönüyor bir interrupt yapýyor. interrupt fonksiyonu çalýþýyor. cnt 1 artýrýlýyor.
400 kere tekrar ettiðinde portb 1 artýrýlýyor. burada zaman farký oluyor, yani delay_ms kullanmak yerine bunu yapýyoruz.

MCU: PIC16F887
OSC: 8MHz

*/

unsigned cnt;

void interrupt(){

     cnt++;
     
     TMR0 = 96;
     
     INTCON = 0x20; // T0IE = 1 yani 0010 0000
                    // T0IF = 0 yapýyoruz. bi sonraki kesmenin oluþmasýný bekliyoruz
                    // TMR0 yeniden aktifleþtirilir.

}


void main() {

     OPTION_REG = 0x84; // 1000 0100 -> RBPU = 1, PORTB Pull-Up disable.
                        // PSA=0, PS2 PS1 PS0 = 100 
                        // PRESCELER=1:32
                        
     ANSEL = 0;
     ANSELH = 0;
     
     TRISB = 0;
     PORTB = 0x0; // 0000 0000
     
     TMR0 = 96; // 96 ile 255 arasý sayma yapacaðýz.
     
     INTCON = 0xA0; // 1010 0000 -> GIE = 1, TOIE = 1
     
     cnt = 0; // Her taþma olduðunda bu deðer artýrýlacak.
     
     do{

        if(cnt == 400){ // TMR0 400 kez taþtýðýnda

               PORTB = PORTB++;

               cnt = 0;

        }
        
        }while(1);

}