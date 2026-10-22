; Exercise 14: heapalloc
;
; Use GetProcessHeap / HeapAlloc (not VirtualAlloc). Exit 0 if heap handle is valid.
;
; Contract: implement `ex_14_heapalloc`; return 0 on success, 1 on failure.
; Expected exit: 0

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
