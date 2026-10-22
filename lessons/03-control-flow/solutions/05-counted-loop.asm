; Exercise: 05-counted-loop
;
; Add r8 times: start rcx=0,r8=5; loop add 3 each time; exit 15.
; Expected exit: 15
;
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
