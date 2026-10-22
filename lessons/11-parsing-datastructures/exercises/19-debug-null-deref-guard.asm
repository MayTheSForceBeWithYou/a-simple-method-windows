; Exercise 19: debug null deref guard
; BUG: walks next without null check. Fix empty list sum=0.
; Expected exit: 0

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_null_deref_guard:PROC

sum_list_bug PROC
    xor rcx, rcx
    xor rsi, rsi                ; empty list head = NULL
    ; BUG: dereference without null test
    add rcx, QWORD PTR [rsi]
    mov rsi, QWORD PTR [rsi+8]
    mov rax, rcx
    ret
sum_list_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_null_deref_guard in this file.
    call    ex_19_debug_null_deref_guard
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
