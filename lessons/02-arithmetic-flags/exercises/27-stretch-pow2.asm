; Exercise 27: stretch pow2
;
; STRETCH: compute 2^8 with successive imuls. Exit (256 - 256)=0.
;
; Build: ml64 /c 27-stretch-pow2.asm && link /OUT:27-stretch-pow2.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-stretch-pow2.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_27_stretch_pow2:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_stretch_pow2 in this file.
    call    ex_27_stretch_pow2
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
