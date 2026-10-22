; Exercise: 13-debug-bad-length
;
; BUG HUNT: Writes "Hi\n" but length parameter too short. Fix via EQU / r8d in `write_hi_buggy` when you implement `ex_13_debug_bad_length`.
;
; Contract: implement `ex_13_debug_bad_length` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "Hi", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_13_debug_bad_length:PROC

; BUG: r8d too small — student fixes this pattern inside ex_13_debug_bad_length.
write_hi_buggy PROC
    sub     rsp, 56
    mov     rcx, -11
    call    GetStdHandle
    mov     rcx, rax
    lea     rdx, msg
    mov     r8d, 2
    mov     r9, 0
    mov     QWORD PTR [rsp+32], 0
    mov     QWORD PTR [rsp+40], 0
    call    WriteFile
    mov     eax, 0
    add     rsp, 56
    ret
write_hi_buggy ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_debug_bad_length in this file (call fixed WriteFile path; exit 0 in EAX).
    call    ex_13_debug_bad_length
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
