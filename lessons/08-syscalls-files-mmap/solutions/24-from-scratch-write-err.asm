; Exercise 24: from scratch write err
;
; FROM SCRATCH: write to invalid handle=-1; expect error; exit 1.
;
; Build: ml64 /c 24-from-scratch-write-err.asm && link /OUT:24-from-scratch-write-err.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-write-err.obj kernel32.lib
;
; Expected exit: 1

EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "x"

.data?
written DWORD ?

.code
ex_24_from_scratch_write_err PROC
    sub rsp, 56
    
    ; WriteFile with invalid handle (-1)
    mov rcx, -1             ; invalid handle
    lea rdx, msg
    mov r8d, 1
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; WriteFile returns 0 on failure
    test rax, rax
    jz L_ok
    
    ; Unexpected success - exit 0
    mov rcx, 0
    jmp L_o
    
L_ok:
    ; Expected failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, 1
    add     rsp, 56
    ret
ex_24_from_scratch_write_err ENDP
main PROC
    call    ex_24_from_scratch_write_err
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
