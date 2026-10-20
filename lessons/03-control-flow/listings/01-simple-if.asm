; Listing 01: Simple if statement
;
; Purpose: Demonstrate conditional execution with JE.
; Expected exit code: 10 (if path taken)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-simple-if.obj 01-simple-if.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-simple-if.exe 01-simple-if.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5
    mov rbx, 5
    mov rcx, 99                ; Default exit code
    
    cmp rax, rbx
    jne skip_then              ; If not equal, skip
    
    ; Then branch (rax == rbx)
    mov rcx, 10
    
skip_then:
    call ExitProcess
main ENDP

END
