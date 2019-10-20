
//
// Official Kernal routine, described in:
//
// - [RG64] C64 Programmer's Reference Guide   - page 280
// - [CM64] Compute's Mapping the Commodore 64 - page 242
//
// CPU registers that has to be preserved (see [RG64]): none
//

CINT:

	// Setup video and I/O
	jsr setup_vicii

	jmp cint_screen_keyboard
