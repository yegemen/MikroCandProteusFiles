
_main:

;deney8.c,17 :: 		void main() {
;deney8.c,19 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;deney8.c,20 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney8.c,22 :: 		PORTB = 0;
	CLRF       PORTB+0
;deney8.c,23 :: 		TRISB = 0;
	CLRF       TRISB+0
;deney8.c,25 :: 		PORTD = 0;
	CLRF       PORTD+0
;deney8.c,26 :: 		TRISD = 0;
	CLRF       TRISD+0
;deney8.c,28 :: 		TRISA = 0XFF;
	MOVLW      255
	MOVWF      TRISA+0
;deney8.c,32 :: 		PORTD = EEPROM_Read(5); // 5. adresini okuduk.
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;deney8.c,34 :: 		do{
L_main0:
;deney8.c,36 :: 		PORTB = PORTB++;
	INCF       PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;deney8.c,38 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;deney8.c,40 :: 		if(PORTA.F2){
	BTFSS      PORTA+0, 2
	GOTO       L_main4
;deney8.c,42 :: 		EEPROM_Write(5, PORTB); // eeprom 5. adresine portb nin deðerini yazdýk.
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       PORTB+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;deney8.c,44 :: 		PORTD = EEPROM_Read(5); // portd ye eeprom un 5. adresindeki deðeri atadýk.
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;deney8.c,46 :: 		do;
L_main5:
;deney8.c,47 :: 		while(PORTA.F2);
	BTFSC      PORTA+0, 2
	GOTO       L_main5
;deney8.c,49 :: 		}
L_main4:
;deney8.c,51 :: 		}while(1);
	GOTO       L_main0
;deney8.c,53 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
