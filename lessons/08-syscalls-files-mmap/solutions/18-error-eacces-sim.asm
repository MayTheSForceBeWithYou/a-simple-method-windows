; Exercise 18: error eacces sim
;
; Try to open "C:\" with write access; if fail exit 1 else close exit 0. Expect 1 often.
;
; Build: ml64 /c 18-error-eacces-sim.asm && link /OUT:18-error-eacces-sim.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-error-eacces-sim.obj kernel32.lib
;
; Expected exit: 1

EXTERN CreateFileA:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "C:\", 0

.code
ex_18_error_eacces_sim PROC
    sub rsp, 72
    
    ; CreateFileA - try to open root with write access
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
    je L_bad
    
    ; Success - close and exit 0
    mov rcx, rax
    call CloseHandle
    
    mov rcx, 0
    jmp L_o
    
L_bad:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, 1
    ret
    add     rsp, 72
ex_18_error_eacces_sim ENDP
main PROC
    call    ex_18_error_eacces_sim
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
