; Exercise 17: vsync stub
;
; Frame ready flag clear; exit 0.
;
; Build: ml64 /c 17-vsync-stub.asm && link /OUT:17-vsync-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-vsync-stub.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
ready BYTE ?

.code
ex_17_vsync_stub PROC
    sub rsp, 40
    mov BYTE PTR [ready], 0
    movzx rcx, BYTE PTR [ready]
    mov     eax, 0
    ret
    add     rsp, 40
ex_17_vsync_stub ENDP
main PROC
    call    ex_17_vsync_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
