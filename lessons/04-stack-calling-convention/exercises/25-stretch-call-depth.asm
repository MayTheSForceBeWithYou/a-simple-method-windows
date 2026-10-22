; Exercise 25: stretch call depth (Win32 port)
; STRETCH: bump(RCX) calls itself depth times adding 1 each return. Start depth 5, return 5.
; Build: ml64 /c /Fo25-stretch-call-depth.obj 25-stretch-call-depth.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:25-stretch-call-depth.exe 25-stretch-call-depth.obj kernel32.lib
; Expected: exit code 5

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive bump(RCX) with depth counter

main PROC
    sub     rsp, 32
    mov rcx, 5
    call bump
    mov rcx, rax
    call ExitProcess
main ENDP
END
