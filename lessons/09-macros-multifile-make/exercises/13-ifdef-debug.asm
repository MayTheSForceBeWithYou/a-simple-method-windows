; 13-ifdef-debug.asm
; IFDEF DEBUG should affect exit code inside ex_13_ifdef_debug (see solutions/).

; Uncomment to enable debug:
; DEBUG = 1

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_ifdef_debug:PROC

main PROC
    sub     rsp, 40
    ; TODO: IFDEF DEBUG / ELSE in ex_13_ifdef_debug; return exit code in eax.
    call    ex_13_ifdef_debug
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
