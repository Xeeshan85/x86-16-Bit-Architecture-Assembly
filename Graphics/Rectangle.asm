; Program draws a rectangle full of pixels on the screen.

.model small
.stack 100h

.data
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Video Mode
    mov ah, 0
    mov al, 13h
    int 10h
    
    mov cx, 100
    mov dx, 50
    mov si, cx
    mov di, 50

	L1:
		mov al, 110b
		mov ah, 0ch
		int 10h

		inc cx
		cmp cx, 200
		jne L1

		mov cx, si
		inc dx
		cmp dx, 100
		jne L1

		mov ah, 4ch
		int 21h

main endp
end main

