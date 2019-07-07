	;; Receive a byte from the IEC bus.
	;; Implemented based on https://www.pagetable.com/?p=1135, https://github.com/mist64/cbmbus_doc,
	;; http://www.zimmers.net/anonftp/pub/cbm/programming/serial-bus.pdf (page 11)

iec_rx_byte:

	;; First, we wait for the talker to release the CLK line
	jsr iec_wait_for_clk_release

	;; We then release the DATA to signal we are ready
	;; We can use this routine, since we weren't pulling CLK anyway
	jsr iec_release_clk_data

	;; Wait till data line is released (someone else might be holding it)
	jsr iec_wait_for_data_release

	;; Wait for talker to pull CLK.
	;; If over 200 usec (205 cycles on NTSC machine) , then it is EOI.
	;; Loop iteraction takes 13 cycles, 17 full iterations are enough

	ldx #$11                  ; 2 cycles
iec_rx_clk_wait:
	lda CI2PRA                ; 4 cycles
	rol                       ; 2 cycles, to put BIT_CI2PRA_CLK_IN as the last bit
	bpl iec_rx_not_eoi        ; 2 cycles if not jumped
	dex                       ; 2 cycles
    bne iec_rx_clk_wait      ; 3 cycles if jumped
    
    ;; Timeout - wait a little bit more to see if EOI confirmation is needed
    ;; (if CLK not pulled within 256 usec - it's not needed, see
    ;; https://www.pagetable.com/?p=1135, chapters End of Stream and Empty Stream)
	jsr iec_wait60us
	lda CI2PRA
	rol
	bmi iec_rx_no_eoi_confirmation
    
	;; Pull data for 60 usec to confirm
	jsr iec_release_clk_pull_data
	jsr iec_wait60us
	jsr iec_release_clk_data

iec_rx_no_eoi_confirmation:
	
	;; Store EOI information in IOSTATUS - XXX this should be done by the caller!
	lda IOSTATUS
	ora #$40
	sta IOSTATUS
	
	sec
	rts

iec_rx_not_eoi:

	;; Latch input bits in on rising edge of CLK, eight times for eight bits.
	ldx #7

	;; Get empty byte to load into.
	lda #$00
	pha

iec_rx_bit_loop:

	;; Wait for CLK to release
	jsr iec_wait_for_clk_release

	;; (we do this implicitly below, with a tighter routine,
	;; so that we don't have timing problems, as the requirements
	;; are quite tight. Basically we need to read the clock and data
	;; bit from the same byte read.

	;; DATA now has the next bit, but inverted (well, except that it turns out not to be).
	;; DATA is in bit 7, which is a bit annoying.
	;; But we can clock it out with a ROL instruction
	;; so that it is in C. We can then ROR it into the
	;; partial data byte.
	;; We use ROR so that we shift in from the top, so that
	;; the first bit we shift in ends up in bit 0 after all
	;; 8 bits have been read.
	;; ODD: For some reason we don't need to invert the
	;; received bits.  This is weird, because we invert them
	;; on the way out, and everything in the protocol seems
	;; to indicate that we sould do so.  But experimentation
	;; has confirmed the bits don't need inversion on reception.

	;; Move data bit into C flag, and loop until bit 6 clears
	;; i.e., the clock has been released.
*	lda CI2PRA
	rol
	bpl -

	;; Pull it into the data byte
	pla
	ror
	pha

	;; Wait for CLK to be pulled again
	jsr iec_wait_for_clk_pull

	;; More bits?
	dex
	bpl iec_rx_bit_loop

	;; Then we must within 1000 usec acknowledge the frame by
	;; pulling DATA. At this point, CLK is pulled by the
	;; talker and DATA by us, i.e., we are ready to receive
	;; the next byte. (p11).
	jsr iec_release_clk_pull_data

	;; Retreive the received byte
	pla

	;; Return no-error
	clc
	rts

