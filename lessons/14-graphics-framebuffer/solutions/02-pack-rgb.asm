; Exercise 02: pack rgb
;
; Pack R=1,G=2,B=3 into 0x010203 then &255 exit 3.
;
; Build: ml64 /c 02-pack-rgb.asm && link /OUT:02-pack-rgb.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-pack-rgb.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_02_pack_rgb PROC
    sub rsp, 40
    mov rax, 1
    shl rax, 16
    mov rbx, 2
    shl rbx, 8
    or rax, rbx
    or rax, 3
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_02_pack_rgb ENDP
main PROC
    sub     rsp, 40
    call    ex_02_pack_rgb
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
