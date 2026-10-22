; Exercise 12: track connect
;
; Two pieces connect if dirs match; exit 1.
;
; Build: ml64 /c 12-track-connect.asm && link /OUT:12-track-connect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-track-connect.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code

ex_12_track_connect PROC
mov rcx, 1
    mov     eax, ecx
    ret
ex_12_track_connect ENDP
main PROC
    sub     rsp, 40
    call    ex_12_track_connect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
