; Exercise 26: stretch atoi
;
; STRETCH: parse "42" decimal ascii into rcx (42) with a loop.
;
; Build: ml64 /c 26-stretch-atoi.asm && link /OUT:26-stretch-atoi.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-stretch-atoi.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.data
s BYTE "42", 0

.code
main PROC
    sub rsp, 40
    lea rsi, [s]
    xor rcx, rcx
loop_start:
    movzx rax, BYTE PTR [rsi]
    test rax, rax
    jz done
    sub rax, '0'
    imul rcx, 10
    add rcx, rax
    inc rsi
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
