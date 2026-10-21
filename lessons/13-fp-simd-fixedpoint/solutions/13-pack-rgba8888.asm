; Exercise 13: pack rgba8888
;
; R=255 G=0 B=0 A=255; low byte R=255 exit 255.
; Expected exit: 255

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, 255
    mov ecx, eax
    call ExitProcess
main ENDP
END
