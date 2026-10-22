; 06-get-process-id.asm
;
; Purpose: Get current process ID (equivalent to getpid)
; Expected exit code: 1
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
    
    test    eax, eax
    seta    cl
    movzx   ecx, cl
    call    ExitProcess
main ENDP

END
