#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_13/mikroC/deney11m.c"
#line 14 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_13/mikroC/deney11m.c"
char uart_rd;

void main() {

 ANSEL = 0;
 ANSELH = 0;

 UART1_Init(9600);

 Delay_ms(100);

 UART1_Write_Text("Start");

 UART1_Write(10);

 UART1_Write(13);

 while(1){

 if(UART1_Data_Ready()){

 uart_rd = UART1_Read();

 UART1_Write(uart_rd);



 }

 }

}
