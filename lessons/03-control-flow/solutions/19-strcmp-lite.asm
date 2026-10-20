; Exercise 19: strcmp lite
;
; Compare 'ab' and 'ab' bytewise; exit 0 if equal else 1. Should exit 0.
;
; Build: ml64 /c 19-strcmp-lite.asm && link /OUT:19-strcmp-lite.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-strcmp-lite.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.data
a BYTE "ab", 0
b BYTE "ab", 0

.code
main PROC
    sub rsp, 32
    lea rsi, [a]
    lea rdi, [b]
loop_start:
    mov al, BYTE PTR [rsi]
    mov dl, BYTE PTR [rdi]
    cmp al, dl
    jne not_equal
    cmp al, 0
    je equal
    inc rsi
    inc rdi
    jmp loop_start
equal:
    xor rcx, rcx
    jmp done
not_equal:
    mov rcx, 1
done:
    call ExitProcess
main ENDP
END
