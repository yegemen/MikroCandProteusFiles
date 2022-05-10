  /*

  MCU: PIC16F887
  OSC: 8Mhz

  */

unsigned short current_duty, old_duty;


void initMain(){//bir program�n ayarlar�n� yapmak

     ANSEL = 0;
     ANSELH = 0;
     
     PORTA = 255; // 1111 1111 yani RA0 ve RA1'in
     TRISA = 255; // girdi olarak ayarlanmas�

     PORTB = 0; // Duty-Cycle de�eri bu 8-bit olarak
     TRISB = 0; //g�sterilecek.
     
     PORTC = 0; // CCP1 (RC2) baca��ndan PWM sinyali
     TRISC = 0; // d��ar�ya verilecek.
     
     //sa�da library manager de pwm se�ili de�ilse se�iyoruz.
     PWM1_Init(5000); // 5KHz'lik sinyal �retilecek. ccp1 oldu�u i�in pwm1 yazd�k. ccp2 olsa pwm2 yazmal�yd�k.
}

void main() {


     initMain();
     
     current_duty = 16;
     
     PWM1_Set_Duty(current_duty);
     
     old_duty = 0;
     
     PWM1_Start(); // CCP1 baca��ndan PWM sinyali �retmeye ba�layal�m

     while(1){
     
              if(Button(&PORTA, 0, 1, 1)){ // RA0'a bas�ld�ysa (0 0. bacak demek, 1 1ms kontrol yap�ls�n, 1 butona bas�ld��� anda lojik 1 olsun)
              
              current_duty++;
              
              }

              if(Button(&PORTA, 1, 1, 1)){ // RA1'e bas�ld�ysa
              
              current_duty--;
              
              }
              
              if(old_duty != current_duty){
                          
                          PWM1_Set_Duty(current_duty);
                          
                          old_duty = current_duty;
                          
                          PORTB = old_duty;
                          
              }
              
              delay_ms(200);
     }

}