; Exercise: 13-peep-pathfind-step
;
; Peep follows path; steps remaining 4; exit 4.
; Expected stdout: (none)
; Expected exit: 4
;
.data
steps QWORD 0

.code
ex_13_peep_pathfind_step PROC
    sub rsp, 40
    mov QWORD PTR [steps], 4
    mov rcx, QWORD PTR [steps]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_peep_pathfind_step ENDP
main PROC
    sub     rsp, 40
    call    ex_13_peep_pathfind_step
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
