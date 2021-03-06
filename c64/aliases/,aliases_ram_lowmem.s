//
// Names of ZP and low memory locations:
// - Compute's Mapping the Commodore 64
// - https://www.c64-wiki.com/wiki/Zeropage
// - http://unusedino.de/ec64/technical/project64/memory_maps.html
//

	// $00-$01 - 6502 CPU registers are here

	//
	// Page 0 - BASIC area ($02-$8F)
	//

	//                 $02             -- UNUSED --          free for user software
	.label ADRAY1    = $03 // $03-$04
	.label ADRAY2    = $05 // $05-$06
	.label CHARAC    = $07 //          [!] our implementation might be different  XXX give more details
	.label ENDCHR    = $08 //          [!] our implementation might be different  XXX give more details
	.label TRMPOS    = $09 //          -- NOT IMPLEMENTED --
	.label VERCKB    = $0A //          -- NOT IMPLEMENTED --
	.label COUNT     = $0B //          [!] our implementation might be different  XXX give more details
	.label DIMFLG    = $0C //          [!] our implementation might be different  XXX give more details
	.label VALTYP    = $0D //          -- NOT IMPLEMENTED --
	.label INTFLG    = $0E //          -- NOT IMPLEMENTED --
	.label GARBFL    = $0F //          [!] our implementation might be different  XXX give more details
	.label SUBFLG    = $10 //          -- NOT IMPLEMENTED --
	.label INPFLG    = $11 //          -- NOT IMPLEMENTED --
	.label TANSGN    = $12 //          -- NOT IMPLEMENTED --
	.label CHANNL    = $13 //          -- NOT IMPLEMENTED --
	.label LINNUM    = $14 // $14-$15  BASIC line number, [!] also used by DOS Wedge
	.label TEMPPT    = $16 //          -- NOT IMPLEMENTED --
	.label LASTPT    = $17 // $17-$18  -- NOT IMPLEMENTED --
	.label TEMPST    = $19 // $19-$21  -- NOT IMPLEMENTED --
	.label INDEX     = $22 // $22-$25  -- NOT IMPLEMENTED -- temporary variables
	.label RESHO     = $26 // $26-$2A  -- NOT IMPLEMENTED --
	.label TXTTAB    = $2B // $2B-$2C  start of BASIC code
	.label VARTAB    = $2D // $2D-$2E  end of BASIC code, start of variables
	.label ARYTAB    = $2F // $2F-$30  -- NOT IMPLEMENTED --
	.label STREND    = $31 // $31-$32  -- NOT IMPLEMENTED --
	.label FRETOP    = $33 // $33-$34  -- NOT IMPLEMENTED --
	.label FRESPC    = $35 // $35-$36  [!] our implementation uses this as temporary string pointer
	.label MEMSIZ    = $37 // $37-$38  highest address of BASIC memory + 1
	.label CURLIN    = $39 // $39-$3A  current BASIC line number
	.label OLDLIN    = $3B // $3B-$3C  previous BASIC line number
	.label OLDTXT    = $3D // $3D-$3E  current BASIC line pointer
	.label DATLIN    = $3F // $3F-$40  -- NOT IMPLEMENTED --
	.label DATPTR    = $41 // $41-$42  -- NOT IMPLEMENTED --
	.label INPPTR    = $43 // $43-$44  -- NOT IMPLEMENTED --
	.label VARNAM    = $45 // $45-$46  -- NOT IMPLEMENTED --
	.label VARPNT    = $47 // $47-$48  -- NOT IMPLEMENTED --
	.label FORPNT    = $49 // $49-$4A  -- NOT IMPLEMENTED --
	.label OPPTR     = $4B // $4B-$4C  -- NOT IMPLEMENTED --
	.label OPMASK    = $4D //          -- NOT IMPLEMENTED --
	.label DEFPNT    = $4E // $4E-$4F  -- NOT IMPLEMENTED --
	.label DSCPNT    = $50 // $50-$52  -- NOT IMPLEMENTED --
	.label FOUR6     = $53 //          -- NOT IMPLEMENTED --
	.label JMPER     = $54 // $54-$56  -- NOT IMPLEMENTED --
	.label TEMPF1    = $57 // $57-$5B  BASIC numeric work area
	.label TEMPF2    = $5C // $5C-$60  BASIC numeric work area

	.label __FAC1    = $61 // $61-$66  floating point accumulator 1
	.label FAC1_exponent   = $61
	.label FAC1_mantissa   = $62 // $62 - $65
	.label FAC1_sign       = $66

	.label SGNFLG    = $67 //          -- NOT IMPLEMENTED --
	.label BITS      = $68 //          FAC1 overflow

	.label __FAC2    = $69 // $69-$6E  floating point accumulator 2 [!] also used for memory move pointers
	.label FAC2_exponent   = $69
	.label FAC2_mantissa   = $6A // $6A - $6D
	.label FAC2_sign       = $6E

	.label ARISGN    = $6F //          -- NOT IMPLEMENTED --
	.label FACOV     = $70 //          FAC1 low order mantissa
	.label FBUFPT    = $71 // $71-$72  -- NOT IMPLEMENTED --
	.label CHRGET    = $73 // $73-$8A  -- NOT IMPLEMENTED --
	.label TXTPTR    = $7A // $7A-$7B  current BASIC statement pointer
	.label RNDX      = $8B // $8B-$8F  -- NOT IMPLEMENTED --

	//
	// Page 0 - Kernal area ($90-$FF)
	//
	
	.label IOSTATUS  = $90
	.label STKEY     = $91  //          Keys down clears bits. STOP - bit 7, C= - bit 6, SPACE - bit 4, CTRL - bit 2
	.label SVXT      = $92  //          -- NOT IMPLEMENTED --
	.label VERCKK    = $93  //          0 = LOAD, 1 = VERIFY
	.label C3PO      = $94  //          flag - is BSOUR content valid
	.label BSOUR     = $95  //          serial bus buffered output byte
	.label SYNO      = $96  //          temporary tape routines storage, [!] our usage differs
	.label XSAV      = $97  //          temporary register storage for ASCII/tape related routines [!] usage details might differ
	.label LDTND     = $98  //          number of entries in LAT / FAT / SAT tables
	.label DFLTN     = $99  //          default input device
	.label DFLTO     = $9A  //          default output device
	.label PRTY      = $9B  //          tape storage for parity/checksum
