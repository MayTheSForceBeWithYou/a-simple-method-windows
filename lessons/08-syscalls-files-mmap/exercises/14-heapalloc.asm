; Exercise: 14-heapalloc
;
; Windows equivalent: HeapAlloc/HeapFree from process heap. Exit 0 if heap exists.
;
; Contract: implement `ex_14_heapalloc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN GetProcessHeap:PROC
EXTRN ExitProcess:PROC
EXTRN ex_14_heapalloc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_heapalloc in this file.
    call    ex_14_heapalloc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
