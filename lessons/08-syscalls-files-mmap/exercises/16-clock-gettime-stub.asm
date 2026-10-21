; 16-clock-gettime-stub.asm
;
; Query performance counter (high-resolution timer), exit 0.
;
; Task: Call QueryPerformanceCounter with pointer to QWORD, exit 0.
;
; Hint: QueryPerformanceCounter(&counter) returns nonzero on success.

.DATA
counter QWORD ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: QueryPerformanceCounter(&counter)
    
    ; TODO: Check result, exit 0
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
