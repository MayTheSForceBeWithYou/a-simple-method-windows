; Exercise 03: jne branch
;
; rax=1,rbx=2. jne -> exit 5; if equal would exit 0.
;
; Build: ml64 /c 03-jne-branch.asm && link /OUT:03-jne-branch.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-jne-branch.obj kernel32.lib
;
; Expected exit: 5


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_jne_branch:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_jne_branch in this file.
    call    ex_03_jne_branch
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
