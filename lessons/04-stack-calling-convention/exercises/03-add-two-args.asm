; Exercise 03: add two args (Win32 port)
;
; Function add2(RCX, RDX) -> RAX. Call with 10, 32; exit 42.
; Note: MS x64 uses RCX, RDX (not RDI, RSI)
;
; Build: ml64 /c /Fo03-add-two-args.obj 03-add-two-args.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-add-two-args.exe 03-add-two-args.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement add2(RCX, RDX) that returns RCX + RDX in RAX

main PROC
    sub     rsp, 32
    mov rcx, 10
    mov rdx, 32
    call add2
    mov rcx, rax
    call ExitProcess
main ENDP
END
