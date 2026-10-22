; Exercise: 13-store-through-ptr
;
; Exercise 13: store through ptr
; lea rdx,[slot]; mov QWORD PTR [rdx], 77; mov rcx,[slot]; exit.
;
; Contract: implement `ex_13_store_through_ptr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 77
;

; Exercise 13: store through ptr
;
; lea rdx,[slot]; mov QWORD PTR [rdx], 77; mov rcx,[slot]; exit.
;
; Build: ml64 /c 13-store-through-ptr.asm && link /OUT:13-store-through-ptr.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-store-through-ptr.obj kernel32.lib
;
; Expected exit: 77


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_store_through_ptr:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_store_through_ptr in this file.
    call    ex_13_store_through_ptr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
