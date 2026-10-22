; Listing 08: RBP saved as nonvolatile only (no .SETFRAME)
;
; Purpose: Contrast with listing 07 form 1 — unwind sees RBP as pushed, not a frame base.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo08-rbp-pushreg-only.obj 08-rbp-pushreg-only.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-rbp-pushreg-only.exe 08-rbp-pushreg-only.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

compute_rbp_saved PROC FRAME
    push rbp
    .pushreg rbp
    sub rsp, 32
    .allocstack 32
    .endprolog

    mov rbp, 42
    mov rax, rbp

    add rsp, 32
    pop rbp
    ret
compute_rbp_saved ENDP

main PROC
    sub rsp, 40
    call compute_rbp_saved
    mov rcx, rax
    call ExitProcess
main ENDP

END
