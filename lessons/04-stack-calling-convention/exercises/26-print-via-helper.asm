; Exercise 26: print via helper (Win32 port)
; Helper write_str(RCX=buf, RDX=len). Print "abi\n"; exit 0.
; Build: ml64 /c /Fo26-print-via-helper.obj 26-print-via-helper.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:26-print-via-helper.exe 26-print-via-helper.obj kernel32.lib
; Expected: exit code 0

.DATA
str DB "abi", 13, 10
str_len EQU $ - str

.DATA?
bytes_written DQ ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

; TODO: Implement write_str(RCX=buf, RDX=len)
.ERR <TODO: Implement write_str helper>

main PROC
    sub rsp, 32
    lea rcx, str
    mov rdx, str_len
    call write_str
    xor ecx, ecx
    call ExitProcess
main ENDP
END
