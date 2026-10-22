; Exercise 14: frame stats
;
; fps counter frames=60 over 1s; exit 60.
;
; Build: ml64 /c 14-frame-stats.asm && link /OUT:14-frame-stats.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-frame-stats.obj kernel32.lib
;
; Expected exit: 60
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
frames QWORD ?

.code
ex_14_frame_stats PROC
    sub rsp, 40
    mov QWORD PTR [frames], 60
        mov     eax, [frames]
    ret
    add     rsp, 40
ex_14_frame_stats ENDP
main PROC
    call    ex_14_frame_stats
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
