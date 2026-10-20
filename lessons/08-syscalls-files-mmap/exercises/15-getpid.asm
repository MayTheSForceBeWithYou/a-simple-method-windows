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
    .ERR <TODO: call GetCurrentProcessId>
    
    ; TODO: Mask to low 7 bits, exit with result
    .ERR <TODO: and eax, 7Fh; mov ecx, eax>
    
    add     rsp, 32
    call    ExitProcess
main ENDP

END
