; Exercise 18: double buffer index
;
; Flip buffer index 0<->1; start 0 flip twice exit 0.
;
; Build: ml64 /c 18-double-buffer-index.asm && link /OUT:18-double-buffer-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-double-buffer-index.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
idx QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [idx], 0
    xor QWORD PTR [idx], 1
    xor QWORD PTR [idx], 1
    mov rcx, [idx]
    call ExitProcess
main ENDP
END
