; Exercise 18: max3 proc (Win32 port)
; max3(a,b,c) returns max. Call max3(3,9,7); exit 9.
; Build: ml64 /c /Fo18-max3-proc.obj 18-max3-proc.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-max3-proc.exe 18-max3-proc.obj kernel32.lib
; Expected: exit code 9

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement max3(RCX, RDX, R8) -> RAX

main PROC
    sub rsp, 32
    mov rcx, 3
    mov rdx, 9
    mov r8, 7
    call max3
    mov rcx, rax
    call ExitProcess
main ENDP
END
