; Listing 05: SoA entity update loop (LESSON.md block 5)
; Expected exit: 4
; Expected stdout: (none)

.DATA
xs DQ 0, 0, 0
vxs DQ 1, 2, 3
alive DB 1, 0, 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, xs
    lea     r11, vxs
    lea     r12, alive
    xor     rcx, rcx
loop_start:
    cmp     rcx, 3
    jge     done
    cmp     BYTE PTR [r12+rcx], 0
    je      next
    mov     rax, QWORD PTR [r11+rcx*8]
    add     QWORD PTR [r10+rcx*8], rax
next:
    inc     rcx
    jmp     loop_start
done:
    mov     rax, QWORD PTR [r10]
    add     rax, QWORD PTR [r10+16]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
