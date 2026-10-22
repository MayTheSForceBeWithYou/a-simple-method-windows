; Exercise: 05-byte-store
;
; Exercise 05: byte store
; buf: 3 bytes. Store "O" and "K", write both + newline. Exit 0.
;
; Contract: implement `ex_05_byte_store` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 05: byte store (Win32 port)
;
; Declare buffer in .DATA?. Store byte 88 to it, load back, exit.
;
; Build: ml64 /c /Fo05-byte-store.obj 05-byte-store.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-byte-store.exe 05-byte-store.obj kernel32.lib
; Run: 05-byte-store.exe & echo %ERRORLEVEL%
;
; Expected exit: 88
; Expected stdout: (none)
.DATA?
buffer DB ?

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_byte_store:PROC

main PROC
    sub     rsp, 40
    ; TODO: Store BYTE 88 to buffer, load with MOVZX, exit
    ; Hint: Use BYTE PTR [buffer] and movzx rcx, BYTE PTR [buffer]
    ; TODO: write ex_05_byte_store in this file.
    call    ex_05_byte_store
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
