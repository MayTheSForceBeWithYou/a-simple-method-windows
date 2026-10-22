; Exercise 21: loop mul table
;
; Compute 7*8 via repeated addition loop. Exit 56.
;
; Build: ml64 /c 21-loop-mul-table.asm && link /OUT:21-loop-mul-table.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-loop-mul-table.obj kernel32.lib
;
; Expected exit: 56

EXTERN ExitProcess:PROC

.code
ex_21_loop_mul_table PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 8
loop_start:
    cmp r8, 0
    je done
    add rcx, 7
    dec r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_21_loop_mul_table ENDP
main PROC
    sub     rsp, 40
    call    ex_21_loop_mul_table
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
