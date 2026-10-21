; Exercise 27: print digits loop
;
; Print "01234\n" using a loop that stores digits into a buffer then one write. Exit 0.
;
; Build: ml64 /c 27-print-digits-loop.asm && link /OUT:27-print-digits-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-print-digits-loop.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data?
buf BYTE 6 DUP(?)
written DWORD ?
hStdOut QWORD ?

.code
main PROC
    sub rsp, 56
    xor r8, r8
loop_start:
    cmp r8, 5
    jge write_buf
    mov rax, r8
    add rax, '0'
    lea r11, [buf]
    mov BYTE PTR [r11+r8], al
    inc r8
    jmp loop_start
write_buf:
    lea r11, [buf]
    mov BYTE PTR [r11+5], 10
    
    ; Get stdout
    mov rcx, -11
    call GetStdHandle
    lea r11, [hStdOut]
    mov QWORD PTR [r11], rax
    
    ; Write buffer
    lea r11, [hStdOut]
    mov rcx, QWORD PTR [r11]
    lea rdx, [buf]
    mov r8d, 6
    lea r9, [written]
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    call ExitProcess
main ENDP
END
