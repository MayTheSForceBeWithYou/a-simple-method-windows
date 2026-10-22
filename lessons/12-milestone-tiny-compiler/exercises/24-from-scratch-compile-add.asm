; 24-from-scratch-compile-add.asm: Full: lex "a+b", parse, emit code, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_compile_add:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_compile_add in this file.
    call    ex_24_from_scratch_compile_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
