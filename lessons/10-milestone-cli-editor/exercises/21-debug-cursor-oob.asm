; 21-debug-cursor-oob.asm: Clamp out-of-range cursor, exit clamped value
.DATA?
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_cursor_oob:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_21_debug_cursor_oob (student routine; defined in solutions/).
    call    ex_21_debug_cursor_oob
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
