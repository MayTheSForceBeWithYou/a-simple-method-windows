; Exercise 17: utf8 ascii cursor
;
; ASCII-only: moving right increments cursor by 1; exit 5 after 5 moves.
;
; Build: ml64 /c 17-utf8-ascii-cursor.asm && link /OUT:17-utf8-ascii-cursor.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-utf8-ascii-cursor.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.data?
cur QWORD ?

.code
ex_17_utf8_ascii_cursor PROC
    sub rsp, 40
    
    mov QWORD PTR [cur], 0
    mov rcx, 5
    
L_l:
    inc QWORD PTR [cur]
    loop L_l
    
        mov     eax, [cur]
    ret

ex_17_utf8_ascii_cursor ENDP
main PROC
    call    ex_17_utf8_ascii_cursor
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
