; Exercise: 18-load-version-check
;
; version==1 ok exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data
ver QWORD 1

.code
ex_18_load_version_check PROC
    sub rsp, 40
    cmp QWORD PTR [ver], 1
    jne ver_bad
    mov rcx, 1
    jmp ver_done
ver_bad:
    xor ecx, ecx
ver_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_load_version_check ENDP
main PROC
    sub     rsp, 40
    call    ex_18_load_version_check
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
