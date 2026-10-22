; Listing 04: Preserving nonvolatile registers
;
; Purpose: Demonstrate saving/restoring RBX (nonvolatile in MS x64).
; Expected exit code: 42
; Expected output: (none)
;
; MS x64 nonvolatile registers: RBX, RBP, RDI, RSI, RSP, R12-R15, XMM6-15
; Callee must preserve these if used.
;
; Build: ml64 /c /Fo04-nonvolatile-regs.obj 04-nonvolatile-regs.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-nonvolatile-regs.exe 04-nonvolatile-regs.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: uses RBX, must save/restore it
compute PROC FRAME
    push rbx                   ; Save nonvolatile RBX
    .pushreg rbx
    sub rsp, 32                ; Shadow space
    .allocstack 32
    .endprolog
    
    mov rbx, rcx               ; Use RBX
    add rbx, 10
    mov rax, rbx               ; Return result
    
    add rsp, 32
    pop rbx                    ; Restore RBX
    ret
compute ENDP

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    mov rbx, 99
    mov rcx, 32
    call compute
    cmp rbx, 99
    jne rbx_clobbered
    mov rcx, rax
    jmp exit_main
rbx_clobbered:
    mov rcx, 1
exit_main:
    call ExitProcess
main ENDP

END
