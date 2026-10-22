; Exercise 10: word dword
;
; WORD 0x1122, DWORD 0x33445566. Load low byte of the word into cl via BYTE PTR [label], exit.
;
; Build: ml64 /c 10-word-dword.asm && link /OUT:10-word-dword.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-word-dword.obj kernel32.lib
;
; Expected exit: 34

EXTERN ExitProcess:PROC

.data
w WORD 01122h
d DWORD 033445566h

.code
ex_10_word_dword PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [w]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_word_dword ENDP
main PROC
    sub     rsp, 40
    call    ex_10_word_dword
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
