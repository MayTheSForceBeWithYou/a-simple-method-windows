; Listing 08: Half-open clip test x in [0, width)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 5
    cmp     rax, 4
    jl      in_range
    mov     ecx, 1
    jmp     done
in_range:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
