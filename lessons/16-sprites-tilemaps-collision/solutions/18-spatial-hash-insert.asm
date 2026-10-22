; Exercise 18: spatial hash insert
;
; Insert entity into cell bucket count++; exit 1.
;
; Build: ml64 /c 18-spatial-hash-insert.asm && link /OUT:18-spatial-hash-insert.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-spatial-hash-insert.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
count QWORD ?

.code

ex_18_spatial_hash_insert PROC
inc QWORD PTR [count]
    mov rcx, [count]
    mov     eax, [count]
    ret
ex_18_spatial_hash_insert ENDP
main PROC
    sub     rsp, 40
    call    ex_18_spatial_hash_insert
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
