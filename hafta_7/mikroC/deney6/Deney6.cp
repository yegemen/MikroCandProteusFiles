#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_7/mikroC/deney6/Deney6.c"
#line 8 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_7/mikroC/deney6/Deney6.c"
unsigned short current_duty, old_duty;


void initMain(){

 ANSEL = 0;
 ANSELH = 0;

 PORTA = 255;
 TRISA = 255;

 PORTB = 0;
 TRISB = 0;

 PORTC = 0;
 TRISC = 0;


 PWM1_Init(5000);
}

void main() {


 initMain();

 current_duty = 16;

 PWM1_Set_Duty(current_duty);

 old_duty = 0;

 PWM1_Start();

 while(1){

 if(Button(&PORTA, 0, 1, 1)){

 current_duty++;

 }

 if(Button(&PORTA, 1, 1, 1)){

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
