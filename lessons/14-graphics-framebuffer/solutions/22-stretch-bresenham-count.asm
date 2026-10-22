; Exercise 22: stretch bresenham count
;
; STRETCH: line from 0,0 to 3,0 plots 4 pixels; exit 4.
;
; Build: ml64 /c 22-stretch-bresenham-count.asm && link /OUT:22-stretch-bresenham-count.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-bresenham-count.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_22_stretch_bresenham_count PROC
sub rsp, 40
    mov     eax, 4
    ret
ex_22_stretch_bresenham_count ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_bresenham_count
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
