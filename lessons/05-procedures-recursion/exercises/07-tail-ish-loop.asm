; Exercise 07: tail ish loop (Win32 port)
; Rewrite recursive sum_to as loop (tail form). sum_to(6)=21.
; Build: ml64 /c /Fo07-tail-ish-loop.obj 07-tail-ish-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-tail-ish-loop.exe 07-tail-ish-loop.obj kernel32.lib
; Expected: exit code 21

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement iterative sum_to using loop

main PROC
    sub rsp, 32
    mov rcx, 6
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP
END
