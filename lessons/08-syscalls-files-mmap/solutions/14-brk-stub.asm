; Exercise 14: brk query
;
; Windows equivalent: HeapAlloc/HeapFree from process heap. Exit 0 if heap exists.
;
; Build: ml64 /c 14-brk-stub.asm && link /OUT:14-brk-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-brk-stub.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetProcessHeap:PROC
EXTERN ExitProcess:PROC

.code
ex_14_brk_stub PROC
    sub rsp, 40
    
    ; GetProcessHeap returns handle to process heap
    call GetProcessHeap
    
    ; Check if valid (nonzero)
    test rax, rax
    jz L_z
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_z:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, 0
    ret
    add     rsp, 40
ex_14_brk_stub ENDP
main PROC
    call    ex_14_brk_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
