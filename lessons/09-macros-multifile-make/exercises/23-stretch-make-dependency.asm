; 23-stretch-make-dependency.asm (stretch)
; Exit 3 (object count as immediate, not Make graph).

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_make_dependency:PROC

main PROC
    sub     rsp, 40
    ; TODO: return 3 from ex_23_stretch_make_dependency (object-count metaphor).
    call    ex_23_stretch_make_dependency
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
