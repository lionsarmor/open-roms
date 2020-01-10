#if ROM_LAYOUT_STD || (ROM_LAYOUT_M65 && SEGMENT_KERNAL_0)

//
// Timer values for PAL/NTSC - low bytes
//

// Based on UP9600 code by Daniel Dallman with Bo Zimmerman adaptations


#if CONFIG_RS232_UP9600


up9600_ilotab:

	.byte $95
	.byte $25


#endif // CONFIG_RS232_UP9600


#endif // ROM layout
