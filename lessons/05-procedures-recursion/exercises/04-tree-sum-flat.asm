; Exercise: 04-tree-sum-flat
;
; Exercise 04: tree sum flat
; Binary heap array [1,2,3,4,5]. Recursively sum. Exit 15.
;
; Contract: implement `ex_04_tree_sum_flat` (MS x64). Return exit code in EAX.
; Expected exit: 15
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_tree_sum_flat:PROC

; TODO: write ex_04_tree_sum_flat in this file.

main PROC
    sub     rsp, 40
    call    ex_04_tree_sum_flat
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
