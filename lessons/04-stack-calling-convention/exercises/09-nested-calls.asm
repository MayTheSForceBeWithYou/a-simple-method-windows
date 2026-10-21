; Exercise 09: nested calls (Win32 port)
;
; double(x)=x*2; add(a,b)=a+b. Compute add(double(10),double(11))=42.
;
; Build: ml64 /c /Fo09-nested-calls.obj 09-nested-calls.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-nested-calls.exe 09-nested-calls.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC

; TODO: Implement double(RCX) -> RAX = RCX*2

main PROC
    sub rsp, 32
    
    ; TODO: Call double(10), save result, call double(11), call add
    ; Remember: must preserve values across calls
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP
END
