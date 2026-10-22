; 23-stretch-make-dependency.asm (stretch)
; Exit 3 (object count as immediate, not Make graph).

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_make_dependency:PROC

main PROC
    ; TODO: mov ecx, 3; mov ecx, 1
    ; TODO: implement ex_23_stretch_make_dependency (student routine; defined in solutions/).
    call    ex_23_stretch_make_dependency
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
