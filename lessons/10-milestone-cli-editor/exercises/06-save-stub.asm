; Exercise: 06-save-stub
;
; Pretend save ok; exit 0.
;
; Contract: implement `ex_06_save_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
fname DB "test.txt", 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_06_save_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_save_stub in this file.
    call    ex_06_save_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
