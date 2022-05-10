#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_7/mikroC/deney5/Deney5.c"
#line 8 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_7/mikroC/deney5/Deney5.c"
void main() {

 OPTION_REG = 0x0E;

 asm CLRWDT;

 PORTB = 0x0F;
 TRISB = 0;

 delay_ms(300);

 PORTB = 0xF0;

 while(1);


}
