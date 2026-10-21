; 07-write-iov-lite.asm
;
; Write two separate buffers to stdout using two WriteFile calls.
;
; Task: WriteFile "Part1\n", then WriteFile "Part2\n", exit 0.
;
; Hint: Two separate WriteFile calls to stdout.

.DATA
buf1 DB "Part1", 13, 10
buf1_len EQU $ - buf1
buf2 DB "Part2", 13, 10
buf2_len EQU $ - buf2
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: Get stdout, save in rbx
    
    ; TODO: WriteFile buf1
    
    ; TODO: WriteFile buf2
    
    xor     ecx, ecx
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
