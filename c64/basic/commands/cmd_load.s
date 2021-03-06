// #LAYOUT# STD *       #TAKE
// #LAYOUT# *   BASIC_0 #TAKE
// #LAYOUT# *   *       #IGNORE


cmd_load:

	// Parse filename
	// (we can tell the KERNAL where it is in memory directly, since the
	// KERNAL will be able to peek under ROMs to read it, since it will have
	// to be able to peek under the ROMs for SAVE and VERIFY).
	// Parse optional device #
	// Parse optional secondary address
	
	// XXX - C64 BASIC apparently does not clear variables after a LOAD in the
	// middle of a program. For safety, we do.
	jsr basic_do_clr
	
	// Set filename and length
	lda #$00
	sta FNLEN

	// Without tape support, LOAD must have a filename
	// (This also skips any leading spaces)
	jsr basic_end_of_statement_check
	bcc !+
	jmp do_MISSING_FILENAME_error
!:
	jsr basic_fetch_and_consume_character
	cmp #$22
	beq !+
	jmp do_SYNTAX_error
!:
	// Filename starts here so set pointer
	lda TXTPTR+0
	sta FNADDR+0
	lda TXTPTR+1
	sta FNADDR+1

	// Now search for end of line or closing quote
	// so that we know the length of the filename
getting_filename:
	jsr basic_fetch_and_consume_character
	cmp #$22
	beq got_filename
	cmp #$00
	bne !+
	jsr basic_unconsume_character

	jmp got_filename
!:
	inc FNLEN
	jmp getting_filename
	
got_filename:

	// Now fetch the file number, start from the default one
	jsr select_device
	stx FA
	jsr injest_comma
	bcs got_devicenumber

	jsr basic_parse_line_number
	lda LINNUM+1
	beq !+
	jmp do_ILLEGAL_QUANTITY_error
!:
	lda LINNUM+0
	sta FA

got_devicenumber:

	// Now fetch the secondary address
	lda #$00
	sta SA
	jsr injest_comma
	bcs cmd_load_got_secondaryaddress
	jsr basic_parse_line_number
	lda LINNUM+1
	bne !+
	lda LINNUM+0
	sta SA
	jmp cmd_load_got_secondaryaddress
!:
	// Second parameter is above 255, this can not be a secondary address
	// Use it as load address instead
	// XXX temporary syntax, it would be better to use something
	// XXX like 'LOAD"FILE",8 TO 49152'
	ldx LINNUM+0
	ldy LINNUM+1
	bne got_loadaddress

cmd_load_got_secondaryaddress: // input for tape wedge
	ldy TXTTAB+1
	ldx TXTTAB+0

got_loadaddress:
	lda #$00 		// LOAD not verify
	jsr JLOAD
	php
	pha
	jsr print_return
	pla
	plp
	bcc load_no_error

	// A = KERNAL error code, which also almost match
	// basic ERROR codes
	tax
	dex
	bpl !+
	ldx #B_ERR_BREAK
!:
	jmp do_basic_error
	
load_no_error:
	// $YYXX is the last loaded address, so store it
	stx VARTAB+0
	sty VARTAB+1

	// Now relink the loaded program, as we cannot trust the line
	// links supplied. For example, the VICE virtual drive emulation
	// always supplies $0101 as the address of the next line.
	jsr LINKPRG
	
	// After LOADing, we either start the program from the beginning,
	// or go back to the READY prompt if LOAD was called from direct mode.

	// Reset to start of program
	jsr init_oldtxt

	// XXX - should run program if LOAD was used in program mode
	jmp basic_main_loop
