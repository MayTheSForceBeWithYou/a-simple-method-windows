; 09-write-len-check.asm
;
; Write a message to stdout, verify bytes written matches expected.
;
; Task: WriteFile "Test\n" (5 bytes), check bytesWritten == 5, exit 0.
;       If mismatch, exit 1.
;
; Hint: Compare bytesWritten with expected length.

.DATA
message DB "Test", 13, 10
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: Get stdout, WriteFile message
    
    ; TODO: Check if bytesWritten == message_len
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 40
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
