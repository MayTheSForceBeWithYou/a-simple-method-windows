; Listing 04: Byte memcpy loop (LESSON.md block 4)
; Expected exit: 4
; Expected stdout: (none)

.DATA
src DB "test", 0

.DATA?
dst DB 16 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rcx, dst
    lea     rdx, src
    mov     r8, 4
    xor     r9, r9
copy:
    cmp     r9, r8
    jge     done
    mov     al, BYTE PTR [rdx+r9]
    mov     BYTE PTR [rcx+r9], al
    inc     r9
    jmp     copy
done:
    mov     ecx, 4
    call    ExitProcess
main ENDP
END
