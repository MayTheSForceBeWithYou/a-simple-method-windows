; Exercise 22: stretch units header
;
; STRETCH: Define constants for API calls; print "U\n" exit 0.
;
; Build: ml64 /c 22-stretch-units-header.asm && link /OUT:22-stretch-units-header.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-units-header.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "U\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

; Define constants (would be in header file in multi-file project)
STD_OUTPUT_HANDLE EQU -11

.data
msg BYTE "U", 10

.data?
written DWORD ?

.code

ex_22_stretch_units_header PROC
sub rsp, 56
    
    ; Get stdout handle
    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    add     rsp, 56
    mov     eax, 0
    ret
ex_22_stretch_units_header ENDP
main PROC
    call    ex_22_stretch_units_header
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
