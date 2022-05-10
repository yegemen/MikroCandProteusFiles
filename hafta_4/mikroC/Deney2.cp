#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_4/mikroC/Deney2.c"
#line 15 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_4/mikroC/Deney2.c"
int k=0;
char saveBank;

void main() {

 ANSEL = 0;
 ANSELH = 0;

 PORTB = 0;
 TRISB = 0;

 do{

 k++;

 PORTB = ~PORTB;

 delay_ms(100);

 }while(k<20);

 k=0;



 saveBank = STATUS & 0b01100000;

 asm{



 bsf STATUS, RP0
 bcf STATUS, RP1


 bcf OSCCON, 6
 bcf OSCCON, 5
 bcf OSCCON, 4

 bsf OSCCON, 0

 }


 STATUS &= 0b10011111;
 STATUS |= saveBank;

 do{

 PORTB = ~PORTB;

 delay_ms(10);

 k++;

 }while(k<20);

}
