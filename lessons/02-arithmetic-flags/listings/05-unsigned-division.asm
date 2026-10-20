; Listing 05: Unsigned division with zero-extended dividend
;
; Purpose: Demonstrates proper setup for unsigned division.
; Expected exit code: 14 (quotient of 100/7)
; Expected output: (none)
;
; Build: ml64 /c /Fo05-unsigned-division.obj 05-unsigned-division.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-unsigned-division.exe 05-unsigned-division.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 100               ; Dividend in RAX
    xor rdx, rdx               ; Clear high half (RDX = 0)
    mov rbx, 7                 ; Divisor
    div rbx                    ; RAX = quotient (14), RDX = remainder (2)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
