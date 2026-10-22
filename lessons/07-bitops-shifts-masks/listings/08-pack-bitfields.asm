; Listing 08: Pack bitfields (lines 124-141 of LESSON.md)
;
; Purpose: Pack three 3-bit values into one register.
; Expected exit code: 85 (0b001_010_101)
; Expected output: (none)
;
; Build: ml64 /c /Fo08-pack-bitfields.obj 08-pack-bitfields.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-pack-bitfields.exe 08-pack-bitfields.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Pack a=5, b=2, c=1 into bits 0-2, 3-5, 6-8
    mov rax, 5
    and rax, 7h                ; Mask to 3 bits
    
    mov rbx, 2
    and rbx, 7h                ; Mask to 3 bits
    shl rbx, 3                 ; Shift to bits 3-5
    or rax, rbx
    
    mov rbx, 1
    and rbx, 7h                ; Mask to 3 bits
    shl rbx, 6                 ; Shift to bits 6-8
    or rax, rbx
    
    ; Result: RAX = 0b001_010_101 = 85
    mov rcx, rax
    call ExitProcess
main ENDP

END
