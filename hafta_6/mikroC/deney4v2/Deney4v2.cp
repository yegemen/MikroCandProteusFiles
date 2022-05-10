#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4v2/Deney4v2.c"
#line 10 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_6/mikroC/deney4v2/Deney4v2.c"
unsigned short cnt;

void interrupt(){

 cnt++;

 PIR1.TMR1IF = 0;

 TMR1H = 0x80;
 TMR1L = 0x00;

}

void main() {

 ANSEL = 0;
 ANSELH = 0;

 PORTB = 0xF0;
 TRISB = 0;

 T1CON = 1;

 PIR1.TMR1IF = 0;


 TMR1H = 0x80;
 TMR1L = 0x00;

 PIE1.TMR1IE = 1;

 cnt = 0;

 INTCON = 0xC0;

 do{

 if(cnt == 76){

 PORTB = ~PORTB;

 cnt = 0;
 }

 }
 while(1);
}
