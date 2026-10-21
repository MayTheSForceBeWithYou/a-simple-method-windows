; Listing 21: Kill-line deletes to newline, keeps newline (LESSON.md)
; Expected exit: 3
; Expected stdout: (none)

.DATA
buf BYTE "ab", 10, "cd", 0

.DATA?
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rdi
    push    rsi
    sub     rsp, 40
    mov     len, 5
    mov     cur, 0

    mov     rcx, 0
    lea     rdx, buf
find_nl:
    cmp     BYTE PTR [rdx + rcx], 10
    je      found_nl
    inc     rcx
    jmp     find_nl

found_nl:
    mov     r8, rcx
    mov     r9, len
    mov     rdi, 0
    mov     rsi, r8
copy_rest:
    cmp     rsi, r9
    jge     copy_done
    movzx   eax, BYTE PTR [rdx + rsi]
    mov     BYTE PTR [rdx + rdi], al
    inc     rsi
    inc     rdi
    jmp     copy_rest

copy_done:
    mov     len, rdi
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP
END
