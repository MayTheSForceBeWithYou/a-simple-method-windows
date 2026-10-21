; Listing 21: EQU constants choose process status (01-* topic)
; Expected exit: 0
; Expected stdout: (none)

STATUS_OK EQU 0
STATUS_ERR EQU 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, STATUS_OK
    cmp     eax, STATUS_ERR
    je      use_err
    mov     ecx, STATUS_OK
    jmp     done
use_err:
    mov     ecx, STATUS_ERR
done:
    call    ExitProcess
main ENDP
END
