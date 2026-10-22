; 04-mmap-anon.asm
;
; Allocate memory with VirtualAlloc, store 42, exit with that value.
;
; Task: VirtualAlloc one page (4096 bytes) with MEM_COMMIT | MEM_RESERVE and PAGE_READWRITE.
;       Store 42 at the base address, read it back, exit with 42.
;
; Hint: VirtualAlloc(NULL, 4096, 0x3000, 4) returns base address in RAX.
;       Check for NULL (error).

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_04_mmap_anon:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_04_mmap_anon (student routine; defined in solutions/).
    call    ex_04_mmap_anon
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
