; Exercise: 21-rec-binary-digits
;
; Exercise 21: rec binary digits
; popcount(0b1101)=3 via recursion. Exit 3.
;
; Contract: implement `ex_21_rec_binary_digits` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; Exercise 21: 21-rec-binary-digits.asm (Win32 port)
; Count bits set via recursion clearing lowbit. popcount(0b1101)=3; exit 3.
; Build: ml64 /c /Fo21-rec-binary-digits.asm.obj 21-rec-binary-digits.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-rec-binary-digits.asm.exe 21-rec-binary-digits.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_rec_binary_digits:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_21_rec_binary_digits in this file.
    call    ex_21_rec_binary_digits
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
