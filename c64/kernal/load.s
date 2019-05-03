				; Function defined on pp272-273 of C64 Programmers Reference Guide
	;; IEC reference at http://www.zimmers.net/anonftp/pub/cbm/programming/serial-bus.pdf
load:

	;; Disable IRQs, since timing matters!
	SEI

	;; Begin sending under attention
	jsr iec_assert_atn

	;; XXX - Use default device number
	;; http://www.zimmers.net/anonftp/pub/cbm/programming/serial-bus.pdf
	;; p13, 16.
	;; also p16 tells us this routine doesn't mess with the file table in the C64,
	;; only in the drive.
	
	;; Call device to LISTEN (p16)
	lda #$28
	jsr iec_tx_byte
	bcs load_error

	;; Open channel #0 (p16)
	lda #$f0
	jsr iec_tx_byte
	bcs load_error

	;; (p16)
	jsr iec_release_atn

	;; Send filename (p16)
	lda #$24 		; $ = directory
	jsr iec_tx_byte

	;; Command device to unlisten to indicate end of file name. (p16)
	jsr iec_assert_atn
	lda #$3f
	jsr iec_tx_byte
	bcs load_error
	jsr iec_release_atn
	
	;; Now command device to talk (p16)
	jsr iec_assert_atn
	lda #$48
	jsr iec_tx_byte
	bcs load_error
	lda #$60 ; open channel / data (p3) , required according to p13
	jsr iec_tx_byte
	bcs load_error
	jsr iec_release_atn

	;; We are currently talker, so do the IEC turn around so that we
	;; are the listener (p16)
	jsr iec_turnaround_to_listen
	bcs load_error
	
	;; We are now ready to receive bytes
	;; jsr iec_rx_byte
	;; bcs load_done


load_done:
	;; Close file on drive


	;; Command drive to listen and to close the file
	jsr iec_assert_atn
	lda #$28
	jsr iec_tx_byte
	lda #$e0
	jsr iec_tx_byte
	jsr iec_release_atn

	;; Tell drive to unlisten
	jsr iec_assert_atn
	lda #$3f
	jsr iec_tx_byte
	jsr iec_release_atn
	
	;;  FALL THROUGH
	
load_error:
	;; Re-enable interrupts and return
	cli
	;; (iec_tx_byte will have set/cleared C flag and put result code
	;; in A if it was an error).
	rts
