; Exercise: 18-struct-offsets
;
; Simulate struct {QWORD a; QWORD b; BYTE c;}: set a=1,b=2,c=3. Exit a+b+c=6 using explicit offsets 0,8,16.
;
; Contract: implement `ex_18_struct_offsets` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_struct_offsets:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_struct_offsets in this file.
    call    ex_18_struct_offsets
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