#if !CONFIG_TAPE_NORMAL && !CONFIG_TAPE_TURBO	
	.label DPSW      = $9C  //          -- NOT IMPLEMENTED --
#else
    .label COLSTORE  = $9C  //          [!] screen border storage for tape routines 
#endif
	.label MSGFLG    = $9D  //          bit 6 = error messages, bit 7 = control message
	.label PTR1      = $9E  //          -- NOT IMPLEMENTED --
	.label PTR2      = $9F  //          -- NOT IMPLEMENTED --
	.label TIME      = $A0  // $A0-$A2  jiffy clock
#if !CONFIG_IEC_JIFFYDOS && !CONFIG_IEC_DOLPHINDOS && !CONFIG_IEC_BURST_CIA1 && !CONFIG_IEC_BURST_CIA2 && !CONFIG_IEC_BURST_SOFT
	.label TSFCNT    = $A3  //          temporary variable for tape and IEC, [!] our usage differs
#else
	.label IECPROTO  = $A3  //          -- WIP -- [!] 0 = normal, 1 = JiffyDOS, >= $80 for unknown
#endif
	.label TBTCNT    = $A4  //          temporary variable for tape and IEC, [!] our usage probably differs in details
	.label CNTDN     = $A5  //          -- NOT IMPLEMENTED --
	.label BUFPNT    = $A6  //          -- NOT IMPLEMENTED --
	.label INBIT     = $A7  //          temporary storage for tape / RS-232 received bits
#if !CONFIG_LEGACY_SCNKEY
	.label BITCI     = $A8  //          -- NOT IMPLEMENTED --
	.label RINONE    = $A9  //          -- WIP -- (UP9600 only) RS-232 check for start bit flag
	.label RIDDATA   = $AA  //          -- NOT IMPLEMENTED --
	.label RIPRTY    = $AB  //          -- WIP -- checksum while reading tape
#endif
	.label SAL       = $AC  // $AC-$AD  -- NOT IMPLEMENTED -- (implemented screen part)
	.label EAL       = $AE  // $AE-$AF  -- NOT IMPLEMENTED -- [!] used also by screen editor, for temporary color storage when scrolling
	.label CMP0      = $B0  // $B0-$B1  temporary tape storage, [!] here used for BRK instruction address
	.label TAPE1     = $B2  // $B2-$B3  tape buffer pointer
#if !CONFIG_LEGACY_SCNKEY
	.label BITTS     = $B4  //          -- NOT IMPLEMENTED --
#endif
	.label NXTBIT    = $B5  //          -- NOT IMPLEMENTED --
#if !CONFIG_LEGACY_SCNKEY
	.label RODATA    = $B6  //          -- NOT IMPLEMENTED --
