
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;deney4.c,21 :: 		void interrupt(){
;deney4.c,23 :: 		cnt++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;deney4.c,25 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;deney4.c,27 :: 		INTCON = 0x20; // T0IE = 1 yani 0010 0000
	MOVLW      32
	MOVWF      INTCON+0
;deney4.c,31 :: 		}
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

;deney4.c,34 :: 		void main() {
;deney4.c,36 :: 		OPTION_REG = 0x84; // 1000 0100 -> RBPU = 1, PORTB Pull-Up disable.
	MOVLW      132
	MOVWF      OPTION_REG+0
;deney4.c,40 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;deney4.c,41 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney4.c,43 :: 		TRISB = 0;
	CLRF       TRISB+0
;deney4.c,44 :: 		PORTB = 0x0; // 0000 0000
	CLRF       PORTB+0
;deney4.c,46 :: 		TMR0 = 96; // 96 ile 255 arasý sayma yapacaðýz.
	MOVLW      96
	MOVWF      TMR0+0
;deney4.c,48 :: 		INTCON = 0xA0; // 1010 0000 -> GIE = 1, TOIE = 1
	MOVLW      160
	MOVWF      INTCON+0
;deney4.c,50 :: 		cnt = 0; // Her taþma olduðunda bu deðer artýrýlacak.
	CLRF       _cnt+0
	CLRF       _cnt+1
;deney4.c,52 :: 		do{
L_main0:
;deney4.c,54 :: 		if(cnt == 400){ // TMR0 400 kez taþtýðýnda
	MOVF       _cnt+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVLW      144
	XORWF      _cnt+0, 0
L__main7:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;deney4.c,56 :: 		PORTB = PORTB++;
	INCF       PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;deney4.c,58 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;deney4.c,60 :: 		}
L_main3:
;deney4.c,62 :: 		}while(1);
	GOTO       L_main0
;deney4.c,64 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
