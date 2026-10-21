; Listing 08: BFS on a 5-node line; visit count
; Expected exit: 5
; Expected stdout: (none)

NODE_COUNT EQU 5

.DATA?
bfs_queue QWORD 16 DUP(?)
head QWORD ?
tail QWORD ?
visited BYTE NODE_COUNT DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rdi
    push    rbx
    sub     rsp, 40
    lea     r10, bfs_queue
    mov     head, 0
    mov     tail, 0
    lea     rdi, visited
    mov     ecx, NODE_COUNT
    xor     eax, eax
    cld
    rep     stosb

    mov     rax, 0
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], rax
    inc     tail
    mov     BYTE PTR visited[0], 1

    mov     rbx, 1

bfs_loop:
    mov     rax, QWORD PTR head
    cmp     rax, QWORD PTR tail
    jge     bfs_done
    mov     rcx, head
    mov     rax, QWORD PTR [r10+rcx*8]
    inc     head

    mov     rcx, rax
    dec     rcx
    jns     try_left
    jmp     try_right
try_left:
    cmp     BYTE PTR visited[rcx], 0
    jne     try_right
    mov     BYTE PTR visited[rcx], 1
    inc     rbx
    mov     rdx, tail
    mov     QWORD PTR [r10+rdx*8], rcx
    inc     tail
try_right:
    mov     rcx, rax
    inc     rcx
    cmp     rcx, NODE_COUNT
    jge     bfs_loop
    cmp     BYTE PTR visited[rcx], 0
    jne     bfs_loop
    mov     BYTE PTR visited[rcx], 1
    inc     rbx
    mov     rdx, tail
    mov     QWORD PTR [r10+rdx*8], rcx
    inc     tail
    jmp     bfs_loop

bfs_done:
    add     rsp, 40
    pop     rbx
    pop     rdi
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
