; Exercise 22: stretch ring drop
;
; STRETCH: input ring full drops; dropped count 1; exit 1.
;
; Build: ml64 /c 22-stretch-ring-drop.asm && link /OUT:22-stretch-ring-drop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-ring-drop.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
dropped QWORD ?

.code

ex_22_stretch_ring_drop PROC
mov QWORD PTR [dropped], 1
    mov rcx, [dropped]
    mov     eax, [dropped]
    ret
ex_22_stretch_ring_drop ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_ring_drop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
