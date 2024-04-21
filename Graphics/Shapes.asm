.model small
.stack 100h

.data
	squareSize dw 60
.code
main proc
	mov ax, @data
	mov ds, ax 
	
	mov ah, 0
	mov bh, 0
	mov al, 13h
	int 10h

	mov cx, 10
	mov dx, 80
	mov si, cx
	mov di, dx
	call drawSquare

	mov cx, 70
	mov dx, 40
	mov si, cx
	mov di, dx
	mov ax, squareSize
	SUB squareSize, 20
	call drawRectangle

	mov cx, 130
	mov dx, 60
	mov si, cx
	mov di, dx
	call drawTriangle
	

	mov cx, 130
	mov dx, 120
	mov si, cx
	mov di, dx
	call drawPentagon

	mov cx, 230
	mov dx, 30
	mov si, cx
	mov di, dx
	call drawHexagon
	
	mov cx, 230
	mov dx, 100
	mov si, cx
	mov di, dx
	call drawOctagon

	mov ah, 4ch
	int 21h
main endp

drawSquare proc
	L1:
		mov al, 1001b
		mov ah, 0ch
		int 10h
		inc cx
		cmp cx, squareSize
		jne L1

	mov ax, dx
	add ax, squareSize
	mov squareSize, ax
	L2:
		mov al, 1001b
		mov ah, 0ch
		int 10h
		inc dx
		cmp dx, squareSize
		jne L2

	L3:
		mov al, 1001b
		mov ah, 0ch
		int 10h
		dec cx
		cmp cx, si
		jne L3
	
	L4:
		mov al, 1001b
		mov ah, 0ch
		int 10h
		dec dx
		cmp dx, di
		jne L4

	ret
drawSquare endp

drawRectangle proc
	L1:
		mov al, 110b
		mov ah, 0ch
		int 10h
		inc cx
		cmp cx, squareSize
		jne L1

	mov ax, dx
	add ax, squareSize
	mov squareSize, ax
	L2:
		mov al, 110b
		mov ah, 0ch
		int 10h
		inc dx
		cmp dx, squareSize
		jne L2

	L3:
		mov al, 110b
		mov ah, 0ch
		int 10h
		dec cx
		cmp cx, si
		jne L3
	
	L4:
		mov al, 110b
		mov ah, 0ch
		int 10h
		dec dx
		cmp dx, di
		jne L4

	ret
drawRectangle endp

drawTriangle proc
	
	L1:
		mov al, 1010b
		mov ah, 0CH
		INT 10h
		dec dx
		inc cx
		cmp cx, 160
		jne L1

	L2:
		mov al, 1010b
		mov ah, 0CH
		INT 10h
		inc dx
		inc cx
		cmp cx, 190
		jne L2

	L3:
		mov al, 1010b
		mov ah, 0CH
		Int 10h
		dec cx
		cmp cx, si
		jne L3

	ret
drawTriangle endp

drawPentagon proc
	L1:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		dec dx
		add cx, 2
		cmp cx, 160
		jne L1

	L2:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		inc dx
		add cx, 2
		cmp cx, 190
		jne L2

	L3:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		inc dx
		inc dx
		inc dx
		dec cx
		cmp cx, 177
		jne L3

	L4:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		dec cx
		cmp cx, 143
		jne L4

	L5:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		dec dx
		dec dx
		dec dx
		dec cx
		cmp cx, 130
		jne L5
		
	ret
drawPentagon endp

drawHexagon proc
	L1:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		inc cx
		cmp cx, 260
		jne L1

	L2:
		mov al, 1110b
		mov ah, 0CH
		INT 10h
		inc dx
		inc cx
		cmp cx, 280
		jne L2

	L3:
		mov al, 1110b
		mov ah, 0ch
		int 10h
		dec cx
		inc dx
		cmp cx, 260
		jne L3
	L4:
		mov al, 1110b
		mov ah, 0ch
		int 10h
		dec cx
		cmp cx, 230
		jne L4
	
	L5:
		mov al, 1110b
		mov ah, 0ch
		int 10h
		dec cx
		dec dx
		cmp cx, 210
		jne L5

	L6:
		mov al, 1110b
		mov ah, 0ch
		int 10h
		inc cx
		dec dx
		cmp cx, 230
		jne L6

	ret
drawHexagon endp

drawOctagon proc
	L1:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		inc cx
		cmp cx, 260
		jne L1

	L2:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		inc dx
		inc cx
		cmp cx, 280
		jne L2

	L3:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		inc dx
		cmp dx, 150
		jne L3

	L4:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		inc dx
		dec cx
		cmp cx, 260
		jne L4

	L5:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		dec cx
		cmp cx, 230
		jne L5
	
	L6:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		dec dx
		dec cx
		cmp cx, 210
		jne L6

	L7:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		dec dx
		cmp dx, 120
		jne L7

	L8:
		mov al, 1101b
		mov ah, 0CH
		INT 10h
		dec dx
		inc cx
		cmp cx, 230
		jne L8

	ret
drawOctagon endp

end
