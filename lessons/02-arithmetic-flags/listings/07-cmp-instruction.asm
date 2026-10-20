; Listing 07: CMP instruction for comparison
;
; Purpose: Demonstrates CMP setting flags without changing operands.
; Expected exit code: 1 (true, because 10 > 5)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-cmp-instruction.obj 07-cmp-instruction.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-cmp-instruction.exe 07-cmp-instruction.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    mov rbx, 5
    
    cmp rax, rbx               ; Compute RAX - RBX, set flags
                               ; RAX and RBX unchanged
                               ; ZF = 0 (not equal)
                               ; For signed: 10 > 5, so result is positive
    
    ; Use SETG (set if greater, signed) to get boolean
    setg cl                    ; CL = 1 if RAX > RBX (signed)
    movzx rcx, cl
    
    call ExitProcess
main ENDP

END
