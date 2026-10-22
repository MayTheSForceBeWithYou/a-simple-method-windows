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
EXTRN ex_09_xor_checksum:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_09_xor_checksum (student routine; defined in solutions/).
    call    ex_09_xor_checksum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
