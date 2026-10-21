; Exercise 21: scenario goal
;
; Guests>=100 goal; guests=100; exit 1 success.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
guests QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [guests], 100
    cmp QWORD PTR [guests], 100
    jl goal_no
    mov rcx, 1
    jmp goal_done
goal_no:
    xor ecx, ecx
goal_done:
    call ExitProcess
main ENDP
END
