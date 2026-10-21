; Exercise 21: intern string
;
; Intern table pointer equality: same slot; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
a BYTE "hi", 0

.data?
table QWORD ?

.code
main PROC
    sub rsp, 40
    lea rax, a
    mov QWORD PTR [table], rax
    mov rbx, QWORD PTR [table]
    cmp rax, rbx
    jne not_equal
    mov rcx, 1
    jmp done
not_equal:
    xor rcx, rcx
done:
    call ExitProcess
main ENDP
END
