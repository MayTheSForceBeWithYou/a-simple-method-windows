; Exercise: 21-abi-quiz-exit
;
; Exercise 21: abi quiz exit
; MS x64: args in rcx,rdx,r8,r9. identity4 returns arg4 (r9). Exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_21_abi_quiz_exit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; Exercise 21: abi quiz exit (Win32 port)
; identity4 returns 4th arg. MS x64: R9 is 4th arg. Exit 4.
; Build: ml64 /c /Fo21-abi-quiz-exit.obj 21-abi-quiz-exit.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-abi-quiz-exit.exe 21-abi-quiz-exit.obj kernel32.lib
; Expected exit: 4
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_21_abi_quiz_exit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_abi_quiz_exit in this file.
    call    ex_21_abi_quiz_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
