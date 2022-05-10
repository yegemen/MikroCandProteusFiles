#line 1 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_10/mikroC/deney13/deney13.c"
#line 9 "D:/2020-2021 Güz/Mikroiþlemcili Sistemler/hafta_10/mikroC/deney13/deney13.c"
void Tone1(){

 Sound_play(659, 250);

}

void Tone2(){

 Sound_play(698, 250);

}

void Tone3(){

 Sound_play(784, 250);

}

void melody1(){

 Tone1(); Tone2(); Tone3(); Tone3();

 Tone1(); Tone2(); Tone3(); Tone3();

 Tone1(); Tone2(); Tone3();

 Tone1(); Tone2(); Tone3(); Tone3();

 Tone1(); Tone2(); Tone3();

 Tone3(); Tone3(); Tone2(); Tone2(); Tone1();

}

void ToneA(){

 Sound_play(880, 50);

}
void ToneB(){

 Sound_play(1046, 50);

}
void ToneC(){

 Sound_play(1318, 50);

}

void melody2(){

 unsigned short i;

 for(i=9; i>0; i--)
 {
 ToneA(); ToneB(); ToneC();
 }

}

void main() {

 ANSEL = 0;
 ANSELH = 0;

 TRISB = 0xF0;

 Sound_Init(&PORTB, 3);



 Sound_Play(1000, 500);

 while(1){

 if(Button(&PORTB, 7, 1, 1))

 Tone1();


 while(PORTB & 0x80);

 if(Button(&PORTB, 6, 1, 1))
 Tone2();

 while(PORTB & 0x40);

 if(Button(&PORTB, 5, 1, 1))
 Melody2();

 while(PORTB & 0x20);

 if(Button(&PORTB, 4, 1, 1))
 Melody1();

 while(PORTB & 0x10);


 }
}
