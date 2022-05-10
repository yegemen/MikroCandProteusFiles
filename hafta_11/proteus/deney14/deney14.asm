
_delay2S:

;deney14.c,51 :: 		void delay2S(){
;deney14.c,52 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_delay2S0:
	DECFSZ     R13+0, 1
	GOTO       L_delay2S0
	DECFSZ     R12+0, 1
	GOTO       L_delay2S0
	DECFSZ     R11+0, 1
	GOTO       L_delay2S0
	NOP
;deney14.c,53 :: 		}
L_end_delay2S:
	RETURN
; end of _delay2S

_main:

;deney14.c,59 :: 		void main() {
;deney14.c,61 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;deney14.c,62 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney14.c,64 :: 		c1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;deney14.c,65 :: 		c2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;deney14.c,67 :: 		Glcd_Init();
	CALL       _Glcd_Init+0
;deney14.c,68 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;deney14.c,70 :: 		while(1){
L_main1:
;deney14.c,72 :: 		Glcd_Image(truck_bmp);
	MOVLW      _truck_bmp+0
	MOVWF      FARG_Glcd_Image_image+0
	MOVLW      hi_addr(_truck_bmp+0)
	MOVWF      FARG_Glcd_Image_image+1
	CALL       _Glcd_Image+0
;deney14.c,74 :: 		delay2S(); delay2S();
	CALL       _delay2S+0
	CALL       _delay2S+0
;deney14.c,76 :: 		Glcd_Fill(0x00);    // kamyon resmi 4 saniye bekledikten sonra ekran temizlenir.
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;deney14.c,78 :: 		Glcd_Box(62,40,124,54,1); // Sýnýrlarý (62,40) dan baþlayýp
	MOVLW      62
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      40
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      124
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      54
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;deney14.c,81 :: 		Glcd_Rectangle(5,5,84,35,1); // içi boþ
	MOVLW      5
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      5
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      84
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      35
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;deney14.c,83 :: 		Glcd_Line(0,0,127,63,1); // Çizgi
	CLRF       FARG_Glcd_Line_x_start+0
	CLRF       FARG_Glcd_Line_x_start+1
	CLRF       FARG_Glcd_Line_y_start+0
	CLRF       FARG_Glcd_Line_y_start+1
	MOVLW      127
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVLW      63
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_y_end+1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
;deney14.c,85 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,87 :: 		for(ii=5;ii<60;ii+=5)
	MOVLW      5
	MOVWF      _ii+0
L_main3:
	MOVLW      60
	SUBWF      _ii+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;deney14.c,90 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;deney14.c,92 :: 		Glcd_V_Line(2,54,ii,1);
	MOVLW      2
	MOVWF      FARG_Glcd_V_Line_y_start+0
	MOVLW      54
	MOVWF      FARG_Glcd_V_Line_y_end+0
	MOVF       _ii+0, 0
	MOVWF      FARG_Glcd_V_Line_x_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_V_Line_color+0
	CALL       _Glcd_V_Line+0
;deney14.c,94 :: 		Glcd_H_Line(2,129,ii,1);
	MOVLW      2
	MOVWF      FARG_Glcd_H_Line_x_start+0
	MOVLW      129
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVF       _ii+0, 0
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;deney14.c,87 :: 		for(ii=5;ii<60;ii+=5)
	MOVLW      5
	ADDWF      _ii+0, 1
;deney14.c,96 :: 		}
	GOTO       L_main3
L_main4:
;deney14.c,98 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,100 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;deney14.c,102 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);
	MOVLW      _Character8x7+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_Character8x7+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      8
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      7
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      32
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;deney14.c,104 :: 		Glcd_Write_Text("mikroE", 1, 7, 2);
	MOVLW      ?lstr1_deney14+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      7
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney14.c,106 :: 		for(ii=1; ii<=10; ii++) Glcd_Circle(63,32,3*ii,1);
	MOVLW      1
	MOVWF      _ii+0
L_main7:
	MOVF       _ii+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_main8
	MOVLW      63
	MOVWF      FARG_Glcd_Circle_x_center+0
	MOVLW      0
	MOVWF      FARG_Glcd_Circle_x_center+1
	MOVLW      32
	MOVWF      FARG_Glcd_Circle_y_center+0
	MOVLW      0
	MOVWF      FARG_Glcd_Circle_y_center+1
	MOVLW      3
	MOVWF      R0+0
	MOVF       _ii+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_Glcd_Circle_radius+0
	MOVF       R0+1, 0
	MOVWF      FARG_Glcd_Circle_radius+1
	MOVLW      1
	MOVWF      FARG_Glcd_Circle_color+0
	CALL       _Glcd_Circle+0
	INCF       _ii+0, 1
	GOTO       L_main7
L_main8:
;deney14.c,108 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,110 :: 		Glcd_Box(12,20,70,57,2);
	MOVLW      12
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      20
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      70
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      57
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      2
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;deney14.c,112 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,114 :: 		Glcd_Fill(0xFF);
	MOVLW      255
	MOVWF      FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;deney14.c,116 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);
	MOVLW      _Character8x7+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_Character8x7+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      8
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      7
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      32
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;deney14.c,118 :: 		someText = "8x7 Font";
	MOVLW      ?lstr2_deney14+0
	MOVWF      _someText+0
;deney14.c,120 :: 		Glcd_Write_Text(someText, 5, 0, 2);
	MOVF       _someText+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      5
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	CLRF       FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney14.c,122 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,124 :: 		Glcd_Set_Font(System3x5, 3, 5, 32);
	MOVLW      _System3x5+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_System3x5+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      3
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      5
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      32
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;deney14.c,126 :: 		someText = "3X5 CAPITALS ONLY";
	MOVLW      ?lstr3_deney14+0
	MOVWF      _someText+0
;deney14.c,128 :: 		Glcd_Write_Text(someText, 60, 2, 2);
	MOVF       _someText+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      60
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney14.c,130 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,132 :: 		Glcd_Set_Font(font5x7, 5, 7, 12);
	MOVLW      _font5x7+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_font5x7+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      5
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      7
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      12
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;deney14.c,134 :: 		someText = "5x7 Font";
	MOVLW      ?lstr4_deney14+0
	MOVWF      _someText+0
;deney14.c,136 :: 		Glcd_Write_Text(SomeText, 5, 4, 2);
	MOVF       _someText+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      5
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney14.c,138 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,140 :: 		Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32);
	MOVLW      _FontSystem5x7_v2+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_FontSystem5x7_v2+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      5
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      7
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      32
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;deney14.c,142 :: 		someText = "5x7 Font (v2)";
	MOVLW      ?lstr5_deney14+0
	MOVWF      _someText+0
;deney14.c,144 :: 		Glcd_Write_Text(someText, 5, 6, 2);
	MOVF       _someText+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      5
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      6
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney14.c,146 :: 		delay2S();
	CALL       _delay2S+0
;deney14.c,148 :: 		}
	GOTO       L_main1
;deney14.c,150 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
