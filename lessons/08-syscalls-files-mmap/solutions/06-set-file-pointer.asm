; Exercise: 06-set-file-pointer
;
; Without real file: simulate offset add; exit 10.
; Expected exit: 10
;
.code
ex_06_set_file_pointer PROC
    sub rsp, 40
    
    ; Simulate offset calculation
    mov rcx, 0
    add rcx, 10
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_set_file_pointer ENDP
main PROC
    sub     rsp, 40
    call    ex_06_set_file_pointer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
