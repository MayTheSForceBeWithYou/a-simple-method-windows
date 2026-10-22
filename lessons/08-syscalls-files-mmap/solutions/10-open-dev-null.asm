; Exercise 10: open dev null
;
; open NUL (Windows null device) write-only; on success close and exit 0.
;
; Build: ml64 /c 10-open-dev-null.asm && link /OUT:10-open-dev-null.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-open-dev-null.obj kernel32.lib
;
; Expected exit: 0

EXTERN CreateFileA:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "NUL", 0

.code

ex_10_open_dev_null PROC
sub rsp, 72
    
    ; CreateFileA for NUL device
    lea rcx, path               ; lpFileName
    mov rdx, 40000000h          ; dwDesiredAccess = GENERIC_WRITE
    mov r8d, 0                  ; dwShareMode = 0
    mov r9, 0                   ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    ; Check for failure
    cmp rax, -1
    je L_e
    
    ; Close handle
    mov rcx, rax
    call CloseHandle
    
    ; Exit 0
    mov rcx, 0
    jmp L_o
    
L_e:
    ; Exit 1 on error
    mov rcx, 1
    
L_o:
    mov     eax, 0
    ret
ex_10_open_dev_null ENDP
main PROC
    sub     rsp, 40
    call    ex_10_open_dev_null
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
