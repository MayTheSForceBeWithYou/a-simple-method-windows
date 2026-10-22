; Exercise 08: caller saved reload (Win32 port)
;
; Put 5 in RDX; call function that returns 1; then add RDX - must reload because caller-saved. Exit 6.
; RDX is volatile in MS x64.
;
; Build: ml64 /c /Fo08-caller-saved-reload.obj 08-caller-saved-reload.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-caller-saved-reload.exe 08-caller-saved-reload.obj kernel32.lib
; Expected exit: 6
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_caller_saved_reload:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_08_caller_saved_reload (student routine; defined in solutions/).
    call    ex_08_caller_saved_reload
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
