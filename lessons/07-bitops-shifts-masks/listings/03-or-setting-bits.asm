; Listing 03: OR setting bits (lines 24-32 of LESSON.md)
;
; Purpose: Set bits using OR.
; Expected exit code: 5
; Expected output: (none)
;
; Build: ml64 /c /Fo03-or-setting-bits.obj 03-or-setting-bits.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-or-setting-bits.exe 03-or-setting-bits.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; RAX = 0
    or rax, 1                  ; Set bit 0
    or rax, 4                  ; Set bit 2
                               ; Result: RAX = 5 (binary 101)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
