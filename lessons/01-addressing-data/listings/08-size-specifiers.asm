; Listing 08: Size specifiers - byte, word, dword, qword
;
; Purpose: Demonstrate explicit size specifications for memory operands.
; Expected exit code: 65 (ASCII 'A')
; Expected output: (none)
;
; Build: ml64 /c /Fo08-size-specifiers.obj 08-size-specifiers.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-size-specifiers.exe 08-size-specifiers.obj kernel32.lib

.DATA?
buffer DB 64 DUP(?)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    lea rbx, buffer
    
    ; Store different sizes
    mov BYTE PTR [rbx], 65     ; Store 1 byte: 'A'
    mov WORD PTR [rbx+1], 4342h  ; Store 2 bytes: 'BC'
    mov DWORD PTR [rbx+3], 12345678 ; Store 4 bytes
    mov QWORD PTR [rbx+7], -1  ; Store 8 bytes
    
    ; Load and exit with first byte
    movzx rcx, BYTE PTR [rbx]
    call ExitProcess
main ENDP

END
