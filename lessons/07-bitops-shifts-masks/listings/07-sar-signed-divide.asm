; Listing 07: SAR signed divide (lines 101-110 of LESSON.md)
;
; Purpose: Signed division preserving sign with SAR.
; Expected exit code: 252 (-4 as unsigned byte)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-sar-signed-divide.obj 07-sar-signed-divide.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-sar-signed-divide.exe 07-sar-signed-divide.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -8
    sar rax, 1                 ; RAX = -8 / 2 = -4 (correct signed)
    
    mov rcx, rax
    and rcx, 0FFh              ; Truncate to byte for exit code
    call ExitProcess
main ENDP

END
