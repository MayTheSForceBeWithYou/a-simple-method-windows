; 09-xor-checksum.asm
;
; Compute a simple XOR checksum of a sequence of bytes.
;
; Task: XOR together the bytes: 012h, 034h, 056h, 078h.
;       Exit with the checksum.
;
; Hint: Start with a zero accumulator, then XOR each byte into it.
;       12 ^ 34 ^ 56 ^ 78 = ... (compute or test to verify)

.DATA
bytes DB 12h, 34h, 56h, 78h
bytes_len EQU $ - bytes

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_xor_checksum:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_xor_checksum in this file.
    call    ex_09_xor_checksum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
