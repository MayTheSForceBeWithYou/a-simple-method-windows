; Exercise: 10-word-dword
;
; WORD 01122h, DWORD 033445566h. Load low byte of the word into cl via BYTE PTR [label], exit.
;
; Contract: implement `ex_10_word_dword` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 34
;
.DATA?
buffer DQ ?

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_word_dword:PROC

main PROC
    sub     rsp, 40
    ; TODO: Store WORD PTR 256 to buffer
    ; TODO: Zero RAX, then load lower byte with MOVZX RCX, BYTE PTR [buffer]
    ; TODO: Exit with RCX
    ; Note: 256 = 00100h, low byte is 0
    ; TODO: write ex_10_word_dword in this file.
    call    ex_10_word_dword
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
