; Listing 18: MY_ADDR EQU OFFSET msg (LESSON.md block 18)
;
; Purpose: Assembly-time offset of a data label equals distance from segment base.
; Expected exit: 0
; Expected stdout: (none)

.DATA
msg BYTE "Z", 0

MY_ADDR EQU OFFSET msg

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; MY_ADDR (= OFFSET msg) is 0 when msg is the first object in this .data segment.
    mov     ecx, 0
    call    ExitProcess
main ENDP

END
