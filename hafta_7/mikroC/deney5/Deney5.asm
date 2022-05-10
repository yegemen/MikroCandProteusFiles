
_main:

;Deney5.c,8 :: 		void main() {
;Deney5.c,10 :: 		OPTION_REG = 0x0E; // 0000 1110 Bit3=PSA=1 Prescaler WDT'ye atandý. PS2 PS1 PS0 (Bit2Bit1Bit0) 110 -> Prescaler 1:64
	MOVLW      14
	MOVWF      OPTION_REG+0
;Deney5.c,12 :: 		asm CLRWDT; // WDT'nin sýfýrlanmasýný engelle
	CLRWDT
;Deney5.c,14 :: 		PORTB = 0x0F;
	MOVLW      15
	MOVWF      PORTB+0
;Deney5.c,15 :: 		TRISB = 0;
	CLRF       TRISB+0
;Deney5.c,17 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
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
;Deney5.c,19 :: 		PORTB = 0xF0;
	MOVLW      240
	MOVWF      PORTB+0
;Deney5.c,21 :: 		while(1); //wdt ýn otomatik olarak taþmasýný ve programýmýzý resetlemesini bekliyoruz.
L_main1:
	GOTO       L_main1
;Deney5.c,24 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
