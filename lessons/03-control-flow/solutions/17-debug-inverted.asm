; Exercise: 17-debug-inverted
;
; BUG: jl used where jg needed. rax=5 should take 'big' path exit 2.
; Expected exit: 2
;
.code
ex_17_debug_inverted PROC
    sub rsp, 40
    mov rax, 5
    cmp rax, 3
    jg big
    mov rcx, 1
    jmp L_done
big:
    mov rcx, 2
L_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_debug_inverted ENDP
main PROC
    sub     rsp, 40
    call    ex_17_debug_inverted
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
