; A program to find the factors of a given number. Main procedure asks the user to input
; a number. The input number is in range between 1 to 100. Now the number is passed to the
; procedure named Factors. Factors are stored in the stack. The procedure named
; OutputFactors will print all factors of given number.


.model small
.stack 0100h
.data
    digitCount db 0 
    enteredNumber dw 0 
    temp1 dw 0
    counter db 0
    FactorCounter db 0
    inputStr db "Enter number (1-100): ","$"
    outputStr db "Factors are: ","$"
    invalid_msg db "Invalid input! Number should be between 1 - 100.$"
.code
MAIN PROC
    mov ax, @data
    mov ds, ax
    MAIN1:
        mov ax, 0
        ; Print the Input string
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
            ; Validation Condition should be in range between 1-100
            cmp enteredNumber, 1
            jl invalid_input
            cmp enteredNumber, 100
            jg invalid_input
            call FACTORS
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

FACTORS PROC
    mov si, 1 ; factor
    mov bx, enteredNumber
    FactorsLoop:
        cmp si, bx
        ja MOVEOut

        mov dx, 0
        mov ax, enteredNumber
        div si ; Number % factor
        cmp dx, 0 ; if the remainder is zero then its a factor
        jne NotAFactor
        push si ; store factor into a stack
        inc FactorCounter

        NotAFactor:
            inc si
            jmp FactorsLoop
        
    MOVEOut:
        call PrintFactors
    ret
FACTORS ENDP

PrintFactors PROC
    pop bp ;return address

    mov ah,09h
    lea dx, outputStr
    int 21h

    OUTPUTLoop:
        cmp FactorCounter, 0
        JE ExitLoop

        mov dx, 0
        pop si
        MOV AX, si
        MOV Bx, 10
        L1:
            mov dx, 0
            CMP Ax, 0
            JE DISP
            DIV Bx
            MOV cx, dx
            PUSH CX
            inc counter
            MOV AH, 0
            JMP L1

        DISP:
            CMP counter, 0
            JE EXITDisp
            POP DX
            ADD DX, 48
            MOV AH, 02H
            INT 21H
            dec counter
            JMP DISP
        EXITDisp:
            mov dx, 02Ch ; print comma
            mov ah, 2
            int 21h
            dec FactorCounter
            jmp OUTPUTLoop
    
    ExitLoop:
    push bp
    ret
PrintFactors ENDP

NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP
END MAIN
