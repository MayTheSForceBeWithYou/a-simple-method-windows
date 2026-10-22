; Exercise 13: 13-variadic-max.asm (Win32 port)
; max_n(n, ...) n in rdi, n qwords on stack. max of 5,9,2,9 -> wait n=3 values 5,1,9 exit 9.
; Build: ml64 /c /Fo13-variadic-max.asm.obj 13-variadic-max.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-variadic-max.asm.exe 13-variadic-max.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_variadic_max:PROC

; TODO: Port from NASM to MASM

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_13_variadic_max in this file.
    call    ex_13_variadic_max
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
