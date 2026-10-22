; Exercise 18: 18-debug-off-by-one-copy (Win32 port)
; BUG: copies n bytes but forgets NUL. Fix strcpy of "ok"; strlen=2.
; Build: ml64 /c /Fo18-debug-off-by-one-copy.obj 18-debug-off-by-one-copy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-debug-off-by-one-copy.exe 18-debug-off-by-one-copy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_debug_off_by_one_copy:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_18_debug_off_by_one_copy (student routine; defined in solutions/).
    call    ex_18_debug_off_by_one_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
