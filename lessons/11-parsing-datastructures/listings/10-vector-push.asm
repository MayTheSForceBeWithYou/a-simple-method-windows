; Listing 10: Fixed-capacity vector push (LESSON.md block 10)
; Expected exit: 3
; Expected stdout: (none)

.DATA?
vec_data DQ 8 DUP(?)
vec_len QWORD ?
vec_cap QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     vec_cap, 8
    mov     vec_len, 0
    mov     rdi, 10
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     vec_data[rcx*8], rdi
    inc     vec_len
    mov     rdi, 20
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     vec_data[rcx*8], rdi
    inc     vec_len
    mov     rdi, 30
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     vec_data[rcx*8], rdi
    inc     vec_len
done:
    mov     ecx, DWORD PTR vec_len
    call    ExitProcess
main ENDP
END
