; Exercise 01: locals three (Win32 port)
; Function with 3 qword locals summing RCX+1..+3; call with 10 return 33; exit 33.
; Build: ml64 /c /Fo01-locals-three.obj 01-locals-three.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-locals-three.exe 01-locals-three.obj kernel32.lib
; Expected: exit code 33

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement function with 3 local variables
.ERR <TODO: Implement function with locals>

main PROC
    sub rsp, 32
    mov rcx, 10
    call sum_locals
    mov rcx, rax
    call ExitProcess
main ENDP
END
