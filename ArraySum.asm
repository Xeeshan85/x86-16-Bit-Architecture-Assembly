.model small
.stack 100h

.data
    n equ 2 ; Size of Array
    array1 dw n dup(?)
    array2 dw n dup(?)
    ResultArray dw n dup(?)
    digitCount db 0 
    enteredNumber dw 0
    temp1 dw 0
    index dw 0

    inputStr1 db "Enter Array : $"
    inputStr2 db "Enter Array : $"
    ResultStr db "Resultant Array: $"

.code
MAIN PROC
    mov ax, @data
    mov ds, ax

    lea si, ResultArray
    lea si, array1
    mov di, 0
    ArrInput1:
        cmp di, n
        jae ExitLoop1
        call INPUTELEMENT
        mov ax, enteredNumber
        mov [si], ax
        inc si
        inc di
        jmp ArrInput1

    call NEWLINE
    ExitLoop1:
    lea si, array2
    mov di, 0
    ArrInput2:
        cmp di, n
        jae ExitLoop2
        call INPUTELEMENT
        mov ax, enteredNumber
        mov [si], ax
        inc si
        inc di
        jmp ArrInput2

    ExitLoop2:

    mov si, n
    dec si
    mov di, 0
    lea bx, ResultArray
    AddLoop:
        cmp di, n
        jae Exit
        mov ax, word ptr [array1 + si]
        mov dx, word ptr [array2 + di]
        
        add ax, dx
        mov [bx], ax
        inc bx

        inc di
        dec si
        jmp AddLoop

    Exit:
        mov ax, 4Ch
        int 21h
MAIN ENDP

INPUTELEMENT PROC
    mov ah,09h
    lea dx, inputStr1
    int 21h

    mov dx, di
    add dl, 30h
    mov ah, 2
    int 21h
    call COLON
    mov enteredNumber, 0
    input:
        mov ah,01h
        int 21h
        cmp al,13 ;Stop taking input if user presses Enter key
        je stopIt
        sub al,48
        mov ah,0
        mov temp1, ax 
        mov ax,0
        mov ax,enteredNumber
        mov bx,10
        mul bx
        add ax,temp1
        mov enteredNumber,ax ; Store Number in Variable 
        inc digitCount ; Count Number of Digits
        jmp input

    stopIt:
    ret
INPUTELEMENT ENDP

NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP

COLON PROC
    mov dx, 03Ah ;print COLON
    mov ah, 2
    int 21h
    ret
COLON ENDP
END MAIN
