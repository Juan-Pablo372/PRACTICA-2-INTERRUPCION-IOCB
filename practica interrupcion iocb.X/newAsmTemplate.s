PROCESSOR 16F887
#include <xc.inc>
;configuración de los fuses
    CONFIG FOSC=INTRC_NOCLKOUT
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=OFF
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
    
    
    CONFIG BOR4V=BOR40V
    CONFIG WRT=OFF
PSECT udata
var_1:
    DS 1
var_2:
    DS 1
var_3:
    DS 1
var_4:
    DS 1
var_5:
    DS 1
var_6:
    DS 1
var_7:
    DS 1  
var_8:
    DS 1  
tick:
    DS 1
counter:
    DS 1
counter2:
    DS 1
operador:
    DS 1
        
PSECT code
delay:
movlw 0xff
movwf counter
counter_loop:
movlw 0xff
movwf tick
tick_loop:
decfsz tick,f
goto tick_loop
decfsz counter,f
goto counter_loop
return
    
PSECT code
delay1:
movlw 0b00000010
movwf var_1
call delay
decfsz var_1
goto $ -2
return
PSECT code
delay2:
movlw 0b00000010
movwf var_2
call delay1
decfsz var_2
goto $ -2
return   
PSECT code
delay3:
movlw 0b00000010
movwf var_3
call delay2
decfsz var_3
goto $ -2
return
PSECT code    
delay4:
movlw 0b00000010
movwf var_4
call delay3
decfsz var_4
goto $ -2
return   
PSECT code    
delay5:
movlw 0b00000010
movwf var_5
call delay4
decfsz var_5
goto $ -2
return  
PSECT code    
delay6:
movlw 0b00000010
movwf var_6
call delay5
decfsz var_6
goto $ -2
return      
PSECT code
delay7:
movlw 0b00000010
movwf var_7
call delay6
decfsz var_7
goto $ -2
return    
PSECT code

PSECT resetVec,class=CODE,delta=2
resetVec:
goto main
    
PSECT isr,class=CODE,delta=2

isr:
    btfss INTCON,0         ;evaluamos la bandera de la interrupcion
    retfie
    clrf PORTD
    evaluar0:
    btfss PORTB,0
    goto evaluar1
    bcf INTCON,0
    bcf PORTB,0
    bsf  PORTD,0
    retfie
    evaluar1:
    btfss PORTB,1
    goto evaluar2
    bcf INTCON,0
    bcf PORTB,1
    bsf  PORTD,1
    retfie
    evaluar2:
    btfss PORTB,2
    goto evaluar3
    bcf INTCON,0
    bcf PORTB,2
    bsf  PORTD,2
    retfie
    evaluar3:
    btfss PORTB,3
    goto evaluar4
    bcf INTCON,0
    bcf PORTB,3
    bsf  PORTD,3
    retfie
    evaluar4:
    btfss PORTB,4
    goto evaluar5
    bcf INTCON,0
    bcf PORTB,4
    bsf  PORTD,4
    retfie
    evaluar5:
    btfss PORTB,5
    goto evaluar6
    bcf INTCON,0
    bcf PORTB,5
    bsf  PORTD,5
    retfie
    evaluar6:
    btfss PORTB,6
    goto evaluar7
    bcf INTCON,0
    bcf PORTB,6
    bsf  PORTD,6
    retfie
    evaluar7:
    btfss PORTB,7
    goto evaluar0
    bcf INTCON,0
    bcf PORTB,7
    bsf  PORTD,7
    retfie
PSECT main,class=CODE,delta=2
main:
    
BANKSEL OPTION_REG
movlw 0b01000000         ;configuracion de inerrupcion en flanco ascendiente
movwf OPTION_REG
BANKSEL WPUB             
movlw 0b11111111         ;activacion de las pull-up del puerto b
movwf WPUB
    

clrf INTCON
movlw 0b11001000         ;configuracion de las interrupciones
movwf INTCON
BANKSEL IOCB 
movlw 0b11111111         ;activar las interrupciones del puerto b
movwf IOCB
    
BANKSEL OSCCON           ;configuracion del ocilador
movlw 0b01110000
movwf OSCCON   
        
BANKSEL ANSEL           ;desactivamos el convertidor analogico digital de PORTA
movlw   0x00
movwf   ANSEL
BANKSEL ANSELH          ;desactivamos el convertidor analogico digital de PORTB
movlw   0x00
movwf   ANSELH   
    
    
BANKSEL TRISB      ;configuramos todo el puerto b como entrada para leer la interrupcion
movlw   0XFF
movwf   TRISB
BANKSEL TRISA      ;configuramos el Puerto A como SALIDA
clrf    TRISA
BANKSEL TRISD      ;configuramos el puerto D como SALIDA
clrf    TRISD
    
BANKSEL PORTA      ;ponemos a 0 PORTA,PORTB Y PORTD 
clrf    PORTA
BANKSEL PORTD
clrf    PORTD
BANKSEL PORTB
clrf    PORTB  


    evaluarPIN0:
    btfss PORTD,0
    goto evaluarPIN1
    bsf  PORTA,0
    call delay7
    bcf PORTA,0
    call delay7
    goto evaluarPIN0
   
    evaluarPIN1:
    btfss PORTD,1
    goto evaluarPIN2
    bsf  PORTA,0
    call delay6
    bcf PORTA,0
    call delay6
    goto evaluarPIN1
    
    evaluarPIN2:
    btfss PORTD,2
    goto evaluarPIN3
    bsf  PORTA,0
    call delay5
    bcf PORTA,0
    call delay5
    goto evaluarPIN2
    
    evaluarPIN3:
    btfss PORTD,3
    goto evaluarPIN4
    bsf  PORTA,0
    call delay4
    bcf PORTA,0
    call delay4
    goto evaluarPIN3
    
    evaluarPIN4:
    btfss PORTD,4
    goto evaluarPIN5
    bsf  PORTA,0
    call delay3
    bcf PORTA,0
    call delay3
    goto evaluarPIN4
    
    evaluarPIN5:
    btfss PORTD,5
    goto evaluarPIN6
    bsf  PORTA,0
    call delay2
    bcf PORTA,0
    call delay2
    goto evaluarPIN5
    
    evaluarPIN6:
    btfss PORTD,6
    goto evaluarPIN7
    bsf  PORTA,0
    call delay1
    bcf PORTA,0
    call delay1
    goto evaluarPIN6
    
    evaluarPIN7:
    btfss PORTD,7
    goto evaluarPIN0
    bsf  PORTA,0
    call delay
    bcf PORTA,0
    call delay
    goto evaluarPIN7 
    END resetVec