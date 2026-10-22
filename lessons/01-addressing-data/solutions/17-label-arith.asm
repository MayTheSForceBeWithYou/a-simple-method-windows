; Exercise 17: label arith
;
; msg BYTE 'A','B','C',CR,LF. Write only 'B' using msg+1 length 1, then write CR,LF from msg+3. Exit 0.
;
; Build: ml64 /c 17-label-arith.asm && link /OUT:17-label-arith.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-label-arith.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "ABC", 13, 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_17_label_arith PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write 'B'
    mov rcx, hStdOut
    lea rdx, [msg+1]
    mov r8d, 1
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Write newline
    mov rcx, hStdOut
    lea rdx, [msg+3]
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_17_label_arith ENDP
main PROC
    sub     rsp, 40
    call    ex_17_label_arith
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
