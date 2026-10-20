; Listing 01: Simple MASM macro
;
; Purpose: Demonstrate MASM macro definition and invocation.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo01-simple-macro.obj 01-simple-macro.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-simple-macro.exe 01-simple-macro.obj kernel32.lib

; MASM macro: add_to_rax value
; Expands to: add rax, value
add_to_rax MACRO value
    add rax, value
ENDM

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5
    add_to_rax 10              ; Macro expands to: add rax, 10
    
    mov rcx, rax               ; RAX = 15
    call ExitProcess
main ENDP

END
