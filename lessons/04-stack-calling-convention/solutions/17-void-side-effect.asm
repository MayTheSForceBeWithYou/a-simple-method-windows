; Exercise: 17-void-side-effect
;
; Write '!' and newline. MS x64 ABI.
; Expected stdout: "!\n"
; Expected exit: 0
;
.data
buf BYTE 0, 10

.code
ex_17_void_side_effect PROC
    sub rsp, 56
    mov cl, '!'
    lea rdx, buf
    call store_byte
    mov rcx, -11
    call GetStdHandle
    mov rcx, rax
    lea rdx, buf
    mov r8, 2
    lea r9, [rsp+32]
    mov QWORD PTR [rsp+40], 0
    call WriteFile
    xor rcx, rcx
    mov     eax, ecx
    add     rsp, 56
    ret
ex_17_void_side_effect ENDP
main PROC
    sub     rsp, 40
    call    ex_17_void_side_effect
    mov     rcx, rax
    call    ExitProcess
main ENDP

store_byte PROC
    mov BYTE PTR [rdx], cl
    ret
store_byte ENDP
END
