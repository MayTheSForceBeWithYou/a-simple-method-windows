; Exercise: 23-stretch-make-dependency
;
; STRETCH: encode dependency count 3 objects; exit 3.
;
; Contract: implement `ex_23_stretch_make_dependency` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_make_dependency:PROC

main PROC
    sub     rsp, 40
    ; TODO: return 3 from ex_23_stretch_make_dependency (object-count metaphor).
    call    ex_23_stretch_make_dependency
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
