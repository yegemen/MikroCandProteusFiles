#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_3/Deney1.c"
#line 34 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_3/Deney1.c"
int k;

void main()
{
 ANSEL = 0;
 ANSELH= 0;

 PORTB = 0xFF;

 TRISB = 0;

 delay_ms(1000);

 PORTB = 0;

 for(k=0;k<20;k++)
 {
 switch(PORTB)
 {
 case 0x00: PORTB = 0xFF;
 delay_ms(100);
 break;

 case 0xFF: PORTB = 0x00;
 delay_ms(500);
 }
 }

 PORTB = 0b01010101;

 while(1)
 {
 PORTB = ~PORTB;

 delay_ms(200);
 }
}
