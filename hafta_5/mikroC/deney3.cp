#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_5/mikroC/deney3.c"
#line 17 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_5/mikroC/deney3.c"
void main() {

 char TEST = 5;

 enum outputs {RELAY = 3};

 ANSEL = ANSELH = 0;

 PORTA = 0;
 TRISA = 0XFF;

 PORTD = 0;
 TRISD = 0b11110111;

 OPTION_REG.F5 = 1;

 OPTION_REG.F3 = 1;

 TMR0 = 0;

 do{

 if(TMR0 == TEST){

 PORTD.RELAY = 1;

 }

 }while(1);

}
