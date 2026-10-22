; Exercise 18: debug off by one copy
; BUG: copies n bytes but forgets NUL. Fix strcpy of "ok"; strlen=2.
; Build: ml64 /c /Fo18-debug-off-by-one-copy.obj 18-debug-off-by-one-copy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-debug-off-by-one-copy.exe 18-debug-off-by-one-copy.obj kernel32.lib
; Expected exit: 2

.DATA
src BYTE "ok", 0

.DATA?
dst BYTE 8 DUP(?)

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_debug_off_by_one_copy:PROC

strcpy_n PROC
    ; BUG: copies exactly two bytes, no terminating NUL
    mov al, BYTE PTR [rdx]
    mov BYTE PTR [rcx], al
    mov al, BYTE PTR [rdx+1]
    mov BYTE PTR [rcx+1], al
    ret
strcpy_n ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_debug_off_by_one_copy in this file (NUL-terminated strcpy).
    call    ex_18_debug_off_by_one_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
