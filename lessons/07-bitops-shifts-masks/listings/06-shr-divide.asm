; Listing 06: SHR unsigned divide (lines 93-99 of LESSON.md)
;
; Purpose: Unsigned division by power of 2 using SHR.
; Expected exit code: 3
; Expected output: (none)
;
; Build: ml64 /c /Fo06-shr-divide.obj 06-shr-divide.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-shr-divide.exe 06-shr-divide.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 12
    shr rax, 2                 ; RAX = 12 / 4 = 3
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
