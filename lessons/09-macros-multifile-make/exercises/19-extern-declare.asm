; 19-extern-declare.asm
; Single file, define helper returning 9, exit 9.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_extern_declare:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_19_extern_declare (student routine; defined in solutions/).
    call    ex_19_extern_declare
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
