; Exercise: 20-fold-list
;
; Exercise 20: fold list
; Null-terminated list [3,4,5,0]. fold_add = 12.
;
; Contract: implement `ex_20_fold_list` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;

; Exercise 20: 20-fold-list.asm (Win32 port)
; Null-terminated qword list (0 sentinel): 3,4,5,0. fold add via proc; exit 12.
; Build: ml64 /c /Fo20-fold-list.asm.obj 20-fold-list.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-fold-list.asm.exe 20-fold-list.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_fold_list:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_20_fold_list in this file.
    call    ex_20_fold_list
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
