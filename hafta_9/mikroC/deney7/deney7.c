//library manager de adc kütüphanesi ekli deðilse ekliyoruz.

/*

        AN2 (RA2) Bacaðýndan analog olarak ayarlanabilir direnç üzerinden gelen voltaj deðerini okuyup,
        ADC vasýtasýyla 10-bit lik dijital deðere dönüþtürme. Sonuç PORTD ve PORTB' ye baðlý LED'ler tarafýndan görüntülenir.

*/

unsigned int temp_res;

void main() {

     ANSEL = 0x04; // 000 0100 = RA2 (AN2) analog
     
     TRISA = 0xFF; // A portu tamamen input
     
     ANSELH = 0; // diðerleri dijital olsa da olur.
     
     TRISB = 0x3F; // 0011 1111 = RB6 ve RB7 çýktý.
     
     TRISD = 0;
     
     do{
     
        temp_res = ADC_Read(2); //hangi kanalý kullanacaðýmýzý söyledik. dijital olarak sakladýk deðeri.
        
        PORTD = temp_res; // 11 (1111 1111)

        PORTB = temp_res >> 2; // (111111 1111) 11 portd ye sýðmayan 2 biti saða kaydýrarak portb ye yazdýk.
     
     }while(1);
     
     

}