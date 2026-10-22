; Exercise 20: 20-count-char (Win32 port)
; Count 's' in 'mississippi' -> 4.
; Build: ml64 /c /Fo20-count-char.obj 20-count-char.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-count-char.exe 20-count-char.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_count_char:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_20_count_char (student routine; defined in solutions/).
    call    ex_20_count_char
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
