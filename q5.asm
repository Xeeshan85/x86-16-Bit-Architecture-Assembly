.model small
.stack 100h

.data
    n equ 5 ; Size of Array
    array1 dw n dup(?)
    array2 dw n dup(?)
    ResultArray dw n dup(?)
    digitCount db 0 
    enteredNumber dw 0
    temp1 dw 0

    inputStr1 db "Enter Array1: $"
    inputStr2 db "Enter Array2: $"
    ResultStr db "Resultant Array: $"

.code
MAIN PROC
    mov ax, @data
    mov ds, ax

    lea bx, array1
    call INPUTARRAYS
 
    mov ax, 4C00h
    int 21h

MAIN ENDP

INPUTARRAYS PROC
    mov ax, 0
    mov ah,09h
    lea dx, inputStr1
    int 21h
    mov di, 0
    inputLoop:
        cmp di, 0
        ja loopOut
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
            mov [bx], ax
            add bx, 2
            inc di
            jmp inputLoop
    loopOut:
    ret
INPUTARRAYS ENDP
END MAIN
