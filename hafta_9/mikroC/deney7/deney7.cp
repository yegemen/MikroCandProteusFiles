#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_9/mikroC/deney7/deney7.c"
#line 10 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_9/mikroC/deney7/deney7.c"
unsigned int temp_res;

void main() {

 ANSEL = 0x04;

 TRISA = 0xFF;

 ANSELH = 0;

 TRISB = 0x3F;

 TRISD = 0;

 do{

 temp_res = ADC_Read(2);

 PORTD = temp_res;

 PORTB = temp_res >> 2;

 }while(1);



}
