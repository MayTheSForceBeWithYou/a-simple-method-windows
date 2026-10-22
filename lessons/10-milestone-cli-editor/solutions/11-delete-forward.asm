; Exercise 11: delete forward
;
; "ABCD" cur=1 delete -> "ACD"; len=3 exit 3.
;
; Build: ml64 /c 11-delete-forward.asm && link /OUT:11-delete-forward.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-delete-forward.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
buf BYTE "ABCD", 0

.data?
len QWORD ?
cur QWORD ?

.code
ex_11_delete_forward PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 4
    mov QWORD PTR [cur], 1
    
    mov rcx, [cur]
    lea rdx, buf
    
L_l:
    mov rax, rcx
    inc rax
    cmp rax, [len]
    jge L_fin
    
    movzx r8, BYTE PTR [rdx+rcx+1]
    mov BYTE PTR [rdx+rcx], r8b
    
    inc rcx
    jmp L_l
    
L_fin:
    dec QWORD PTR [len]
        mov     eax, [len]
    ret

ex_11_delete_forward ENDP
main PROC
    call    ex_11_delete_forward
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
