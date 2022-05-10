
_Tone1:

;deney13.c,9 :: 		void Tone1(){
;deney13.c,11 :: 		Sound_play(659, 250); // 659 Hz lik, 250 ms süren ses
	MOVLW      147
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      250
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,13 :: 		}
L_end_Tone1:
	RETURN
; end of _Tone1

_Tone2:

;deney13.c,15 :: 		void Tone2(){
;deney13.c,17 :: 		Sound_play(698, 250);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      250
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,19 :: 		}
L_end_Tone2:
	RETURN
; end of _Tone2

_Tone3:

;deney13.c,21 :: 		void Tone3(){
;deney13.c,23 :: 		Sound_play(784, 250);
	MOVLW      16
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      250
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,25 :: 		}
L_end_Tone3:
	RETURN
; end of _Tone3

_melody1:

;deney13.c,27 :: 		void melody1(){
;deney13.c,29 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL       _Tone1+0
	CALL       _Tone2+0
	CALL       _Tone3+0
	CALL       _Tone3+0
;deney13.c,31 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL       _Tone1+0
	CALL       _Tone2+0
	CALL       _Tone3+0
	CALL       _Tone3+0
;deney13.c,33 :: 		Tone1(); Tone2(); Tone3();
	CALL       _Tone1+0
	CALL       _Tone2+0
	CALL       _Tone3+0
;deney13.c,35 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL       _Tone1+0
	CALL       _Tone2+0
	CALL       _Tone3+0
	CALL       _Tone3+0
;deney13.c,37 :: 		Tone1(); Tone2(); Tone3();
	CALL       _Tone1+0
	CALL       _Tone2+0
	CALL       _Tone3+0
;deney13.c,39 :: 		Tone3(); Tone3(); Tone2(); Tone2(); Tone1();
	CALL       _Tone3+0
	CALL       _Tone3+0
	CALL       _Tone2+0
	CALL       _Tone2+0
	CALL       _Tone1+0
;deney13.c,41 :: 		}
L_end_melody1:
	RETURN
; end of _melody1

_ToneA:

;deney13.c,43 :: 		void ToneA(){
;deney13.c,45 :: 		Sound_play(880, 50);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,47 :: 		}
L_end_ToneA:
	RETURN
; end of _ToneA

_ToneB:

;deney13.c,48 :: 		void ToneB(){
;deney13.c,50 :: 		Sound_play(1046, 50);
	MOVLW      22
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,52 :: 		}
L_end_ToneB:
	RETURN
; end of _ToneB

_ToneC:

;deney13.c,53 :: 		void ToneC(){
;deney13.c,55 :: 		Sound_play(1318, 50);
	MOVLW      38
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      5
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,57 :: 		}
L_end_ToneC:
	RETURN
; end of _ToneC

_melody2:

;deney13.c,59 :: 		void melody2(){
;deney13.c,63 :: 		for(i=9; i>0; i--)
	MOVLW      9
	MOVWF      melody2_i_L0+0
L_melody20:
	MOVF       melody2_i_L0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_melody21
;deney13.c,65 :: 		ToneA(); ToneB(); ToneC();
	CALL       _ToneA+0
	CALL       _ToneB+0
	CALL       _ToneC+0
;deney13.c,63 :: 		for(i=9; i>0; i--)
	DECF       melody2_i_L0+0, 1
;deney13.c,66 :: 		}
	GOTO       L_melody20
L_melody21:
;deney13.c,68 :: 		}
L_end_melody2:
	RETURN
; end of _melody2

_main:

;deney13.c,70 :: 		void main() {
;deney13.c,72 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;deney13.c,73 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;deney13.c,75 :: 		TRISB = 0xF0; // 1111 = (RB7 RB6 RB5 RB4) , 0000 =  (RB3 RB2 RB1 RB0)
	MOVLW      240
	MOVWF      TRISB+0
;deney13.c,77 :: 		Sound_Init(&PORTB, 3); // portb nin 3. bacaðýndan sesi üret
	MOVLW      PORTB+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      3
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;deney13.c,81 :: 		Sound_Play(1000, 500); // 1000 Hz lik frekansa sahip ses, 500 ms boyunca çalsýn. program ilk çalýþtýðýnda bip sesi çýkacak.
	MOVLW      232
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      244
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;deney13.c,83 :: 		while(1){
L_main3:
;deney13.c,85 :: 		if(Button(&PORTB, 7, 1, 1)) // 7. bacaða basýlýrsa fon1 i çal.
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;deney13.c,87 :: 		Tone1();
	CALL       _Tone1+0
L_main5:
;deney13.c,90 :: 		while(PORTB & 0x80); // 1000 0000 & 1000 0000 = 1 ise bekle (sonsuz döngü) button dan elimizi çekene kadar diðer if e gimesin.
L_main6:
	BTFSS      PORTB+0, 7
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;deney13.c,92 :: 		if(Button(&PORTB, 6, 1, 1))
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;deney13.c,93 :: 		Tone2();
	CALL       _Tone2+0
L_main8:
;deney13.c,95 :: 		while(PORTB & 0x40);
L_main9:
	BTFSS      PORTB+0, 6
	GOTO       L_main10
	GOTO       L_main9
L_main10:
;deney13.c,97 :: 		if(Button(&PORTB, 5, 1, 1))
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main11
;deney13.c,98 :: 		Melody2();
	CALL       _melody2+0
L_main11:
;deney13.c,100 :: 		while(PORTB & 0x20);
L_main12:
	BTFSS      PORTB+0, 5
	GOTO       L_main13
	GOTO       L_main12
L_main13:
;deney13.c,102 :: 		if(Button(&PORTB, 4, 1, 1))
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;deney13.c,103 :: 		Melody1();
	CALL       _melody1+0
L_main14:
;deney13.c,105 :: 		while(PORTB & 0x10);
L_main15:
	BTFSS      PORTB+0, 4
	GOTO       L_main16
	GOTO       L_main15
L_main16:
;deney13.c,108 :: 		}
	GOTO       L_main3
;deney13.c,109 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
