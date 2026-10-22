; Exercise 08: from scratch close
;
; FROM SCRATCH: open NUL (Windows null device) read-only; close handle; exit 0 on success.
;
; Build: ml64 /c 08-from-scratch-close.asm && link /OUT:08-from-scratch-close.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-close.obj kernel32.lib
;
; Expected exit: 0

EXTERN CreateFileA:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "NUL", 0

.code

ex_08_from_scratch_close PROC
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
    mov     eax, 0
    ret
ex_08_from_scratch_close ENDP
main PROC
    sub     rsp, 72
    call    ex_08_from_scratch_close
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
