  /*

  MCU: PIC16F887
  OSC: 8Mhz

  */

unsigned short current_duty, old_duty;


void initMain(){//bir programýn ayarlarýný yapmak

     ANSEL = 0;
     ANSELH = 0;
     
     PORTA = 255; // 1111 1111 yani RA0 ve RA1'in
     TRISA = 255; // girdi olarak ayarlanmasý

     PORTB = 0; // Duty-Cycle deðeri bu 8-bit olarak
     TRISB = 0; //gösterilecek.
     
     PORTC = 0; // CCP1 (RC2) bacaðýndan PWM sinyali
     TRISC = 0; // dýþarýya verilecek.
     
     //saðda library manager de pwm seçili deðilse seçiyoruz.
     PWM1_Init(5000); // 5KHz'lik sinyal üretilecek. ccp1 olduðu için pwm1 yazdýk. ccp2 olsa pwm2 yazmalýydýk.
}

void main() {


     initMain();
     
     current_duty = 16;
     
     PWM1_Set_Duty(current_duty);
     
     old_duty = 0;
     
     PWM1_Start(); // CCP1 bacaðýndan PWM sinyali üretmeye baþlayalým

     while(1){
     
              if(Button(&PORTA, 0, 1, 1)){ // RA0'a basýldýysa (0 0. bacak demek, 1 1ms kontrol yapýlsýn, 1 butona basýldýðý anda lojik 1 olsun)
              
              current_duty++;
              
              }

              if(Button(&PORTA, 1, 1, 1)){ // RA1'e basýldýysa
              
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