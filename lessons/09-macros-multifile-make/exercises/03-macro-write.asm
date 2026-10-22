; Exercise: 03-macro-write
;
; Exercise 03: macro write
; Macro write_stdout msg,len; print 'M\n'.
; Expected stdout: "M\n"
;
; Contract: implement `ex_03_macro_write` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 03-macro-write.asm
; Macro writes "M\n", exit 0.
; Task: Define macro that gets stdout and writes message.

.DATA
msg DB "M", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_03_macro_write:PROC

; TODO: Define WriteMsgMacro

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_macro_write in this file.
    call    ex_03_macro_write
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
