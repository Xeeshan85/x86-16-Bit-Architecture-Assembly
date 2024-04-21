; The Following code Draws Chess Board on the Screen
.model small
.stack 0100h
.data

	color db 15
	s_l db 3
	s_h db 3
	d_l db 4
	d_h db 4
	i dw 0
	j dw 0
	counter dw 0
	
.code
mov ax, @data
mov ds, ax
mov si, offset i

;video mode (graphic)
mov ah, 0
mov al, 13h
int 10h


outer_loop1:

	cmp i, 8
	jge end_loop1
	mov j, 0
	
	call draw_box
		
		inner_loop1:
		
			cmp j, 8
			jge end_loop2
			
			;get Color
			mov bx, counter
			and bx, 1
			jz even_color
			
			mov color, 10
			jmp next_label
			even_color:
				mov color, 15
			

			next_label:
				call draw_box
				
				mov dl, s_l
				add dl, 2
				mov s_l, dl
				mov dl, d_l
				add dl, 2
				mov d_l, dl
				
				inc j
				inc counter
				jmp inner_loop1
				
		
		
		end_loop2:
			inc counter
			inc i
			mov s_l, 3
			mov d_l, 4
			
			mov dl, s_h
			add dl, 2
			mov s_h, dl
			mov dl, d_h
			add dl, 2
			mov d_h, dl
			
			jmp outer_loop1
			

end_loop1:



mov ah, 4ch
int 21h


draw_box proc

	mov ah, 6
	mov al, 0
	mov bh, color
	mov ch, s_h     ;top row of window
	mov cl, s_l     ;left most column of window
	mov dh, d_h     ;Bottom row of window
	mov dl, d_l     ;Right most column of window
	int 10h
	
	ret
draw_box endp


end
box.asm
Displaying box.asm.
