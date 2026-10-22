; 06-set-file-pointer.asm
;
; Arithmetic offset calculation (not actual SetFilePointer call).
;
; Task: Start with offset 5, add 5, exit with 10.
;       Demonstrates offset arithmetic without Win32 API.
;
; Hint: This is a trivial arithmetic drill, not a real file operation.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_set_file_pointer:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_set_file_pointer in this file.
    call    ex_06_set_file_pointer
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
