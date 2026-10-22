; Exercise: 17-bounded-strcpy
;
; Copy at most 3 chars + NUL from "abcdef" into 4-byte dst; strlen dst=3.
; Expected stdout: (none)
;
; Contract: implement `ex_17_bounded_strcpy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_bounded_strcpy:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_17_bounded_strcpy in this file.
    call    ex_17_bounded_strcpy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
