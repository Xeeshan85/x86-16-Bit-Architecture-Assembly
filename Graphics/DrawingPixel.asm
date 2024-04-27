.model small
.stack 100h
.data
    x_pos dw 150          ; Initial X position (column)
    y_pos dw 100          ; Initial Y position (row)
    screen_width equ 320  ; Screen width
    screen_height equ 200 ; Screen height
    pixel_color db 14     ; Yellow color

.code
    mov ax, @data
    mov ds, ax

    ; Set Video Mode (Graphics Mode)
    mov ax, 0013h     ; 320x200, 256 colors
    int 10h

    ; Set Pixel Color
    mov al, pixel_color
    mov ah, 0Ch       ; Pixel
    xor bh, bh        ; Page 0
    mov cx, x_pos     ; X-coordinate (column)
    mov dx, y_pos     ; Y-coordinate (row)
    int 10h

    ; Main loop
    draw_pixel:
        mov ah, 00h
        int 16h         ; KeyBoard Interupt

        ; Check for arrow key press
        cmp ah, 0Eh     ; Check for backspace key, If pressed then Exit
        je backspace_pressed
        cmp ah, 48h     ; Up arrow key
        je move_up
        cmp ah, 50h     ; Down arrow key
        je move_down
        cmp ah, 4Bh     ; Left arrow key
        je move_left
        cmp ah, 4Dh     ; Right arrow key
        je move_right

        jmp draw_pixel

    move_up:
        cmp word ptr [y_pos], 0     ; Check if Y position is at the top of the screen
        jbe draw_pixel
        sub word ptr [y_pos], 1
        jmp redraw

    move_down:
        cmp word ptr [y_pos], screen_height - 1  ; Check if Y position is at the bottom of the screen
        jae draw_pixel
        add word ptr [y_pos], 1
        jmp redraw

    move_left:
        cmp word ptr [x_pos], 0     ; Check if X position is at the left edge of the screen
        jbe draw_pixel
        sub word ptr [x_pos], 1
        jmp redraw

    move_right:
        cmp word ptr [x_pos], screen_width - 1   ; Check if X position is at the right edge of the screen
        jae draw_pixel
        add word ptr [x_pos], 1
        jmp redraw

    redraw:
        mov ah, 0Ch
        mov al, pixel_color
        xor bh, bh        ; Video page number (0 for default)
        mov cx, word ptr [x_pos]  ; X-coordinate (column)
        mov dx, word ptr [y_pos]  ; Y-coordinate (row)
        int 10h
        jmp draw_pixel

    backspace_pressed:
        mov ah, 4Ch
        int 21h
end
