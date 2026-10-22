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
mov QWORD PTR [frames], 60
    mov rcx, [frames]
    mov     eax, [frames]
    ret
ex_14_frame_stats ENDP
main PROC
    sub     rsp, 40
    call    ex_14_frame_stats
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
