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
main PROC
    sub rsp, 32
    
    ; GetProcessHeap returns handle to process heap
    call GetProcessHeap
    
    ; Check if valid (nonzero)
    test rax, rax
    jz .z
    
    ; Success - exit 0
    mov rcx, 0
    jmp .o
    
.z:
    ; Failure - exit 1
    mov rcx, 1
    
.o:
    call ExitProcess
main ENDP
END
