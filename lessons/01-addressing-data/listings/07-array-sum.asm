; Listing 07: Complete array summing example
;
; Purpose: Iterate over array, sum all elements.
; Expected exit code: 100 (10+20+30+40)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-array-sum.obj 07-array-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-array-sum.exe 07-array-sum.obj kernel32.lib

.DATA
arr DQ 10, 20, 30, 40
arr_len EQU ($ - arr) / 8

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax               ; Sum = 0
    xor rcx, rcx               ; Index = 0
    lea rbx, arr               ; Base address
    
loop_start:
    cmp rcx, arr_len
    jge loop_done
    
    add rax, [rbx+rcx*8]       ; sum += arr[index]
    inc rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax               ; Exit with sum (100)
    call ExitProcess
main ENDP

END
