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
    .ERR <TODO: VirtualAlloc(NULL, 4096, 0x3000, 4)>
    
    ; TODO: Store 99 at offset 100
    .ERR <TODO: mov BYTE PTR [rax+100], 99>
    
    ; TODO: Read back and exit with value
    .ERR <TODO: movzx ecx, BYTE PTR [rax+100]>
    
    ; TODO: VirtualFree
    .ERR <TODO: VirtualFree(address, 0, 0x8000)>
    
    add     rsp, 32
    pop     rbx
    call    ExitProcess
main ENDP

END
