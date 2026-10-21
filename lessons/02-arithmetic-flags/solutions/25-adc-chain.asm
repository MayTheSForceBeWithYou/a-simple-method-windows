; Exercise 25: adc chain
;
; Add two 128-bit values lo/hi: a=(1,0) b=(0xFFFFFFFFFFFFFFFF,0). Use add/adc. Exit with CF after adc (1) via setc.
;
; Build: ml64 /c 25-adc-chain.asm && link /OUT:25-adc-chain.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-adc-chain.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    mov rdx, 0
    mov rbx, 0FFFFFFFFFFFFFFFFh
    mov r8, 0
    add rax, rbx
    adc rdx, r8
    ; High word is 1 after the incoming carry from add.
    mov rcx, rdx
    call ExitProcess
main ENDP
END
