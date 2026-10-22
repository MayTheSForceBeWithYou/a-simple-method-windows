; Exercise 05: render line
;
; Print buffer 'ed\n'; exit 0.
;
; Build: ml64 /c 05-render-line.asm && link /OUT:05-render-line.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-render-line.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "ed\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
buf BYTE "ed", 10

.data?
written DWORD ?

.code
ex_05_render_line PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write buffer
    mov rcx, rax
    lea rdx, buf
    mov r8d, 3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    call ExitProcess
    mov     eax, 0
    add     rsp, 56
    ret
ex_05_render_line ENDP
main PROC
    sub     rsp, 40
    call    ex_05_render_line
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
