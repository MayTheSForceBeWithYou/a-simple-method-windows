; Exercise: 17-macro-stringize
;
; Exercise 17: macro stringize
; MASM text macro: write 'Q' and newline exit 0.
; Expected stdout: "Q\n"
;
; Contract: implement `ex_17_macro_stringize` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 17-macro-stringize.asm
; Stores string "Q\n", exit 0 (no stringification in MASM).

.DATA
msg DB "Q", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_17_macro_stringize:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_macro_stringize in this file.
    call    ex_17_macro_stringize
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
