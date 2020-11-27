	#include<p18F4550.inc> 

lp_cnt1	set 0x00
lp_cnt2	set 0x01
		org 0x00 
		goto start 
		org 0x08 
		retfie 
		org 0x18 
		retfie 

dup_nop	macro kk
		variable i

i=0
		while i < kk
		nop

i+=1	
		endw
		endm

;10ms Delay
delay	movlw	d'20'
		movwf	lp_cnt2,A
again1	movlw	d'250'
		movwf 	lp_cnt1,A
again2	dup_nop	d'17'
		decfsz	lp_cnt1,F,A
		bra 	again2
		decfsz 	lp_cnt2,F,A
		bra		again1
		return

;show delay Name & ID 1second
delay1	movlw	d'80'
		movwf	lp_cnt2,A
again3	movlw	d'250'
		movwf 	lp_cnt1,A
again4	dup_nop	d'247'
		decfsz	lp_cnt1,F,A
		bra 	again4
		decfsz 	lp_cnt2,F,A
		bra		again3
		return

;show delay number	0.2second
delay2	movlw	d'16'
		movwf	lp_cnt2,A
again5	movlw	d'250'
		movwf 	lp_cnt1,A
again6	dup_nop	d'247'
		decfsz	lp_cnt1,F,A
		bra 	again6
		decfsz 	lp_cnt2,F,A
		bra		again5

		return
;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################
;Write Command
wcmd	bcf		PORTC,4,A
		bcf		PORTC,5,A
		bsf		PORTC,6,A
		call	delay
		bcf		PORTC,6,A
		return

;Write Data
wdata	bsf		PORTC,4,A ; RS=1
		bcf		PORTC,5,A ; RW=0
		bsf		PORTC,6,A ; E=1
		call	delay
		bcf		PORTC,6,A		
		return

;clear lcd display
lcd_clr	movlw	0x01
		movwf	PORTD,A
		call	wcmd
		return

;Show on 2nd line
line2	movlw	0xC0
		movwf	PORTD,A
		call	wcmd
		return
;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################

;sub for show name
name	movlw	D'72'
		movwf	PORTD,A
		call	wdata
		movlw	D'97'
		movwf	PORTD,A	
		call	wdata	
		movlw	D'114'
		movwf	PORTD,A	
		call	wdata	
		movlw	D'114'
		movwf	PORTD,A	
		call	wdata	
		movlw	D'105'
		movwf	PORTD,A
		call	wdata		
		movlw	D'101'
		movwf	PORTD,A
		call	wdata	
		movlw	D'121'
		movwf	PORTD,A
		call	wdata
		call	delay1
		return

;Show ID number
numid	movlw	D'68'
		movwf	PORTD,A
		call	wdata
		movlw	D'69'
		movwf	PORTD,A
		call	wdata
		movlw	D'57'
		movwf	PORTD,A
		call	wdata
		movlw	D'55'
		movwf	PORTD,A
		call	wdata
		movlw	D'51'
		movwf	PORTD,A
		call	wdata
		movlw	D'49'
		movwf	PORTD,A
		call	wdata
		movlw	D'50'
		movwf	PORTD,A
		call	wdata
		call	delay1
		return



;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################


;subroutine for keypad

show1	call	line2
		movlw	D'49'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show2	call	line2
		movlw	D'50'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show3	call	line2
		movlw	D'51'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show4	call	line2
		movlw	D'52'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show5	call	line2
		movlw	D'53'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show6	call	line2
		movlw	D'54'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show7	call	line2
		movlw	D'55'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show8	call	line2
		movlw	D'56'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show9	call	line2
		movlw	D'57'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
showSt	call	line2
		movlw	D'42'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show0	call	line2
		movlw	D'48'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return
show#	call	line2
		movlw	D'35'
		movwf	PORTD,A
		call	wdata
		call	delay2
		return

;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################
;subroutine to setup keypad

setupA	bsf		PORTB,4,A
		bcf		PORTB,5,A
		bcf		PORTB,6,A
		bcf		PORTB,7,A
		return
	
setupB	bcf		PORTB,4,A
		bsf		PORTB,5,A
		bcf		PORTB,6,A
		bcf		PORTB,7,A
		return

setupC	bcf		PORTB,4,A
		bcf		PORTB,5,A
		bsf		PORTB,6,A
		bcf		PORTB,7,A
		return

setupD	bcf		PORTB,4,A
		bcf		PORTB,5,A
		bcf		PORTB,6,A
		bsf		PORTB,7,A
		return
	
;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################



start	movlw	B'0000011'
		movwf	TRISC,A
		clrf	TRISD,A
		movlw	B'00001110'
		movwf	TRISB,A

		;2line 5x7 matrix
		movlw	0x38
		movwf	PORTD,A
		call	wcmd
		
		;on display and blink cursor
		movlw	0x0F
		movwf	PORTD,A
		call	wcmd

check	btfss	PORTC,0,A
		bra		check2
		call	name
		call	lcd_clr
		bra		check2
check2	btfss	PORTC,1,A
		bra		checkn1
		call	numid
		call	lcd_clr
		bra		checkn1

;///////////////////////////////////////////////////////////////////////////////

checkn1		call	setupA
			btfss	PORTB,1,A
			bra		checkn2
			call	show1
			call	lcd_clr
			bra 	checkn2

checkn2		call	setupA
			btfss	PORTB,2,A
			bra		checkn3
			call	show2
			call	lcd_clr
			bra 	checkn3

checkn3		call	setupA
			btfss	PORTB,3,A
			bra		checkn4
			call	show3
			call	lcd_clr
			bra 	checkn4

;///////////////////////////////////////////////////////////////////////////////
checkn4		call	setupB
			btfss	PORTB,1,A
			bra		checkn5
			call	show4
			call	lcd_clr
			bra 	checkn5
checkn5		call	setupB
			btfss	PORTB,2,A
			bra		checkn6
			call	show5
			call	lcd_clr
			bra 	checkn6
checkn6		call	setupB
			btfss	PORTB,3,A
			bra		checkn7
			call	show6
			call	lcd_clr
			bra 	checkn7

;///////////////////////////////////////////////////////////////////////////////
checkn7		call	setupC
			btfss	PORTB,1,A
			bra		checkn8
			call	show7
			call	lcd_clr
			bra 	checkn8
checkn8		call	setupC
			btfss	PORTB,2,A
			bra		checkn9
			call	show8
			call	lcd_clr
			bra 	checkn9
checkn9		call	setupC
			btfss	PORTB,3,A
			bra		checkn10
			call	show9
			call	lcd_clr
			bra 	checkn10

;///////////////////////////////////////////////////////////////////////////////
checkn10	call	setupD
			btfss	PORTB,1,A
			bra		checkn11
			call	showSt
			call	lcd_clr
			bra 	checkn11
checkn11	call	setupD
			btfss	PORTB,2,A
			bra		checkn12
			call	show0
			call	lcd_clr
			bra 	checkn12
checkn12	call	setupD
			btfss	PORTB,3,A
			bra		check
			call	show#
			call	lcd_clr
			bra 	check



	
;###############################################################################
;*******************************************************************************
;*******************************************************************************
;###############################################################################
		end