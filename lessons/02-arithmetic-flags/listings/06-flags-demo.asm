; Listing 06: FLAGS demonstration
;
; Purpose: Show how arithmetic sets ZF, SF, CF, OF.
; Expected exit code: 0
; Expected output: (none)
;
; Build: ml64 /c /Fo06-flags-demo.obj 06-flags-demo.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-flags-demo.exe 06-flags-demo.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Zero flag: result is zero
    mov rax, 5
    sub rax, 5                 ; RAX = 0, ZF = 1
    
    ; Sign flag: result is negative
    mov rbx, 10
    sub rbx, 20                ; RBX = -10, SF = 1
    
    ; Carry flag: unsigned overflow
    mov cl, 255
    add cl, 1                  ; CL wraps to 0, CF = 1
    
    ; Overflow flag: signed overflow
    mov al, 127
    add al, 1                  ; AL wraps to -128, OF = 1
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
