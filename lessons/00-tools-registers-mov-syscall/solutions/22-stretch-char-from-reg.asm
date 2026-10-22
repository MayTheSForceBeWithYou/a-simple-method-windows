; Exercise 22: stretch char from reg
;
; Set bl=05Ah ('Z'). Store into a 2-byte buffer (char + newline), write it, exit 0.
;
; Build: ml64 /c 22-stretch-char-from-reg.asm && link /OUT:22-stretch-char-from-reg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-char-from-reg.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
buf BYTE 0, 13, 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_22_stretch_char_from_reg PROC
    sub rsp, 56
    
    ; Set character
    mov bl, 05Ah
    mov BYTE PTR [buf], bl
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write buffer
    mov rcx, hStdOut
    lea rdx, buf
    mov r8d, 3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_22_stretch_char_from_reg ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_char_from_reg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
