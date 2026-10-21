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
    sub     rsp, 32
    xor     rcx, rcx
loop_start:
    cmp     rcx, 3
    jge     done
    cmp     BYTE PTR alive[rcx], 0
    je      next
    mov     rax, vxs[rcx*8]
    add     xs[rcx*8], rax
next:
    inc     rcx
    jmp     loop_start
done:
    mov     rax, xs
    add     rax, xs[16]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
