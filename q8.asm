.model small
.stack 0100h
.data
    digitCount dw 0 
    enteredNumber dw 0
    temp1 dw 0
    counter db 0
    ArmSum dw 0

    inputStr db "Enter number (1-500): ","$"
    ArmstrongStr db "It is an Armstrong Number.","$"
    NotArmstrongStr db "It is not an Armstrong Number.","$"
    invalid_msg db "Invalid input! Number should be between 1 - 500.$"
.code
MAIN PROC
    mov ax, @data
    mov ds, ax
    MAIN1:
    mov ax, 0
    mov ah,09h
    lea dx, inputStr
    int 21h

    ;input multidigit number
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
        cmp enteredNumber, 1
        jl invalid_input
        cmp enteredNumber, 500
        jg invalid_input

        call IsARMSTRONG
        
        jmp EXIT
    
    invalid_input:
        mov ah, 09h
        lea dx, invalid_msg
        int 21h
        call NEWLINE
        jmp MAIN1

    EXIT:
        mov ah, 4ch
        int 21h
MAIN ENDP

IsARMSTRONG PROC
    mov  si, 0
    mov counter, 0
    ArmLoop:  
        cmp si, digitCount
        ja exitArm
        mov  dx, 0
        mov  bx, 10
        div  bx
        add  dx, '0'
        push dx
        inc counter
        inc si
        jmp ArmLoop

    exitArm:
    L1:
        cmp counter, 0
        je exitL1
        pop ax
        mov di, 1
        InnerLoop:
            cmp di, digitCount
            jae ExitInner
            MUL dx ; x=x^n
            inc di
            jmp InnerLoop
            
        ExitInner:
            ADD ax, ArmSum ;sum += x
            mov ArmSum, ax
            dec counter
            jmp L1

    exitL1:
        mov ax, ArmSum
        cmp ax, enteredNumber
        je L2
        mov ah, 09h
        lea dx, NotArmstrongStr
        int 21h
        jmp L3
        L2:
            mov ah, 09h
            lea dx, ArmstrongStr
            int 21h
    L3:
        ret
IsARMSTRONG ENDP

NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP

PRINTNUMBER PROC
    add dl, 30h
    mov ah, 2
    int 21h 
    ret
PRINTNUMBER ENDP
END MAIN