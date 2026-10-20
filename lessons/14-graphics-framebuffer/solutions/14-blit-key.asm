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
main PROC
    sub rsp, 32
    xor rcx, rcx
loop_start:
    cmp rcx, 4
    jge loop_end
    mov al, BYTE PTR [src+rcx]
    test al, al
    jz skip_pixel
    mov BYTE PTR [dst+rcx], al
skip_pixel:
    inc rcx
    jmp loop_start
loop_end:
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
