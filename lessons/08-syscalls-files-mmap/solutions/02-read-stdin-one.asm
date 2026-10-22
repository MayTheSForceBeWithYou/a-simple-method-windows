; Exercise 02: read stdin one
;
; STUB design: read 1 byte from stdin into buf; exit that byte (run with echo A | ). Solution exits 0 if read fails.
;
; Build: ml64 /c 02-read-stdin-one.asm && link /OUT:02-read-stdin-one.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-read-stdin-one.obj kernel32.lib
;
; Expected exit: 65
; Expected stdin: "A"

EXTERN GetStdHandle:PROC
EXTERN ReadFile:PROC
EXTERN ExitProcess:PROC

.data?
b BYTE ?
bytesRead DWORD ?

.code
ex_02_read_stdin_one PROC
    sub rsp, 56
    
    ; Get stdin handle
    mov rcx, -10
    call GetStdHandle
    
    ; Read 1 byte
    mov rcx, rax
    lea rdx, b
    mov r8d, 1
    lea r9, bytesRead
    mov QWORD PTR [rsp+32], 0
    call ReadFile
    
    ; Check if read succeeded and got 1 byte
    test rax, rax
    jz L_fail
    cmp bytesRead, 1
    jne L_fail
    
    ; Exit with byte value
    movzx rcx, BYTE PTR [b]
    mov     eax, ecx
    add     rsp, 56
    ret
L_fail:
    ; Exit 0 on failure
    mov rcx, 0
    mov     eax, 0
    ret
ex_02_read_stdin_one ENDP
main PROC
    sub     rsp, 40
    call    ex_02_read_stdin_one
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
