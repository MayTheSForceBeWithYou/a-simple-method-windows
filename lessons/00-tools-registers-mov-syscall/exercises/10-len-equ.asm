; Exercise: 10-len-equ
;
; Exercise 10: len equ
; Define string "equ works\n" with BYTE; length via EQU $ - label. Write it; exit 0.
;
; Contract: implement `ex_10_len_equ` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 10: len equ (Win32 port)
;
; Declare a message and compute its length with EQU $ - label.
; Write the message using the computed length.
;
; Build: ml64 /c /Fo10-len-equ.obj 10-len-equ.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-len-equ.exe 10-len-equ.obj kernel32.lib
; Run: 10-len-equ.exe
;
; Expected exit: 0
; Expected stdout: "Test message\n"

.DATA
; TODO: Declare 'msg' with "Test message" and CRLF
; TODO: Use 'msg_len EQU $ - msg' to compute length

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_10_len_equ:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_len_equ in this file.
    call    ex_10_len_equ
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
