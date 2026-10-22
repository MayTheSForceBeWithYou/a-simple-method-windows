; Exercise 24: from scratch fb size
;
; FROM SCRATCH: w=320 h=200 bpp=4 bytes; size &0xff of low... 320*200*4=256000; exit (size>>12)&255 or simply exit 0 after computing into rax and using 256000/10000=25.6 - exit 25 via /10240. Simpler: exit (w*h*bpp)>>16 = 3.
;
; Build: ml64 /c 24-from-scratch-fb-size.asm && link /OUT:24-from-scratch-fb-size.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-fb-size.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_24_from_scratch_fb_size PROC
mov rax, 320
    imul rax, 200
    imul rax, 4
    shr rax, 16
    mov rcx, rax
    ret
ex_24_from_scratch_fb_size ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_fb_size
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
