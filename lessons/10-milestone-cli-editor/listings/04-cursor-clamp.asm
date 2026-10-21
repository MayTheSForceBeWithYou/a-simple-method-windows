; 04-cursor-clamp.asm
;
; Purpose: Demonstrate cursor clamping to valid range [0, buf_len]
; Expected exit code: 3
; Expected stdout: (none)
;
; Clamps out-of-range cursor to [0, buf_len]

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    ; Setup: buffer with buf_len 3
    mov     buf_len, 3
    
    ; Simulate corrupted cursor (cursor = 9, out of range)
    mov     cursor, 9
    
    ; Clamp cursor to [0, buf_len]
    mov     rax, cursor
    cmp     rax, buf_len
    jbe     cursor_ok
    mov     rax, buf_len
    mov     cursor, rax
    
cursor_ok:
    ; Cursor now clamped to 3
    ; Exit with clamped cursor value
    mov     ecx, DWORD PTR cursor
    call    ExitProcess
main ENDP

END
