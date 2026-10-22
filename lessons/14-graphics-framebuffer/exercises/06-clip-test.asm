; 06-clip-test: clip test
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_clip_test:PROC
main PROC
    ; TODO: implement ex_06_clip_test (student routine; defined in solutions/).
    call    ex_06_clip_test
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
