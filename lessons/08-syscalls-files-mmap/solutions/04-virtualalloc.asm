; Exercise: 04-virtualalloc
;
; VirtualAlloc 4096 bytes RW; store 42; exit 42.
; Expected exit: 42
;
.code
ex_04_virtualalloc PROC
    sub rsp, 40
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 4096       ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Check for NULL (failure)
    test rax, rax
    jz L_fail
    
    ; Store 42 at allocated address
    mov rbx, rax
    mov QWORD PTR [rbx], 42
    
    ; Exit with value from memory
    mov rcx, [rbx]
    mov     eax, ecx
    add     rsp, 40
    ret
L_fail:
    ; Exit 2 on allocation failure
    mov rcx, 2
    mov     eax, 2
    ret
ex_04_virtualalloc ENDP
main PROC
    sub     rsp, 40
    call    ex_04_virtualalloc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
