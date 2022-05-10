/*

GLCD Display �zerinde baz� �izimler, yaz�lar ve resim g�sterilmesi.

MCU: PIC16F887

GLCD k�t�phanesi ekli olmal�.

*/

//#define UNI-DS6

const code char truck_bmp[1024];

char GLCD_Dataport at PORTD;  // PORTD ye y�nlendiriyoruz.
         /*
//#ifdef UNI_DS6

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS at RB2_bit;
sbit GLCD_RW at RB3_bit;
sbit GLCD_EN at RB5_bit;
sbit GLCD_RST at RB4_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB5_bit;
sbit GLCD_RST_Direction at TRISB4_bit;
                                      */
// Proteus i�in

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS at RB2_bit;
sbit GLCD_RW at RB3_bit;
sbit GLCD_EN at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;



void delay2S(){
 delay_ms(2000);
}

unsigned short ii;

char *someText;

void main() {

     ANSEL = 0;
     ANSELH = 0;

     c1ON_bit = 0;
     c2ON_bit = 0; //bu bitleri disable etmemiz gerekiyormu�.

     Glcd_Init();
     Glcd_Fill(0x00); // ekran� temizledik.

     while(1){

              Glcd_Image(truck_bmp);

              delay2S(); delay2S();

              Glcd_Fill(0x00);    // kamyon resmi 4 saniye bekledikten sonra ekran temizlenir.

              Glcd_Box(62,40,124,54,1); // S�n�rlar� (62,40) dan ba�lay�p
                                        // (124,54) de biten i�i dolu siyah bir kutu �iz.   0 beyaz 1 siyah 2 tersine �evir.

              Glcd_Rectangle(5,5,84,35,1); // i�i bo� dikd�rtgen, 5 e 5 ile 84 e 35 aras�na �iz. 1 siyah.

              Glcd_Line(0,0,127,63,1); // �izgi. 0 a 0 dan ba�lay�p 127 ye 63 te biten. 1 siyah.

              delay2S();

              for(ii=5;ii<60;ii+=5)
              {

               delay_ms(250);

               Glcd_V_Line(2,54,ii,1); // yatay �izgi �iziyoruz. x koordinat�m�z sabit, y koordinat�m�z de�i�ken.

               Glcd_H_Line(2,129,ii,1); // dikay �izgi �iziyoruz.

              }

              delay2S();

              Glcd_Fill(0x00);

              Glcd_Set_Font(Character8x7, 8, 7, 32);  // 8 e 7 lik karakter, son de�eri offset de�eri.

              Glcd_Write_Text("mikroE", 1, 7, 2); // mikroe yaz�s�, x koordinat�, y koordinat�, zeminin tersi renginde.

              for(ii=1; ii<=10; ii++) Glcd_Circle(63,32,3*ii,1); // koordinat� 63 e 32 olan �ap� 3*ii olan ve siyah daire.

              delay2S();

              Glcd_Box(12,20,70,57,2);  // i�i dolu kutu, rengi ters olacak.

              delay2S();

              Glcd_Fill(0xFF);

              Glcd_Set_Font(Character8x7, 8, 7, 32);

              someText = "8x7 Font";

              Glcd_Write_Text(someText, 5, 0, 2); // someText i�eri�i 5 e 0 a yaz�lacak. ters renkte.

              delay2S();

              Glcd_Set_Font(System3x5, 3, 5, 32); //system3x5 yaz� tipi. bunlar glcd k�t�phanesinde belli.

              someText = "3X5 CAPITALS ONLY";

              Glcd_Write_Text(someText, 60, 2, 2);

              delay2S();

              Glcd_Set_Font(font5x7, 5, 7, 12);

              someText = "5x7 Font";

              Glcd_Write_Text(SomeText, 5, 4, 2);

              delay2S();

              Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32);

              someText = "5x7 Font (v2)";

              Glcd_Write_Text(someText, 5, 6, 2);

              delay2S();

     }

}