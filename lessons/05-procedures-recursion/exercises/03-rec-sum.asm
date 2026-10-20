; Exercise 03: rec sum (Win32 port)
; sum_to(n)=n+(n-1)+...+1 recursive. sum_to(5)=15.
; Build: ml64 /c /Fo03-rec-sum.obj 03-rec-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-rec-sum.exe 03-rec-sum.obj kernel32.lib
; Expected: exit code 15

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive sum_to
.ERR <TODO: Implement recursive sum with proper spill>

main PROC
    sub rsp, 32
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP
END
