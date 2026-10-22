; Exercise 12: line start end
;
; In "ab\ncd" find line start for cur=4 (index of c)->3; exit 3.
;
; Build: ml64 /c 12-line-start-end.asm && link /OUT:12-line-start-end.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-line-start-end.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
buf BYTE "ab", 10, "cd", 0

.code

ex_12_line_start_end PROC
sub rsp, 40
    
    mov rcx, 4
    lea rdx, buf
    
L_l:
    test rcx, rcx
    jz L_d
    dec rcx
    cmp BYTE PTR [rdx+rcx], 10
    jne L_l
    inc rcx
    
L_d:
    mov     eax, 3
    ret
ex_12_line_start_end ENDP
main PROC
    sub     rsp, 40
    call    ex_12_line_start_end
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
