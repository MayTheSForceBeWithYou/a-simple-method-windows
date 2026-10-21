; Exercise 29: from scratch factorial loop
;
; FROM SCRATCH: 6! with a counted loop = 720. Exit 720&255=208.
;
; Build: ml64 /c 29-from-scratch-factorial-loop.asm && link /OUT:29-from-scratch-factorial-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 29-from-scratch-factorial-loop.obj kernel32.lib
;
; Expected exit: 208

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    mov r8, 2
loop_start:
    cmp r8, 6
    jg done
    imul rax, r8
    inc r8
    jmp loop_start
done:
    mov rcx, rax
    and rcx, 255
    call ExitProcess
main ENDP
END
