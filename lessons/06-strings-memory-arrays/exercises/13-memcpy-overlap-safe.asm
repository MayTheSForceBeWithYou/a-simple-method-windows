; Exercise 13: 13-memcpy-overlap-safe (Win32 port)
; Copy 8 bytes forward non-overlap; checksum low byte sum of dst. src 1..8 sum=36.
; Build: ml64 /c /Fo13-memcpy-overlap-safe.obj 13-memcpy-overlap-safe.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-memcpy-overlap-safe.exe 13-memcpy-overlap-safe.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 13-memcpy-overlap-safe>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
