; Exercise: 10-word-dword
;
; WORD 01122h, DWORD 033445566h. Load low byte of the word into cl via BYTE PTR [label], exit.
; Expected exit: 34
;
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
