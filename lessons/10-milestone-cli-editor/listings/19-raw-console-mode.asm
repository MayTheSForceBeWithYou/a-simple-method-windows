; Listing 19: Raw console mode via Get/SetConsoleMode (LESSON.md block 19)
;
; Purpose: Clear ENABLE_LINE_INPUT and ENABLE_ECHO_INPUT, then restore mode.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
mode DWORD ?
original_mode DWORD ?
stdin_handle QWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN GetConsoleMode:PROC
EXTRN SetConsoleMode:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov     rcx, -10
    call    GetStdHandle
    mov     stdin_handle, rax

    mov     rcx, stdin_handle
    lea     rdx, original_mode
    call    GetConsoleMode
    test    rax, rax
    jz      no_console

    mov     eax, original_mode
    and     eax, NOT 6
    mov     mode, eax

    mov     rcx, stdin_handle
    mov     edx, mode
    call    SetConsoleMode
    test    rax, rax
    jz      error_exit

    mov     rcx, stdin_handle
    mov     edx, original_mode
    call    SetConsoleMode

    xor     ecx, ecx
    call    ExitProcess

no_console:
    xor     ecx, ecx
    call    ExitProcess

error_exit:
    mov     ecx, 1
    call    ExitProcess
main ENDP

END
