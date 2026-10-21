; Listing 18: MY_ADDR EQU OFFSET msg (LESSON.md block 18)
;
; Purpose: Assembly-time offset of a data label equals distance from segment base.
; Expected exit: 0 (low byte of OFFSET msg for flat .data at start)
; Expected stdout: (none)

.DATA
msg BYTE "Z", 0

MY_ADDR EQU OFFSET msg

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 32
    .allocstack 32
    .endprolog
    mov ecx, MY_ADDR
    call ExitProcess
main ENDP

END
