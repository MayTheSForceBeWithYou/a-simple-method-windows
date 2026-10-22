; Listing 15: PUBLIC message in data module (LESSON.md block 15)
;
; Assembles standalone; message is exported for multifile demos.
; Expected exit: 0

.DATA
PUBLIC message
message BYTE "Hello from data.asm", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
