; Exercise 13: munmap
;
; VirtualAlloc then VirtualFree; exit 0 if VirtualFree succeeds.
;
; Build: ml64 /c 13-munmap.asm && link /OUT:13-munmap.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-munmap.obj kernel32.lib
;
; Expected exit: 0

EXTERN VirtualAlloc:PROC
EXTERN VirtualFree:PROC
EXTERN ExitProcess:PROC

.code
ex_13_munmap PROC
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
    
    ; VirtualFree(address, 0, MEM_RELEASE)
    mov rcx, rax        ; lpAddress
    mov rdx, 0          ; dwSize = 0 for MEM_RELEASE
    mov r8d, 8000h      ; dwFreeType = MEM_RELEASE
    call VirtualFree
    
    ; VirtualFree returns nonzero on success, 0 on failure
    test rax, rax
    jz L_f
    
    ; Success - exit 0
        mov     eax, 0
    ret
    
L_f:
    ; Failure - exit 1
    mov rcx, 1
    call ExitProcess

ex_13_munmap ENDP
main PROC
    call    ex_13_munmap
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
