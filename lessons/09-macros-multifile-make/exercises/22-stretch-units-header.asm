; 22-stretch-units-header.asm (stretch)
; Define constants, write "U\n", exit 0.

STD_OUTPUT_HANDLE EQU -11

.DATA
msg DB "U", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: GetStdHandle(STD_OUTPUT_HANDLE), WriteFile, exit 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
