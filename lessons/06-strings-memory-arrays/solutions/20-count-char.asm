; Exercise 20: count char
;
; Count 's' in 'mississippi' -> 4.
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
s BYTE "mississippi", 0

.code
main PROC
    sub rsp, 40
    lea rdx, s
    xor rcx, rcx
count_loop:
    movzx rax, BYTE PTR [rdx]
    test rax, rax
    jz count_done
    cmp al, 's'
    jne count_next
    inc rcx
count_next:
    inc rdx
    jmp count_loop
count_done:
    call ExitProcess
main ENDP
END
