; Exercise 17: void side effect (Win32 port)
; Procedure writes '!\n' to buffer via WriteFile. Exit 0.
; Build: ml64 /c /Fo17-void-side-effect.obj 17-void-side-effect.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-void-side-effect.exe 17-void-side-effect.obj kernel32.lib
; Expected: exit code 0

.DATA
buf DB "!", 13, 10
buf_len EQU $ - buf

.DATA?
bytes_written DQ ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

; TODO: Implement void write_buf() that calls WriteFile
.ERR <TODO: Implement write_buf procedure>

main PROC
    sub rsp, 32
    call write_buf
    xor ecx, ecx
    call ExitProcess
main ENDP
END
