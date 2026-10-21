; Exercise 07: while double
;
; rax=1; while rax<100 rax*=2; exit with final rax clamped: put rax in rcx then and 255; 128&255=128.
;
; Build: ml64 /c 07-while-double.asm && link /OUT:07-while-double.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-while-double.obj kernel32.lib
;
; Expected exit: 128

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
loop_start:
    cmp rax, 100
    jge done
    imul rax, 2
    jmp loop_start
done:
    mov rcx, rax
    and rcx, 255
    call ExitProcess
main ENDP
END
