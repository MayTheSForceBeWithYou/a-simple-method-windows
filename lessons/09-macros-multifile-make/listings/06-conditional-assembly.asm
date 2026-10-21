; 06-conditional-assembly.asm
;
; Purpose: Demonstrate conditional assembly with IF/IFDEF
; Expected exit code: 1 (DEBUG defined) or 0 (DEBUG not defined)
; Expected stdout: (none)
;
; MASM uses IF, IFDEF, IFNDEF, ELSE, ENDIF for conditional assembly.
; To enable DEBUG, uncomment the DEBUG = 1 line.

; Uncomment to enable debug mode:
; DEBUG = 1

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    IFDEF DEBUG
        mov     ecx, 1      ; Debug exit code
    ELSE
        xor     ecx, ecx    ; Release exit code
    ENDIF
    
    call    ExitProcess
main ENDP

END
