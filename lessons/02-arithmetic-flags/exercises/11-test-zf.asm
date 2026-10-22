; Exercise 11: test zf
;
; rax=0; test rax,rax; sete al; exit 1.
;
; Build: ml64 /c 11-test-zf.asm && link /OUT:11-test-zf.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-test-zf.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_test_zf:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_test_zf in this file.
    call    ex_11_test_zf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
