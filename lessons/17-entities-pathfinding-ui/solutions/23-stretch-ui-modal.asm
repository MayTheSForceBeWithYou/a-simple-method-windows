; Exercise 23: stretch ui modal
;
; STRETCH: modal stack depth 1; exit 1.
;
; Build: ml64 /c 23-stretch-ui-modal.asm && link /OUT:23-stretch-ui-modal.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-ui-modal.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    inc qword [modal_depth]
    mov rcx, [modal_depth]
    call ExitProcess

main ENDP
END
