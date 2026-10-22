; Exercise: 03-memcmp
;
; Exercise 03: memcmp
; memcmp 3 bytes; equal -> 0.
;
; Contract: implement `ex_03_memcmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 03: 03-memcmp (Win32 port)
; memcmp 3 bytes; equal -> 0 exit.
; Build: ml64 /c /Fo03-memcmp.obj 03-memcmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-memcmp.exe 03-memcmp.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_memcmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_03_memcmp in this file.
    call    ex_03_memcmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
