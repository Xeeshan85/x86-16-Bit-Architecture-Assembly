; A program that displays the following output. If n = 5 then: (15)
; 
;     1            *
;    212          ***
;   32123        *****
;  4321234      *******
; 543212345    *********
;  4321234      *******
;   32123        *****
;    212          ***
;     1            *

.model small
.stack 100h

.data
    n dw ?
    temp dw ?
    str1 db "Enter N: $"

.code
MAIN PROC
    mov ax, @data
    mov ds, ax
    lea ax, n

    ; Print the input String
    lea dx, str1
    Mov ah, 9
    Int 21h
    ; Take input for the row Count
    mov ah, 1
    int 21h
    mov ah, 0
    sub ax, 30h
    mov n, ax

    call NEWLINE
    
    ; Upper Triangles
    mov bx, 1 ; i = 1
    mov di, n
    OuterLoop1:
        cmp bx, di
        ja Outer

        ; Print space triangle
        mov si, 0 ; j = 0
        mov ax, n
        sub ax, bx ; n-i
        mov temp, ax
        InnerLoop1:
            cmp si, temp
            jae Inner2
            call SPACE
            inc si
            jmp InnerLoop1

        ; Print upper Left Half of first triangle
        Inner2:
        mov cx, bx ; j = i
        InnerLoop2:
            mov dx, cx
            call PRINTNUMBER
            loop InnerLoop2

        ; Print upper Right Half of first triangle
        mov si, 2 ;j = 2
        InnerLoop3:
            cmp si, bx
            ja Inner4
            mov dx, si
            call PRINTNUMBER
            inc si
            jmp InnerLoop3

        ; Print Middle spaces b/w two triangles
        Inner4:
        mov si, 0
        mov ax, n
        mov dx, 2
        sub ax, bx ; n-i
        MUL dx ;(n-i)MUL2
        mov temp, ax
        InnerLoop4:
            cmp si, temp
            ja Inner5
            call SPACE
            inc si
            jmp InnerLoop4

        ; Print upper Left Half of Second triangle
        Inner5:
        mov cx, bx
        InnerLoop5:
            call STAR
            loop InnerLoop5

        ; Print upper Right Half of Second triangle
        mov si, 2
        InnerLoop6:
            cmp si, bx
            ja OUTNEW
            call STAR
            inc si
            jmp InnerLoop6

        OUTNEW:
            call NEWLINE
            inc bx
        jmp OuterLoop1
;------------------------------------------
    Outer:
        lea ax, n
        lea dx, temp

    ; Lower Triangles
    mov bx, n ; i = 1
    dec bx
    mov di, 0
    OuterLoop2:
        cmp bx, di
        jbe Exit

        mov si, 0 ; j = 0
        mov ax, n
        sub ax, bx ; n-i
        mov temp, ax
        InnerLoop11:
            cmp si, temp
            jae Inner22
            call SPACE
            inc si
            jmp InnerLoop11

        Inner22:
        mov cx, bx ; j = i
        InnerLoop22:
            mov dx, cx
            call PRINTNUMBER
            loop InnerLoop22

        mov si, 2 ;j = 2
        InnerLoop33:
            cmp si, bx
            ja Inner44
            mov dx, si
            call PRINTNUMBER
            inc si
            jmp InnerLoop33

        Inner44:
        mov si, 0
        mov ax, n
        mov dx, 2
        sub ax, bx ; n-i
        MUL dx ;(n-i)MUL2
        mov temp, ax
        InnerLoop44:
            cmp si, temp
            ja Inner55
            call SPACE
            inc si
            jmp InnerLoop44

        Inner55:
        mov cx, bx
        InnerLoop55:
            call STAR
            loop InnerLoop55

        mov si, 2
        InnerLoop66:
            cmp si, bx
            ja OUTNEW1
            call STAR
            inc si
            jmp InnerLoop66
        
        OUTNEW1:
            call NEWLINE
            dec bx
        jmp OuterLoop2

        

    Exit:
        mov ah, 4Ch
        int 21h
MAIN ENDP

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

SPACE PROC
    mov dx, 020h ; print space
    mov ah, 2
    int 21h
    ret
SPACE ENDP

STAR PROC
    mov dx, 02Ah ;print Star
    mov ah, 2
    int 21h
    ret
STAR ENDP
end main
