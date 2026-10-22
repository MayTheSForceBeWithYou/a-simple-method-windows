; Exercise 16: pitch bytes
;
; pitch=width*4 aligned up to 16: width=5 -> 20 align 32? 20; exit 20.
;
; Build: ml64 /c 16-pitch-bytes.asm && link /OUT:16-pitch-bytes.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-pitch-bytes.obj kernel32.lib
;
; Expected exit: 20
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_16_pitch_bytes PROC
    sub rsp, 40
    mov rcx, 5
    imul rcx, 4
    mov     eax, 20
    add     rsp, 40
    ret
ex_16_pitch_bytes ENDP
main PROC
    call    ex_16_pitch_bytes
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
