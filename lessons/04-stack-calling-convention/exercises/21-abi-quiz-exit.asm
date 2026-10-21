; Exercise 21: abi quiz exit (Win32 port)
; identity4 returns 4th arg. MS x64: R9 is 4th arg. Exit 4.
; Build: ml64 /c /Fo21-abi-quiz-exit.obj 21-abi-quiz-exit.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-abi-quiz-exit.exe 21-abi-quiz-exit.obj kernel32.lib
; Expected exit: 4
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC

identity4 PROC
    mov rax, r9                ; 4th arg in R9 (MS x64)
    ret
identity4 ENDP

main PROC
    sub rsp, 32
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4                  ; 4th arg
    ; TODO: Call identity4 and exit with result

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP
END
