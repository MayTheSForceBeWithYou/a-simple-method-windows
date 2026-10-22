; Exercise 10: despawn freelist
;
; Free id 3 onto freelist top; exit 3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
free_top QWORD 0

.code

ex_10_despawn_freelist PROC
mov QWORD PTR [free_top], 3
    mov rcx, QWORD PTR [free_top]
    mov     eax, QWORD PTR [free_top]
    ret
ex_10_despawn_freelist ENDP
main PROC
    sub     rsp, 40
    call    ex_10_despawn_freelist
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
