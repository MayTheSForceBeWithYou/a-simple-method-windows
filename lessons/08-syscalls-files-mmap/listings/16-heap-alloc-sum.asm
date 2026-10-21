; Listing 16: GetProcessHeap, HeapAlloc, HeapFree (LESSON.md)
; Expected exit: 16
; Expected stdout: (none)

HEAP_ZERO_MEMORY EQU 8

.DATA?
hHeap QWORD ?
pBuf QWORD ?

.CODE
EXTRN GetProcessHeap:PROC
EXTRN HeapAlloc:PROC
EXTRN HeapFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    call    GetProcessHeap
    test    rax, rax
    jz      fail
    mov     hHeap, rax

    mov     rcx, hHeap
    xor     edx, edx
    mov     r8d, 16
    call    HeapAlloc
    test    rax, rax
    jz      fail
    mov     pBuf, rax

    mov     rdi, rax
    mov     ecx, 16
    mov     al, 1
    cld
    rep     stosb

    xor     eax, eax
    mov     rcx, 16
    mov     rsi, pBuf
sum_loop:
    movzx   edx, BYTE PTR [rsi]
    add     eax, edx
    inc     rsi
    loop    sum_loop

    mov     rbx, eax

    mov     rcx, hHeap
    xor     edx, edx
    mov     r8, pBuf
    call    HeapFree

    mov     ecx, ebx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
