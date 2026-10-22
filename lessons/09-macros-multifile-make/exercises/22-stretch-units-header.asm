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
EXTRN ex_22_stretch_units_header:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_units_header in this file.
    call    ex_22_stretch_units_header
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
