; Listing 13: Track piece direction connect rule
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 1
    mov     rbx, 3
    mov     rcx, rbx
    add     rcx, 2
    and     rcx, 3
    cmp     rax, rcx
    je      connected
    xor     ecx, ecx
    jmp     done
connected:
    mov     ecx, 1
done:
    call    ExitProcess
main ENDP
END
