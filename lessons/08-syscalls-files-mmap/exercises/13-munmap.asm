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
    
    ; TODO: Save address, VirtualFree
    mov ecx, 1
    call ExitProcess
main ENDP

END
