.model small
.stack 100h

.data
    n                    equ 3
    matrix               db  n*n dup(0)
    matrixMul            db  2, 2, 2, 2, 2, 2, 2, 2, 2
    resultantMatrix      db  n*n dup(0)
    count                dw  0
    count1               dw  0
    seed                 dw  0
    temp dw 0
    tempSum dw 0
    row dw 0
    col dw 0
    row1 dw 0
    col1 dw 0


    output   db  "Initialized matrix: $"
    output1  db  "Matrix after random filling: $"
    output2  db  "Sum of the third row is: $"
    output3  db  "Maximum in third row is: $"
    output4  db  "The sum of left diagonal is: $"
    output5  db  "The transpose of matrix is: $"
    output6  db  "The product of the matrices is: $"

.code
main proc
    mov  ax, @Data
    mov  ds, ax

    mov  ah, 09h
    lea  dx, output
    int  21h
    call NEWLINE

    lea  si, matrix
    call displayMatrix

    ; Initialize random seed with system time
    mov  ah, 2Ch
    int  21h
    mov  seed, cx

    ; Filling matrix with random numbers (0 to 9)
    mov  cx, n*n
    lea  si, matrix
    fillMatrix:
        call random_number
        mov  [si], dl
        inc  si
        loop fillMatrix
    call NEWLINE

    lea  dx, output1
    mov ah, 9
    int  21h
    call NEWLINE
    lea  si, matrix
    call displayMatrix

; ##################### MATRIX OPERATIONS #########################
; ================= ROW ADDITION =============================
    ; Calculating sum of row: 3
    mov  cx, n
    xor  bx, bx
    mov  si, offset matrix + 2*n

        call NEWLINE
    RowSum:         
        add  bl, [si]

        inc  si
        loop RowSum

    ; Output the sum calculated
    mov  ah, 09h
    lea  dx, output2
    int  21h
    
    mov  dx, bx
    call PRINT_ELEMENT

;============ MAX FIND ================
    ; Finding max in row:
    mov  cx, n-1                 ; Loop for n-1 elements since the first is already in bx
    mov  si, offset matrix + 2*n ; Point to the start of the third row (2*n)
    mov  bl, [si]                ; Load the first element into bl
    inc  si                      ; Move to the next element

    call NEWLINE                 ; Print a new line for clarity
    findMaxInRow:
        cmp  [si], bl
        jle  less                ; Jump if [si] <= bl

        mov  bl, [si]            ; Update max if current element is larger
    less:
        inc  si                  ; Move to the next element
        loop findMaxInRow        ; Repeat for all elements in the row

    ; Displaying Result
    call NEWLINE
    mov  ah, 09h
    lea  dx, output3
    int  21h

    mov  ah, 02h
    mov  dl, bl
    add  dl, '0'
    int  21h

    call NEWLINE

;============= SUM DIAGONAL ===============
    ; Sum of left diagonal
    mov  cx, n
    mov  si, offset matrix
    xor  dx, dx                 ; Clear ax register for sum
    diagonalSum:
        add  dl, [si]

        add  si, n+1            ; Move to the next element in the diagonal
        loop diagonalSum
    push dx
    ; Displaying Result
    call NEWLINE
    mov  ah, 09h
    lea  dx, output4
    int  21h

    ;mov  ah, 02h
    pop dx
    call PRINT_ELEMENT
    call NEWLINE

;=============== TRANSPOSE ===================
    ; Transposing the matrix
    call NEWLINE
    mov  ah, 09h
    lea  dx, output5
    int  21h
    call NEWLINE

    mov cx, n
    mov bx, 0
    TransLoop:
        lea si, matrix
        mov dx, [si+bx]
        call PRINTNUMBER
        mov  si, offset matrix + n
        mov dx, [si+bx]
        call PRINTNUMBER
        mov  si, offset matrix + 2*n
        mov dx, [si+bx]
        call PRINTNUMBER

        call NEWLINE
        inc bx
        loop TransLoop

    
    call NEWLINE

