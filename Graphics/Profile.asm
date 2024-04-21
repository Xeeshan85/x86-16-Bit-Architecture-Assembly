; The program draws a border on the screen 
; and write text in the center of the screen.


.model small
.stack 0100h
.data
	text db 'Follow Xeeshan85$'
.code
MAIN PROC
	mov ax, @data
	mov ds, ax
	
	mov ah, 0
	mov al, 13h
	int 10h

	;setting cursor position
	mov ah, 2
	mov dh, 10    ;row
	mov dl, 15    ;column
	int 10h

	mov bx,0
	mov bl,0010b
	lea si, text
	mov di, 0
	L1:
		call printS
		inc si
		inc di
		inc dl
		cmp di, 9
		jne L1

	mov ah, 6
	mov al, 0
	mov bh, 12 ;Color

	mov ch, 0
	mov cl, 0
	mov dh, 100
	mov dl, 1
	int 10h

	mov ch, 0
	mov cl, 0
	mov dh, 1
	mov dl, 100
	int 10h

	mov ch, 28
	mov cl, 0
	mov dh, 40
	mov dl, 40
	int 10h

	mov ch, 0
	mov cl, 38
	mov dh, 40
	mov dl, 40
	int 10h

	mov ah, 4ch
	int 21h
MAIN ENDP

printS proc
	mov al,[si]
	mov cx, 5
	mov ah,0eh
	int 10h
	ret
printS endp
end
