; Exercise: 11-read-nul
;
; Allocate zero-filled memory with VirtualAlloc; read 8 bytes; sum should be 0; exit 0.
; Expected exit: 0
;
.code
ex_11_read_nul PROC
    sub rsp, 40
    
    ; VirtualAlloc(NULL, 8, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 8          ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Check for NULL (failure)
    test eax, eax
    jz L_e
    
    ; Memory is automatically zero-filled
    ; Sum 8 bytes (should all be 0)
    mov r8, rax
    xor rdi, rdi
    xor rcx, rcx
    mov cl, 8
    
L_sum_loop:
    movzx rdx, BYTE PTR [r8]
    add rdi, rdx
    inc r8
    dec cl
    jnz L_sum_loop
    
    ; Exit with sum (should be 0)
    mov rcx, rdi
    jmp L_o
    
L_e:
    ; Exit 1 on error
    mov rcx, 1
    
L_o:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_read_nul ENDP
main PROC
    sub     rsp, 40
    call    ex_11_read_nul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
