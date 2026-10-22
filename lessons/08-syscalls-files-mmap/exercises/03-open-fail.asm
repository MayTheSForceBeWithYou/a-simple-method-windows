; Exercise: 03-open-fail
;
; open nonexistent path; if CreateFileA returns INVALID_HANDLE_VALUE exit 1 else 0. Expect 1.
;
; Contract: implement `ex_03_open_fail` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA
filename DB "C:\no\such\file.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_03_open_fail:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_open_fail in this file.
    call    ex_03_open_fail
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
