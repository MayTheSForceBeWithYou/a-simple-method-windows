; Exercise 21: index loop prep
;
; arr BYTE 7,8,9. Without loops yet: sum using three scaled/byte loads into rcx (24).
;
; Build: ml64 /c 21-index-loop-prep.asm && link /OUT:21-index-loop-prep.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-index-loop-prep.obj kernel32.lib
;
; Expected exit: 24

EXTERN ExitProcess:PROC

.data
arr BYTE 7, 8, 9

.code
ex_21_index_loop_prep PROC
    sub rsp, 40
    xor rcx, rcx
    movzx rax, BYTE PTR [arr]
    add rcx, rax
    movzx rax, BYTE PTR [arr+1]
    add rcx, rax
    movzx rax, BYTE PTR [arr+2]
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_21_index_loop_prep ENDP
main PROC
    sub     rsp, 40
    call    ex_21_index_loop_prep
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
