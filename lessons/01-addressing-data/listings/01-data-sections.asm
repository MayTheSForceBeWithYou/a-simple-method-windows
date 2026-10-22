; Listing 01: Data section declarations
;
; Purpose: Demonstrates different data sections and their uses.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo01-data-sections.obj 01-data-sections.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-data-sections.exe 01-data-sections.obj kernel32.lib

.CONST
readonly_msg DB "This is read-only", 0

.DATA
counter DQ 42                  ; Initialized, writable 64-bit value
status DD 0                    ; Initialized 32-bit value

.DATA?
buffer DB 256 DUP(?)           ; Uninitialized 256-byte buffer

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Load counter value and exit with it
    mov rax, counter           ; Load from .DATA
    mov rcx, rax
    call ExitProcess
main ENDP

END
