
_CopyConst2Ram:

;deney15.c,40 :: 		char *CopyConst2Ram(char *dest, const char *src)
;deney15.c,43 :: 		for(;;*dest++ = *src++); //ilk 0 elemaný aktarýr devam eder
L_CopyConst2Ram0:
	MOVF       FARG_CopyConst2Ram_src+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_CopyConst2Ram_src+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       FARG_CopyConst2Ram_dest+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FARG_CopyConst2Ram_dest+0, 1
	INCF       FARG_CopyConst2Ram_src+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_CopyConst2Ram_src+1, 1
	GOTO       L_CopyConst2Ram0
;deney15.c,46 :: 		}
L_end_CopyConst2Ram:
	RETURN
; end of _CopyConst2Ram

_GetX:

;deney15.c,50 :: 		unsigned int GetX(){
;deney15.c,52 :: 		PORTC.F0 = 1; // DRIVEA aktifleþtirilir.
	BSF        PORTC+0, 0
;deney15.c,54 :: 		PORTC.F1 = 0; // DRIVEB deaktif edilir.
	BCF        PORTC+0, 1
;deney15.c,56 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_GetX3:
	DECFSZ     R13+0, 1
	GOTO       L_GetX3
	DECFSZ     R12+0, 1
	GOTO       L_GetX3
	NOP
	NOP
;deney15.c,58 :: 		return ADC_read(0); // B Panelinden RA0 dan analog okunur.(Channel0=RA0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;deney15.c,60 :: 		}
L_end_GetX:
	RETURN
; end of _GetX

_GetY:

;deney15.c,62 :: 		unsigned int GetY(){
;deney15.c,64 :: 		PORTC.F0 = 0; // DRIVEA aktifleþtirilir.
	BCF        PORTC+0, 0
;deney15.c,66 :: 		PORTC.F1 = 1; // DRIVEB deaktif edilir.
	BSF        PORTC+0, 1
;deney15.c,68 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_GetY4:
	DECFSZ     R13+0, 1
	GOTO       L_GetY4
	DECFSZ     R12+0, 1
	GOTO       L_GetY4
	NOP
	NOP
;deney15.c,70 :: 		return ADC_read(1); // A Panelinden RA1 den analog okunur.(Channel1=RA1)
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;deney15.c,72 :: 		}
L_end_GetY:
	RETURN
; end of _GetY

_main:

;deney15.c,74 :: 		void main() {
;deney15.c,78 :: 		ANSEL = 0x03; // 0000 0011 (RA0 ve RA1 analog input)
	MOVLW      3
	MOVWF      ANSEL+0
;deney15.c,79 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney15.c,82 :: 		PORTC = 0;
	CLRF       PORTC+0
;deney15.c,83 :: 		TRISC = 0;
	CLRF       TRISC+0
;deney15.c,85 :: 		PORTA = 0;
	CLRF       PORTA+0
;deney15.c,86 :: 		TRISA = 0x03; // RA0 ve RA1'i input olarak ayarladýk.
	MOVLW      3
	MOVWF      TRISA+0
;deney15.c,88 :: 		Glcd_Init();
	CALL       _Glcd_Init+0
;deney15.c,90 :: 		Glcd_Set_Font(FontSystem5x7_v2, 5, 7, 32); //yazý tipi
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
;deney15.c,92 :: 		Glcd_Fill(0); // ekraný temizledik
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;deney15.c,96 :: 		CopyConst2Ram(msg, msg1); // hedef, kaynak
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg1+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg1+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,97 :: 		Glcd_Write_Text(msg, 10, 0, 1); // msj ve koordinat. mesajýn yazýlacaðý x koordinatý, page numarasý 0 en üst satýra, ve siyah
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      10
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	CLRF       FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,101 :: 		CopyConst2Ram(msg, msg2);
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg2+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg2+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,102 :: 		Glcd_Write_Text(msg, 17, 7, 1);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      17
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      7
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,105 :: 		Glcd_Rectangle(8, 16, 60, 48, 1);
	MOVLW      8
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      16
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      60
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      48
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;deney15.c,106 :: 		Glcd_Box(10, 18, 58, 46, 1);
	MOVLW      10
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      18
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      58
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      46
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;deney15.c,109 :: 		Glcd_Rectangle(68, 16, 120, 48, 1);
	MOVLW      68
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      16
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      120
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      48
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;deney15.c,110 :: 		Glcd_Box(70, 18, 118, 46, 1);
	MOVLW      70
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      18
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      118
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      46
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;deney15.c,112 :: 		CopyConst2Ram(msg, msg3); // "BUTTON 1" yazýsý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg3+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg3+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,113 :: 		Glcd_Write_Text(msg, 14, 3, 0); // beyaz yazýlacak
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      14
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,115 :: 		CopyConst2Ram(msg, msg5); // "RC6 OFF" yazýsý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg5+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg5+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,116 :: 		Glcd_Write_Text(msg, 14, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      14
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,118 :: 		CopyConst2Ram(msg, msg3); // "BUTTON 2" yazýsý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg3+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg3+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,119 :: 		Glcd_Write_Text(msg, 74, 3, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      74
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,121 :: 		CopyConst2Ram(msg, msg5); // "RC7 OFF" yazýsý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg5+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg5+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,122 :: 		Glcd_Write_Text(msg, 74, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      74
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,125 :: 		while(1)
L_main5:
;deney15.c,128 :: 		x_coord = GetX();
	CALL       _GetX+0
	MOVF       R0+0, 0
	MOVWF      _x_coord+0
	MOVF       R0+1, 0
	MOVWF      _x_coord+1
	CLRF       _x_coord+2
	CLRF       _x_coord+3
;deney15.c,129 :: 		y_coord = GetY();
	CALL       _GetY+0
	MOVF       R0+0, 0
	MOVWF      _y_coord+0
	MOVF       R0+1, 0
	MOVWF      _y_coord+1
	CLRF       _y_coord+2
	CLRF       _y_coord+3
;deney15.c,131 :: 		x_coord128 = (x_coord * 128) / 1024;
	MOVLW      7
	MOVWF      R4+0
	MOVF       _x_coord+0, 0
	MOVWF      R0+0
	MOVF       _x_coord+1, 0
	MOVWF      R0+1
	MOVF       _x_coord+2, 0
	MOVWF      R0+2
	MOVF       _x_coord+3, 0
	MOVWF      R0+3
	MOVF       R4+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L__main24
	RLF        R0+0, 1
	RLF        R0+1, 1
	RLF        R0+2, 1
	RLF        R0+3, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main23
L__main24:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      4
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVF       FLOC__main+0, 0
	MOVWF      _x_coord128+0
	MOVF       FLOC__main+1, 0
	MOVWF      _x_coord128+1
	MOVF       FLOC__main+2, 0
	MOVWF      _x_coord128+2
	MOVF       FLOC__main+3, 0
	MOVWF      _x_coord128+3
;deney15.c,132 :: 		y_coord64 = 64 - ((y_coord*64) / 1024);
	MOVLW      6
	MOVWF      R4+0
	MOVF       _y_coord+0, 0
	MOVWF      R0+0
	MOVF       _y_coord+1, 0
	MOVWF      R0+1
	MOVF       _y_coord+2, 0
	MOVWF      R0+2
	MOVF       _y_coord+3, 0
	MOVWF      R0+3
	MOVF       R4+0, 0
L__main25:
	BTFSC      STATUS+0, 2
	GOTO       L__main26
	RLF        R0+0, 1
	RLF        R0+1, 1
	RLF        R0+2, 1
	RLF        R0+3, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main25
L__main26:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      4
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVLW      64
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       R4+0, 0
	MOVWF      _y_coord64+0
	MOVF       R4+1, 0
	MOVWF      _y_coord64+1
	MOVF       R4+2, 0
	MOVWF      _y_coord64+2
	MOVF       R4+3, 0
	MOVWF      _y_coord64+3
	MOVF       R0+0, 0
	SUBWF      _y_coord64+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      _y_coord64+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      _y_coord64+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      _y_coord64+3, 1
;deney15.c,135 :: 		if((x_coord128 >= 10) && (x_coord128 <= 58) && (y_coord64 >= 18) && (y_coord64 <= 46)){
	MOVLW      128
	XORWF      FLOC__main+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      0
	SUBWF      FLOC__main+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      0
	SUBWF      FLOC__main+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      10
	SUBWF      FLOC__main+0, 0
L__main27:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x_coord128+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVF       _x_coord128+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVF       _x_coord128+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVF       _x_coord128+0, 0
	SUBLW      58
L__main28:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	XORWF      _y_coord64+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      0
	SUBWF      _y_coord64+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      0
	SUBWF      _y_coord64+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      18
	SUBWF      _y_coord64+0, 0
L__main29:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _y_coord64+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVF       _y_coord64+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVF       _y_coord64+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVF       _y_coord64+0, 0
	SUBLW      46
L__main30:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
L__main18:
;deney15.c,137 :: 		if(PORTC.F6 == 0){ // RC6 ya baðlý led sönük ise
	BTFSC      PORTC+0, 6
	GOTO       L_main10
;deney15.c,139 :: 		PORTC.F6 = 1; // RC6 ya baðlý led yansýn
	BSF        PORTC+0, 6
;deney15.c,141 :: 		CopyConst2Ram(msg, msg7); // "RC6 ON" mesajý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg7+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg7+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,143 :: 		Glcd_Write_Text(msg, 14, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      14
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,145 :: 		}
	GOTO       L_main11
L_main10:
;deney15.c,148 :: 		PORTC.F6 = 0; // RC6 ya baðlý led sönsün
	BCF        PORTC+0, 6
;deney15.c,150 :: 		CopyConst2Ram(msg, msg5); // "RC6 OFF" mesajý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg5+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg5+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,152 :: 		Glcd_Write_Text(msg, 14, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      14
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,154 :: 		}
L_main11:
;deney15.c,156 :: 		}
L_main9:
;deney15.c,159 :: 		if((x_coord128 >= 70) && (x_coord128 <= 118) && (y_coord64 >= 18) && (y_coord64 <= 46)){
	MOVLW      128
	XORWF      _x_coord128+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      0
	SUBWF      _x_coord128+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      0
	SUBWF      _x_coord128+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      70
	SUBWF      _x_coord128+0, 0
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x_coord128+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _x_coord128+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _x_coord128+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _x_coord128+0, 0
	SUBLW      118
L__main32:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
	MOVLW      128
	XORWF      _y_coord64+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      0
	SUBWF      _y_coord64+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      0
	SUBWF      _y_coord64+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      18
	SUBWF      _y_coord64+0, 0
L__main33:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _y_coord64+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       _y_coord64+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       _y_coord64+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       _y_coord64+0, 0
	SUBLW      46
L__main34:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
L__main17:
;deney15.c,161 :: 		if(PORTC.F7 == 0){ // RC7 ye baðlý led sönük ise
	BTFSC      PORTC+0, 7
	GOTO       L_main15
;deney15.c,163 :: 		PORTC.F6 = 1; // RC7 ye baðlý led yansýn
	BSF        PORTC+0, 6
;deney15.c,165 :: 		CopyConst2Ram(msg, msg8); // "RC7 ON" mesajý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg8+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg8+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,167 :: 		Glcd_Write_Text(msg, 74, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      74
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,169 :: 		}
	GOTO       L_main16
L_main15:
;deney15.c,172 :: 		PORTC.F7 = 0; // RC7 ye baðlý led sönsün
	BCF        PORTC+0, 7
;deney15.c,174 :: 		CopyConst2Ram(msg, msg6); // "RC7 OFF" mesajý
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _msg6+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_msg6+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
;deney15.c,176 :: 		Glcd_Write_Text(msg, 74, 4, 0);
	MOVLW      _msg+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      74
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	CLRF       FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;deney15.c,178 :: 		}
L_main16:
;deney15.c,180 :: 		}
L_main14:
;deney15.c,182 :: 		}
	GOTO       L_main5
;deney15.c,185 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
