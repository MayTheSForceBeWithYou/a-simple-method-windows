; 15-getpid.asm
;
; Get current process ID, exit with low 7 bits.
;
; Task: Call GetCurrentProcessId, AND with 07Fh, exit with result.
;
; Hint: GetCurrentProcessId returns DWORD in EAX.

.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC
EXTRN ex_15_getpid:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_15_getpid (student routine; defined in solutions/).
    call    ex_15_getpid
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
