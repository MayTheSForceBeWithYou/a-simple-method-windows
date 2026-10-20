; Exercise 16: debug off by one
;
; BUG: loop runs 0..n inclusive summing 1..5 as 0..5. Fix to sum 1..5 = 15.
;
; Build: ml64 /c 16-debug-off-by-one.asm && link /OUT:16-debug-off-by-one.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-debug-off-by-one.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    mov r8, 1
loop_start:
    cmp r8, 5
    jg done
    add rcx, r8
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
