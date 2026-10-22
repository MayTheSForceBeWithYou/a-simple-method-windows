; Listing 06: Fixed timestep division (LESSON.md block 6)
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 50
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
