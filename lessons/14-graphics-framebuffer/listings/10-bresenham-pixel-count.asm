; Listing 10: Bresenham line (0,0)-(3,0) plots 4 pixels
; Expected exit: 4
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 0
    mov     rbx, 3
    mov     rcx, 0
plot_loop:
    cmp     rax, rbx
    jg      done
    inc     rcx
    inc     rax
    jmp     plot_loop
done:
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
