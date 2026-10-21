; Exercise 13: codegen mov
;
; Emit conceptual: store imm 42 into slot; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slot QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [slot], 42
    mov rcx, QWORD PTR [slot]
    call ExitProcess
main ENDP
END
