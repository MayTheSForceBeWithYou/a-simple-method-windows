; Exercise: 14-early-break
;
; Sum arr QWORD 5,5,5,5 until sum>=10; exit sum (10).
; Expected exit: 10
;
.data
arr QWORD 5, 5, 5, 5

.code
ex_14_early_break PROC
    sub rsp, 40
    xor rcx, rcx
    xor r8, r8
loop_start:
    cmp rcx, 10
    jge done
    lea r11, [arr]
    add rcx, QWORD PTR [r11+r8*8]
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_early_break ENDP
main PROC
    sub     rsp, 40
    call    ex_14_early_break
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
