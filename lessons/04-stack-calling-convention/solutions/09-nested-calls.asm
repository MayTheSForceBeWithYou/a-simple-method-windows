; Exercise 09: nested calls
;
; double(x)=x*2; add(a,b)=a+b. Compute add(double(10),double(11))=42. MS x64 ABI.
;
; Build: ml64 /c 09-nested-calls.asm && link /OUT:09-nested-calls.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-nested-calls.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_09_nested_calls PROC
    sub rsp, 40
    mov rcx, 10
    call double_it
    push rax
    mov rcx, 11
    call double_it
    mov rdx, rax
    pop rcx
    call add2
        mov     eax, rax
    ret

ex_09_nested_calls ENDP
main PROC
    call    ex_09_nested_calls
    mov     rcx, rax
    call    ExitProcess
main ENDP

double_it PROC
    mov rax, rcx
    add rax, rax
    ret
double_it ENDP

add2 PROC
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP
END
