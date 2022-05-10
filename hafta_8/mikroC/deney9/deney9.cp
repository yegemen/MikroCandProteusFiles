#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_8/mikroC/deney9/deney9.c"
#line 16 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_8/mikroC/deney9/deney9.c"
unsigned short i, digit, digit1, digit10, digit_no;

unsigned short mask(unsigned short num);

void interrupt(){

 if(digit_no == 0){

 PORTA = 0;

 PORTD = digit1;

 PORTA = 1;

 digit_no = 1;

 }
 else{

 PORTA = 0;

 PORTD = digit10;

 PORTA = 2;

 digit_no = 0;

 }

 TMR0 = 0;

 INTCON = 0x20;

}

void main() {

 OPTION_REG = 0x80;

 TMR0 = 0;

 INTCON = 0xA0;

 PORTA = 0;
 TRISA = 0;

 PORTD = 0;
 TRISD = 0;

 do{

 for(i=0;i<=99;i++){

 digit = i % 10u;

 digit1 = mask(digit);

 digit = (char)(i / 10u) % 10u;

 digit10 = mask(digit);

 delay_ms(1000);

 }

 }while(1);

}
