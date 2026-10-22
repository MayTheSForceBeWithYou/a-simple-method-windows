; Exercise 21: debug cursor oob
;
; BUG: cursor can exceed len. Clamp cur to len; start cur=9 len=3; exit 3.
;
; Build: ml64 /c 21-debug-cursor-oob.asm && link /OUT:21-debug-cursor-oob.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-debug-cursor-oob.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
cur QWORD ?
len QWORD ?

.code
ex_21_debug_cursor_oob PROC
    sub rsp, 40
    
    mov QWORD PTR [cur], 9
    mov QWORD PTR [len], 3
    
    mov rax, [cur]
    cmp rax, [len]
    jbe L_ok
    
    mov rax, [len]
    mov [cur], rax
    
L_ok:
        mov     eax, [cur]
    ret
    add     rsp, 40
ex_21_debug_cursor_oob ENDP
main PROC
    call    ex_21_debug_cursor_oob
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
