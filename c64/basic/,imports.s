
// Routines imported from Kernal - our private API

#if ROM_LAYOUT_STD
	#import "KERNAL_combined.sym"
#else
	#import "KERNAL_0_combined.sym"
#endif


.function KERNAL()
{
#if ROM_LAYOUT_STD
	.return KERNAL
#else
	.return KERNAL_0
#endif
}


#if CONFIG_PANIC_SCREEN
.label panic               = KERNAL().panic
#endif

.label hw_entry_reset      = KERNAL().hw_entry_reset

#if CONFIG_DBG_PRINTF
.label printf              = KERNAL().printf
#endif

.label plot_set            = KERNAL().plot_set
.label print_hex_byte      = KERNAL().print_hex_byte
.label print_return        = KERNAL().print_return
.label print_space         = KERNAL().print_space

#if CONFIG_SHOW_FEATURES
.label print_features      = KERNAL().print_features
#endif

#if CONFIG_SHOW_PAL_NTSC
.label print_pal_ntsc      = KERNAL().print_pal_ntsc
#endif
