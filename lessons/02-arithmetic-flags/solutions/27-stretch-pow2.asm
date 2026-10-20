; Exercise 27: stretch pow2
;
; STRETCH: compute 2^8 with successive imuls. Exit (256 - 256)=0.
;
; Build: ml64 /c 27-stretch-pow2.asm && link /OUT:27-stretch-pow2.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-stretch-pow2.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 1
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    sub rax, 256
    mov rcx, rax
    call ExitProcess
main ENDP
END
