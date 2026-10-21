; 12-mmap-write-read.asm
;
; Allocate memory, store 99 at offset 100, read it back, exit 99.
;
; Task: VirtualAlloc 4096 bytes, write 99 at [base+100], read back, exit 99.
;
; Hint: VirtualAlloc, mov BYTE PTR [rax+100], 99, movzx ecx, BYTE PTR [rax+100]

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: VirtualAlloc 4096 bytes
    
    ; TODO: Store 99 at offset 100
    
    ; TODO: Read back and exit with value
    
    ; TODO: VirtualFree
    mov ecx, 1
    call ExitProcess
main ENDP

END
