; Exercise: 18-error-eacces-sim
;
; Exercise 18: error eacces sim
; Try to open "C:\" with write access; if fail exit 1 else close exit 0. Expect 1 often.
;
; Contract: implement `ex_18_error_eacces_sim` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 18-error-eacces-sim.asm
;
; Try to open a directory for writing (should fail with ACCESS_DENIED).
;
; Task: CreateFileA("C:\", GENERIC_WRITE, ..., OPEN_EXISTING, ...),
;       expect failure, GetLastError, exit 1.
;
; Hint: Opening a directory for writing typically fails with ERROR_ACCESS_DENIED (5).

.DATA
path DB "C:\", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC
EXTRN ex_18_error_eacces_sim:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_error_eacces_sim in this file.
    call    ex_18_error_eacces_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
