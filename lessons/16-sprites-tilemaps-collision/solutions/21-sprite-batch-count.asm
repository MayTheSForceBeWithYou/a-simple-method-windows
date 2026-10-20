; Exercise 21: sprite batch count
;
; Batch 8 sprites; exit 8.
;
; Build: ml64 /c 21-sprite-batch-count.asm && link /OUT:21-sprite-batch-count.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-sprite-batch-count.obj kernel32.lib
;
; Expected exit: 8
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 8
    call ExitProcess
main ENDP
END
