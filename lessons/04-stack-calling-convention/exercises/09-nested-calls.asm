; Exercise 09: nested calls (Win32 port)
;
; double(x)=x*2; add(a,b)=a+b. Compute add(double(10),double(11))=42.
;
; Build: ml64 /c /Fo09-nested-calls.obj 09-nested-calls.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-nested-calls.exe 09-nested-calls.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_nested_calls:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_nested_calls in this file.
    call    ex_09_nested_calls
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
