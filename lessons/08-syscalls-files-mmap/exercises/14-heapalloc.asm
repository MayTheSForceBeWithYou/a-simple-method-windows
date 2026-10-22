; 14-heapalloc.asm
;
; Windows doesn't have brk. Demonstrate VirtualAlloc instead, exit 0.
;
; Task: VirtualAlloc one page, check for nonzero, exit 0 if successful.
;
; Hint: This exercise adapts the Linux brk concept to Windows VirtualAlloc.

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_14_heapalloc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_heapalloc in this file.
    call    ex_14_heapalloc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
