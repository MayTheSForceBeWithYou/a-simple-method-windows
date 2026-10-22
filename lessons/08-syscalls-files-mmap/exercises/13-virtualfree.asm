; 13-virtualfree.asm
;
; Allocate memory with VirtualAlloc, then free it with VirtualFree, exit 0.
;
; Task: VirtualAlloc one page, VirtualFree it, exit 0.
;
; Hint: VirtualFree(address, 0, MEM_RELEASE) where MEM_RELEASE = 08000h.

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_13_virtualfree:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_virtualfree in this file.
    call    ex_13_virtualfree
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
