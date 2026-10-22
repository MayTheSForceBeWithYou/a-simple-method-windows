; 21-debug-cursor-oob.asm: Clamp out-of-range cursor, exit clamped value
.DATA?
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_cursor_oob:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_cursor_oob in this file.
    call    ex_21_debug_cursor_oob
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
