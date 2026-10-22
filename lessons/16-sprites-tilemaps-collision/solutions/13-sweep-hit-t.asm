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
mov rcx, 3
    mov     eax, ecx
    ret
ex_13_sweep_hit_t ENDP
main PROC
    sub     rsp, 40
    call    ex_13_sweep_hit_t
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
