; 24-from-scratch-compile-add.asm: Full: lex "a+b", parse, emit code, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_compile_add:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_compile_add (student routine; defined in solutions/).
    call    ex_24_from_scratch_compile_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
