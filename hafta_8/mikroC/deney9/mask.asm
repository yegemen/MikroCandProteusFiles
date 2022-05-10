
_mask:

;mask.c,1 :: 		unsigned short mask(unsigned short num){
;mask.c,3 :: 		switch(num){
	GOTO       L_mask0
;mask.c,4 :: 		case 0: return 0x3F; // 0011 1111 = dp g f e d c b a
L_mask2:
	MOVLW      63
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,5 :: 		case 1: return 0x06;
L_mask3:
	MOVLW      6
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,6 :: 		case 2: return 0x5B;
L_mask4:
	MOVLW      91
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,7 :: 		case 3: return 0x4F;
L_mask5:
	MOVLW      79
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,8 :: 		case 4: return 0x66;
L_mask6:
	MOVLW      102
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,9 :: 		case 5: return 0x6D;
L_mask7:
	MOVLW      109
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,10 :: 		case 6: return 0x7D;
L_mask8:
	MOVLW      125
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,11 :: 		case 7: return 0x07;
L_mask9:
	MOVLW      7
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,12 :: 		case 8: return 0x7F;
L_mask10:
	MOVLW      127
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,13 :: 		case 9: return 0x6F;
L_mask11:
	MOVLW      111
	MOVWF      R0+0
	GOTO       L_end_mask
;mask.c,14 :: 		}
L_mask0:
	MOVF       FARG_mask_num+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_mask2
	MOVF       FARG_mask_num+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_mask3
	MOVF       FARG_mask_num+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_mask4
	MOVF       FARG_mask_num+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_mask5
	MOVF       FARG_mask_num+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_mask6
	MOVF       FARG_mask_num+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_mask7
	MOVF       FARG_mask_num+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_mask8
	MOVF       FARG_mask_num+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_mask9
	MOVF       FARG_mask_num+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_mask10
	MOVF       FARG_mask_num+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_mask11
;mask.c,15 :: 		}
L_end_mask:
	RETURN
; end of _mask
