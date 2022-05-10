
_main:

;Deney1.c,36 :: 		void main()
;Deney1.c,38 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Deney1.c,39 :: 		ANSELH= 0;
	CLRF       ANSELH+0
;Deney1.c,41 :: 		PORTB = 0xFF; // Port B nin tamamýný yanacak þekilde ayarladýk
	MOVLW      255
	MOVWF      PORTB+0
;Deney1.c,43 :: 		TRISB = 0;
	CLRF       TRISB+0
;Deney1.c,45 :: 		delay_ms(1000); // 1 ms bekle
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;Deney1.c,47 :: 		PORTB = 0;
	CLRF       PORTB+0
;Deney1.c,49 :: 		for(k=0;k<20;k++)
	CLRF       _k+0
	CLRF       _k+1
L_main1:
	MOVLW      128
	XORWF      _k+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      20
	SUBWF      _k+0, 0
L__main14:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;Deney1.c,51 :: 		switch(PORTB)
	GOTO       L_main4
;Deney1.c,53 :: 		case 0x00: PORTB = 0xFF;
L_main6:
	MOVLW      255
	MOVWF      PORTB+0
;Deney1.c,54 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;Deney1.c,55 :: 		break;
	GOTO       L_main5
;Deney1.c,57 :: 		case 0xFF: PORTB = 0x00;
L_main8:
	CLRF       PORTB+0
;Deney1.c,58 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
	NOP
;Deney1.c,59 :: 		}
	GOTO       L_main5
L_main4:
	MOVF       PORTB+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVF       PORTB+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_main8
L_main5:
;Deney1.c,49 :: 		for(k=0;k<20;k++)
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;Deney1.c,60 :: 		}
	GOTO       L_main1
L_main2:
;Deney1.c,62 :: 		PORTB = 0b01010101;
	MOVLW      85
	MOVWF      PORTB+0
;Deney1.c,64 :: 		while(1)
L_main10:
;Deney1.c,66 :: 		PORTB = ~PORTB; // tümleyeni
	COMF       PORTB+0, 1
;Deney1.c,68 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
;Deney1.c,69 :: 		}
	GOTO       L_main10
;Deney1.c,70 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
