; 13-munmap.asm
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
EXTRN ex_13_munmap:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_13_munmap (student routine; defined in solutions/).
    call    ex_13_munmap
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
