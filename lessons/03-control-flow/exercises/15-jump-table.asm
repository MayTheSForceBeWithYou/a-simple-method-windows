; Exercise: 15-jump-table
;
; Exercise 15: jump table
; rax=1. Jump table of 3 cases setting rcx to 10/20/30. Exit 20.
;
; Contract: implement `ex_15_jump_table` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 20
;

; Exercise 15: jump table
;
; rax=1. Jump table of 3 cases setting rcx to 10/20/30. Exit 20.
;
; Build: ml64 /c 15-jump-table.asm && link /OUT:15-jump-table.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-jump-table.obj kernel32.lib
;
; Expected exit: 20


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_jump_table:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_jump_table in this file.
    call    ex_15_jump_table
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
