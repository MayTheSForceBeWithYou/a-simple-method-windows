; Exercise 21: debug fd pattern
;
; BUG: wrong handle for close. Fix open NUL and close; exit 0.
;
; Build: ml64 /c 21-debug-fd-leak-pattern.asm && link /OUT:21-debug-fd-leak-pattern.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-debug-fd-leak-pattern.obj kernel32.lib
;
; Expected exit: 0

EXTERN CreateFileA:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "NUL", 0

.code

ex_21_debug_fd_leak_pattern PROC
; CreateFileA for NUL device
    lea rcx, path               ; lpFileName
    mov rdx, 80000000h          ; dwDesiredAccess = GENERIC_READ
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
    mov     eax, ecx
    ret
ex_21_debug_fd_leak_pattern ENDP
main PROC
    sub     rsp, 72
    call    ex_21_debug_fd_leak_pattern
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
