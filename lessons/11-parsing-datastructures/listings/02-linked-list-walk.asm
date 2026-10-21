; 02-linked-list-walk.asm: Walk linked list, count nodes, exit count
.DATA
node1 QWORD 10, offset node2
node2 QWORD 20, offset node3
node3 QWORD 30, 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    lea rax, node1
    xor ecx, ecx
walk_loop:
    test rax, rax
    jz done
    inc ecx
    mov rax, [rax+8]
    jmp walk_loop
done:
    call ExitProcess
main ENDP
END
