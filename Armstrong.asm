;A procedure that takes an integer from the user and checks whether the input number is
;Armstrong or not. (Input range up to 500). An Armstrong number is an n-digit number that is
;equal to the sum of the nth powers of its digits. 3*3*3+7*7*7+1*1*1= 371.

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
        ; Print the input String
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
            ; Validation conditions (1 < n < 500)
            cmp enteredNumber, 1
            jl invalid_input
            cmp enteredNumber, 500
            jg invalid_input
    
            call IsARMSTRONG
            
            jmp EXIT
        
        invalid_input:
            ; Print Invalid Input Message
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
    mov counter, 0
    mov ax, enteredNumber
    mov  si, 1
    ArmLoop:  
        cmp si, digitCount
        ja L1
        mov  dx, 0
        mov  bx, 10
        div  bx ; n % 10 = Last Digit
        push dx ; Push into stack
        inc counter
        inc si
        jmp ArmLoop

    L1: ; Pop the number and take number^(no.of digits in entered number)
        cmp counter, 0
        je exitL1
        pop ax
        mov temp1, ax
        mov di, 1
        InnerLoop:
            mov dx, temp1
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
        je L2 ; Jump if Armstrong else:
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
