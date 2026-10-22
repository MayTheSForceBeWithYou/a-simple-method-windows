; Exercise 17: dup concept
;
; Without DuplicateHandle: write to stdout; exit 0. Documents handle reuse.
;
; Build: ml64 /c 17-dup-concept.asm && link /OUT:17-dup-concept.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-dup-concept.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "d\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "d", 10

.data?
written DWORD ?

.code
ex_17_dup_concept PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
        mov     eax, 0
    add     rsp, 56
    ret
ex_17_dup_concept ENDP
main PROC
    call    ex_17_dup_concept
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
