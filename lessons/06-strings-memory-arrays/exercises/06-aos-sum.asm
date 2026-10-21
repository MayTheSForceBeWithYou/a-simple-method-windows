; Exercise 06: 06-aos-sum (Win32 port)
; AoS records {dq x,y} two ents. Sum all coords exit.
; Build: ml64 /c /Fo06-aos-sum.obj 06-aos-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-aos-sum.exe 06-aos-sum.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub rsp, 32
    ; TODO: Implement

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
