
_replace:

;Deney4v3.c,14 :: 		void replace(){
;Deney4v3.c,16 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Deney4v3.c,18 :: 		}
L_end_replace:
	RETURN
; end of _replace

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Deney4v3.c,20 :: 		void interrupt(){
;Deney4v3.c,24 :: 		if(PIR1.TMR2IF)
	BTFSS      PIR1+0, 1
	GOTO       L_interrupt0
;Deney4v3.c,27 :: 		cnt++;
	INCF       _cnt+0, 1
;Deney4v3.c,29 :: 		PIR1.TMR2IF = 0;
	BCF        PIR1+0, 1
;Deney4v3.c,31 :: 		TMR2 = 0;
	CLRF       TMR2+0
;Deney4v3.c,33 :: 		}
L_interrupt0:
;Deney4v3.c,35 :: 		}
L_end_interrupt:
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Deney4v3.c,37 :: 		void main() {
;Deney4v3.c,39 :: 		cnt = 0;
	CLRF       _cnt+0
;Deney4v3.c,41 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Deney4v3.c,42 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Deney4v3.c,44 :: 		PORTB = 0b10101010;
	MOVLW      170
	MOVWF      PORTB+0
;Deney4v3.c,45 :: 		TRISB = 0;
	CLRF       TRISB+0
;Deney4v3.c,47 :: 		T2CON = 0xFF; // TMR2ON = 1, 1:16 prescaler rate,
	MOVLW      255
	MOVWF      T2CON+0
;Deney4v3.c,50 :: 		PIE1.TMR2IE = 1;
	BSF        PIE1+0, 1
;Deney4v3.c,51 :: 		INTCON = 0xC0; // 1000 0000 -> GIE = 1, PEIE = 1
	MOVLW      192
	MOVWF      INTCON+0
;Deney4v3.c,53 :: 		while(1){
L_main1:
;Deney4v3.c,55 :: 		if(cnt == 30){
	MOVF       _cnt+0, 0
	XORLW      30
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;Deney4v3.c,57 :: 		cnt = 0;
	CLRF       _cnt+0
;Deney4v3.c,59 :: 		replace();
	CALL       _replace+0
;Deney4v3.c,61 :: 		}
L_main3:
;Deney4v3.c,63 :: 		}
	GOTO       L_main1
;Deney4v3.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
