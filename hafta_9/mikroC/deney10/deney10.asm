
_main:

;deney10.c,52 :: 		void main() {
;deney10.c,54 :: 		INTCON = 0; // Tüm kesmeler deaktif edilir. (sebebini bilmiyorum dedi)
	CLRF       INTCON+0
;deney10.c,56 :: 		ANSEL = 0x04;
	MOVLW      4
	MOVWF      ANSEL+0
;deney10.c,57 :: 		TRISA = 0x04;
	MOVLW      4
	MOVWF      TRISA+0
;deney10.c,59 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney10.c,61 :: 		Lcd_Init(); //lcd yi baþlat.
	CALL       _Lcd_Init+0
;deney10.c,63 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // lcd deki cursor u kapattýk (yanýp sönen imleç gibi)
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;deney10.c,65 :: 		Lcd_Cmd(_LCD_CLEAR); // lcd nin içeriðini temizliyor.
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;deney10.c,67 :: 		text = "mikroElektronika"; // 16 karakterlik, daha fazla yazarsak ekrana sýðmaz.
	MOVLW      ?lstr1_deney10+0
	MOVWF      _text+0
;deney10.c,69 :: 		Lcd_Out(1,1,text); // ilk satýr ilk sütundan yazdýrmaya baþlayacaðýz.
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;deney10.c,71 :: 		text = "LCD example"; // yeni yazý yazdýk
	MOVLW      ?lstr2_deney10+0
	MOVWF      _text+0
;deney10.c,73 :: 		Lcd_Out(2,1,text); // alt satýrýn ilk sütunundan yazdýrmaya baþlýyoruz.
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;deney10.c,75 :: 		delay_ms(2000); // 2 sn beklesin yazýlar.
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;deney10.c,77 :: 		text = "voltage:";
	MOVLW      ?lstr3_deney10+0
	MOVWF      _text+0
;deney10.c,79 :: 		while(1){
L_main1:
;deney10.c,81 :: 		adc_rd = ADC_Read(2); // 2. kanaldan okuyoruz.
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_rd+0
	MOVF       R0+1, 0
	MOVWF      _adc_rd+1
;deney10.c,83 :: 		Lcd_Out(2,1,text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;deney10.c,91 :: 		tlong = (long)adc_rd * 5 * 1000;
	MOVF       _adc_rd+0, 0
	MOVWF      R0+0
	MOVF       _adc_rd+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVLW      5
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _tlong+0
	MOVF       R0+1, 0
	MOVWF      _tlong+1
	MOVF       R0+2, 0
	MOVWF      _tlong+2
	MOVF       R0+3, 0
	MOVWF      _tlong+3
;deney10.c,94 :: 		tlong = tlong / 1023;
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _tlong+0
	MOVF       R0+1, 0
	MOVWF      _tlong+1
	MOVF       R0+2, 0
	MOVWF      _tlong+2
	MOVF       R0+3, 0
	MOVWF      _tlong+3
;deney10.c,98 :: 		ch = tlong / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _ch+0
;deney10.c,100 :: 		Lcd_Chr(2,9,48+ch); // voltage: 3 (48 ascii 0 a denk geliyor. onun üstüne ch koyarsak ch nin rakam deðeri yazar.)
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;deney10.c,102 :: 		Lcd_Chr_CP('.'); // voltage: 3. (3 ten sonra nokta koymasý için) CP - current position (cursor un bulunduðu yer)
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;deney10.c,106 :: 		ch = (tlong/100)%10;
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _tlong+0, 0
	MOVWF      R0+0
	MOVF       _tlong+1, 0
	MOVWF      R0+1
	MOVF       _tlong+2, 0
	MOVWF      R0+2
	MOVF       _tlong+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
;deney10.c,108 :: 		Lcd_Chr_CP(48+ch); // voltage: 3.7
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;deney10.c,111 :: 		ch = (tlong / 10)%10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _tlong+0, 0
	MOVWF      R0+0
	MOVF       _tlong+1, 0
	MOVWF      R0+1
	MOVF       _tlong+2, 0
	MOVWF      R0+2
	MOVF       _tlong+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
;deney10.c,113 :: 		Lcd_Chr_CP(48+ch); // voltage: 3.74
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;deney10.c,116 :: 		ch = tlong%10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _tlong+0, 0
	MOVWF      R0+0
	MOVF       _tlong+1, 0
	MOVWF      R0+1
	MOVF       _tlong+2, 0
	MOVWF      R0+2
	MOVF       _tlong+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
;deney10.c,118 :: 		Lcd_Chr_CP(48+ch); // voltage: 3.748
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;deney10.c,120 :: 		Lcd_Chr_CP('V');
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;deney10.c,122 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;deney10.c,124 :: 		}
	GOTO       L_main1
;deney10.c,126 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
