; Exercise: 02-rodata-string
;
; Exercise 02: rodata string
; Put "rodata\n" in .const (read-only data), write it, exit 0.
;
; Contract: implement `ex_02_rodata_string` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 02: rodata string (Win32 port)
;
; Put "rodata\r\n" in .CONST (read-only), write it, exit 0.
;
; Build: ml64 /c /Fo02-rodata-string.obj 02-rodata-string.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-rodata-string.exe 02-rodata-string.obj kernel32.lib
; Run: 02-rodata-string.exe
;
; Expected output: rodata\n
; Expected exit: 0
; Expected stdout: (none)
; TODO: Declare .CONST section with msg and msg_len

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_02_rodata_string:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_rodata_string in this file.
    call    ex_02_rodata_string
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
