; Exercise 22: stretch coaster excitement
;
; STRETCH: excitement score 42; exit 42.
;
; Build: ml64 /c 22-stretch-coaster-excitement.asm && link /OUT:22-stretch-coaster-excitement.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-coaster-excitement.obj kernel32.lib
;
; Expected exit: 42
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
ex_22_stretch_coaster_excitement PROC
    sub rsp, 40
        mov     eax, 42
    ret
    add     rsp, 40
ex_22_stretch_coaster_excitement ENDP
main PROC
    call    ex_22_stretch_coaster_excitement
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
