; Listing 05: SHL multiply (lines 84-89 of LESSON.md)
;
; Purpose: Multiply by power of 2 using SHL.
; Expected exit code: 12
; Expected output: (none)
;
; Build: ml64 /c /Fo05-shl-multiply.obj 05-shl-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-shl-multiply.exe 05-shl-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 3
    shl rax, 2                 ; RAX = 3 * 4 = 12
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
