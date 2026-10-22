; 01-buffer-init.asm: Initialize buffer (len=0, cur=0), exit 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_buffer_init:PROC
main PROC
    ; TODO: write ex_01_buffer_init in this file.
    call    ex_01_buffer_init
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
