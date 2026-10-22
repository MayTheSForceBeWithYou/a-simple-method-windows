; Exercise 14: brk query
;
; Windows equivalent: HeapAlloc/HeapFree from process heap. Exit 0 if heap exists.
;
; Build: ml64 /c 14-heapalloc.asm && link /OUT:14-heapalloc.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-heapalloc.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetProcessHeap:PROC
EXTERN ExitProcess:PROC

.code
ex_14_heapalloc PROC
    sub rsp, 40
    
    ; GetProcessHeap returns handle to process heap
    call GetProcessHeap
    
    ; Check if valid (nonzero)
    test eax, eax
    jz L_z
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_z:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_heapalloc ENDP
main PROC
    sub     rsp, 40
    call    ex_14_heapalloc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
