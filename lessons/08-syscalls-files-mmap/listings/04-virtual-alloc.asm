; 04-virtual-alloc.asm
;
; Purpose: Allocate memory using VirtualAlloc (equivalent to anonymous mmap)
; Expected exit code: 42
; Expected stdout: (none)
;
; Demonstrates:
; - VirtualAlloc for anonymous memory allocation
; - MEM_COMMIT | MEM_RESERVE flags
; - PAGE_READWRITE protection
; - VirtualFree to release memory

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    xor     ecx, ecx            ; lpAddress = NULL (let system choose)
    mov     edx, 4096           ; dwSize = 4096 bytes (one page)
    mov     r8d, 3000h          ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov     r9d, 4              ; flProtect = PAGE_READWRITE
    call    VirtualAlloc
    
    test    rax, rax
    jz      error
    
    mov     rbx, rax            ; Save memory address
    
    ; Write value 42 to allocated memory
    mov     BYTE PTR [rbx], 42
    
    ; Read it back
    movzx   r12d, BYTE PTR [rbx]
    
    ; VirtualFree(address, 0, MEM_RELEASE)
    mov     rcx, rbx
    xor     edx, edx            ; dwSize = 0 (required for MEM_RELEASE)
    mov     r8d, 8000h          ; dwFreeType = MEM_RELEASE
    call    VirtualFree
    
    ; Exit with value we stored
    mov     ecx, r12d
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 40
    call    ExitProcess
main ENDP

END
