.model small
.stack 100h

.data
    Number dw 1234
    ReverseNum db 4 dup(?)
    sum            dw ?
    counter        db 0

    output         db "Reversed string is: $"
    output1        db "Sum of digits is: $"

.code
main proc
    mov ax, @Data
    mov ds, ax

    mov cx, 4
    mov ax, Number
    mov si, Offset ReverseNum

    reverseLoop:  
        mov  dx, 0
        mov  bx, 10
        div  bx
        add  dx, '0'
        mov  [si], dx
        add  sum, dx
        inc  si
        loop reverseLoop

    mov  ah, 09h
    lea  dx, output
    int  21h

    mov  cx, 4
    mov  si, Offset ReverseNum
    DISPDigits:
        mov  dx, [si]
        mov  ah, 02h
        int  21h
        inc  si
        loop DISPDigits

    call NEWLINE
    mov  ax, 0
    mov  cx, 4
    mov  si, Offset ReverseNum
    calculateSum: 
        mov  dl, [si]
        sub  dl, '0'
        add  al, dl
        mov  ah, 0
        inc  si
        loop calculateSum

    mov  sum, ax
    call NEWLINE
    mov  ah, 09h
    lea  dx, output1
    int  21h
    call OUTPUTP

    EXIT:  
        mov  ah, 4ch
        int  21h
main endp

NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP

OUTPUTP PROC
    mov  dx, 0
    mov  ax, sum
    mov  bx, 10

    L1:           
        mov  dx, 0
        cmp  ax, 0
        je   DISP
        div  bx
        mov  cx, dx
        push cx
        inc  counter
        mov  ah, 0
        jmp  L1

    DISP:      
        cmp  counter, 0
        je   return
        pop  dx
        add  dx, 48
        mov  ah, 02h
        int  21h
        dec  counter
        jmp  DISP

    return:       
        ret
OUTPUTP ENDP
end main
