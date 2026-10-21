; Exercise 02: mutual even odd (Win32 port)
; is_even/is_odd mutual recursion. is_even(4)->1; exit 1.
; Build: ml64 /c /Fo02-mutual-even-odd.obj 02-mutual-even-odd.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-mutual-even-odd.exe 02-mutual-even-odd.obj kernel32.lib
; Expected: exit code 1

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement is_even and is_odd with mutual recursion

main PROC
    sub rsp, 32
    mov rcx, 4
    call is_even
    mov rcx, rax
    call ExitProcess
main ENDP
END
