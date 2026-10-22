; Exercise 08: from scratch loop counter
;
; FROM SCRATCH: 10 frame iterations; exit 10.
;
; Build: ml64 /c 08-from-scratch-loop-counter.asm && link /OUT:08-from-scratch-loop-counter.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-loop-counter.obj kernel32.lib
;
; Expected exit: 10
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_loop_counter PROC
    sub rsp, 40
    xor rcx, rcx
loop_start:
    cmp rcx, 10
    jge loop_done
    inc rcx
    jmp loop_start
loop_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_loop_counter ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_loop_counter
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
