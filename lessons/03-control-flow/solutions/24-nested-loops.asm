; Exercise 24: nested loops
;
; Count pairs (i,j) with 0<=i<3, 0<=j<4 (12). Exit 12.
;
; Build: ml64 /c 24-nested-loops.asm && link /OUT:24-nested-loops.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-nested-loops.obj kernel32.lib
;
; Expected exit: 12

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    xor r8, r8
outer:
    cmp r8, 3
    jge done
    xor r9, r9
inner:
    cmp r9, 4
    jge next
    inc rcx
    inc r9
    jmp inner
next:
    inc r8
    jmp outer
done:
    call ExitProcess
main ENDP
END
