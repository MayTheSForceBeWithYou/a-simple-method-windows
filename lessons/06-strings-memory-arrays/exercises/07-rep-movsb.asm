; Exercise 07: 07-rep-movsb (Win32 port)
; Copy 5 bytes with rep movsb; checksum exit 15 for bytes 1..5.
; Build: ml64 /c /Fo07-rep-movsb.obj 07-rep-movsb.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-rep-movsb.exe 07-rep-movsb.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 07-rep-movsb>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
