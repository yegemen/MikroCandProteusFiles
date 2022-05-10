/*

  Ses �reten Program. MCU'dan gelen sinyale g�re speaker dan ses ��k��� al�nabilir.
  sound ve button k�t�phanesi eklenmeli.
  
  seslerin nas�l �al�naca��n�n ayarlanmas� biraz uzmanl�k gerektiren bi�ey, tam ayarlamad�k biz burda.
*/

void Tone1(){

     Sound_play(659, 250); // 659 Hz lik, 250 ms s�ren ses

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
     
     TRISB = 0xF0; // 1111 = (RB7 RB6 RB5 RB4) , 0000 =  (RB3 RB2 RB1 RB0)

     Sound_Init(&PORTB, 3); // portb nin 3. baca��ndan sesi �ret
     
     //Sound_Init(&PORTA, 4); deney seti i�in �stteki de�il bunu yazd�.
     
     Sound_Play(1000, 500); // 1000 Hz lik frekansa sahip ses, 500 ms boyunca �als�n. program ilk �al��t���nda bip sesi ��kacak.
     
     while(1){
     
        if(Button(&PORTB, 7, 1, 1)) // 7. baca�a bas�l�rsa fon1 i �al.

                          Tone1();

        // Buttona bas�l� tutulursa
        while(PORTB & 0x80); // 1000 0000 & 1000 0000 = 1 ise bekle (sonsuz d�ng�) button dan elimizi �ekene kadar di�er if e gimesin.
        
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