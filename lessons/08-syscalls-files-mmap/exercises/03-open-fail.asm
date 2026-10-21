; 03-open-fail.asm
;
; Try to open a missing file, exit 1 on failure.
;
; Task: Call CreateFileA on "/no/such/file" with OPEN_EXISTING.
;       Check for INVALID_HANDLE_VALUE (-1), exit 1 if failed.
;
; Hint: CreateFileA returns INVALID_HANDLE_VALUE (-1) on error.
;       Compare rax with -1: cmp rax, -1; je error

.DATA
filename DB "C:\no\such\file.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 56
    .allocstack 56
    .endprolog
    
    ; TODO: CreateFileA(filename, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    
    ; TODO: Check for INVALID_HANDLE_VALUE
    
    ; Success (unlikely)
    mov     rcx, rax
    call    CloseHandle
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 56
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
