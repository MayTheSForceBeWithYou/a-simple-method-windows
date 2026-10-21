; Listing 03: Key hold repeat counter (LESSON.md block 3)
; Expected exit: 1
; Expected stdout: (none)

.DATA?
key BYTE ?
hold_count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     BYTE PTR key, 1
    mov     hold_count, 0
    cmp     BYTE PTR key, 1
    jne     not_held
    inc     hold_count
    inc     hold_count
    inc     hold_count
not_held:
    cmp     hold_count, 3
    jl      no_fire
    mov     ecx, 1
    jmp     done
no_fire:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
