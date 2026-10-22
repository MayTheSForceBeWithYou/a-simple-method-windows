; Exercise 16: clock gettime stub
;
; QueryPerformanceCounter into counter; exit 0 if successful.
;
; Build: ml64 /c 16-qpc.asm && link /OUT:16-qpc.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-qpc.obj kernel32.lib
;
; Expected exit: 0

EXTERN QueryPerformanceCounter:PROC
EXTERN ExitProcess:PROC

.data?
counter QWORD ?

.code
ex_16_qpc PROC
    sub rsp, 40
    
    ; QueryPerformanceCounter(&counter)
    lea rcx, counter
    call QueryPerformanceCounter
    
    ; Returns nonzero on success, 0 on failure
    test eax, eax
    jz L_fail
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_fail:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_qpc ENDP
main PROC
    sub     rsp, 40
    call    ex_16_qpc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
