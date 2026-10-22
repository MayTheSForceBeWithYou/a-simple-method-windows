; Exercise 16: include path sim
;
; Define VERSION 3; exit VERSION.
;
; Build: ml64 /c 16-include-path-sim.asm && link /OUT:16-include-path-sim.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-include-path-sim.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

; Define constant
VERSION EQU 3

.code
ex_16_include_path_sim PROC
    sub rsp, 40
        mov     eax, ecx
    add     rsp, 40
    ret
ex_16_include_path_sim ENDP
main PROC
    sub     rsp, 40
    call    ex_16_include_path_sim
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
