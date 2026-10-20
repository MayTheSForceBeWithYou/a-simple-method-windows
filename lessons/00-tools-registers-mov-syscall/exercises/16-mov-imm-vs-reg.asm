; Exercise 16: mov imm vs reg (Win32 port)
;
; Demonstrate difference between immediate and register operands.
;
; Build: ml64 /c /Fo16-mov-imm-vs-reg.obj 16-mov-imm-vs-reg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-mov-imm-vs-reg.exe 16-mov-imm-vs-reg.obj kernel32.lib
; Run: 16-mov-imm-vs-reg & echo %ERRORLEVEL%
;
; Expected: exit code 20

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10                ; Immediate 10 to RAX
    mov rbx, rax               ; Copy RAX to RBX (register operand)
    
    ; TODO: Add RBX to RAX, move result to RCX, and exit
    .ERR <TODO: Finish the addition and exit>
    
main ENDP

END
