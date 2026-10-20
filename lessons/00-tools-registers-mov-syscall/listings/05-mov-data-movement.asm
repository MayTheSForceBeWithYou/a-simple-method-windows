; Listing 05: Moving data with MOV
;
; Purpose: Demonstrates various forms of the MOV instruction.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo05-mov-data-movement.obj 05-mov-data-movement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-mov-data-movement.exe 05-mov-data-movement.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32                ; Shadow space

    ; Immediate to register
    mov rax, 5                 ; RAX = 5

    ; Register to register
    mov rbx, rax               ; RBX = RAX = 5

    ; Add to get 10
    add rax, rbx               ; RAX = 10

    ; Move to another register
    mov rdx, rax               ; RDX = 10
    
    ; Compute exit code: 10 + 5 = 15
    add rax, rbx               ; RAX = 15
    
    ; Move to exit parameter register
    mov rcx, rax               ; RCX = 15
    
    call ExitProcess
main ENDP

END
