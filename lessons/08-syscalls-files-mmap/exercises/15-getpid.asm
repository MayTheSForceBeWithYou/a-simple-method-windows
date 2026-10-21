; 15-getpid.asm
;
; Get current process ID, exit with low 7 bits.
;
; Task: Call GetCurrentProcessId, AND with 0x7F, exit with result.
;
; Hint: GetCurrentProcessId returns DWORD in EAX.

.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: Call GetCurrentProcessId
    
    ; TODO: Mask to low 7 bits, exit with result
    
    add     rsp, 32
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
