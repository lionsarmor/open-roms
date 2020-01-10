#if ROM_LAYOUT_STD || (ROM_LAYOUT_M65 && SEGMENT_BASIC_0)


basic_follow_link_to_next_line:
	ldy #0

#if CONFIG_MEMORY_MODEL_60K
	ldx #<OLDTXT+0
	jsr peek_under_roms
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	pha
	iny

#if CONFIG_MEMORY_MODEL_60K
	jsr peek_under_roms
#else // CONFIG_MEMORY_MODEL_38K
	lda (OLDTXT),y
#endif

	sta OLDTXT+1
	pla
	sta OLDTXT+0
	rts


#endif // ROM layout
