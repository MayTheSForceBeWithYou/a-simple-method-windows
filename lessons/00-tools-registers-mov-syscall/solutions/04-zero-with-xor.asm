; Exercise 04: zero with xor
;
; Zero rdi using xor, then exit 0. No mov immediate.
;
; Build: ml64 /c 04-zero-with-xor.asm && link /OUT:04-zero-with-xor.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-zero-with-xor.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_04_zero_with_xor PROC
    sub rsp, 40
    xor rcx, rcx
    mov     eax, 0
    add     rsp, 40
    ret
ex_04_zero_with_xor ENDP
main PROC
    call    ex_04_zero_with_xor
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
