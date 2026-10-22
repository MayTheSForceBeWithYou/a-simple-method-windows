; Exercise: 08-from-scratch-strchr
;
; Exercise 08: from scratch strchr
; strchr 'c' in 'abcd' -> index 2.
;
; Contract: implement `ex_08_from_scratch_strchr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 08: 08-from-scratch-strchr (Win32 port)
; FROM SCRATCH: strchr for 'c' in 'abcd'; return index 2.
; Build: ml64 /c /Fo08-from-scratch-strchr.obj 08-from-scratch-strchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-from-scratch-strchr.exe 08-from-scratch-strchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_strchr:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_08_from_scratch_strchr in this file.
    call    ex_08_from_scratch_strchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
