; Exercise 10: factorial iter proc
;
; fact(n) iterative as procedure. fact(5)=120; exit 120.
;
; Build: ml64 /c 10-factorial-iter-proc.asm && link /OUT:10-factorial-iter-proc.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-factorial-iter-proc.obj kernel32.lib
;
; Expected exit: 120

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 5
    call fact
    and rax, 255
    mov rcx, rax
    call ExitProcess
main ENDP

fact PROC
    mov rax, 1
    mov r8, 1
loop_start:
    cmp r8, rcx
    jg done
    imul rax, r8
    inc r8
    jmp loop_start
done:
    ret
fact ENDP
END
