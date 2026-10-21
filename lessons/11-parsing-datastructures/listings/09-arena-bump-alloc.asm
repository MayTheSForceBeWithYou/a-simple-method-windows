; Listing 09: Bump-pointer arena allocator (LESSON.md block 9)
; Expected exit: 32
; Expected stdout: (none)

.DATA?
arena DB 4096 DUP(?)
bump QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     bump, 0
    mov     rdi, 16
    mov     rax, bump
    add     bump, rdi
    mov     rdi, 16
    add     bump, rdi
    mov     ecx, DWORD PTR bump
    call    ExitProcess
main ENDP
END
