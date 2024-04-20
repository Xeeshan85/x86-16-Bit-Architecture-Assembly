.model small
.stack 100h

.data
    string db "You're damn mad, Roy"
    var dw ?

.code
MAIN PROC
    mov ax, @data
    mov ds, ax


    mov si, lengthof string
    dec si

    mov di, 0
    L1:
        mov al, byte ptr [string+di]
        mov bl, byte ptr [string+si]

        cmp al, bl
        jne ExitLoop

        cmp si, di
        je PalindromExit

        inc di
        dec si
        jmp L1

    PalindromExit:
        mov var, 050h

    jmp EXIT
    ExitLoop:
        mov var, 04Eh

    EXIT:
        mov ax, 4Ch
        int 21h
MAIN ENDP
END MAIN
