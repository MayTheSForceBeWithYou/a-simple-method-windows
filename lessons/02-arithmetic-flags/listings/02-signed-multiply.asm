; Listing 02: Signed multiplication with IMUL
;
; Purpose: Demonstrates IMUL in various forms.
; Expected exit code: 20
; Expected output: (none)
;
; Build: ml64 /c /Fo02-signed-multiply.obj 02-signed-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-signed-multiply.exe 02-signed-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Two-operand form
    mov rax, 5
    imul rax, 4                ; RAX = 5 * 4 = 20
    
    ; Three-operand immediate form
    mov rbx, 3
    imul rcx, rbx, 7           ; RCX = RBX * 7 = 21
    
    ; Exit with first result (20)
    mov rcx, rax
    call ExitProcess
main ENDP

END
