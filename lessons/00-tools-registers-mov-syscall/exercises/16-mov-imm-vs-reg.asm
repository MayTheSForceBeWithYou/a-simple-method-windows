; Exercise 16: mov imm vs reg (Win32 port)
;
; Demonstrate difference between immediate and register operands.
;
; Build: ml64 /c /Fo16-mov-imm-vs-reg.obj 16-mov-imm-vs-reg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-mov-imm-vs-reg.exe 16-mov-imm-vs-reg.obj kernel32.lib
; Run: 16-mov-imm-vs-reg & echo %ERRORLEVEL%
;
; Expected exit: 20
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_mov_imm_vs_reg:PROC

main PROC
    sub     rsp, 32
    ; TODO: write ex_16_mov_imm_vs_reg in this file.
    call    ex_16_mov_imm_vs_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
