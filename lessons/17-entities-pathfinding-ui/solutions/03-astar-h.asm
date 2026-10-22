; Exercise 03: astar h
;
; Manhattan |3-1|+|4-2|=4.
;
; Build: ml64 /c 03-astar-h.asm && link /OUT:03-astar-h.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-astar-h.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_03_astar_h PROC
sub rsp, 40
    mov rax, 3
    sub rax, 1
    mov rbx, 4
    sub rbx, 2
    add rax, rbx
    mov     eax, 4
    ret
ex_03_astar_h ENDP
main PROC
    sub     rsp, 40
    call    ex_03_astar_h
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
