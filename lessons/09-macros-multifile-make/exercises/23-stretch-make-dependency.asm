; 23-stretch-make-dependency.asm (stretch)
; Exit 3 (object count as immediate, not Make graph).

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; TODO: mov ecx, 3; call ExitProcess
main ENDP
END
