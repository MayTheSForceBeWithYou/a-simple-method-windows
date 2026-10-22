; Exercise: 20-allocation-granularity
;
; Exercise 20: mmap pagesize fill
; Fill first 16 bytes of VirtualAlloc with 1; sum=16; exit 16.
;
; Contract: implement `ex_20_allocation_granularity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 16
;

; 20-allocation-granularity.asm
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
EXTRN ex_20_allocation_granularity:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_allocation_granularity in this file.
    call    ex_20_allocation_granularity
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
