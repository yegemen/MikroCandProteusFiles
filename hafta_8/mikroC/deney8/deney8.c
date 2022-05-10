/*

  Deney 8
  
• EEPROM’un adresi 5 olan lokasyonundaki deðeri önce okunup PORTD’ye yazýlýr.

• PORTB’nin deðeri ise RA2’ye baðlý butona her basýldýðýnda bir artacak þekilde program çalýþýr ve 
bu deðer EEPROM’un 5 adresine ve ardýndan PORTD’ye aktarýlýr.

NOT: MCU reset’lendiðinde ne olduðuna dikkat edelim! (simülasyonu sýfýrlayýp tekrar baþlatýnca)

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
     
     //library de ekli deðilse eeprom u eklemeliyiz.
     
     PORTD = EEPROM_Read(5); // 5. adresini okuduk.
     
     do{
     
        PORTB = PORTB++;
        
        delay_ms(1000);
        
        if(PORTA.F2){

                     EEPROM_Write(5, PORTB); // eeprom 5. adresine portb nin deðerini yazdýk.

                     PORTD = EEPROM_Read(5); // portd ye eeprom un 5. adresindeki deðeri atadýk.
                     
                     do;
                     while(PORTA.F2);

        }

     }while(1);

}