; 04-mmap-anon.asm
;
; Allocate memory with VirtualAlloc, store 42, exit with that value.
;
; Task: VirtualAlloc one page (4096 bytes) with MEM_COMMIT | MEM_RESERVE and PAGE_READWRITE.
;       Store 42 at the base address, read it back, exit with 42.
;
; Hint: VirtualAlloc(NULL, 4096, 0x3000, 4) returns base address in RAX.
;       Check for NULL (error).

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    .ERR <TODO: Call VirtualAlloc with proper flags>
    
    ; TODO: Check for NULL
    .ERR <TODO: Test rax, jz error>
    
    ; TODO: Store 42 at [rax]
    .ERR <TODO: mov BYTE PTR [rax], 42>
    
    ; TODO: Read back and exit with value
    .ERR <TODO: movzx ecx, BYTE PTR [rax]>
    
    ; TODO: VirtualFree(address, 0, MEM_RELEASE)
    .ERR <TODO: Call VirtualFree>
    
    add     rsp, 32
    pop     rbx
    call    ExitProcess
main ENDP

END
