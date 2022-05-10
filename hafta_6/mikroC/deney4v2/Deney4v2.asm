
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Deney4v2.c,12 :: 		void interrupt(){
;Deney4v2.c,14 :: 		cnt++;
	INCF       _cnt+0, 1
;Deney4v2.c,16 :: 		PIR1.TMR1IF = 0;
	BCF        PIR1+0, 0
;Deney4v2.c,18 :: 		TMR1H = 0x80;
	MOVLW      128
	MOVWF      TMR1H+0
;Deney4v2.c,19 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;Deney4v2.c,21 :: 		}
L_end_interrupt:
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Deney4v2.c,23 :: 		void main() {
;Deney4v2.c,25 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Deney4v2.c,26 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Deney4v2.c,28 :: 		PORTB = 0xF0; // Baþlangýçta ledlerin yarýsý yansýn.
	MOVLW      240
	MOVWF      PORTB+0
;Deney4v2.c,29 :: 		TRISB = 0;
	CLRF       TRISB+0
;Deney4v2.c,31 :: 		T1CON = 1; // TMR1ON = 1 yani TMR1 aktifleþtirilir.
	MOVLW      1
	MOVWF      T1CON+0
;Deney4v2.c,33 :: 		PIR1.TMR1IF = 0; // TMR1 Kesme bayraðý sýfýrlanýr.
	BCF        PIR1+0, 0
;Deney4v2.c,36 :: 		TMR1H = 0x80; // 1000 0000
	MOVLW      128
	MOVWF      TMR1H+0
;Deney4v2.c,37 :: 		TMR1L = 0x00; // 0000 0000
	CLRF       TMR1L+0
;Deney4v2.c,39 :: 		PIE1.TMR1IE = 1; // TMR1 Taþtýðýnda kesme oluþsun
	BSF        PIE1+0, 0
;Deney4v2.c,41 :: 		cnt = 0;
	CLRF       _cnt+0
;Deney4v2.c,43 :: 		INTCON = 0xC0; // 1100 0000 -> GIE = 1, PEIE = 1 demektir. bunu tek satýrda yazmak daha pratik.
	MOVLW      192
	MOVWF      INTCON+0
;Deney4v2.c,45 :: 		do{
L_main0:
;Deney4v2.c,47 :: 		if(cnt == 76){
	MOVF       _cnt+0, 0
	XORLW      76
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;Deney4v2.c,49 :: 		PORTB = ~PORTB; // Diðer dört LED yansýn
	COMF       PORTB+0, 1
;Deney4v2.c,51 :: 		cnt = 0;
	CLRF       _cnt+0
;Deney4v2.c,52 :: 		}
L_main3:
;Deney4v2.c,55 :: 		while(1);
	GOTO       L_main0
;Deney4v2.c,56 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
