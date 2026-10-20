; 13-munmap.asm
;
; Allocate memory with VirtualAlloc, then free it with VirtualFree, exit 0.
;
; Task: VirtualAlloc one page, VirtualFree it, exit 0.
;
; Hint: VirtualFree(address, 0, MEM_RELEASE) where MEM_RELEASE = 0x8000.

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
    
    ; TODO: VirtualAlloc
    .ERR <TODO: VirtualAlloc(NULL, 4096, 0x3000, 4)>
    
    ; TODO: Save address, VirtualFree
    .ERR <TODO: mov rbx, rax; VirtualFree(rbx, 0, 0x8000)>
    
    xor     ecx, ecx
    add     rsp, 32
    pop     rbx
    call    ExitProcess
main ENDP

END
