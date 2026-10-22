; Exercise: 08-caller-saved-reload
;
; Exercise 08: caller saved reload
; Put 5 in r10; call function that returns 1; add r10 — must save r10 (volatile). Exit 6.
;
; Contract: implement `ex_08_caller_saved_reload` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;

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
    ; TODO: write ex_08_caller_saved_reload in this file.
    call    ex_08_caller_saved_reload
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
