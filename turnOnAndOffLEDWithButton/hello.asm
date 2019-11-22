	;; for AVR: atmega16a
	;; Turn on and off an LED which is connnected to PC0
	;; Button is connected to PC1

	.include "./include/m16Adef.inc" 

;	ldi r16, 0b00000001
;	out DDRC, r16
;	out PortC, r16
;Start:
				;	rjmp Start
	;; =====================================================================
	;; Declarations
	.def	temp	=r16	; designate working register r16 as temp

	;; =====================================================================
	;; Start of Program
Init:
;	ser	temp		; Set all bits in temp to 1's.
;	clr	temp		; Set all bits in temp to 0's.
	ldi	temp, 0b11111111	; 1 sets a pin as an output, 0 set's a
					; pin as an input. Therfore after
					; applying this pin 1 of whatever set of
					; pins it was applied to will be set as
					; an input pin.
	out 	DDRC, temp		; Set the Data Direction Register for
					; port C to temp. This set's PC1 to an
					; input and the other PC pins to
					; output.
	ldi	temp, 0b00000001
	out	PortC, temp		; Set all pins of PortC (except 1) to OV
					; (1 is set to 5V.)
					
	ldi	temp, 0b11111110
	out	DDRA, temp		; Set all pins of PortA to outputs,
					; except for PA0.
	clr	temp			; Set all bit's to 0.
	out	PortA, temp		; Set all pins of PortA to 0V.

	;; =====================================================================
	;; Main boy of program
Main:;
	in	temp, PinA		; Copy the state of PortC to temp, if
					; button connected to PC1 is pressed
					; temp position 1 will be 1, otherwise 0
	out	PortC, temp		; Set pins of PortC to temp.
	rjmp	Main
