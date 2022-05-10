#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4.c"
#line 19 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4.c"
unsigned cnt;

void interrupt(){

 cnt++;

 TMR0 = 96;

 INTCON = 0x20;



}


void main() {

 OPTION_REG = 0x84;



 ANSEL = 0;
 ANSELH = 0;

 TRISB = 0;
 PORTB = 0x0;

 TMR0 = 96;

 INTCON = 0xA0;

 cnt = 0;

 do{

 if(cnt == 400){

 PORTB = PORTB++;

 cnt = 0;

 }

 }while(1);

}
