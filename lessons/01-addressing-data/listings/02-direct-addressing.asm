; Listing 02: Direct addressing with labels
;
; Purpose: Load from and store to memory using label addresses.
; Expected exit code: 30
; Expected output: (none)
;
; Build: ml64 /c /Fo02-direct-addressing.obj 02-direct-addressing.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-direct-addressing.exe 02-direct-addressing.obj kernel32.lib

.DATA
value1 DQ 10
value2 DQ 20
result DQ 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load values from memory
    mov rax, value1            ; RAX = 10
    mov rbx, value2            ; RBX = 20
    
    ; Compute sum
    add rax, rbx               ; RAX = 30
    
    ; Store result to memory
    mov result, rax            ; Store 30 to result
    
    ; Exit with result
    mov rcx, rax
    call ExitProcess
main ENDP

END
