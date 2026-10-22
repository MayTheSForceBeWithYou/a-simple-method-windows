; Exercise: 22-stretch-units-header
;
; STRETCH: Define constants for API calls; print "U\n" exit 0.
; Expected stdout: "U\n"
; Expected exit: 0
;
.data
msg BYTE "U", 10

.data?
written DWORD ?

.code
ex_22_stretch_units_header PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_22_stretch_units_header ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_units_header
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
