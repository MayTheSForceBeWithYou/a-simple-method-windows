; Listing 18: OFFSET / label span (LESSON.md block 18)
;
; Purpose: RIP-relative LEA vs OFFSET immediate; assemble-time span MSG_LEN.
; Expected exit: 2
; Expected stdout: (none)
;
; MSG_LEN = msg_end - msg (same .DATA section). Runtime span must match.
; Failure codes: 117 = span mismatch, 118 = LEA vs OFFSET address mismatch.

.DATA
msg BYTE "Z", 0
msg_end LABEL BYTE

MSG_LEN EQU msg_end - msg
FAIL_SPAN_CODE EQU 117
FAIL_ADDR_CODE EQU 118

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog

    ; Two legal ways to take the address of msg in MASM x64:
    lea     rcx, msg                 ; RIP-relative
    mov     rdx, OFFSET msg          ; 64-bit immediate (ADDR64)

    lea     rax, msg
    lea     rbx, msg_end
    sub     rbx, rax
    cmp     ebx, MSG_LEN
    jne     fail_span_exit

    cmp     rcx, rdx
    jne     fail_addr_exit

    mov     ecx, MSG_LEN
    call    ExitProcess

fail_span_exit:
    mov     ecx, FAIL_SPAN_CODE
    call    ExitProcess

fail_addr_exit:
    mov     ecx, FAIL_ADDR_CODE
    call    ExitProcess
main ENDP

END
