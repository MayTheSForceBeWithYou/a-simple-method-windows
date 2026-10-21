; 06-get-process-id.asm
;
; Purpose: Get current process ID (equivalent to getpid)
; Expected exit code: Low 7 bits of process ID (varies)
; Expected stdout: (none)
;
; Demonstrates:
; - GetCurrentProcessId Win32 API

.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    
    ; GetCurrentProcessId returns DWORD in EAX
    call    GetCurrentProcessId
    
    ; Mask to low 7 bits for predictable exit code
    and     eax, 7Fh
    
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
