; Listing 02: If-else statement
;
; Purpose: Demonstrate if-else with signed comparison.
; Expected exit code: 20 (else path, since 10 is not negative)
; Expected output: (none)
;
; Build: ml64 /c /Fo02-if-else.obj 02-if-else.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-if-else.exe 02-if-else.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    
    cmp rax, 0
    jge else_branch            ; If RAX >= 0, jump to else
    
    ; Then branch: RAX < 0
    mov rcx, 10
    jmp end_if
    
else_branch:
    ; Else branch: RAX >= 0
    mov rcx, 20
    
end_if:
    call ExitProcess
main ENDP

END
