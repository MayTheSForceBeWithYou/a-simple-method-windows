; Exercise 23: stretch create pipe
;
; CreatePipe, write "ABC", read back; exit byte count (3).
;
; Expected exit: 3

EXTERN CreatePipe:PROC
EXTERN WriteFile:PROC
EXTERN ReadFile:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
payload BYTE "ABC"

.data?
hRead QWORD ?
hWrite QWORD ?
readBuf BYTE 8 DUP(?)
bytesWritten DWORD ?
bytesRead DWORD ?

.code
ex_23_stretch_createpipe PROC
    sub rsp, 80
    
    lea rcx, hRead
    lea rdx, hWrite
    xor r8, r8
    xor r9d, r9d
    call CreatePipe
    test eax, eax
    jz L_fail

    mov rcx, hWrite
    lea rdx, payload
    mov r8d, 3
    lea r9, bytesWritten
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    test eax, eax
    jz L_fail_close

    mov rcx, hRead
    lea rdx, readBuf
    mov r8d, 3
    lea r9, bytesRead
    mov QWORD PTR [rsp+32], 0
    call ReadFile
    test eax, eax
    jz L_fail_close

    mov eax, DWORD PTR bytesRead
    jmp L_cleanup

L_fail_close:
    mov rcx, hRead
    call CloseHandle
    mov rcx, hWrite
    call CloseHandle
    mov eax, 1
    jmp L_done

L_cleanup:
    mov rcx, hRead
    call CloseHandle
    mov rcx, hWrite
    call CloseHandle
    jmp L_done

L_fail:
    mov eax, 1

L_done:
    add rsp, 80
    ret
ex_23_stretch_createpipe ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_createpipe
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
