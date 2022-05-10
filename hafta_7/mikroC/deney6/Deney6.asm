
_initMain:

;Deney6.c,11 :: 		void initMain(){//bir programýn ayarlarýný yapmak
;Deney6.c,13 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Deney6.c,14 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Deney6.c,16 :: 		PORTA = 255; // 1111 1111 yani RA0 ve RA1'in
	MOVLW      255
	MOVWF      PORTA+0
;Deney6.c,17 :: 		TRISA = 255; // girdi olarak ayarlanmasý
	MOVLW      255
	MOVWF      TRISA+0
;Deney6.c,19 :: 		PORTB = 0; // Duty-Cycle deðeri bu 8-bit olarak
	CLRF       PORTB+0
;Deney6.c,20 :: 		TRISB = 0; //gösterilecek.
	CLRF       TRISB+0
;Deney6.c,22 :: 		PORTC = 0; // CCP1 (RC2) bacaðýndan PWM sinyali
	CLRF       PORTC+0
;Deney6.c,23 :: 		TRISC = 0; // dýþarýya verilecek.
	CLRF       TRISC+0
;Deney6.c,26 :: 		PWM1_Init(5000); // 5KHz'lik sinyal üretilecek. ccp1 olduðu için pwm1 yazdýk. ccp2 olsa pwm2 yazmalýydýk.
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Deney6.c,27 :: 		}
L_end_initMain:
	RETURN
; end of _initMain

_main:

;Deney6.c,29 :: 		void main() {
;Deney6.c,32 :: 		initMain();
	CALL       _initMain+0
;Deney6.c,34 :: 		current_duty = 16;
	MOVLW      16
	MOVWF      _current_duty+0
;Deney6.c,36 :: 		PWM1_Set_Duty(current_duty);
	MOVLW      16
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Deney6.c,38 :: 		old_duty = 0;
	CLRF       _old_duty+0
;Deney6.c,40 :: 		PWM1_Start(); // CCP1 bacaðýndan PWM sinyali üretmeye baþlayalým
	CALL       _PWM1_Start+0
;Deney6.c,42 :: 		while(1){
L_main0:
;Deney6.c,44 :: 		if(Button(&PORTA, 0, 1, 1)){ // RA0'a basýldýysa (0 0. bacak demek, 1 1ms kontrol yapýlsýn, 1 butona basýldýðý anda lojik 1 olsun)
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;Deney6.c,46 :: 		current_duty++;
	INCF       _current_duty+0, 1
;Deney6.c,48 :: 		}
L_main2:
;Deney6.c,50 :: 		if(Button(&PORTA, 1, 1, 1)){ // RA1'e basýldýysa
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;Deney6.c,52 :: 		current_duty--;
	DECF       _current_duty+0, 1
;Deney6.c,54 :: 		}
L_main3:
;Deney6.c,56 :: 		if(old_duty != current_duty){
	MOVF       _old_duty+0, 0
	XORWF      _current_duty+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;Deney6.c,58 :: 		PWM1_Set_Duty(current_duty);
	MOVF       _current_duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Deney6.c,60 :: 		old_duty = current_duty;
	MOVF       _current_duty+0, 0
	MOVWF      _old_duty+0
;Deney6.c,62 :: 		PORTB = old_duty;
	MOVF       _current_duty+0, 0
	MOVWF      PORTB+0
;Deney6.c,64 :: 		}
L_main4:
;Deney6.c,66 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
;Deney6.c,67 :: 		}
	GOTO       L_main0
;Deney6.c,69 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
