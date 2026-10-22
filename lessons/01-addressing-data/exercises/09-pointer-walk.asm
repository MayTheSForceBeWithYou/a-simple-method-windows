; Exercise: 09-pointer-walk
;
; bytes BYTE 1,2,3,4. rsi=&bytes. Sum four byte loads with inc rsi into rcx, exit (10).
;
; Contract: implement `ex_09_pointer_walk` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.DATA
walkMsg DB "ABC", 0

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_09_pointer_walk:PROC

main PROC
    sub     rsp, 40
    ; TODO: LEA RSI, walkMsg
    ; TODO: MOVZX RAX, BYTE PTR [RSI]   ; first byte
    ; TODO: INC RSI or ADD RSI, 1
    ; TODO: MOVZX RBX, BYTE PTR [RSI]   ; second byte
    ; TODO: ADD RAX, RBX and exit
    ; TODO: write ex_09_pointer_walk in this file.
    call    ex_09_pointer_walk
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
