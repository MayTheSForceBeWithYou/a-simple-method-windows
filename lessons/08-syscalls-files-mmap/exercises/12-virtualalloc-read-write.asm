; Exercise: 12-virtualalloc-read-write
;
; Exercise 12: mmap write read
; VirtualAlloc 4096; write 99 at +100; read back; exit 99.
;
; Contract: implement `ex_12_virtualalloc_read_write` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 99
;

; 12-virtualalloc-read-write.asm
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
EXTRN ex_12_virtualalloc_read_write:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_virtualalloc_read_write in this file.
    call    ex_12_virtualalloc_read_write
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
