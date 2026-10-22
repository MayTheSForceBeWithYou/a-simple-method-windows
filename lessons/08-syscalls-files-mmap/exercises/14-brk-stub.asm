; 14-brk-stub.asm
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
EXTRN ex_14_brk_stub:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_14_brk_stub (student routine; defined in solutions/).
    call    ex_14_brk_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
