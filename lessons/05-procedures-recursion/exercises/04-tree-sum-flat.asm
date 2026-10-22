; Exercise 04: tree sum flat (Win32 port)
; Simulate binary heap array DQ 1,2,3,4,5. Recursively sum. Exit 15.
; Build: ml64 /c /Fo04-tree-sum-flat.obj 04-tree-sum-flat.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-tree-sum-flat.exe 04-tree-sum-flat.obj kernel32.lib
; Expected: exit code 15

.DATA
heap DQ 1, 2, 3, 4, 5
heap_len EQU ($ - heap) / 8

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive tree sum over heap array

main PROC
    sub     rsp, 32
    call tree_sum
    mov rcx, rax
    call ExitProcess
main ENDP
END
