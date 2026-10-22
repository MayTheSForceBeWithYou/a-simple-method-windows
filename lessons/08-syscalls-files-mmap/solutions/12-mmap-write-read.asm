; Exercise 12: mmap write read
;
; VirtualAlloc 4096; write 99 at +100; read back; exit 99.
;
; Build: ml64 /c 12-mmap-write-read.asm && link /OUT:12-mmap-write-read.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-mmap-write-read.obj kernel32.lib
;
; Expected exit: 99

EXTERN VirtualAlloc:PROC
EXTERN ExitProcess:PROC

.code
ex_12_mmap_write_read PROC
    sub rsp, 40
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    mov rcx, 0          ; lpAddress = NULL
    mov rdx, 4096       ; dwSize
    mov r8d, 3000h      ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9d, 4          ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    ; Check for NULL (failure)
    test rax, rax
    jz L_f
    
    ; Write 99 at offset +100
    mov rbx, rax
    mov BYTE PTR [rbx+100], 99
    
    ; Read back and exit with value
    movzx rcx, BYTE PTR [rbx+100]
    call ExitProcess
    
L_f:
    ; Exit 2 on allocation failure
    call ExitProcess
    mov     eax, 2
    add     rsp, 40
    ret
ex_12_mmap_write_read ENDP
main PROC
    sub     rsp, 40
    call    ex_12_mmap_write_read
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
