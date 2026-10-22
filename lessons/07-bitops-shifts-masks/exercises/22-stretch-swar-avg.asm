; 22-stretch-swar-avg.asm (stretch)
;
; Compute average of two unsigned bytes without overflow using SWAR technique.
;
; Task: Compute average of 200 and 180 using formula: (a & b) + ((a ^ b) >> 1).
;       This avoids overflow from (a + b) / 2 when a + b > 255.
;       Exit with the average (should be 190).
;
; Hint: This SWAR (SIMD Within A Register) trick splits the sum into
;       shared bits (a & b) and differing bits ((a ^ b) >> 1).

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_swar_avg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_swar_avg in this file.
    call    ex_22_stretch_swar_avg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
