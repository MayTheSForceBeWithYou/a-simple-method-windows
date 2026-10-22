; Exercise 06: ack lite (Win32 port)
; ack(1,1) classic = 3. Implement ack(m,n). Exit 3.
; Build: ml64 /c /Fo06-ack-lite.obj 06-ack-lite.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-ack-lite.exe 06-ack-lite.obj kernel32.lib
; Expected: exit code 3

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement Ackermann function ack(RCX=m, RDX=n)

main PROC
    sub     rsp, 32
    mov rcx, 1
    mov rdx, 1
    call ack
    mov rcx, rax
    call ExitProcess
main ENDP
END
