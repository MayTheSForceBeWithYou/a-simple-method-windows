; 20-mmap-pagesize-fill.asm
;
; Allocate one page, fill first 16 bytes with 1, exit with 16.
;
; Task: VirtualAlloc 4096 bytes, fill bytes 0-15 with value 1, exit 16.
;
; Hint: Use a loop to store 1 into each of the first 16 bytes.

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: VirtualAlloc
    
    ; TODO: Fill first 16 bytes with 1
    
    ; TODO: VirtualFree, exit 16
    
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
