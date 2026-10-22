; Exercise 02: place track
;
; Track piece type 3; exit 3.
;
; Build: ml64 /c 02-place-track.asm && link /OUT:02-place-track.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-place-track.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_02_place_track PROC
    sub rsp, 40
        mov     eax, 3
    ret

ex_02_place_track ENDP
main PROC
    call    ex_02_place_track
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
