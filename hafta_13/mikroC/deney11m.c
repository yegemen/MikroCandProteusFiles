/*

    UNI-DS6'nýn USB UART1 arayüzü aracýlýðýyla seri haberleþme örneði:
    Bilgisayardan gönderilen bir verinin MCU tarafýndan alýnýp ayný mesajýn
    tekrar bilgisayara gönderilmesi.
    
    uart kütüphanesi ekli olmalý.
    
    MCU: PIC16F887
    OSC: 8MHz

*/

char uart_rd; //bilgisayardan alýnan verinin tek karakter olarak tutulmasý

void main() {

     ANSEL = 0;
     ANSELH = 0;
     
     UART1_Init(9600); // Baud Rate 9600bps olacak.
     
     Delay_ms(100);
     
     UART1_Write_Text("Start"); // start yazýsý gönderdik
     
     UART1_Write(10); // 10 deðeri gönderdik.
     
     UART1_Write(13); // 13 deðeri gönderdik.
     
     while(1){
     
              if(UART1_Data_Ready()){
              
               uart_rd = UART1_Read();
               
               UART1_Write(uart_rd);
               
               //veriyi alýyoruz ve tekrar gönderiyoruz.
              
              }
     
     }

}