#endif

	.label FNLEN     = $B7  //          current file name length
	.label LA        = $B8  //          current logical_file number
	.label SA        = $B9  //          current secondary address
	.label FA        = $BA  //          current device number
	.label FNADDR    = $BB  // $BB-$BC  current file name pointer
	.label ROPRTY    = $BD  //          -- NOT IMPLEMENTED -- tape / RS-232 temporary storage
	.label FSBLK     = $BE  //          -- NOT IMPLEMENTED -- tape / RS-232 temporary storage
	.label MYCH      = $BF  //          -- NOT IMPLEMENTED --
	.label CAS1      = $C0  //          tape motor interlock
	.label STAL      = $C1  // $C1-$C2  LOAD/SAVE start address
	.label MEMUSS    = $C3  // $C3-$C4  temporary address for tape LOAD/SAVE
	.label LSTX      = $C5  //          last key matrix position [!] our usage probably differs in details
	.label NDX       = $C6  //          number of chars in keyboard buffer
	.label RVS       = $C7  //          flag, whether to print reversed characters
	.label INDX      = $C8  //          end of logical line (column, 0-79)
	.label LXSP      = $C9  // $C9-$CA  start of input, X/Y position
	.label SFDX      = $CB  //          -- NOT IMPLEMENTED --
	.label BLNSW     = $CC  //          cursor blink disable flag
	.label BLNCT     = $CD  //          cursor blink countdown
	.label GDBLN     = $CE  //          cursor saved character
	.label BLNON     = $CF  //          cursor visibility flag
	.label CRSW      = $D0  //          whether to input from screen or keyboard
	.label PNT       = $D1  // $D1-$D2  pointer to the current screen line
	.label PNTR      = $D3  //          current screen X position (logical column), 0-79
	.label QTSW      = $D4  //          quote mode flag
	.label LNMX      = $D5  //          logical line length, 39 or 79
	.label TBLX      = $D6  //          current screen Y position (row), 0-24
	.label SCHAR     = $D7  //          ASCII value of the last printed character
	.label INSRT     = $D8  //          insert mode flag/counter
	.label LDTBL     = $D9  // $D9-$F2  screen line link table, [!] our usage is different  XXX give more details
	.label USER      = $F3  // $F3-$F4  pointer to current color RAM location
	.label KEYTAB    = $F5  // $F5-$F6  pointer to keyboard lookup table
	.label RIBUF     = $F7  // $F7-$F8  -- WIP -- RS-232 receive buffer pointer
	.label ROBUF     = $F9  // $F9-$FA  -- WIP -- RS-232 send buffer pointer
	//                 $FB     $FB-$FE  -- UNUSED --          free for user software
	.label BASZPT    = $FF  //          -- NOT IMPLEMENTED --

	//
	// Page 1
	//

	.label STACK     = $100  // $100-$1FF, processor stack

	//
	// Pages 2 & 3
	//
    
	.label BUF       = $200  // $200-$250, BASIC line editor input buffer (81 bytes)

	// $250-$258 is the 81st - 88th characters in BASIC input, a carry over from VIC-20
	// and not used on C64 - they are used if CONFIG_LEGACY_SCNKEY is enabled.

	// [!] XXX document $251-$258 usage
	.label LAT       = $259  // $259-$262, logical file numbers (table, 10 bytes)
	.label FAT       = $263  // $263-$26C, device numbers       (table, 10 bytes)
	.label SAT       = $26D  // $26D-$276, secondary addresses  (table, 10 bytes)
	.label KEYD      = $277  // $277-$280, keyboard buffer
	.label MEMSTR    = $281  // $281-$282, start of BASIC memory
	.label MEMSIZK   = $283  // $283-$284, NOTE: Mapping the 64 erroneously has the hex as $282 (DEC is correct)
	.label TIMOUT    = $285  //            IEEE-488 timeout
	.label COLOR     = $286  //            current text foreground color
	.label GDCOL     = $287  //            color of character under cursor
	.label HIBASE    = $288  //            high byte of start of screen
	.label XMAX      = $289  //            max keyboard buffer size
	.label RPTFLG    = $28A  //            whether to repeat keys (highest bit set = repeat)
	.label KOUNT     = $28B  //            key repeat counter
	.label DELAY     = $28C  //            -- NOT IMPLEMENTED --
	.label SHFLAG    = $28D  //            bucky keys (SHIFT/CTRL/C=) flags
	.label LSTSHF    = $28E  //            last bucky key flags
	.label KEYLOG    = $28F  // $28F-$290  routine to setup keyboard decoding
	.label MODE      = $291  //            flag, is case switch allowed
	.label AUTODN    = $292  //            -- NOT IMPLEMENTED -- screen scroll disable
#if !CONFIG_LEGACY_SCNKEY
	.label M51CRT    = $293  //            -- NOT IMPLEMENTED -- mock 6551
	.label M51CDR    = $294  //            -- NOT IMPLEMENTED -- mock 6551
	.label M51AJB    = $295  // $295-$296  -- NOT IMPLEMENTED -- mock 6551
	.label RSSTAT    = $297  //            -- WIP -- (UP9600 only) mock 6551, RS-232 status
	.label BITNUM    = $298  //            -- NOT IMPLEMENTED --
	.label BAUDOF    = $299  // $299-$29A  -- NOT IMPLEMENTED --
