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

get_one PROC
    mov rax, 1
    ret
get_one ENDP

main PROC
    sub rsp, 32
    
    ; TODO: Save RDX before call, reload after, add to RAX
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP
END
