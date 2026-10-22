; Exercise: 12-virtualalloc-read-write
;
; VirtualAlloc 4096; write 99 at +100; read back; exit 99.
; Expected exit: 99
;
.code
ex_12_virtualalloc_read_write PROC
    sub rsp, 40
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 4096       ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Check for NULL (failure)
    test eax, eax
    jz L_f
    
    ; Write 99 at offset +100
    mov rbx, rax
    mov BYTE PTR [rbx+100], 99
    
    ; Read back and exit with value
    movzx rcx, BYTE PTR [rbx+100]
    mov     eax, ecx
    add     rsp, 40
    ret
L_f:
    ; Exit 2 on allocation failure
    mov rcx, 2
    mov     eax, 2
    ret
ex_12_virtualalloc_read_write ENDP
main PROC
    sub     rsp, 40
    call    ex_12_virtualalloc_read_write
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
