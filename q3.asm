.model small
.stack 100h

.data
    Number dd 12345678
    originalNumber dw 1234
    reversedNumber dd 8 dup(?)
    sum            dw ?
    counter        db 0

    output         db "The reversed string is: $"
    output1        db "The sum of the digits involved in the string is: $"

.code
main proc
    mov  ax, @Data
    mov  ds, ax

    lea di, originalNumber
    lea di, Number
    add di, 2
    mov  ax, [di]
    mov  si, Offset reversedNumber
    mov  cx, 4
    reverseLoop:  
        mov  dx, 0
        mov  bx, 10
        div  bx
        add  dx, '0'
        mov  [si], dx
        add  sum, dx
        inc  si
        loop reverseLoop


    ;call REVERSE
    ;add di, 2
    ;mov ax, [di]
    ;call REVERSE
    ;call NEWLINE

    mov  ah, 09h
    lea  dx, output
    int  21h
    mov  cx, 8
    mov  si, Offset reversedNumber
    displayDigits:
        mov  dx, [si]
        mov  ah, 02h
        int  21h
        inc  si
        loop displayDigits
        
        

    exitProgram:  
        mov  ah, 4ch
        int  21h
main endp
REVERSE PROC
    mov  cx, 4
    reverseLoop:  
        mov  dx, 0
        mov  bx, 10
        div  bx
        add  dx, '0'
        mov  [si], dx
        add  sum, dx
        inc  si
        loop reverseLoop
REVERSE ENDP

twoByteOuput PROC
    mov  dx, 0
    mov  ax, sum
    mov  bx, 10

    L1:           
        mov  dx, 0
        cmp  ax, 0
        je   display
        div  bx
        mov  cx, dx
        push cx
        inc  counter
        mov  ah, 0
        jmp  L1

    display:      
        cmp  counter, 0
        je   return
        pop  dx
        add  dx, 48
        mov  ah, 02h
        int  21h
        dec  counter
        jmp  display
    return:       
        ret
twoByteOuput ENDP

NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP
end main
