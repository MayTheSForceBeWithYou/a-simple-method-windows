; Exercise: 18-spatial-hash-insert
;
; Insert entity into cell bucket count++; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
count QWORD ?

.code
ex_18_spatial_hash_insert PROC
    sub rsp, 40
    inc QWORD PTR [count]
    mov rcx, [count]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_spatial_hash_insert ENDP
main PROC
    sub     rsp, 40
    call    ex_18_spatial_hash_insert
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
