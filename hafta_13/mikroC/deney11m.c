/*

    UNI-DS6'n�n USB UART1 aray�z� arac�l���yla seri haberle�me �rne�i:
    Bilgisayardan g�nderilen bir verinin MCU taraf�ndan al�n�p ayn� mesaj�n
    tekrar bilgisayara g�nderilmesi.
    
    uart k�t�phanesi ekli olmal�.
    
    MCU: PIC16F887
    OSC: 8MHz

*/

char uart_rd; //bilgisayardan al�nan verinin tek karakter olarak tutulmas�

void main() {

     ANSEL = 0;
     ANSELH = 0;
     
     UART1_Init(9600); // Baud Rate 9600bps olacak.
     
     Delay_ms(100);
     
     UART1_Write_Text("Start"); // start yaz�s� g�nderdik
     
     UART1_Write(10); // 10 de�eri g�nderdik.
     
     UART1_Write(13); // 13 de�eri g�nderdik.
     
     while(1){
     
              if(UART1_Data_Ready()){
              
               uart_rd = UART1_Read();
               
               UART1_Write(uart_rd);
               
               //veriyi al�yoruz ve tekrar g�nderiyoruz.
              
              }
     
     }

}