;=============== MULTIPLY ====================

    lea bx, matrix
    lea si, matrixMul
    lea di, resultantMatrix
    mov tempSum, 0
    mov row, 0
    mov col, 0
    mov cx, n
    mov si, 0
    mov count, 0
    mov count1, 0

    LoopMultiplyOuter:
        mov row1, 0
        mov col1, 0
        mov tempSum, 0
        mov di, 0
        mov count1, 0
        P1:
            mov col, 0
            mov row1, 0
            cmp count1, n
            je ExitP1

            LoopMultiplyInner:
                cmp di, n
                je exitMul

                call MULTIPLY
                MUL dx

                add ax, tempSum
                mov tempSum, ax

                inc di
                jmp LoopMultiplyInner

                exitMul:
                    inc col1
                    lea si, resultantMatrix
                    add si, count
                    mov ax, tempSum
                    mov [si], ax
                    inc count

                
                inc count1
                jmp P1

            ExitP1:
                inc row

        loop LoopMultiplyOuter
    

    

    mov  ah, 09h
    lea  dx, output6
    int  21h
    call NEWLINE

    lea  si, resultantMatrix
    call displayMatrix2

    EXIT:        
        mov  ah, 4Ch
        int  21h

    mov ah, 4Ch
    int 21h
main endp

Multiply proc
    mov ax, row
    mov bx, n
    MUL bx
    mov bx, ax
    xor ax, ax
    mov si, col
    xor ax, ax
    mov al, matrix[bx + si]   ; MATRIX 1 2 3 rows
    inc col
    push ax


    mov ax, row1
    mov bx, n
    MUL bx
    mov bx, ax
    xor ax, ax
    mov si, col1
    xor dx, dx
    mov dl, matrixMul[bx + si]   ; MATRIX 1 4 7 cols
    inc row1
    pop ax
        ret
Multiply ENDP


NEWLINE PROC
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NEWLINE ENDP


displayMatrix2 PROC Uses cx dx
    mov  cl, n
    rowLoop:            
        cmp  cl, 0
        je   return
        mov  ch, n
    columnLoop:         
        cmp  ch, 0
        je   endColumnLoop
        mov  ah, 02h
        xor dx, dx
        mov  dl, [si]
        call PRINT_ELEMENT
        call SPACE
        inc  si
        dec  ch
        jmp  columnLoop
    endColumnLoop:      
        call NEWLINE
        dec  cl
        jmp  rowLoop
    return:
        ret
displayMatrix2 ENDP

SPACE PROC
    mov dx, 020h ; print space
    mov ah, 2
    int 21h
    ret
SPACE ENDP


displayMatrix PROC Uses cx dx
    mov  cl, n
    rowLoop:            
        cmp  cl, 0
        je   return
        mov  ch, n
    columnLoop:         
        cmp  ch, 0
        je   endColumnLoop
        mov  ah, 02h
        mov  dl, [si]
        add  dl, '0'
        int  21h
        inc  si
        dec  ch
        jmp  columnLoop
    endColumnLoop:      
        call NEWLINE
        dec  cl
        jmp  rowLoop
    return:
        ret
displayMatrix ENDP

random_number PROC
    mov  ax, seed
    mov  bx, 1103515245
    mul  bx
    add  ax, 12345
    mov  seed, ax
    and  ax, 0FFFFh
    xor  dx, dx
    mov  bx, 10        ; Range (0 to 9)
    div  bx
    ret
random_number ENDP

PRINT_ELEMENT PROC
    push dx
    push cx

    ; Check if the number is 3 digits, 2 digits, or 1 digit
    mov ax, dx
    xor dx, dx

    ; Check for 3-digit number
    cmp ax, 100
    jb check_two_digits
    mov CX, 100
    div CX               ; AX = quotient (hundreds), DX = remainder
    mov temp, DX
    mov dx, ax
    call PRINTNUMBER

    mov ax, temp         ; Get remainder
    xor dx, dx              ; Clear DX

    check_two_digits:
        cmp ax, 10
        jb print_units
        mov CX, 10
        div CX               ; AX = quotient (tens), DX = remainder
        mov temp, dx
        mov dx, ax
        call PRINTNUMBER

        mov ax, temp         ; Get remainder
        xor dx, dx              ; Clear DX

    print_units:
        mov dx, ax
        call PRINTNUMBER

    ; Restore the DX register
    pop cx
    pop dx
    ret
PRINT_ELEMENT ENDP

PRINTNUMBER PROC
    add dl, 30h
    mov ah, 2
    int 21h 
    ret
PRINTNUMBER ENDP

end main
