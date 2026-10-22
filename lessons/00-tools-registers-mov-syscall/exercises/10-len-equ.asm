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
    ; TODO: implement ex_10_len_equ (student routine; defined in solutions/).
    call    ex_10_len_equ
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
