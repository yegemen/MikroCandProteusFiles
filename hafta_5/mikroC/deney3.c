  /*
  
  Deney 3:
  
  � �imdiye kadar yapt���m�z deneylerden farkl� olarak d��ar�dan MCU�ya bir buton ba�lanarak girdi (input) alaca��z.
  � �o�u MCU uygulamas�nda bu �ekilde girdiler sens�rlerden al�n�r.
  � Butona her bas�ld���nda sayma i�lemi ger�ekle�ecek.
  � Yani TMR0�yu say�c� (counter) olarak kullanaca��z.
  � Dolay�s�yla butona her bas�ld���nda TMR0 bir darbeyi (pulse) sayacak.
  � Say�lan de�er 5�e ula�t���nda MCU�ya ba�l� bir R�LE�yi aktifle�tirecek.
  � Sim�lasyondan elde edilen sonucun g�rselli�ini art�rmak i�in r�le bir
    lambay� �al��t�racak �ekilde ba�land� ve lamban�n yanmas� sa�land�.
  
  */


void main() {

     char TEST = 5;
     
     enum outputs {RELAY = 3}; // HEATER = 4, PUMP = 7 etc.

     ANSEL = ANSELH = 0;
     
     PORTA = 0;
     TRISA = 0XFF; // RA4 yani T0CKI baca�� input yap�l�r.
     
     PORTD = 0;
     TRISD = 0b11110111; // RD3 baca�� output yap�l�r.
     
     OPTION_REG.F5 = 1; // T0CKI baca��ndan clock pulse al�nmas�. (T0CS = 1)
     
     OPTION_REG.F3 = 1; // Prescaler  WDT'ye atanarak TMR0'�n 1:1 olarak scale edilmesi sa�lan�r (PSA = 1)
     
     TMR0 = 0; // Timer 0'�n i�eri�i s�f�rlans�n yani 0 de�erinden saymaya ba�layaca��z.
     
     do{
     
        if(TMR0 == TEST){
        
                PORTD.RELAY = 1; // RD4 baca�� 0'dan 1'e de�i�ir ve R�le (Relay) �al���r.
                
        }
     
     }while(1);

}