; 09-xor-checksum.asm
;
; Compute a simple XOR checksum of a sequence of bytes.
;
; Task: XOR together the bytes: 0x12, 0x34, 0x56, 0x78.
;       Exit with the checksum.
;
; Hint: Start with a zero accumulator, then XOR each byte into it.
;       12 ^ 34 ^ 56 ^ 78 = ... (compute or test to verify)

.DATA
bytes DB 12h, 34h, 56h, 78h
bytes_len EQU $ - bytes

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    .endprolog
    
    xor     rax, rax        ; checksum = 0
    lea     rbx, bytes
    mov     r12, bytes_len
    
    ; TODO: Loop through bytes, XOR each into RAX
    
    mov     ecx, eax
    and     ecx, 0FFh       ; Low byte only
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
