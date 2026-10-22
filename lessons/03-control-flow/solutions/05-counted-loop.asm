; Exercise 05: counted loop
;
; Add r8 times: start rcx=0,r8=5; loop add 3 each time; exit 15.
;
; Build: ml64 /c 05-counted-loop.asm && link /OUT:05-counted-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-counted-loop.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
ex_05_counted_loop PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 5
loop_start:
    cmp r8, 0
    je done
    add rcx, 3
    dec r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_counted_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_05_counted_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
