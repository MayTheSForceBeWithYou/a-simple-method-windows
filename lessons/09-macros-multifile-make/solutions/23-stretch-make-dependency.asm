; Exercise 23: stretch make dependency
;
; STRETCH: encode dependency count 3 objects; exit 3.
;
; Build: ml64 /c 23-stretch-make-dependency.asm && link /OUT:23-stretch-make-dependency.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-make-dependency.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_23_stretch_make_dependency PROC
    sub rsp, 40
        mov     eax, 3
    ret
    add     rsp, 40
ex_23_stretch_make_dependency ENDP
main PROC
    call    ex_23_stretch_make_dependency
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
