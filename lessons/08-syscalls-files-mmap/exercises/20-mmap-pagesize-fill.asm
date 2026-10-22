; 20-mmap-pagesize-fill.asm
;
; Allocate one page, fill first 16 bytes with 1, exit with 16.
;
; Task: VirtualAlloc 4096 bytes, fill bytes 0-15 with value 1, exit 16.
;
; Hint: Use a loop to store 1 into each of the first 16 bytes.

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_20_mmap_pagesize_fill:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_20_mmap_pagesize_fill (student routine; defined in solutions/).
    call    ex_20_mmap_pagesize_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
