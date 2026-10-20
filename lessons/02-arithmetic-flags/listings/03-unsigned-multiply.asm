; Listing 03: Unsigned multiplication with MUL
;
; Purpose: Demonstrates MUL producing rdx:rax result.
; Expected exit code: 40
; Expected output: (none)
;
; Build: ml64 /c /Fo03-unsigned-multiply.obj 03-unsigned-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-unsigned-multiply.exe 03-unsigned-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    mov rbx, 4
    mul rbx                    ; RDX:RAX = RAX * RBX = 40
                               ; RAX = 40, RDX = 0 (high bits)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
