; Exercise 13: store through ptr
;
; lea rdx,[slot]; mov QWORD PTR [rdx], 77; mov rcx,[slot]; exit.
;
; Build: ml64 /c 13-store-through-ptr.asm && link /OUT:13-store-through-ptr.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-store-through-ptr.obj kernel32.lib
;
; Expected exit: 77

EXTERN ExitProcess:PROC

.data?
slot QWORD ?

.code
main PROC
    sub rsp, 32
    lea rdx, [slot]
    mov QWORD PTR [rdx], 77
    mov rcx, [slot]
    call ExitProcess
main ENDP
END