#endif
	.label RIDBE     = $29B  //            -- WIP -- write pointer into RS-232 receive buffer
	.label RIDBS     = $29C  //            -- WIP -- read pointer into RS-232 receive buffer
	.label RODBS     = $29D  //            -- WIP -- read pointer into RS-232 send buffer
	.label RODBE     = $29E  //            -- WIP -- write pointer into RS-232 send buffer
	.label IRQTMP    = $29F  // $29F-$2A0  temporary IRQ vector storage [!] we use it for tape speed calibration instead
	.label ENABL     = $2A1  //            -- NOT IMPLEMENTED --
	.label TODSNS    = $2A2  //            -- NOT IMPLEMENTED --
	.label TRDTMP    = $2A3  //            -- NOT IMPLEMENTED --
	.label TD1IRQ    = $2A4  //            -- NOT IMPLEMENTED --
	.label TLNIDX    = $2A5  //            -- NOT IMPLEMENTED --
	.label TVSFLG    = $2A6  //            0 = NTSC, 1 = PAL
	
	// [!] $2A7-$2FF is normally free, but in our case some extra functionality uses it

#if CONFIG_MEMORY_MODEL_60K

	// IRQs are disabled when doing such accesses, and a default NMI handler only increments
	// a counter, so that if an NMI occurs, it doesn't crash the machine, but can be captured.

	.label missed_nmi_flag  = $2A7
	.label tiny_nmi_handler = $2A8
	.label peek_under_roms  = tiny_nmi_handler + peek_under_roms_routine - tiny_nmi_handler_routine
	.label poke_under_roms  = tiny_nmi_handler + poke_under_roms_routine - tiny_nmi_handler_routine
	.label memmap_allram    = tiny_nmi_handler + memmap_allram_routine   - tiny_nmi_handler_routine
	.label memmap_normal    = tiny_nmi_handler + memmap_normal_routine   - tiny_nmi_handler_routine
#if SEGMENT_BASIC
	.label shift_mem_up     = tiny_nmi_handler + shift_mem_up_routine    - tiny_nmi_handler_routine
	.label shift_mem_down   = tiny_nmi_handler + shift_mem_down_routine  - tiny_nmi_handler_routine
#endif

#endif // CONFIG_MEMORY_MODEL_60K

	// BASIC vectors
	.label IERROR    = $300  // $300-$301
	.label IMAIN     = $302  // $302-$303
	.label ICRNCH    = $304  // $304-$305
	.label IQPLOP    = $306  // $306-$307
	.label IGONE     = $308  // $308-$309
	.label IEVAL     = $30A  // $30A-$30B
	
	.label SAREG     = $30C  //            .A storage, for SYS call
	.label SXREG     = $30D  //            .X storage, for SYS call
	.label SYREG     = $30E  //            .Y storage, for SYS call
	.label SPREG     = $30F  //            .P storage, for SYS call

	.label USRPOK    = $310  //            -- NOT IMPLEMENTED -- JMP instruction
	.label USRADD    = $311  // $311-$312  -- NOT IMPLEMENTED --
	//                 $313                -- UNUSED --          free for user software
	
	// Kernal vectors - interrupts
	.label CINV      = $314  // $314-$315
	.label CBINV     = $316  // $316-$317
	.label NMINV     = $318  // $318-$319
	
	// Kernal vectors - routines
	.label IOPEN     = $31A  // $31A-$31B
	.label ICLOSE    = $31C  // $31C-$31D
	.label ICHKIN    = $31E  // $31E-$31F
	.label ICKOUT    = $320  // $320-$321
	.label ICLRCH    = $322  // $322-$323
	.label IBASIN    = $324  // $324-$325
	.label IBSOUT    = $326  // $326-$327
	.label ISTOP     = $328  // $328-$329
	.label IGETIN    = $32A  // $32A-$32B
	.label ICLALL    = $32C  // $32C-$32D
	.label USRCMD    = $32E  // $32E-$32F
	.label ILOAD     = $330  // $330-$331
	.label ISAVE     = $332  // $332-$333

	//                 $314     $334-$33B  -- UNUSED --          free for user software
	
#if !CONFIG_RS232_UP9600
	.label TBUFFR    = $33C  // $33C-$3FB  [!] tape buffer, our usage details differ
#else
    .label REVTAB    = $37C  // $37C-$3FB  -- WIP -- [!] RS-232 precalculated data
#endif

	//                 $3FC     $3FC-$3FF  -- UNUSED --          free for user software
