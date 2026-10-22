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
EXTRN ex_03_open_fail:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_03_open_fail (student routine; defined in solutions/).
    call    ex_03_open_fail
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
