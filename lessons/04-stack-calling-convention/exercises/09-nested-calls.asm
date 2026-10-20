; Exercise 09: nested calls (Win32 port)
;
; double(x)=x*2; add(a,b)=a+b. Compute add(double(10),double(11))=42.
;
; Build: ml64 /c /Fo09-nested-calls.obj 09-nested-calls.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-nested-calls.exe 09-nested-calls.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement double(RCX) -> RAX = RCX*2
.ERR <TODO: Implement double and add procedures>

main PROC
    sub rsp, 32
    
    ; TODO: Call double(10), save result, call double(11), call add
    ; Remember: must preserve values across calls
    .ERR <TODO: Implement nested function calls>
    
main ENDP
END
