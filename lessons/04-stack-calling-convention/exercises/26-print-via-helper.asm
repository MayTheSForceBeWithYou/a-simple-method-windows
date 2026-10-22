; Exercise 26: print via helper (Win32 port)
; Helper write_str(RCX=buf, RDX=len). Print "abi\n"; exit 0.
; Build: ml64 /c /Fo26-print-via-helper.obj 26-print-via-helper.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:26-print-via-helper.exe 26-print-via-helper.obj kernel32.lib
; Expected: exit code 0

.DATA
walkMsg DB "abi", 13, 10
walkMsg_len EQU $ - walkMsg

.DATA?
bytes_written DQ ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

; TODO: Implement write_str(RCX=buf, RDX=len)

main PROC
    sub     rsp, 32
    lea rcx, walkMsg
    mov rdx, walkMsg_len
    call write_str
    xor ecx, ecx
    call ExitProcess
main ENDP
END
