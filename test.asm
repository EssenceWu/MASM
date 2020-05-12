;登陆验证程序
data segment
first db 'usename:',0dh,0ah,'$'
second db 'password:',0dh,0ah,'$'
databasename db 'think'
databasepassword db '123456'
tempname db 15,?, 15 dup (?)
countname db $-tempname-02h,'$'
temppassword db 15,?,15 dup (?)
countpassword db $-temppassword-02h
welcome	db 'welcome!','$'

data ends

code segment 
assume cs:code,ds:data,es:data
start:
	mov ax,data
	mov ds,ax

	;dos 调用显示欢迎界面
	mov ah,09h
	mov dx,offset first
	int 21h

	;dos 0ah 调用用户输入
	mov ah,0ah
	mov dx,offset tempname
	int 21h

	cmp byte ptr tempname+1,05h  ;验证长度
	jnz exit

	mov cx,5			;字符串比较
	mov si,offset databasename
	mov di,offset tempname+2
	mov ax,data
	mov es,ax
	cld
	repe cmpsb
	jnz exit

	mov dx,offset tempname+2   ;显示输入的字符串
	mov byte ptr tempname[7],'$'
	call dosshow

	;提示输入password
	mov ah,09h
	mov dx,offset second
	int 21h

	;dos 0ah 调用用户输入
	mov ah,0ah
	mov dx,offset temppassword
	int 21h

	cmp byte ptr temppassword+1,06h
	jnz exit

	mov cx,6
	mov si,offset databasepassword
	mov di,offset temppassword+2
	mov ax,data
	mov es,ax
	cld
	repe cmpsb
	jnz exit

	mov dx,offset temppassword+2
	mov byte ptr temppassword[8],'$'
	call dosshow

	mov ah,09h
	mov dx,offset welcome
	int 21h	

exit:	
	mov ax,4c00h
	int 21h

dosshow proc
	mov ah,09h
	int 21h

	mov dl,0dh
	mov ah,02h
	int 21h

	mov dl,0ah
	mov ah,02h
	int 21h

	ret
dosshow endp

code ends
end start