; Exercise 16: clock gettime stub
;
; QueryPerformanceCounter into counter; exit 0 if successful.
;
; Build: ml64 /c 16-clock-gettime-stub.asm && link /OUT:16-clock-gettime-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-clock-gettime-stub.obj kernel32.lib
;
; Expected exit: 0

EXTERN QueryPerformanceCounter:PROC
EXTERN ExitProcess:PROC

.data?
counter QWORD ?

.code
main PROC
    sub rsp, 32
    
    ; QueryPerformanceCounter(&counter)
    lea rcx, counter
    call QueryPerformanceCounter
    
    ; Returns nonzero on success, 0 on failure
    test rax, rax
    jz L_fail
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_fail:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    call ExitProcess
main ENDP
END
