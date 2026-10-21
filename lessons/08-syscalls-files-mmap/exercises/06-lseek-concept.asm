; 06-lseek-concept.asm
;
; Arithmetic offset calculation (not actual SetFilePointer call).
;
; Task: Start with offset 5, add 5, exit with 10.
;       Demonstrates offset arithmetic without Win32 API.
;
; Hint: This is a trivial arithmetic drill, not a real file operation.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 5          ; Starting offset
    
    ; TODO: Add 5 to offset
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 10

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
