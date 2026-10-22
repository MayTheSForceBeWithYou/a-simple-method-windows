; Exercise: 20-count-char
;
; Count 's' in 'mississippi' -> 4.
; Expected stdout: (none)
;
; Contract: implement `ex_20_count_char` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_count_char:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_20_count_char in this file.
    call    ex_20_count_char
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
