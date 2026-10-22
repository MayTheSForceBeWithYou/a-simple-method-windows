; Listing 07: Idiomatic zero check with TEST
;
; Purpose: Demonstrate TEST for checking if register is zero.
; Expected exit code: 1 (rdi is nonzero)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-test-zero-check.obj 07-test-zero-check.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-test-zero-check.exe 07-test-zero-check.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rdi, 42
    
    test rdi, rdi
    jz is_zero                 ; Jump if zero
    
    ; Nonzero path
    mov rcx, 1
    jmp end_check
    
is_zero:
    xor ecx, ecx
    
end_check:
    call ExitProcess
main ENDP

END
