; Listing 12: Two-key chord (W and Shift both down)
; Expected exit: 1
; Expected stdout: (none)

.DATA?
key_w BYTE ?
key_shift BYTE ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     BYTE PTR key_w, 1
    mov     BYTE PTR key_shift, 1
    movzx   eax, BYTE PTR key_w
    and     al, BYTE PTR key_shift
    movzx   ecx, al
    call    ExitProcess
main ENDP
END
