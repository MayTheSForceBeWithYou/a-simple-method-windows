; Exercise: 20-load-validate-magic
;
; Exercise 20: load validate magic
; Magic "ED01"; check first two ED; exit 1 if ok.
;
; Contract: implement `ex_20_load_validate_magic` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 20-load-validate-magic.asm: Load file, check magic, exit 0 if valid else 1
.DATA
fname DB "save.dat", 0
MAGIC EQU 12345678h
.DATA?
fileMagic DWORD ?
fileLen QWORD ?
buf DB 256 DUP(?)
bytesRead DWORD ?
.CODE
EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_20_load_validate_magic:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_load_validate_magic in this file.
    call    ex_20_load_validate_magic
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
