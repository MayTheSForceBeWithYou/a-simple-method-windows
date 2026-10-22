; Exercise 15: 15-aos-scale (Win32 port)
; AoS {x,y} *2 for one entity {3,4}->6,8; exit x+y=14.
; Build: ml64 /c /Fo15-aos-scale.obj 15-aos-scale.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-aos-scale.exe 15-aos-scale.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_aos_scale:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: write ex_15_aos_scale in this file.
    call    ex_15_aos_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
