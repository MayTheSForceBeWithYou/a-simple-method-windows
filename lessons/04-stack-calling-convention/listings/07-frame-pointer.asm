; Listing 07: Prologue/epilogue with RBP frame pointer
;
; Purpose: Demonstrate frame pointer usage (lines 122-134 of LESSON.md).
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo07-frame-pointer.obj 07-frame-pointer.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-frame-pointer.exe 07-frame-pointer.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

compute PROC FRAME
    push rbp                   ; Save old frame pointer
    .pushreg rbp
    mov rbp, rsp               ; Set up new frame pointer
    sub rsp, 32                ; Allocate locals
    .allocstack 32
    .endprolog
    
    ; Function body - access locals via [RBP-N]
    mov rax, 42
    
    mov rsp, rbp               ; Deallocate locals
    pop rbp                    ; Restore frame pointer
    ret
compute ENDP

main PROC
    sub rsp, 32
    call compute
    mov rcx, rax
    call ExitProcess
main ENDP

END
