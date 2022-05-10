
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;deney9.c,20 :: 		void interrupt(){
;deney9.c,22 :: 		if(digit_no == 0){ // Birler basamaðý display i çalýþacak.
	MOVF       _digit_no+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;deney9.c,24 :: 		PORTA = 0;
	CLRF       PORTA+0
;deney9.c,26 :: 		PORTD = digit1;
	MOVF       _digit1+0, 0
	MOVWF      PORTD+0
;deney9.c,28 :: 		PORTA = 1; // 01 (RA0'ý aktifleþtir)
	MOVLW      1
	MOVWF      PORTA+0
;deney9.c,30 :: 		digit_no = 1; // Bir sonraki kesmede diðer display çalýþsýn
	MOVLW      1
	MOVWF      _digit_no+0
;deney9.c,32 :: 		}
	GOTO       L_interrupt1
L_interrupt0:
;deney9.c,35 :: 		PORTA = 0;
	CLRF       PORTA+0
;deney9.c,37 :: 		PORTD = digit10;
	MOVF       _digit10+0, 0
	MOVWF      PORTD+0
;deney9.c,39 :: 		PORTA = 2; // 10 (RA1'i aktifleþtirir)
	MOVLW      2
	MOVWF      PORTA+0
;deney9.c,41 :: 		digit_no = 0; // Bir sonraki kesmede diðer display çalýþsýn.
	CLRF       _digit_no+0
;deney9.c,43 :: 		}
L_interrupt1:
;deney9.c,45 :: 		TMR0 = 0;
	CLRF       TMR0+0
;deney9.c,47 :: 		INTCON = 0x20; // Taþma bayraðýný sýfýrla
	MOVLW      32
	MOVWF      INTCON+0
;deney9.c,49 :: 		}
L_end_interrupt:
L__interrupt10:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;deney9.c,51 :: 		void main() {
;deney9.c,53 :: 		OPTION_REG = 0x80; // TMR0 için gerekli
	MOVLW      128
	MOVWF      OPTION_REG+0
;deney9.c,55 :: 		TMR0 = 0;
	CLRF       TMR0+0
;deney9.c,57 :: 		INTCON = 0xA0; // Tüm unmasked kesmeler ile TMR0 kesmesi aktifleþtirilir. (GIE ve T0IE)
	MOVLW      160
	MOVWF      INTCON+0
;deney9.c,59 :: 		PORTA = 0;
	CLRF       PORTA+0
;deney9.c,60 :: 		TRISA = 0;
	CLRF       TRISA+0
;deney9.c,62 :: 		PORTD = 0;
	CLRF       PORTD+0
;deney9.c,63 :: 		TRISD = 0;
	CLRF       TRISD+0
;deney9.c,65 :: 		do{
L_main2:
;deney9.c,67 :: 		for(i=0;i<=99;i++){
	CLRF       _i+0
L_main5:
	MOVF       _i+0, 0
	SUBLW      99
	BTFSS      STATUS+0, 0
	GOTO       L_main6
;deney9.c,69 :: 		digit = i % 10u; // birler basamaðýný aldýk.
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _digit+0
;deney9.c,71 :: 		digit1 = mask(digit);
	MOVF       R0+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      _digit1+0
;deney9.c,73 :: 		digit = (char)(i / 10u) % 10u;                 //bellekte char olarak saklanýyormuþ.
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _digit+0
;deney9.c,75 :: 		digit10 = mask(digit);
	MOVF       R0+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      _digit10+0
;deney9.c,77 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;deney9.c,67 :: 		for(i=0;i<=99;i++){
	INCF       _i+0, 1
;deney9.c,79 :: 		}
	GOTO       L_main5
L_main6:
;deney9.c,81 :: 		}while(1);
	GOTO       L_main2
;deney9.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
