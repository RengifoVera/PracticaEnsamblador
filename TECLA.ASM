ASSUME CS:CODIGO, DS:DATOS, SS:PILA
CODIGO SEGMENT	
        MOV BX,DATOS
	MOV DS,BX
	  
	MOV BX,0
	
	MOV DX, OFFSET PARIDAD; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla

	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET IMPAR; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla

	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET PAR; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV AH,1H
    INT 21H; se llama a la int 21h con el servicio 1h, captura de teclado CON eco en pantalla
	MOV OPCION,AL
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
		
	MOV DX, OFFSET MENSAJE; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET VALOR; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
CICLO:
	
	MOV AH,1H
    INT 21H; se llama a la int 21h con el servicio 1h, captura de teclado CON eco en pantalla
	
	inc CX	
	CMP CX,4
	JE	MAXCARACTER
	
	CMP Al,2Dh;ASQUII DE LA TECLA -
	je CONFIRNEG
	MOV SIGNO,31h
	CMP Al,0Dh	;d=13 seria el ascii de la tecla enter
	je TECLAENTER ;en caso que el ascii digitado sea igual al ENTER saltara
	PUSH ax ;Guarda Cada elemento Digitado en la PILA
	jmp CICLO
	
CONFIRNEG:
	MOV SIGNO,32h

	MOV AH,1H
    INT 21H; se llama a la int 21h con el servicio 1h, captura de teclado CON eco en pantalla
	
	CMP AL,30H
	JE INVALIDO
	JMP CICLO2
	
	
CICLO2:
	MOV AH,1H
    INT 21H; se llama a la int 21h con el servicio 1h, captura de teclado CON eco en pantalla
	
	inc CX	
	CMP CX,4
	JE	MAXCARACTER
	
	CMP Al,0Dh
	je TECLAENTER ;en caso que el ascii digitado sea igual al ENTER saltara
	PUSH ax ;Guarda Cada elemento Digitado en la PILA
	jmp CICLO2	
	
	
INVALIDO:
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET ERRORR; almaceno en DX la direccion inicial de mensaje
	MOV AH,9
	INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	JMP FIN	
	
	
TECLAENTER:
MAXCARACTER:

	MOV DL,SIGNO
	CMP DL,31h
	je SIGNOPOSITIVO
	jne SIGNONEGATIVO
	
SIGNOPOSITIVO:	
	
	MOV DL,OPCION
	cmp DL,31h
	je IMPARPOSITIVO
	jne PARPOSITIVO

PARPOSITIVO:
						
    pop BX
	MOV AL,BL
	SUB AL,30H
	AND AL,1 ;hacemos la and entre el numero y el 1 asi sabremos si el numero es par o impar si el resultado de la AND es 0 el numero es par si no el numero es impar 	
	JP 	ESPAR;saltara a la et2 donde ira si el resultado es PAR
	JNP ESIMPAR;saltara a la et1 donde ira si el resultado es IMPAR
	
	ESPAR:
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADO1; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	JMP FIN
	
	ESIMPAR:
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADONEG1; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en pantalla
	JMP FIN

IMPARPOSITIVO:
						
    pop BX
	MOV AX,BX
	SUB AL,30H
	AND AL,1 ;hacemos la and entre el numero y el 1 asi sabremos si el numero es par o impar si el resultado de la AND es 0 el numero es par si no el numero es impar 	
	JP 	ESPAAR;saltara a la et2 donde ira si el resultado es IMPAR
	JNP ESIMPAAR ;saltara a la et1 donde ira si el resultado es PAR
	
	ESIMPAAR:
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADONEG2; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en pantalla
	JMP FIN

	ESPAAR:
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADO2; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	JMP FIN
		
SIGNONEGATIVO:
		
	MOV BL,OPCION
	cmp BL,31h
	je IMPAR_NEGATIVO
	jne PAR_NEGATIVO

PAR_NEGATIVO:
						
    pop BX
	MOV AL,BL
	
	SUB AL,30H
	MOV BL,-1
	MUL BL
	
	AND AL,1 ;hacemos la and entre el numero y el 1 asi sabremos si el numero es par o impar si el resultado de la AND es 0 el numero es par si no el numero es impar 	
	JP NEGPAR	;saltara a la et2 donde ira si el resultado es PAR
	JNP NEGIMPAR ;saltara a la et1 donde ira si el resultado es IMPAR
	
	NEGPAR:
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h

	MOV DX, OFFSET RESULTADONEG1; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	JMP FIN
	
	NEGIMPAR:
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADO1; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en pantalla
	JMP FIN

IMPAR_NEGATIVO:
						
    pop BX
	MOV AL,BL
	
	SUB AL,30H
	MOV BL,-1
	MUL BL
	
	AND AL,1 ;hacemos la and entre el numero y el 1 asi sabremos si el numero es par o impar si el resultado de la AND es 0 el numero es par si no el numero es impar 	
	JP  NEGPAAR;saltara a la et2 donde ira si el resultado es IMPAR
	JNP NEGIMPAAR ;saltara a la et1 donde ira si el resultado es PAR
	
	NEGIMPAAR:
	
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADO2; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en pantalla
	JMP FIN

	NEGPAAR:
	mov ah,02h
	mov dl,0ah ;salto de línea
	int 21h
	
	MOV DX, OFFSET RESULTADONEG2; almaceno en DX la direccion inicial de mensaje
    MOV AH,9
    INT 21h; se llama a la int 21h con el servicio 9h, impresion de una cadena en panatalla
	JMP FIN
	
	FIN:

	MOV AH,4Ch  
        INT 21h         
CODIGO ENDS

PILA SEGMENT STACK
        DW 32 DUP (0)
PILA ENDS

DATOS SEGMENT
	
ERRORR DB '!!! DATO INVALIDO !!!!$' 
OPCION Db '$' ; mensaje es una variable que almacena una cadena de caracteres, el caracter $ es necesario para indicar fin de cadena
SIGNO Db '$' 
PARIDAD DB 'BIENVENIDO SELECCIONE LA PARIDAD QUE DESEA: $'
MENSAJE DB 'PODRAS ESCRIBIR 4 DIGITOS NUMERICOS O MENOS, SI DESEA MENOS SOLO PRESIONE ENTER $'
VALOR DB 'DIGITE EL VALOR $'
IMPAR DB 'DIGITE 1 PARA PARIDAD IMPAR $'
PAR DB 'DIGITE 2 PARA PARIDAD PAR $'
RESULTADO1 DB 'R// El BIT DE PARIDAD PAR PARA EL DATO INGRESADO ES 0$'
RESULTADO2 DB 'R// EL BIT DE PARIDAD IMPAR PARA EL DATO INGRESADO ES 1$'
RESULTADONEG1 DB 'R// El BIT DE PARIDAD PAR PARA EL DATO INGRESADO ES 1$'
RESULTADONEG2 DB 'R// EL BIT DE PARIDAD IMPAR PARA EL DATO INGRESADO ES 0$'

DATOS ENDS

END
