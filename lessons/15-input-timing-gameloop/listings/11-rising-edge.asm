; Listing 11: Rising edge prev==0 && cur==1
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 0
    mov     ebx, 1
    cmp     eax, 0
    jne     not_rising
    cmp     ebx, 1
    jne     not_rising
    mov     ecx, 1
    jmp     exit_proc
not_rising:
    xor     ecx, ecx
exit_proc:
    call    ExitProcess
main ENDP
END
