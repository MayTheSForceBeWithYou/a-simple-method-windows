; 03-arena-alloc.asm: Bump allocator, allocate 16 bytes, exit offset
.DATA?
arena DB 1024 DUP(?)
arena_cursor QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    lea rax, arena
    mov arena_cursor, rax
    mov rbx, arena_cursor
    add rbx, 16
    mov arena_cursor, rbx
    sub rbx, rax
    mov ecx, ebx
    call ExitProcess
main ENDP
END
