; Exercise: 06-mul-unsigned
;
; Exercise 06: mul unsigned
; rax=100000, rbx=3; mul rbx; exit with low 8 bits of rax. Product 300000, status 300000&255=224.
;
; Contract: implement `ex_06_mul_unsigned` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 224
;

; Exercise 06: mul unsigned (Win32 port)
;
; RAX=21, RBX=2. MUL RBX. Exit with quotient (42).
;
; Build: ml64 /c /Fo06-mul-unsigned.obj 06-mul-unsigned.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-mul-unsigned.exe 06-mul-unsigned.obj kernel32.lib
; Run: 06-mul-unsigned.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_mul_unsigned:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_mul_unsigned in this file.
    call    ex_06_mul_unsigned
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
