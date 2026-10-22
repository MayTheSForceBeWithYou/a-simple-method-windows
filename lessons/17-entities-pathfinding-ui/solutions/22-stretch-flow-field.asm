; Exercise 22: stretch flow field
;
; STRETCH: flow cell cost 4; exit 4.
;
; Build: ml64 /c 22-stretch-flow-field.asm && link /OUT:22-stretch-flow-field.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-flow-field.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code

ex_22_stretch_flow_field PROC
mov rcx, 4
    mov     eax, 4
    ret
ex_22_stretch_flow_field ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_flow_field
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
