; 14-brk-stub.asm
;
; Windows doesn't have brk. Demonstrate VirtualAlloc instead, exit 0.
;
; Task: VirtualAlloc one page, check for nonzero, exit 0 if successful.
;
; Hint: This exercise adapts the Linux brk concept to Windows VirtualAlloc.

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog
    
    ; TODO: VirtualAlloc
    
    ; TODO: Check nonzero, free, exit 0
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
