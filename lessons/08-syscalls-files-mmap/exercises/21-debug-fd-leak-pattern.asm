; 21-debug-fd-leak-pattern.asm
;
; Fix bug: Open file, forget to close it (intentional leak pattern for debugging).
;
; Task: CreateFileA("NUL", GENERIC_READ, ...), intentionally do NOT close, exit 0.
;       Demonstrates resource leak (in real code, CloseHandle is required).
;
; Hint: Bug demonstration - normally you'd CloseHandle, but here we leak it.

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 56
    .allocstack 56
    .endprolog
    
    ; TODO: CreateFileA("NUL", GENERIC_READ, ...)
    
    ; BUG: Should call CloseHandle here, but intentionally skip it
    ; TODO: Exit 0 without closing (leak demonstration)
    mov ecx, 1
    call ExitProcess
main ENDP

END
