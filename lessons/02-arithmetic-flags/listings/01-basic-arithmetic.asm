; Listing 01: Basic arithmetic operations
;
; Purpose: Demonstrates ADD, SUB, INC, DEC, NEG.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo01-basic-arithmetic.obj 01-basic-arithmetic.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-basic-arithmetic.exe 01-basic-arithmetic.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 10
    add rax, 5                 ; RAX = 15
    sub rax, 3                 ; RAX = 12
    inc rax                    ; RAX = 13
    inc rax                    ; RAX = 14
    dec rax                    ; RAX = 13
    add rax, 2                 ; RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
