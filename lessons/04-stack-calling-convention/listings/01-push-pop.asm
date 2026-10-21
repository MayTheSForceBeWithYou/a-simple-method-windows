; Listing 01: PUSH and POP basics
;
; Purpose: Demonstrate stack operations with PUSH/POP.
; Expected exit code: 42
; Expected output: (none)
;
; Note: MS x64 ABI differs from System V - this lesson's NASM examples 
; assume System V, but these listings follow MS x64.
;
; Build: ml64 /c /Fo01-push-pop.obj 01-push-pop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-push-pop.exe 01-push-pop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 42
    push rax                   ; Save RAX on stack (RSP -= 8)
    
    mov rax, 99                ; Overwrite RAX
    
    pop rbx                    ; Restore original value to RBX (RSP += 8)
                               ; RBX = 42
    
    mov rcx, rbx
    call ExitProcess
main ENDP

END
