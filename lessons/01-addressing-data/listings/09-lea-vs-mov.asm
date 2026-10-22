; Listing 09: LEA scaled index without a memory load (LESSON.md block 9)
;
; Purpose: LEA computes 3*rcx in one instruction; distinct from listing 06 (loads value 20).
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo09-lea-vs-mov.obj 09-lea-vs-mov.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-lea-vs-mov.exe 09-lea-vs-mov.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rcx, 5
    lea rdx, [rcx+rcx*2]       ; RDX = 5 + 5*2 = 15 (no memory access)
    mov rcx, rdx
    call ExitProcess
main ENDP

END
