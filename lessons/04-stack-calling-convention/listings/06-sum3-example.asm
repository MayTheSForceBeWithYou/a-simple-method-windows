; Listing 06: sum3 worked example from LESSON.md (MS x64)
;
; Purpose: Sum three numbers using function (lines 162-183 of LESSON.md).
; Expected exit code: 60
; Expected output: (none)
;
; Build: ml64 /c /Fo06-sum3-example.obj 06-sum3-example.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-sum3-example.exe 06-sum3-example.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; sum3(a, b, c) -> a+b+c
; MS x64: RCX=a, RDX=b, R8=c
sum3 PROC
    mov rax, rcx               ; RAX = a
    add rax, rdx               ; RAX = a + b
    add rax, r8                ; RAX = a + b + c
    ret
sum3 ENDP

main PROC
    sub rsp, 40
    
    mov rcx, 10
    mov rdx, 20
    mov r8, 30
    call sum3                  ; RAX = 60
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
