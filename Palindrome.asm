
; An assembly program that takes a string and check if it is a palindrome or not. If the string
; is a palindrome, then the program stores P in a variable otherwise it stores N. For Example, "You're damn mad,
; Roy" is not a palindrome. So N is stored in the variable


.model small
.stack 100h

.data
    string db "You're damn mad, Roy"
    var dw ?

.code
MAIN PROC
    mov ax, @data
    mov ds, ax


    mov si, lengthof string ; Gets the length of the string
    dec si

    mov di, 0
    L1:
        mov al, byte ptr [string+di] ; Checks from start of the string
        mov bl, byte ptr [string+si] ; Checks from the end of the string

        cmp al, bl
        jne ExitLoop ; If not Equal Exit the loop

        cmp si, di 
        je PalindromExit ; If both si and di becomes equal then exit

        inc di ; else increment di and si
        dec si
        jmp L1

    PalindromExit:
        mov var, 050h ; Store P in the variable indicating the string is palindrome

    jmp EXIT
    ExitLoop:
        mov var, 04Eh ; Store N in the variable indicating the string is not a palindrome

    EXIT:
        mov ax, 4Ch
        int 21h
MAIN ENDP
END MAIN
