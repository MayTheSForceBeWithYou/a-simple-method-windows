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
EXTRN ex_06_lseek_concept:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_06_lseek_concept (student routine; defined in solutions/).
    call    ex_06_lseek_concept
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
