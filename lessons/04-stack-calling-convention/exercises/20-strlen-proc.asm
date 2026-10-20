; Exercise 20: strlen proc (Win32 port)
; strlen(RCX)->RAX. 'assembly' len 8; exit 8.
; Build: ml64 /c /Fo20-strlen-proc.obj 20-strlen-proc.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-strlen-proc.exe 20-strlen-proc.obj kernel32.lib
; Expected: exit code 8

.DATA
str DB "assembly", 0

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement strlen(RCX) -> RAX
.ERR <TODO: Implement strlen procedure>

main PROC
    sub rsp, 32
    lea rcx, str
    call strlen
    mov rcx, rax
    call ExitProcess
main ENDP
END
