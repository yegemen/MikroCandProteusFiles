#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4v3/Deney4v3.c"
#line 12 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4v3/Deney4v3.c"
unsigned short cnt;

void replace(){

 PORTB = ~PORTB;

}

void interrupt(){



 if(PIR1.TMR2IF)
 {

 cnt++;

 PIR1.TMR2IF = 0;

 TMR2 = 0;

 }

}

void main() {

 cnt = 0;

 ANSEL = 0;
 ANSELH = 0;

 PORTB = 0b10101010;
 TRISB = 0;

 T2CON = 0xFF;


 PIE1.TMR2IE = 1;
 INTCON = 0xC0;

 while(1){

 if(cnt == 30){

 cnt = 0;

 replace();

 }

 }

}
