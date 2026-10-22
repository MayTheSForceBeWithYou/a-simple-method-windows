; Exercise: 21-debug-cursor-oob
;
; BUG: cursor can exceed len. Clamp cur to len; start cur=9 len=3; exit 3.
;
; Contract: implement `ex_21_debug_cursor_oob` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA?
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_cursor_oob:PROC

clamp_bug PROC
    mov QWORD PTR [cur], 9
    mov QWORD PTR [len], 3
    mov rax, QWORD PTR [cur]
    ; BUG: no compare/clamp against len
    ret
clamp_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_cursor_oob in this file.
    call    ex_21_debug_cursor_oob
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
