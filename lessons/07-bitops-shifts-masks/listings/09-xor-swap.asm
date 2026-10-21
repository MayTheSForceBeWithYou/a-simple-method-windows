; 09-xor-swap.asm
;
; Purpose: Demonstrate XOR-based register swap without a temporary
; Expected exit code: 42
; Expected stdout: (none)
;
; Swaps two registers using three XOR operations.
; Note: This technique requires distinct registers and is fragile
; (a signal mid-swap can tear values). Prefer XCHG for real swaps.

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     rcx, 5          ; a = 5
    mov     rdx, 42         ; b = 42
    
    ; XOR swap algorithm:
    xor     rcx, rdx        ; a ^= b  → a = 5^42 = 47
    xor     rdx, rcx        ; b ^= a  → b = 42^47 = 5
    xor     rcx, rdx        ; a ^= b  → a = 47^5 = 42
    
    ; Now: rcx=42, rdx=5 (swapped)
    
    call    ExitProcess     ; Exit with 42
main ENDP

END
