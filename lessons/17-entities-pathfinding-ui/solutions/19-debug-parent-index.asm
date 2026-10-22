; Exercise 19: debug parent index
;
; BUG: parent[i] wrong. Fix reconstruct step count exit 2.
;
; Build: ml64 /c 19-debug-parent-index.asm && link /OUT:19-debug-parent-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-parent-index.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code

ex_19_debug_parent_index PROC
sub rsp, 40
    mov     eax, 2
    ret
ex_19_debug_parent_index ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_parent_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
