; Listing 08: TEST instruction for bit testing
;
; Purpose: Demonstrates TEST setting flags with bitwise AND.
; Expected exit code: 1 (bit 2 is set)
; Expected output: (none)
;
; Build: ml64 /c /Fo08-test-instruction.obj 08-test-instruction.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-test-instruction.exe 08-test-instruction.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 0b0101            ; Binary: 0101 (bits 0 and 2 set)
    test rax, 4                ; Test bit 2 (4 = 0b0100)
                               ; Computes RAX & 4, sets flags
                               ; ZF = 0 (result nonzero, bit is set)
    
    setnz cl                   ; CL = 1 if ZF = 0 (bit was set)
    movzx rcx, cl
    
    call ExitProcess
main ENDP

END
