
_main:

;deney11m.c,16 :: 		void main() {
;deney11m.c,18 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;deney11m.c,19 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney11m.c,21 :: 		UART1_Init(9600); // Baud Rate 9600bps olacak.
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;deney11m.c,23 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;deney11m.c,25 :: 		UART1_Write_Text("Start"); // start yazýsý gönderdik
	MOVLW      ?lstr1_deney11m+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;deney11m.c,27 :: 		UART1_Write(10); // 10 deðeri gönderdik.
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;deney11m.c,29 :: 		UART1_Write(13); // 13 deðeri gönderdik.
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;deney11m.c,31 :: 		while(1){
L_main1:
;deney11m.c,33 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;deney11m.c,35 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;deney11m.c,37 :: 		UART1_Write(uart_rd);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;deney11m.c,41 :: 		}
L_main3:
;deney11m.c,43 :: 		}
	GOTO       L_main1
;deney11m.c,45 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
