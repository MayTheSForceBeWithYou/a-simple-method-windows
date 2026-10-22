; 19-extern-declare.asm
; Single file, define helper returning 9, exit 9.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_extern_declare:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_extern_declare in this file.
    call    ex_19_extern_declare
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
