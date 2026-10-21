; Exercise 22: stretch file copy mem
;
; STRETCH: copy 4 bytes between two VirtualAlloc regions; checksum 10 for 1,2,3,4.
;
; Build: ml64 /c 22-stretch-file-copy-mem.asm && link /OUT:22-stretch-file-copy-mem.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-file-copy-mem.obj kernel32.lib
;
; Expected exit: 10

EXTERN VirtualAlloc:PROC
EXTERN ExitProcess:PROC

.data
srcinit BYTE 1, 2, 3, 4

.code
main PROC
    sub rsp, 40
    
    ; VirtualAlloc for destination
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 4096       ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Save destination pointer
    mov rbx, rax
    
    ; Copy 4 bytes from srcinit to destination
    lea rsi, srcinit
    mov rdi, rbx
    mov rcx, 4
    rep movsb
    
    ; Calculate checksum (1+2+3+4=10)
    xor rdi, rdi
    movzx rax, BYTE PTR [rbx]
    add rdi, rax
    movzx rax, BYTE PTR [rbx+1]
    add rdi, rax
    movzx rax, BYTE PTR [rbx+2]
    add rdi, rax
    movzx rax, BYTE PTR [rbx+3]
    add rdi, rax
    
    ; Exit with checksum
    mov rcx, rdi
    call ExitProcess
main ENDP
END
