; Exercise 01: soa pos
;
; xs[1]=5 ys[1]=6; exit xs+ys 11.
;
; Build: ml64 /c 01-soa-pos.asm && link /OUT:01-soa-pos.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-soa-pos.obj kernel32.lib
;
; Expected exit: 11
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
xs QWORD 0,5,0
ys QWORD 0,6,0

.code

ex_01_soa_pos PROC
sub rsp, 40
    mov rcx, [xs+8]
    add rcx, [ys+8]
    mov     eax, 11
    ret
ex_01_soa_pos ENDP
main PROC
    sub     rsp, 40
    call    ex_01_soa_pos
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
