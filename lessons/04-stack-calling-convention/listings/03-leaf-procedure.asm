; Listing 03: Leaf procedure (calls no one)
;
; Purpose: Demonstrate simple leaf function in MS x64 ABI.
; Expected exit code: 25
; Expected output: (none)
;
; Build: ml64 /c /Fo03-leaf-procedure.obj 03-leaf-procedure.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-leaf-procedure.exe 03-leaf-procedure.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: square(x) -> x * x
; Leaf function: no prologue needed, just compute and return
square PROC
    imul rcx, rcx              ; RCX = RCX * RCX
    mov rax, rcx               ; Return value in RAX
    ret
square ENDP

main PROC
    sub rsp, 40
    
    mov rcx, 5
    call square                ; RAX = 25
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
