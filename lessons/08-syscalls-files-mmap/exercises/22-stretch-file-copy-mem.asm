; 22-stretch-file-copy-mem.asm (stretch)
;
; Allocate memory, copy four bytes from .DATA, sum them, exit with sum.
;
; Task: VirtualAlloc one page, copy four bytes from data section to allocated memory,
;       sum the four bytes, exit with sum.
;
; Hint: Use REP MOVSB or manual byte-by-byte copy.

.DATA
source DB 2, 3, 4, 1    ; Sum = 10

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    rsi
    .pushreg rsi
    push    rdi
    .pushreg rdi
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: VirtualAlloc
    .ERR <TODO: VirtualAlloc(NULL, 4096, 0x3000, 4)>
    
    ; TODO: Copy four bytes from source to allocated memory
    .ERR <TODO: Use MOVSB or manual copy>
    
    ; TODO: Sum the four bytes
    .ERR <TODO: Add bytes together>
    
    ; TODO: VirtualFree, exit with sum (should be 10)
    .ERR <TODO: VirtualFree, exit with sum>
    
    add     rsp, 32
    pop     rdi
    pop     rsi
    pop     rbx
    call    ExitProcess
main ENDP

END
