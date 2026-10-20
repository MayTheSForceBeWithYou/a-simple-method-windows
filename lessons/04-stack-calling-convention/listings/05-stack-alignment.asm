; Listing 05: Stack alignment (16-byte boundary)
;
; Purpose: Demonstrate maintaining 16-byte stack alignment.
; Expected exit code: 15
; Expected output: (none)
;
; MS x64 requires RSP to be 16-byte aligned before CALL.
; After CALL, the return address makes it misaligned (RSP+8).
; Functions must account for this.
;
; Build: ml64 /c /Fo05-stack-alignment.obj 05-stack-alignment.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-stack-alignment.exe 05-stack-alignment.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_three PROC FRAME
    ; On entry: RSP is 8 mod 16 (return address pushed)
    ; We need 32 bytes shadow + maintain alignment
    sub rsp, 40                ; 40 bytes keeps 16-byte alignment
    .allocstack 40
    .endprolog
    
    mov rax, rcx
    add rax, rdx
    add rax, r8
    
    add rsp, 40
    ret
sum_three ENDP

main PROC
    sub rsp, 40                ; 40 to maintain alignment (8 + 32 + alignment)
    
    mov rcx, 5
    mov rdx, 4
    mov r8, 6
    call sum_three             ; RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
