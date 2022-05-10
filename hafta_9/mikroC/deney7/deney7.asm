
_main:

;deney7.c,12 :: 		void main() {
;deney7.c,14 :: 		ANSEL = 0x04; // 000 0100 = RA2 (AN2) analog
	MOVLW      4
	MOVWF      ANSEL+0
;deney7.c,16 :: 		TRISA = 0xFF; // A portu tamamen input
	MOVLW      255
	MOVWF      TRISA+0
;deney7.c,18 :: 		ANSELH = 0; // diðerleri dijital olsa da olur.
	CLRF       ANSELH+0
;deney7.c,20 :: 		TRISB = 0x3F; // 0011 1111 = RB6 ve RB7 çýktý.
	MOVLW      63
	MOVWF      TRISB+0
;deney7.c,22 :: 		TRISD = 0;
	CLRF       TRISD+0
;deney7.c,24 :: 		do{
L_main0:
;deney7.c,26 :: 		temp_res = ADC_Read(2); //hangi kanalý kullanacaðýmýzý söyledik. dijital olarak sakladýk deðeri.
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _temp_res+0
	MOVF       R0+1, 0
	MOVWF      _temp_res+1
;deney7.c,28 :: 		PORTD = temp_res; // 11 (1111 1111)
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;deney7.c,30 :: 		PORTB = temp_res >> 2; // (111111 1111) 11 portd ye sýðmayan 2 biti saða kaydýrarak portb ye yazdýk.
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	MOVF       R2+0, 0
	MOVWF      PORTB+0
;deney7.c,32 :: 		}while(1);
	GOTO       L_main0
;deney7.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
