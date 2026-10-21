; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Listing 04: Color-key blit copy loop (LESSON.md block 4)
; Expected exit: 10
; Expected stdout: (none)

.DATA
src DB 0, 5, 0, 5, 0

.DATA?
dst DB 4 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, src
    lea     r11, dst
    xor     rcx, rcx
copy_loop:
    cmp     rcx, 4
    jge     done
    mov     al, BYTE PTR [r10+rcx]
    test    al, al
    jz      skip
    mov     BYTE PTR [r11+rcx], al
skip:
    inc     rcx
    jmp     copy_loop
done:
    xor     rax, rax
    mov     rcx, 4
sum_loop:
    dec     rcx
    js      exit_sum
    movzx   rdx, BYTE PTR [r11+rcx]
    add     rax, rdx
    jmp     sum_loop
exit_sum:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
