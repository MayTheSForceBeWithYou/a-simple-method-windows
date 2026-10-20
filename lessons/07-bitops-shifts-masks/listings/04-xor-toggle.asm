; Listing 04: XOR toggling (lines 36-47 of LESSON.md)
;
; Purpose: Toggle bits using XOR.
; Expected exit code: 4
; Expected output: (none)
;
; Build: ml64 /c /Fo04-xor-toggle.obj 04-xor-toggle.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-xor-toggle.exe 04-xor-toggle.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5                 ; Binary 101
    xor rax, 1                 ; Flip bit 0 → binary 100
                               ; Result: RAX = 4
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
