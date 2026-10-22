; Exercise: 20-count-char
;
; Exercise 20: count char
; Count 's' in 'mississippi' -> 4.
; Expected stdout: (none)
;
; Contract: implement `ex_20_count_char` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; Exercise 20: 20-count-char (Win32 port)
; Count 's' in 'mississippi' -> 4.
; Build: ml64 /c /Fo20-count-char.obj 20-count-char.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-count-char.exe 20-count-char.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_count_char:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_20_count_char in this file.
    call    ex_20_count_char
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
