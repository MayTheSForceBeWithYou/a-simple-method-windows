; 22-stretch-file-copy-mem.asm (stretch)
;
; Allocate memory, copy four bytes from .DATA, sum them, exit with sum.
;
; Task: VirtualAlloc one page, copy four bytes from data section to allocated memory,
;       sum the four bytes, exit with sum.
;
; Hint: Use REP MOVSB or manual byte-by-byte copy.

.DATA
source DB 2, 3, 4, 1    ; Sum = 10

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_file_copy_mem:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_file_copy_mem in this file.
    call    ex_22_stretch_file_copy_mem
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
