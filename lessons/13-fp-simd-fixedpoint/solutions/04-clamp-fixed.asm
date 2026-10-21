; Exercise 04: clamp fixed
;
; Clamp Q16.16 value 10<<16 to max 8<<16; exit 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, 10 SHL 16
    mov ebx, 8 SHL 16
    cmp eax, ebx
    jle clamp_ok
    mov eax, ebx
clamp_ok:
    shr eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
