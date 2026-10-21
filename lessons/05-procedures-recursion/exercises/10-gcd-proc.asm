; Exercise 10: gcd proc (Win32 port)
; gcd(RCX,RDX) Euclid recursive. gcd(48,18)=6; exit 6.
; Build: ml64 /c /Fo10-gcd-proc.obj 10-gcd-proc.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-gcd-proc.exe 10-gcd-proc.obj kernel32.lib
; Expected: exit code 6

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive Euclidean GCD

main PROC
    sub rsp, 32
    mov rcx, 48
    mov rdx, 18
    call gcd
    mov rcx, rax
    call ExitProcess
main ENDP
END
