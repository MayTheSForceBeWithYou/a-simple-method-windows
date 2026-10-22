; Exercise 16: debug off by one
;
; BUG: loop runs 0..n inclusive summing 1..5 as 0..5. Fix to sum 1..5 = 15.
;
; Build: ml64 /c 16-debug-off-by-one.asm && link /OUT:16-debug-off-by-one.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-debug-off-by-one.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
ex_16_debug_off_by_one PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 1
loop_start:
    cmp r8, 5
    jg done
    add rcx, r8
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_debug_off_by_one ENDP
main PROC
    sub     rsp, 40
    call    ex_16_debug_off_by_one
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
