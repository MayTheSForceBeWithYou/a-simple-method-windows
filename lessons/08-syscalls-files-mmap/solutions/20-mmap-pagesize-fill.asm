; Exercise 20: mmap pagesize fill
;
; Fill first 16 bytes of VirtualAlloc with 1; sum=16; exit 16.
;
; Build: ml64 /c 20-mmap-pagesize-fill.asm && link /OUT:20-mmap-pagesize-fill.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-mmap-pagesize-fill.obj kernel32.lib
;
; Expected exit: 16

EXTERN VirtualAlloc:PROC
EXTERN ExitProcess:PROC

.code
ex_20_mmap_pagesize_fill PROC
    sub rsp, 40
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 4096       ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Save pointer
    mov rbx, rax
    
    ; Fill first 16 bytes with 1
    mov rcx, 16
    mov rdi, rbx
    mov al, 1
    rep stosb
    
    ; Sum first 16 bytes
    xor rcx, rcx
    xor rdi, rdi
    
L_s:
    cmp rcx, 16
    jge L_o
    movzx rax, BYTE PTR [rbx+rcx]
    add rdi, rax
    inc rcx
    jmp L_s
    
L_o:
    ; Exit with sum (16)
    mov rcx, rdi
    mov     eax, edi
    add     rsp, 40
    ret
ex_20_mmap_pagesize_fill ENDP
main PROC
    sub     rsp, 40
    call    ex_20_mmap_pagesize_fill
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
