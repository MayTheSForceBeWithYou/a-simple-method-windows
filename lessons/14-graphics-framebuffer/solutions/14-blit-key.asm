; Exercise 14: blit key
;
; Blit with color key 0 skip; src 0,5,0,5 -> dst sum 10.
;
; Build: ml64 /c 14-blit-key.asm && link /OUT:14-blit-key.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-blit-key.obj kernel32.lib
;
; Expected exit: 10
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
src BYTE 0,5,0,5

.data?
dst BYTE 4 DUP(?)

.code

ex_14_blit_key PROC
xor rcx, rcx
loop_start:
    cmp rcx, 4
    jge loop_end
    lea r11, [src]
    mov al, BYTE PTR [r11+rcx]
    test al, al
    jz skip_pixel
    lea r11, [dst]
    mov BYTE PTR [r11+rcx], al
skip_pixel:
    inc rcx
    jmp loop_start
loop_end:
    xor rcx, rcx
    lea r11, [dst]
    movzx rax, BYTE PTR [r11]
    add rcx, rax
    lea r11, [dst]
    movzx rax, BYTE PTR [r11+1]
    add rcx, rax
    lea r11, [dst]
    movzx rax, BYTE PTR [r11+2]
    add rcx, rax
    lea r11, [dst]
    movzx rax, BYTE PTR [r11+3]
    add rcx, rax
    mov     eax, 10
    ret
ex_14_blit_key ENDP
main PROC
    sub     rsp, 40
    call    ex_14_blit_key
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
