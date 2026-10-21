; Listing 11: Four-compare panel hit test (half-open)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    ; panel x=0 y=0 w=10 h=10; point px=5 py=5
    mov     rax, 5
    mov     rbx, 5
    cmp     rax, 0
    jl      miss
    cmp     rax, 10
    jge     miss
    cmp     rbx, 0
    jl      miss
    cmp     rbx, 10
    jge     miss
    mov     ecx, 1
    jmp     done
miss:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
