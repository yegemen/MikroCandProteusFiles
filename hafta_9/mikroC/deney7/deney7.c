//library manager de adc k�t�phanesi ekli de�ilse ekliyoruz.

/*

        AN2 (RA2) Baca��ndan analog olarak ayarlanabilir diren� �zerinden gelen voltaj de�erini okuyup,
        ADC vas�tas�yla 10-bit lik dijital de�ere d�n��t�rme. Sonu� PORTD ve PORTB' ye ba�l� LED'ler taraf�ndan g�r�nt�lenir.

*/

unsigned int temp_res;

void main() {

     ANSEL = 0x04; // 000 0100 = RA2 (AN2) analog
     
     TRISA = 0xFF; // A portu tamamen input
     
     ANSELH = 0; // di�erleri dijital olsa da olur.
     
     TRISB = 0x3F; // 0011 1111 = RB6 ve RB7 ��kt�.
     
     TRISD = 0;
     
     do{
     
        temp_res = ADC_Read(2); //hangi kanal� kullanaca��m�z� s�yledik. dijital olarak saklad�k de�eri.
        
        PORTD = temp_res; // 11 (1111 1111)

        PORTB = temp_res >> 2; // (111111 1111) 11 portd ye s��mayan 2 biti sa�a kayd�rarak portb ye yazd�k.
     
     }while(1);
     
     

}