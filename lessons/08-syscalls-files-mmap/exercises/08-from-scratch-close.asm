; 08-from-scratch-close.asm (from scratch)
;
; Open NUL device, close it, exit 0.
;
; Task: CreateFileA("NUL", GENERIC_READ, ..., OPEN_EXISTING, ...),
;       CloseHandle, exit 0.
;
; Hint: "NUL" is Windows null device (like /dev/null or /dev/zero).

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 48
    .allocstack 48
    .endprolog
    
    ; TODO: CreateFileA("NUL", GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    
    ; TODO: Check for error
    
    ; TODO: CloseHandle(handle)
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 48
    pop     rbx
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
