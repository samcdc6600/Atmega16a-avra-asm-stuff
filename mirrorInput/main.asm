	;; for AVR: atmega16a
	;; Yes this code is messy, we are just playing around with things.
	;; Sets up PD6 and an input and mirrors it's state on PA0, i.e. if PD6
	;; is high then PA0 is high and if PD6 is low then PA0 is low. This is
	;; done by constantly polling PD6.

	.nolist			; Don't include in the .lst file if we ask the
				; assembler to generate one.
	.include "./include/m16Adef.inc"
	.list

;	ldi r16, 0b00000001
;	out DDRC, r16
;	out PortC, r16
;Start:
				;	rjmp Start
	;; =====================================================================
	;; Declarations
	.def	temp	= r16	; designate working register r16 as temp
	.def	inHigh	= r17
	.def	high	= r18
	.def	low	= r19

	;; =====================================================================
	;; Start of Program
Init:
;	ser	temp		; Set all bits in temp to 1's.
	;	clr	temp		; Set all bits in temp to 0's.
	ldi	low, 0b00000000
	ldi	high, 0b00000001
	ldi	inHigh, 0b01000000
	ldi	temp, 0b11111111	; 1 sets a pin as an output, 0 set's a
					; pin as an input. Therfore after
					; applying this pin 1 of whatever set of
					; pins it was applied to will be set as
					; an input pin.
	out 	DDRA, temp		; Set the Data Direction Register for
					; port A to temp. This sets all pins as
					; outputs.
	ldi	temp, 0b00000000
	out	PortA, temp		; Set all pins of PortA (except 0) to OV
					; (0 is set to 5V.)
					
	ldi	temp, 0b10111111
	out	DDRD, temp		; Set all pins of PortD to outputs,
					; except for PA6.
	clr	temp			; Set all bit's to 0.
	out	PortD, temp		; Set all pins of PortD to 0V.

	;; =====================================================================
	;; Main boy of program
Main:;
	in	temp, PinD		; Copy the state of PortD to temp. If a
					; pin is high temp position 6 will be 1.
					; otherwise 0
	mov	r12, high
	cpse	temp, inHigh		; Compare, Skip if Equal
	mov	r12, low		; (if Rd = Rr)PC <- PC + 2 or 3
	out	PortA, r12
	rjmp	Main
