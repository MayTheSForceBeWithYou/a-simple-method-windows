; Exercise 06: hash cell
;
; cell=(x>>3)+((y>>3)<<4); x=10 y=10; compute exit &255.
;
; Build: ml64 /c 06-hash-cell.asm && link /OUT:06-hash-cell.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-hash-cell.obj kernel32.lib
;
; Expected exit: 17
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_06_hash_cell PROC
mov rax, 10
    shr rax, 3
    mov rbx, 10
    shr rbx, 3
    shl rbx, 4
    add rax, rbx
    and rax, 255
    mov rcx, rax
    ; return value already in EAX/RAX
    ret
ex_06_hash_cell ENDP
main PROC
    sub     rsp, 40
    call    ex_06_hash_cell
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
