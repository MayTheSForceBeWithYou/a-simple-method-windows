; Exercise: 13-variadic-max
;
; Exercise 13: variadic max
; max_n(n, ...) MS x64: rcx=count, args on stack. max(3, 5,1,9)=9.
;
; Contract: implement `ex_13_variadic_max` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; Exercise 13: 13-variadic-max.asm (Win32 port)
; max_n(n, ...) n in rdi, n qwords on stack. max of 5,9,2,9 -> wait n=3 values 5,1,9 exit 9.
; Build: ml64 /c /Fo13-variadic-max.asm.obj 13-variadic-max.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-variadic-max.asm.exe 13-variadic-max.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_variadic_max:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_13_variadic_max in this file.
    call    ex_13_variadic_max
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
