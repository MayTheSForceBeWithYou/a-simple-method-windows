; Exercise 11: map array proc
; apply_inc: for {1,2,3,4}, +=1 each. Sum=2+3+4+5=14.
; Expected exit: 14

EXTERN ExitProcess:PROC

.data
arr QWORD 1,2,3,4

.code
main PROC
    sub rsp, 32
    lea rcx, arr
    mov rdx, 4
    call map_inc
    mov rcx, arr
    add rcx, arr[8]
    add rcx, arr[16]
    add rcx, arr[24]
    call ExitProcess
main ENDP

map_inc PROC
    xor r8, r8
loop_map:
    cmp r8, rdx
    jge done_map
    inc QWORD PTR [rcx+r8*8]
    inc r8
    jmp loop_map
done_map:
    ret
map_inc ENDP
END
