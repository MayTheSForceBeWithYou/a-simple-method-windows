; Listing 15: Write buffer to stdout (LESSON.md block 15)
;
; Purpose: Write live buffer bytes with WriteFile to stdout.
; Expected exit code: 0
; Expected stdout: "ed\r\n"

.DATA
buf BYTE "ed", 13, 10
len EQU $ - buf

.DATA?
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov     rcx, -11
    call    GetStdHandle
    mov     rcx, rax
    lea     rdx, buf
    mov     r8d, len
    lea     r9, written
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
