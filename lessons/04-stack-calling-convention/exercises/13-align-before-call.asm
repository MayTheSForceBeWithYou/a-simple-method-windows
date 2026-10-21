; Exercise 13: align before call (Win32 port)
; Verify RSP is 16-byte aligned. Check RSP&15 in callee. Exit 0 if correct (RSP&15=8 at func entry).
; Build: ml64 /c /Fo13-align-before-call.obj 13-align-before-call.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-align-before-call.exe 13-align-before-call.obj kernel32.lib
; Expected: exit code 0

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement check_alignment that returns RSP&15

main PROC
    sub rsp, 32
    call check_alignment
    ; RAX should be 8 (aligned after CALL pushed return addr)
    mov rcx, rax
    sub rcx, 8                 ; Should be 0 if correct
    call ExitProcess
main ENDP
END
