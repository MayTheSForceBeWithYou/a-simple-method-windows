; Exercise 27: stretch dot product
;
; STRETCH: u QWORD 2,3,4  v QWORD 5,6,7. rcx=2*5+3*6+4*7 (56). imul allowed.
;
; Build: ml64 /c 27-stretch-dot-product.asm && link /OUT:27-stretch-dot-product.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-stretch-dot-product.obj kernel32.lib
;
; Expected exit: 56

EXTERN ExitProcess:PROC

.data
u QWORD 2, 3, 4
v QWORD 5, 6, 7

.code
main PROC
    sub rsp, 40
    mov rax, [u]
    imul rax, [v]
    mov rcx, rax
    mov rax, [u+8]
    imul rax, [v+8]
    add rcx, rax
    mov rax, [u+16]
    imul rax, [v+16]
    add rcx, rax
    call ExitProcess
main ENDP
END
