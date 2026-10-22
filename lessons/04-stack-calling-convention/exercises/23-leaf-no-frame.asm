; Exercise 23: leaf no frame (Win32 port)
; Leaf mul3(RCX)=RCX*3 without prologue. Exit 42 for input 14.
; Build: ml64 /c /Fo23-leaf-no-frame.obj 23-leaf-no-frame.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:23-leaf-no-frame.exe 23-leaf-no-frame.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement mul3 as leaf (no PROC FRAME needed)

main PROC
    sub     rsp, 32
    mov rcx, 14
    call mul3
    mov rcx, rax
    call ExitProcess
main ENDP
END
