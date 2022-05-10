
_main:

;Deney2.c,18 :: 		void main() {
;Deney2.c,20 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Deney2.c,21 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Deney2.c,23 :: 		PORTB = 0;
	CLRF       PORTB+0
;Deney2.c,24 :: 		TRISB = 0;
	CLRF       TRISB+0
;Deney2.c,26 :: 		do{
L_main0:
;Deney2.c,28 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;Deney2.c,30 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Deney2.c,32 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;Deney2.c,34 :: 		}while(k<20);
	MOVLW      128
	XORWF      _k+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVLW      20
	SUBWF      _k+0, 0
L__main9:
	BTFSS      STATUS+0, 0
	GOTO       L_main0
;Deney2.c,36 :: 		k=0;
	CLRF       _k+0
	CLRF       _k+1
;Deney2.c,40 :: 		saveBank = STATUS & 0b01100000; // RP1 ve RP0 biti (Bit 5 ve 6)
	MOVLW      96
	ANDWF      STATUS+0, 0
	MOVWF      _saveBank+0
;Deney2.c,46 :: 		bsf STATUS, RP0
	BSF        STATUS+0, 5
;Deney2.c,47 :: 		bcf STATUS, RP1
	BCF        STATUS+0, 6
;Deney2.c,50 :: 		bcf OSCCON, 6
	BCF        OSCCON+0, 6
;Deney2.c,51 :: 		bcf OSCCON, 5
	BCF        OSCCON+0, 5
;Deney2.c,52 :: 		bcf OSCCON, 4
	BCF        OSCCON+0, 4
;Deney2.c,54 :: 		bsf OSCCON, 0 // SCS (0 no'lu bit) 1 yapýlýr. Dahili OSC seçilir.
	BSF        OSCCON+0, 0
;Deney2.c,59 :: 		STATUS &= 0b10011111; // STATUS = yyyyyyyy & 10011111 = y00yyyyy
	MOVLW      159
	ANDWF      STATUS+0, 1
;Deney2.c,60 :: 		STATUS |= saveBank;   // STATUS = y00yyyyy | 0xx00000 = yxxyyyyy
	MOVF       _saveBank+0, 0
	IORWF      STATUS+0, 1
;Deney2.c,62 :: 		do{
L_main4:
;Deney2.c,64 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Deney2.c,66 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
;Deney2.c,68 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;Deney2.c,70 :: 		}while(k<20);
	MOVLW      128
	XORWF      _k+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      20
	SUBWF      _k+0, 0
L__main10:
	BTFSS      STATUS+0, 0
	GOTO       L_main4
;Deney2.c,72 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
