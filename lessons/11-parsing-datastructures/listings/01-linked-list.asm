; Listing 01: Simple linked list in assembly
;
; Purpose: Demonstrate struct-like data and pointer chasing.
; Expected exit code: 3 (count of nodes)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-linked-list.obj 01-linked-list.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-linked-list.exe 01-linked-list.obj kernel32.lib

; Node structure:
;   +0: value (DQ)
;   +8: next pointer (DQ)

.DATA
node1 DQ 10, node2
node2 DQ 20, node3
node3 DQ 30, 0

.CODE

EXTRN ExitProcess:PROC

; count_list(head) -> count of nodes
; RCX = head pointer
count_list PROC
    xor rax, rax               ; Count = 0
loop_start:
    test rcx, rcx              ; Check if null
    jz loop_done
    inc rax
    mov rcx, [rcx+8]           ; Follow next pointer
    jmp loop_start
loop_done:
    ret
count_list ENDP

main PROC
    sub rsp, 32
    
    lea rcx, node1
    call count_list            ; RAX = 3
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
