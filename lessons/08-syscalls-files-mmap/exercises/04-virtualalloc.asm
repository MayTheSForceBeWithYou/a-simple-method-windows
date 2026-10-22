; Exercise: 04-virtualalloc
;
; Exercise 04: mmap anon
; VirtualAlloc 4096 bytes RW; store 42; exit 42.
;
; Contract: implement `ex_04_virtualalloc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; 04-virtualalloc.asm
;
; Allocate memory with VirtualAlloc, store 42, exit with that value.
;
; Task: VirtualAlloc one page (4096 bytes) with MEM_COMMIT | MEM_RESERVE and PAGE_READWRITE.
;       Store 42 at the base address, read it back, exit with 42.
;
; Hint: VirtualAlloc(NULL, 4096, 03000h, 4) returns base address in RAX.
;       Check for NULL (error).

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_04_virtualalloc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_virtualalloc in this file.
    call    ex_04_virtualalloc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
