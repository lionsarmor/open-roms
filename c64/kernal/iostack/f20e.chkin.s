// #LAYOUT# STD *        #TAKE
// #LAYOUT# *   KERNAL_0 #TAKE
// #LAYOUT# *   *        #IGNORE

//
// Official Kernal routines, described in:
//
// - [RG64] C64 Programmers Reference Guide   - page 275
// - [CM64] Computes Mapping the Commodore 64 - page 229
//
// CPU registers that has to be preserved (see [RG64]): .Y, .A (see [CM64], page 213)
//


CHKIN:

	// Store registers for preservation
	pha
	phy_trash_a

	// Reset status
	jsr kernalstatus_reset

	// First retrieve the FAT/LAT/SAT table index (and check if file is open)

	txa
	jsr find_fls
	bcs_16 chkinout_file_not_open

	// Now we have table index in Y

	lda FAT,Y

	// Handle all the devices

	beq chkin_set_device // 0 - keyboard

	// Tape not supported here

#if HAS_RS232

	cmp #$02
	beq_16 chkin_rs232

#endif // HAS_RS232

#if CONFIG_IEC

	jsr iec_check_devnum_oc
	bcc_16 chkin_iec

#endif // CONFIG_IEC

	cmp #$03 // screen - only legal one left
	bne_16 chkinout_device_not_present

chkin_set_device:
	lda FAT,Y
	sta DFLTN

	// FALLTROUGH

chkinout_end:
	ply_trash_a
	pla
	clc // indicate success
	rts

chkin_file_not_input:
	ply_trash_a
	pla
	jmp kernalerror_FILE_NOT_INPUT
