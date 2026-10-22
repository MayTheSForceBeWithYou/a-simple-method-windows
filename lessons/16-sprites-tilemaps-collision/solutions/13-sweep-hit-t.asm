; Exercise 13: sweep hit t
;
; TOI stub t=3; exit 3.
;
; Build: ml64 /c 13-sweep-hit-t.asm && link /OUT:13-sweep-hit-t.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-sweep-hit-t.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_13_sweep_hit_t PROC
    sub rsp, 40
        mov     eax, 3
    add     rsp, 40
    ret
ex_13_sweep_hit_t ENDP
main PROC
    call    ex_13_sweep_hit_t
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
