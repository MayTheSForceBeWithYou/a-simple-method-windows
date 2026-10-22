; Exercise: 19-debug-q-shift
;
; BUG: forgot >>16 after Q mul. Fix 2*3 Q mul -> 6.
;
; Contract: implement `ex_19_debug_q_shift` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_19_debug_q_shift:PROC

q_mul_bug PROC
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 16               ; BUG: need another >>16 for Q16.16
    ret
q_mul_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_q_shift in this file.
    call    ex_19_debug_q_shift
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
