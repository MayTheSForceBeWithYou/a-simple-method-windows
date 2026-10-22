; Exercise 20: write from bss
;
; Fill 4-byte bss with 'Z',CR,LF,'Z',LF. Write 5 bytes. Exit 0.
;
; Build: ml64 /c 20-write-from-bss.asm && link /OUT:20-write-from-bss.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-write-from-bss.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data?
buf BYTE 5 DUP(?)
written DWORD ?
hStdOut QWORD ?

.code
ex_20_write_from_bss PROC
    sub rsp, 56
    
    ; Fill buffer
    mov BYTE PTR [buf], 'Z'
    mov BYTE PTR [buf+1], 13
    mov BYTE PTR [buf+2], 10
    mov BYTE PTR [buf+3], 'Z'
    mov BYTE PTR [buf+4], 10
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write buffer
    mov rcx, hStdOut
    lea rdx, buf
    mov r8d, 5
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_20_write_from_bss ENDP
main PROC
    sub     rsp, 40
    call    ex_20_write_from_bss
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
