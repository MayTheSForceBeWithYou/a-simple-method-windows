; Exercise: 13-hashmap-put-get
;
; Exercise 13: hashmap put get
; Simple open array slots[4]; put key hash 2 -> 42; get exit 42.
;
; Contract: implement `ex_13_hashmap_put_get` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; 13-hashmap-put-get
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_hashmap_put_get:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_hashmap_put_get in this file.
    call    ex_13_hashmap_put_get
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
