; Listing 02: AND masking (lines 12-18 of LESSON.md)
;
; Purpose: Extract low nibble using AND mask.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo02-and-masking.obj 02-and-masking.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-and-masking.exe 02-and-masking.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 0FFh              ; RAX = 11111111 binary
    and rax, 0Fh               ; RAX = 00001111 binary (keep low nibble)
                               ; Result: RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
