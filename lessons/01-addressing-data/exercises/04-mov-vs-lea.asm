; Exercise: 04-mov-vs-lea
;
; Label x QWORD 99. lea rbx,[x] then mov rcx,[rbx]. Exit with 99. Comment which is address vs load.
;
; Contract: implement `ex_04_mov_vs_lea` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 99
;
.DATA
x DQ 99

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_04_mov_vs_lea:PROC

main PROC
    sub     rsp, 40
    ; TODO: Use LEA to load address of x into RBX
    ; TODO: Use MOV to load value from [RBX] into RAX
    ; TODO: Move RAX to RCX and exit
    ; TODO: write ex_04_mov_vs_lea in this file.
    call    ex_04_mov_vs_lea
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
