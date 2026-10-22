; Exercise 03: open fail
;
; open nonexistent path; if CreateFileA returns INVALID_HANDLE_VALUE exit 1 else 0. Expect 1.
;
; Build: ml64 /c 03-open-fail.asm && link /OUT:03-open-fail.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-open-fail.obj kernel32.lib
;
; Expected exit: 1

EXTERN CreateFileA:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "/no/such/asm_course_file", 0

.code

ex_03_open_fail PROC
; CreateFileA
    lea rcx, path               ; lpFileName
    mov rdx, 80000000h          ; dwDesiredAccess = GENERIC_READ
    mov r8d, 0                  ; dwShareMode = 0
    mov r9, 0                   ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    ; Check if INVALID_HANDLE_VALUE (-1)
    cmp rax, -1
    je L_bad
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_out
    
L_bad:
    ; Failure - exit 1
    mov rcx, 1
    
L_out:
    mov     eax, ecx
    ret
ex_03_open_fail ENDP
main PROC
    sub     rsp, 72
    call    ex_03_open_fail
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
