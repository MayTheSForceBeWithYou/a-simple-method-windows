; Listing 14: Fixed 100-tick simulation loop
; Expected exit: 100
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     rax, rax
tick_loop:
    cmp     rax, 100
    jge     tick_done
    inc     rax
    jmp     tick_loop
tick_done:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
