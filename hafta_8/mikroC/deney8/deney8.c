/*

  Deney 8
  
� EEPROM�un adresi 5 olan lokasyonundaki de�eri �nce okunup PORTD�ye yaz�l�r.

� PORTB�nin de�eri ise RA2�ye ba�l� butona her bas�ld���nda bir artacak �ekilde program �al���r ve 
bu de�er EEPROM�un 5 adresine ve ard�ndan PORTD�ye aktar�l�r.

NOT: MCU reset�lendi�inde ne oldu�una dikkat edelim! (sim�lasyonu s�f�rlay�p tekrar ba�lat�nca)

MCU: PIC16F887
OSC: 8MHz

*/

void main() {

     ANSEL = 0;
     ANSELH = 0;
     
     PORTB = 0;
     TRISB = 0;
     
     PORTD = 0;
     TRISD = 0;
     
     TRISA = 0XFF;
     
     //library de ekli de�ilse eeprom u eklemeliyiz.
     
     PORTD = EEPROM_Read(5); // 5. adresini okuduk.
     
     do{
     
        PORTB = PORTB++;
        
        delay_ms(1000);
        
        if(PORTA.F2){

                     EEPROM_Write(5, PORTB); // eeprom 5. adresine portb nin de�erini yazd�k.

                     PORTD = EEPROM_Read(5); // portd ye eeprom un 5. adresindeki de�eri atad�k.
                     
                     do;
                     while(PORTA.F2);

        }

     }while(1);

}