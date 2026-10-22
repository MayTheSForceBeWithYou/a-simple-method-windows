; Exercise 13: render viewport
;
; Render first line only of "L1\nL2\n"; write "L1\n"; exit 0.
;
; Build: ml64 /c 13-render-viewport.asm && link /OUT:13-render-viewport.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-render-viewport.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "L1\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
buf BYTE "L1", 10, "L2", 10

.data?
written DWORD ?

.code

ex_13_render_viewport PROC
sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write first line only
    mov rcx, rax
    lea rdx, buf
    mov r8d, 3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov     eax, 0
    ret
ex_13_render_viewport ENDP
main PROC
    sub     rsp, 40
    call    ex_13_render_viewport
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
