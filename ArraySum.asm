
; An assembly language program that takes 2 arrays of size n (size is declared
; generically in .data) the entries are added in such a way that 1st index of one array adds to the last
; index of the second array, 2nd index of the first array adds to the second last index of the other array,
; and so on. The added numbers are saved in a third array.


.model small
.stack 100h

.data
    n equ 5 ; Initialize the Size of Arrays
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

    lea si, array1
    mov di, 0
    ArrInput1: ; Input elements for the first Array
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
    mov di, 0 ; Counter to keep track of size for loop
    ArrInput2: ; Input Elements for the second Array
        cmp di, n
        jae ExitLoop2
        call INPUTELEMENT
        mov ax, enteredNumber
        mov [si], ax
        inc si
        inc di
        jmp ArrInput2

    ExitLoop2:

    mov si, n ; End Index
    dec si
    mov di, 0 ; Start index
    lea bx, ResultArray
    AddLoop: ; Addition Logic
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
    ; Print input String
    mov ah,09h
    lea dx, inputStr1
    int 21h

    ; Print the number of element being input
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
