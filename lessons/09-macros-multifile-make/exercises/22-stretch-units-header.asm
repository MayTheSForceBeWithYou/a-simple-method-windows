; Exercise: 22-stretch-units-header
;
; STRETCH: Define constants for API calls; print "U\n" exit 0.
; Expected stdout: "U\n"
;
; Contract: implement `ex_22_stretch_units_header` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg DB "U", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_units_header:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_units_header in this file.
    call    ex_22_stretch_units_header
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
