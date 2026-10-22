; Exercise: 10-despawn-freelist
;
; Free id 3 onto freelist top; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.data
free_top QWORD 0

.code
ex_10_despawn_freelist PROC
    sub rsp, 40
    mov QWORD PTR [free_top], 3
    mov rcx, QWORD PTR [free_top]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_despawn_freelist ENDP
main PROC
    sub     rsp, 40
    call    ex_10_despawn_freelist
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
