; Exercise: 13-virtualfree
;
; Exercise 13: munmap
; VirtualAlloc then VirtualFree; exit 0 if VirtualFree succeeds.
;
; Contract: implement `ex_13_virtualfree` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

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
