; Exercise 18: load version check
;
; version==1 ok exit 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
ver QWORD 1

.code

ex_18_load_version_check PROC
cmp QWORD PTR [ver], 1
    jne ver_bad
    mov rcx, 1
    jmp ver_done
ver_bad:
    xor ecx, ecx
ver_done:
    mov     eax, ecx
    ret
ex_18_load_version_check ENDP
main PROC
    sub     rsp, 40
    call    ex_18_load_version_check
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
