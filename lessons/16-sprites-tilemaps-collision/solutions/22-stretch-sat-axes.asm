; Exercise 22: stretch sat axes
;
; STRETCH: SAT axis count for AABB=2; exit 2.
;
; Build: ml64 /c 22-stretch-sat-axes.asm && link /OUT:22-stretch-sat-axes.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-sat-axes.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_22_stretch_sat_axes PROC
sub rsp, 40
    mov     eax, 2
    ret
ex_22_stretch_sat_axes ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_sat_axes
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
