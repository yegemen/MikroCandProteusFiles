
_main:

;deney3.c,17 :: 		void main() {
;deney3.c,19 :: 		char TEST = 5;
	MOVLW      5
	MOVWF      main_TEST_L0+0
;deney3.c,23 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;deney3.c,25 :: 		PORTA = 0;
	CLRF       PORTA+0
;deney3.c,26 :: 		TRISA = 0XFF; // RA4 yani T0CKI baca�� input yap�l�r.
	MOVLW      255
	MOVWF      TRISA+0
;deney3.c,28 :: 		PORTD = 0;
	CLRF       PORTD+0
;deney3.c,29 :: 		TRISD = 0b11110111; // RD3 baca�� output yap�l�r.
	MOVLW      247
	MOVWF      TRISD+0
;deney3.c,31 :: 		OPTION_REG.F5 = 1; // T0CKI baca��ndan clock pulse al�nmas�. (T0CS = 1)
	BSF        OPTION_REG+0, 5
;deney3.c,33 :: 		OPTION_REG.F3 = 1; // Prescaler  WDT'ye atanarak TMR0'�n 1:1 olarak scale edilmesi sa�lan�r (PSA = 1)
	BSF        OPTION_REG+0, 3
;deney3.c,35 :: 		TMR0 = 0; // Timer 0'�n i�eri�i s�f�rlans�n yani 0 de�erinden saymaya ba�layaca��z.
	CLRF       TMR0+0
;deney3.c,37 :: 		do{
L_main0:
;deney3.c,39 :: 		if(TMR0 == TEST){
	MOVF       TMR0+0, 0
	XORWF      main_TEST_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;deney3.c,41 :: 		PORTD.RELAY = 1; // RD4 baca�� 0'dan 1'e de�i�ir ve R�le (Relay) �al���r.
	BSF        PORTD+0, 3
;deney3.c,43 :: 		}
L_main3:
;deney3.c,45 :: 		}while(1);
	GOTO       L_main0
;deney3.c,47 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
