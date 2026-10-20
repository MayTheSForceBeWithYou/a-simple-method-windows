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
    .ERR <TODO: Open NUL>
    
    ; BUG: Should call CloseHandle here, but intentionally skip it
    ; TODO: Exit 0 without closing (leak demonstration)
    .ERR <TODO: Exit 0 without CloseHandle>
    
    xor     ecx, ecx
    add     rsp, 56
    call    ExitProcess
main ENDP

END
