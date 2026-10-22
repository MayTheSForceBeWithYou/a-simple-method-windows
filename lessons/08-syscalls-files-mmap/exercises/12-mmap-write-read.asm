; 12-mmap-write-read.asm
;
; Allocate memory, store 99 at offset 100, read it back, exit 99.
;
; Task: VirtualAlloc 4096 bytes, write 99 at [base+100], read back, exit 99.
;
; Hint: VirtualAlloc, mov BYTE PTR [rax+100], 99, movzx ecx, BYTE PTR [rax+100]

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_12_mmap_write_read:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_12_mmap_write_read (student routine; defined in solutions/).
    call    ex_12_mmap_write_read
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
