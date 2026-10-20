; Listing 04: Signed division with CQO and IDIV
;
; Purpose: Demonstrates proper setup for signed division.
; Expected exit code: 7 (quotient of 22/3)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-signed-division.obj 04-signed-division.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-signed-division.exe 04-signed-division.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 22                ; Dividend in RAX
    cqo                        ; Sign-extend RAX into RDX:RAX
    mov rbx, 3                 ; Divisor
    idiv rbx                   ; RAX = quotient (7), RDX = remainder (1)
    
    mov rcx, rax               ; Exit with quotient
    call ExitProcess
main ENDP

END
