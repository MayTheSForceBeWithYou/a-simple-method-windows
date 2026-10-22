; Listing 03: strcpy implementation (lines 56-68 of LESSON.md)
;
; Purpose: Copy string including NUL terminator.
; Expected exit code: 0
; Expected output: (none, but dst contains copy)
;
; Build: ml64 /c /Fo03-strcpy-implementation.obj 03-strcpy-implementation.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-strcpy-implementation.exe 03-strcpy-implementation.obj kernel32.lib

.DATA
src DB "test", 0

.DATA?
dst DB 10 DUP(?)

.CODE

EXTRN ExitProcess:PROC

; strcpy(RCX=dst, RDX=src)
my_strcpy PROC
copy_loop:
    mov al, [rdx]              ; Load byte from source
    mov [rcx], al              ; Store to dest (including NUL)
    inc rdx
    inc rcx
    test al, al                ; Was it NUL?
    jnz copy_loop
    ret
my_strcpy ENDP

main PROC
    sub rsp, 40
    lea rcx, dst
    lea rdx, src
    call my_strcpy
    xor ecx, ecx
    call ExitProcess
main ENDP

END
