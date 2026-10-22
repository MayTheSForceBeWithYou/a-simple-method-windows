; Exercise 09: map place path
;
; Place PATH=1 at (2,3) on w=8; index=3*8+2=26; store; exit cell.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

PATH EQU 1

.data?
map BYTE 256 DUP(0)

.code
ex_09_map_place_path PROC
    sub rsp, 40
    mov rax, 3
    imul rax, 8
    add rax, 2
    lea r11, [map]
    mov BYTE PTR [r11+rax], PATH
    lea r11, [map]
    movzx rcx, BYTE PTR [r11+rax]
    mov     eax, 1
    ret
    add     rsp, 40
ex_09_map_place_path ENDP
main PROC
    call    ex_09_map_place_path
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
