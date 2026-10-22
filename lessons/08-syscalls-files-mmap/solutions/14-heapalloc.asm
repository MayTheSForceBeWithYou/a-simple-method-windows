; Exercise: 14-heapalloc
;
; Windows equivalent: HeapAlloc/HeapFree from process heap. Exit 0 if heap exists.
; Expected exit: 0
;
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
