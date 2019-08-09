
;;
;; Official Kernal routine, described in:
;;
;; - [RG64] C64 Programmer's Reference Guide   - page 300
;; - [CM64] Compute's Mapping the Commodore 64 - page 239
;;
;; CPU registers that has to be preserved (see [RG64]): .A, .X, .Y
;;

settmo:
	sta TIMOUT
	rts
