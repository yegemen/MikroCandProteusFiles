#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_8/mikroC/deney8/deney8.c"
#line 17 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_8/mikroC/deney8/deney8.c"
void main() {

 ANSEL = 0;
 ANSELH = 0;

 PORTB = 0;
 TRISB = 0;

 PORTD = 0;
 TRISD = 0;

 TRISA = 0XFF;



 PORTD = EEPROM_Read(5);

 do{

 PORTB = PORTB++;

 delay_ms(1000);

 if(PORTA.F2){

 EEPROM_Write(5, PORTB);

 PORTD = EEPROM_Read(5);

 do;
 while(PORTA.F2);

 }

 }while(1);

}
