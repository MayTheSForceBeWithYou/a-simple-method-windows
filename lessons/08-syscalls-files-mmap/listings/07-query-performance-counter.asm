; 07-query-performance-counter.asm
;
; Purpose: Query high-resolution performance counter (timing)
; Expected exit code: 0
; Expected stdout: (none)
;
; Demonstrates:
; - QueryPerformanceCounter for high-resolution timing
; - QueryPerformanceFrequency to get timer frequency
; - Equivalent to Linux clock_gettime

.DATA
counter QWORD ?
frequency QWORD ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN QueryPerformanceFrequency:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; QueryPerformanceFrequency(&frequency)
    lea     rcx, frequency
    call    QueryPerformanceFrequency
    
    ; QueryPerformanceCounter(&counter)
    lea     rcx, counter
    call    QueryPerformanceCounter
    
    ; Both return nonzero on success
    test    eax, eax
    jz      error
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 32
    call    ExitProcess
main ENDP

END
