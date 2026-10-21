; Exercise 22: stretch memcpy4
;
; STRETCH: src BYTE 1,2,3,4. dst BYTE 4 DUP(?). Copy 4 bytes via register loads/stores. Sum dst into rcx (10).
;
; Build: ml64 /c 22-stretch-memcpy4.asm && link /OUT:22-stretch-memcpy4.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-memcpy4.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
src BYTE 1, 2, 3, 4

.data?
dst BYTE 4 DUP(?)

.code
main PROC
    sub rsp, 40
    mov al, BYTE PTR [src]
    mov BYTE PTR [dst], al
    mov al, BYTE PTR [src+1]
    mov BYTE PTR [dst+1], al
    mov al, BYTE PTR [src+2]
    mov BYTE PTR [dst+2], al
    mov al, BYTE PTR [src+3]
    mov BYTE PTR [dst+3], al
    xor rcx, rcx
    movzx rax, BYTE PTR [dst]
    add rcx, rax
    movzx rax, BYTE PTR [dst+1]
    add rcx, rax
    movzx rax, BYTE PTR [dst+2]
    add rcx, rax
    movzx rax, BYTE PTR [dst+3]
    add rcx, rax
    call ExitProcess
main ENDP
END
