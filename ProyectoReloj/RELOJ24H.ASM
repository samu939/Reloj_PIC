        LIST P=16F84

OP      EQU     01H	;DECLARACION DEL REGISTRO OPCION
TMR0    EQU     01H	;DECLARACION DEL TIMER 0	
INTCON  EQU     0BH	;DECLARACION DEL REGSITRO INTCON
TRISA   EQU     05H	;DECLARACION DEL REGISTRO TRISA (CONFIGURACION DEL PUERTO A)
PA      EQU     05H	;DECLARACION DEL PUERTO A
STATUS  EQU     03H	;DECLARACION DEL REGSITRO STATUS
VAR     EQU     10H	;DECLARACION DEL REGISTRO VAR (UTILIZADO COMO CONTADOR) 
PB		EQU		06H
TRISB	EQU		06H
SEGUNI	EQU		11H
SEGDEC	EQU		12H
MINUNI	EQU		13H
MINDEC	EQU		14H
HORUNI	EQU		15H
HORDEC	EQU		16H
ANDRES	EQU		17H
JOYCE	EQU		18H
NICOLA	EQU		19H
MODO	EQU		20H
CONTROL	EQU		21H
DIAUNI	EQU		22H
DIADEC	EQU		23H
MESUNI	EQU		24H
MESDEC	EQU		25H
CAMBIO	EQU		26H
VARCRO	EQU		27H
INICRO	EQU		28H
SUNICR	EQU		29H
SDECCR	EQU		30H
MUNICR	EQU		31H
MDECCR	EQU		32H
CONTROL2 EQU	33H
CONTROL3 EQU 	34H
MINUNIZ	EQU		35H
MINDECZ	EQU		36H
HORUNIZ	EQU		37H
HORDECZ	EQU		38H
ZONAH	EQU		39H
CONTZ	EQU		40H



        ORG     0	;VECTOR DE INTERRUPCION DEL RESET
        GOTO    INICIO	;SALTO A INICIO DEL PROGRAMA

INICIO  ORG     10
        BSF     STATUS,5	;CAMBIO DE BANCO DE MEMORIA (BANCO 1)
        CLRF    TRISA		;
		BSF		TRISA,0
		BSF		TRISA,1
		BSF		TRISA,3
		BSF		TRISA,4
		CLRF	TRISB
		MOVLW   B'00000111'	;MOVIENDO EL VALOR DE 00000111 A W
        MOVWF   OP			;ASIGNADO EL DIVISOR A 256, ASIGNADO AL TIMER, UTILIZANDO LA SENAL INTERNA DEL MICROCONTROLADOR
        BCF     STATUS,5	;CAMBIO DE BANCO DE MEMORIA (BANCO 0)

        MOVLW   B'10100000'	;MOVIENDO EL VALOR DE 10100000 A W
        MOVWF   INTCON		;HABILITANDO LAS INTERRUPCIONES Y DANDO PERMISO A LA INTERRUPCION DEL TIMER

        MOVLW   d'217'		;MOVIENDO EL VALOR DE 217 A W
        MOVWF   TMR0		;PRECARGANDO EL TIMER EN 217
        MOVLW   D'100'		;MOVIENDO EL VALOR DE 100 A W
        MOVWF   VAR			;CARGANDO EN LA VARIABLE DE CONTEO EL VALOR DE 100
		MOVLW   D'100'		;MOVIENDO EL VALOR DE 100 A W
        MOVWF   VARCRO	
		CLRF	PB
		
N1		CLRF	MINDECZ
		CLRF	MINUNIZ
		CLRF	HORUNIZ
		CLRF	HORDECZ
		CLRF	ZONAH
		CLRF	SUNICR
		CLRF	SDECCR
		CLRF	MUNICR
		CLRF	MDECCR
		CLRF	SEGUNI
		CLRF	SEGDEC
		CLRF	MINDEC
		CLRF	MINUNI
		CLRF	HORUNI
		CLRF	INICRO
		CLRF	DIAUNI
		CLRF	DIADEC
		CLRF	MESDEC
		CLRF	MESUNI
		INCF	MESUNI,1
		INCF	DIAUNI,1		
		CLRF	CONTROL
		CLRF	CONTROL2
		CLRF	MODO
		CLRF	CAMBIO
		CLRF	HORDEC
		CLRF	NICOLA

SAMUELI	BCF		CONTROL,0
		BCF		CONTROL2,0
		
SAMUEL	
		BTFSS	PA,0		;VALIDO SI QUIERE AJUSTA MINUTOS
		GOTO	MINUTOS		;AJUSTAR MINUTOS
		BTFSS	PA,1		;VALIDO SI QUIERE AJUSTAR HORAS
		GOTO 	HORAS
		BTFSS	PA,3
		BSF		CONTROL2,0
		BTFSS	PA,4
		BSF		CONTROL,0
		BTFSC	CONTROL,0
		GOTO	CMHF
		BTFSC	CONTROL2,0
		GOTO	CMHS
N8		BTFSC	MODO,0	
		GOTO	FECHAI
		BTFSC	MODO,1	
		GOTO	SEGUI	;CAMBIAR POR LA FUNCION INICIAL DE VER SEGUNDOS	
		BCF		NICOLA,0
SANDRO	MOVF	MINUNI,0
		MOVWF	PB
		BSF		PB,7
		CALL	RETARDO
		BCF		PB,7
		MOVF	MINDEC,0
		MOVWF	PB
		BSF		PB,6
		CALL	RETARDO
		BCF		PB,6
		MOVF	HORUNI,0
		MOVWF	PB
		BSF		PB,5
		CALL	RETARDO
		BCF		PB,5
		MOVF	HORDEC,0
		MOVWF	PB
		BSF		PB,4
		CALL	RETARDO
		BCF		PB,4
		GOTO    SAMUEL			;SALTA A LA ETIQUETA N1

CMHF	BTFSC	PA,4
		INCF	MODO,1
		GOTO	N8

CMHS	BTFSC	PA,3
		BSF		MODO,1
		GOTO	N8




RETARDO		MOVLW	D'255'
			MOVWF	ANDRES
GABRIELA	DECFSZ	ANDRES,1
			GOTO	GABRIELA
        	RETURN

MINUTOS		BTFSC	NICOLA,0
			GOTO	SANDRO
			BSF		NICOLA,0
			INCF	MINUNI,1
			MOVF	MINUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	SANDRO
			CLRF	MINUNI
			INCF	MINDEC,1
			MOVF	MINDEC,0
			SUBLW	D'6'
			BTFSS	STATUS,2
			GOTO	SANDRO
			CLRF	MINDEC
			GOTO	SANDRO

HORAS		BTFSC	NICOLA,0
			GOTO	SANDRO
			BSF		NICOLA,0
			INCF	HORUNI,1	
			MOVF	HORUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	MARIAPAOLA
			GOTO	ALFREDO
MARIAPAOLA	MOVF	HORUNI,0
			SUBLW	D'4'
			BTFSS	STATUS,2
			GOTO	SANDRO
			BTFSS	HORDEC,1
			GOTO	SANDRO
			CLRF	HORDEC
			CLRF	HORUNI
			GOTO	SANDRO				
ALFREDO		CLRF	HORUNI
			INCF	HORDEC,1
			GOTO	SANDRO



FECHAI	BCF		CONTROL,0
		BCF		CONTROL2,0


FECHA	BTFSS	PA,0		;VALIDO SI QUIERE AJUSTA DIA
		GOTO	DIA	
		BTFSS	PA,1		;VALIDO SI QUIERE AJUSTA MES
		GOTO	MES	
		BCF		NICOLA,0
		BTFSS	PA,3
		BSF		CONTROL2,0
		BTFSS	PA,4
		BSF		CONTROL,0
		BTFSC	CONTROL,0
		GOTO	CMFH
		BTFSC	CONTROL2,0
		GOTO	CMFS
N9		BTFSS	MODO,0	
		GOTO	SAMUELI
		BTFSC	MODO,1	
		GOTO	CRONOMI	;CAMBIAR POR LA FUNCION INICIAL DE VER SEGUNDOS
FECHA2	MOVF	MESUNI,0
		MOVWF	PB
		BSF		PB,7
		CALL	RETARDO
		BCF		PB,7
		MOVF	MESDEC,0
		MOVWF	PB
		BSF		PB,6
		CALL	RETARDO
		BCF		PB,6
		MOVF	DIAUNI,0
		MOVWF	PB
		BSF		PB,5
		CALL	RETARDO
		BCF		PB,5
		MOVF	DIADEC,0
		MOVWF	PB
		BSF		PB,4
		CALL	RETARDO
		BCF		PB,4
		GOTO    FECHA	
	
CMFH	BTFSC	PA,4
		DECF	MODO,1
		GOTO	N9
CMFS	BTFSC	PA,3
		INCF	MODO,1
		GOTO	N9


DIA			BTFSC	NICOLA,0
			GOTO	FECHA2
			BSF		NICOLA,0
			CALL	INCDIA
			GOTO	FECHA2

MES			BTFSC	NICOLA,0
			GOTO	FECHA2
			BSF		NICOLA,0
			CALL	INCMES
			GOTO	FECHA2


SEGUI	BCF		CONTROL2,0
		BCF		CONTROL,0
		BCF		CONTROL3,0

SEGUN	BTFSS	PA,0		
		GOTO	CLRSEG
		BCF		NICOLA,0
		BTFSS	PA,1
		BSF		CONTROL3,0
		BTFSS	PA,4
		BSF		CONTROL,0
		BTFSS	PA,3
		BSF		CONTROL2,0
		BTFSC	CONTROL2,0
		GOTO	CMSH
		BTFSC	CONTROL,0
		GOTO	CMSF
		BTFSC	CONTROL3,0
		GOTO	CMSC
N11		BTFSS	MODO,1	
		GOTO	COMPMOD
		BTFSC	MODO,0
		GOTO	CRONOMI
SEGUN2	MOVF	SEGUNI,0
		MOVWF	PB
		BSF		PB,7
		CALL	RETARDO
		BCF		PB,7
		MOVF	SEGDEC,0
		MOVWF	PB
		BSF		PB,6
		CALL	RETARDO
		BCF		PB,6
		GOTO    SEGUN

COMPMOD	BTFSS	MODO,0
		GOTO	SAMUELI
		GOTO	FECHAI
	
CMSH	BTFSC	PA,3
		CLRF	MODO
		GOTO	N11

CMSC	BTFSC	PA,1
		INCF	MODO,1
		GOTO	N11

CMSF	BTFSC	PA,4
		CLRF	MODO
		BTFSC	PA,4
		BSF		MODO,0
		GOTO	N11

CLRSEG	BTFSC	NICOLA,0
		GOTO	SEGUN2
		BSF		NICOLA,0
		CLRF	SEGUNI
		CLRF	SEGDEC
		GOTO	SEGUN2




CRONOMI	BCF		CONTROL3,0
		BCF		CONTROL,0

CRONOM	BTFSS	PA,0		
		GOTO	COMPINI			
		BTFSS	PA,3
		GOTO	CLRCRO
		BCF		NICOLA,0
		BTFSS	PA,4
		BSF		CONTROL,0
		BTFSS	PA,1
		BSF		CONTROL3,0
		BTFSC	CONTROL3,0
		GOTO	CMCS
		BTFSC	CONTROL,0
		GOTO	CMCRM
N10		BTFSC	MODO,2	
		GOTO	REJMUNI
		BTFSS	MODO,0	
		GOTO	SEGUI
		
CRONOM2	MOVF	SUNICR,0
		MOVWF	PB
		BSF		PB,7
		CALL	RETARDO
		BCF		PB,7
		MOVF	SDECCR,0
		MOVWF	PB
		BSF		PB,6
		CALL	RETARDO
		BCF		PB,6
		MOVF	MUNICR,0
		MOVWF	PB
		BSF		PB,5
		CALL	RETARDO
		BCF		PB,5
		MOVF	MDECCR,0
		MOVWF	PB
		BSF		PB,4
		CALL	RETARDO
		BCF		PB,4
		GOTO    CRONOM	

COMPINI	BTFSC	NICOLA,0
		GOTO	CRONOM2
		BSF		NICOLA,0
		BTFSS	INICRO,0
		GOTO 	CRON
		GOTO	CROFF

CROFF	BCF		INICRO,0
		GOTO	CRONOM2

CRON	BSF		INICRO,0
		GOTO	CRONOM2
		
	
CMCS	BTFSC	PA,1
		GOTO	RETUR
		GOTO	N10

CMCRM	BTFSC	PA,4
		GOTO	RETUR2
		GOTO	N10

RETUR	DECF	MODO,1
		CLRF	SUNICR
		CLRF	SDECCR
		CLRF	MUNICR
		CLRF	MDECCR
		BCF		INICRO,0
		GOTO	N10

RETUR2	INCF	MODO,1
		CLRF	SUNICR
		CLRF	SDECCR
		CLRF	MUNICR
		CLRF	MDECCR
		BCF		INICRO,0
		GOTO	N10

CLRCRO	BTFSC	NICOLA,0
		GOTO	CRONOM2
		BSF		NICOLA,0
		CLRF	SUNICR
		CLRF	SDECCR
		CLRF	MUNICR
		CLRF	MDECCR
		BCF		INICRO,0
		MOVLW	D'100'
		MOVWF	VARCRO	
		GOTO	CRONOM2


REJMUNI	CLRF	CONTROL
		CLRF	ZONAH
		INCF	ZONAH
	

RELMUN	BTFSS	PA,0
		BSF		ZONAH,0
		BTFSS	PA,0
		BCF		ZONAH,1
		BTFSS	PA,0
		BCF		ZONAH,2
		BTFSS	PA,1
		BSF		ZONAH,1
		BTFSS	PA,1
		BCF		ZONAH,0
		BTFSS	PA,1
		BCF		ZONAH,2
		BTFSS	PA,3
		BSF		ZONAH,2
		BTFSS	PA,3
		BCF		ZONAH,1
		BTFSS	PA,3
		BCF		ZONAH,0
		BTFSS	PA,4
		BSF		CONTROL,0
		BTFSC	CONTROL,0
		GOTO	CMRMC
		
N21		BTFSS	MODO,2
		GOTO	CRONOMI

		MOVF	MINUNI,0
		MOVWF	MINUNIZ
		MOVF	MINDEC,0
		MOVWF	MINDECZ
		MOVF	HORUNI,0
		MOVWF	HORUNIZ
		MOVF	HORDEC,0
		MOVWF	HORDECZ

		BTFSC	ZONAH,0
		GOTO	MADRID
		BTFSC	ZONAH,1
		GOTO	CHINA
		BTFSC	ZONAH,2
		GOTO	LONDRES
		
IMPH	MOVF	MINUNIZ,0
		MOVWF	PB
		BSF		PB,7
		CALL	RETARDO
		BCF		PB,7
		MOVF	MINDECZ,0
		MOVWF	PB
		BSF		PB,6
		CALL	RETARDO
		BCF		PB,6
		MOVF	HORUNIZ,0
		MOVWF	PB
		BSF		PB,5
		CALL	RETARDO
		BCF		PB,5
		MOVF	HORDECZ,0
		MOVWF	PB
		BSF		PB,4
		CALL	RETARDO
		BCF		PB,4
		GOTO    RELMUN


MADRID	MOVLW	D'6'
		MOVWF	CONTZ
		GOTO	HORAZ
	

CHINA	MOVLW	D'12'
		MOVWF	CONTZ
		GOTO	HORAZ


LONDRES MOVLW	D'5'
		MOVWF	CONTZ
		GOTO	HORAZ



CMRMC	BTFSC	PA,4
		DECF	MODO,1
		GOTO	N21


HORAZ	
			INCF	HORUNIZ,1	
			MOVF	HORUNIZ,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	MARIAPAOLAZ
			GOTO	ALFREDOZ
MARIAPAOLAZ	MOVF	HORUNIZ,0
			SUBLW	D'4'
			BTFSS	STATUS,2
			GOTO	RETZ
			BTFSS	HORDECZ,1
			GOTO	RETZ
			CLRF	HORDECZ
			CLRF	HORUNIZ
			GOTO	RETZ				
ALFREDOZ	CLRF	HORUNIZ
			INCF	HORDECZ,1

RETZ		DECFSZ	CONTZ,1
			GOTO	HORAZ
			GOTO	IMPH
;METODOS DE FECHA


INCDIA		MOVF	MESDEC,0
			SUBLW	D'1'
			BTFSS	STATUS,2
			GOTO 	INC0
			GOTO	INC1
INC0		MOVF	MESUNI,0
			SUBLW	D'1'
			BTFSC	STATUS,2
			GOTO	DIA31		
			MOVF	MESUNI,0
			SUBLW	D'2'
			BTFSC	STATUS,2
			GOTO	DIA28
			MOVF	MESUNI,0
			SUBLW	D'3'
			BTFSC	STATUS,2
			GOTO	DIA31
			MOVF	MESUNI,0
			SUBLW	D'4'
			BTFSC	STATUS,2
			GOTO	DIA30
			MOVF	MESUNI,0
			SUBLW	D'5'
			BTFSC	STATUS,2
			GOTO	DIA31
			MOVF	MESUNI,0
			SUBLW	D'6'
			BTFSC	STATUS,2
			GOTO	DIA30
			MOVF	MESUNI,0
			SUBLW	D'7'
			BTFSC	STATUS,2
			GOTO	DIA31
			MOVF	MESUNI,0
			SUBLW	D'8'
			BTFSC	STATUS,2
			GOTO	DIA31
			MOVF	MESUNI,0
			SUBLW	D'9'
			BTFSC	STATUS,2
			GOTO	DIA30
INC1		MOVF	MESUNI,0
			SUBLW	D'0'
			BTFSC	STATUS,2
			GOTO	DIA31
			MOVF	MESUNI,0
			SUBLW	D'1'
			BTFSC	STATUS,2
			GOTO	DIA30
			MOVF	MESUNI,0
			SUBLW	D'2'
			BTFSC	STATUS,2
			GOTO	DIA31

RET			RETURN

DIA30		CALL	INCDIA30
			GOTO	RET

DIA31		CALL	INCDIA31
			GOTO	RET

DIA28		CALL	INCDIA28
			GOTO	RET



INCDIA30	BCF		CAMBIO,0
			INCF	DIAUNI,1	
			MOVF	DIAUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	CDU
			GOTO	PDD
CDU			MOVF	DIAUNI,0
			SUBLW	D'1'
			BTFSS	STATUS,2
			RETURN
			MOVF	DIADEC,0
			SUBLW	D'3'
			BTFSS	STATUS,2
			RETURN
			CLRF	DIADEC
			CLRF	DIAUNI
			INCF	DIAUNI,1
			BSF		CAMBIO,0
			RETURN				
PDD			CLRF	DIAUNI
			INCF	DIADEC,1
			RETURN


INCDIA28	BCF		CAMBIO,0
			INCF	DIAUNI,1	
			MOVF	DIAUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	CDU3
			GOTO	PDD3
CDU3		MOVF	DIAUNI,0
			SUBLW	D'9'
			BTFSS	STATUS,2
			RETURN
			MOVF	DIADEC,0
			SUBLW	D'2'
			BTFSS	STATUS,2
			RETURN
			CLRF	DIADEC
			CLRF	DIAUNI
			INCF	DIAUNI,1
			BSF		CAMBIO,0
			RETURN				
PDD3		CLRF	DIAUNI
			INCF	DIADEC,1
			RETURN




INCDIA31	BCF		CAMBIO,0
			INCF	DIAUNI,1	
			MOVF	DIAUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	CDU2
			GOTO	PDD2
CDU2		MOVF	DIAUNI,0
			SUBLW	D'2'
			BTFSS	STATUS,2
			RETURN
			MOVF	DIADEC,0
			SUBLW	D'3'
			BTFSS	STATUS,2
			RETURN
			CLRF	DIADEC
			CLRF	DIAUNI
			INCF	DIAUNI,1
			BSF		CAMBIO,0
			RETURN				
PDD2		CLRF	DIAUNI
			INCF	DIADEC,1
			RETURN


INCMES		INCF	MESUNI,1	
			MOVF	MESUNI,0
			SUBLW	D'10'
			BTFSS	STATUS,2
			GOTO	CDU4
			GOTO	PDD4
CDU4		MOVF	MESUNI,0
			SUBLW	D'3'
			BTFSS	STATUS,2
			RETURN
			MOVF	MESDEC,0
			SUBLW	D'1'
			BTFSS	STATUS,2
			RETURN
			CLRF	MESDEC
			CLRF	MESUNI
			INCF	MESUNI,1
			RETURN				
PDD4		CLRF	MESUNI
			INCF	MESDEC,1
			RETURN




        
        ORG     4			;VECTOR DE INTERRUPCION
        GOTO    INTER		;SALTA A LA RUTINA A EJECUTAR CUANDO LLEGA LA INTERRUPCION

INTER   ORG     267
        DECFSZ  VAR,1		;DECREMENTA EN 1 LA VARIABLE DE CONTEO (VAR) Y SI EL RESULTADO ES CERO SALTA UNA LINEA
        GOTO    N3			;EL RESULTADO DE LA VARIABLE ES DISTINTO DE CERO
        GOTO    SEG			;EL RESULTADO DE LA RESTA ES CERO Y SI ES ASI ACABA DE PASAR UN SEGUNDO
N3      BTFSC	INICRO,0
		GOTO	INCCRO
N5		MOVLW   d'217'		;MOVIENDO EL VALOR DE 217 A W
        MOVWF   TMR0		;PRECARGANDO EL TIMER EN 217
        BCF     INTCON,2	;APAGANDO LA BANDERA DE LA INTERRUPCION DE DESBORDAMIENTO DEL TIMER
        MOVF	JOYCE,0
        RETFIE			;SALIENDO DE LA INTERRUPCION

INCCRO	DECFSZ  VARCRO,1
		GOTO 	N5
		GOTO	SEGCRO


SEGCRO	INCF	SUNICR,1	;SEGUNI=SEGUNI+1
		MOVF	SUNICR,0	;W=SEGUNI
		SUBLW	D'10'		;W=10-W
		BTFSS	STATUS,2	;SI EL FLAG ES 1 EL RESULTADO FUE 0 Y SEGUNI=10
		GOTO	N4
		CLRF	SUNICR
		INCF	SDECCR,1	;SEGDEC=SEGDEC+1
		MOVF	SDECCR,0	;W=SEGDEC
		SUBLW	D'6'
		BTFSS	STATUS,2
		GOTO	N4
		CLRF	SDECCR
		INCF	MUNICR,1
		MOVF	MUNICR,0
		SUBLW	D'10'
		BTFSS	STATUS,2
		GOTO	N4
		CLRF	MUNICR
		INCF	MDECCR,1
		MOVF	MDECCR,0
		SUBLW	D'6'
		BTFSS	STATUS,2
		GOTO	N4
		CLRF	MDECCR
		GOTO	N4

N4		MOVLW   D'100'		;MOVIENDO EL VALOR DE 100 A W
        MOVWF   VARCRO			;CARGANDO LA VARIABLE DE CONTEO A 100
        GOTO    N3	

SEG     BTFSC   PA,2		;PREGUNTANDO SI EN BIT0 DEL PUERTO A ES CERO (SI ES CIERTO SALTA UNA LINEA)
        GOTO    OFF			;COMO EL BIT0 ES 1 ENTONCES SALTAMOS A LA ETIQUETA OFF
        BSF     PA,2		;COMO EL BIT0 ERA 0 ENTONCES LO COLOCAMOS EN 1
        GOTO    SEG1			;SALTAMOS A LA ETIQUETA N2
OFF     BCF     PA,2		;EN ESTA INSTRUCCION PONEMOS A 0 AL BIT0 DEL PUERTO A
SEG1    MOVWF	JOYCE
		INCF	SEGUNI,1	;SEGUNI=SEGUNI+1
		MOVF	SEGUNI,0	;W=SEGUNI
		SUBLW	D'10'		;W=10-W
		BTFSS	STATUS,2	;SI EL FLAG ES 1 EL RESULTADO FUE 0 Y SEGUNI=10
		GOTO	N2
		CLRF	SEGUNI
		INCF	SEGDEC,1	;SEGDEC=SEGDEC+1
		MOVF	SEGDEC,0	;W=SEGDEC
		SUBLW	D'6'
		BTFSS	STATUS,2
		GOTO	N2
		CLRF	SEGDEC
		INCF	MINUNI,1
		MOVF	MINUNI,0
		SUBLW	D'10'
		BTFSS	STATUS,2
		GOTO	N2
		CLRF	MINUNI
		INCF	MINDEC,1
		MOVF	MINDEC,0
		SUBLW	D'6'
		BTFSS	STATUS,2
		GOTO	N2
		CLRF	MINDEC
		INCF	HORUNI,1	
		MOVF	HORUNI,0
		SUBLW	D'10'
		BTFSS	STATUS,2
		GOTO	GIAN
		GOTO	DANIEL
GIAN	MOVF	HORUNI,0
		SUBLW	D'4'
		BTFSS	STATUS,2
		GOTO	N2
		BTFSS	HORDEC,1
		GOTO	N2
		CLRF	HORDEC
		CLRF	HORUNI
		GOTO	PASODIA
		GOTO	N2				
DANIEL	CLRF	HORUNI
		INCF	HORDEC,1		
		GOTO	N2
PASODIA	CALL	INCDIA
		BTFSC	CAMBIO,0
		GOTO	PASOMES
		GOTO	N2
PASOMES	BCF		CAMBIO,0
		CALL	INCMES		
N2		MOVLW   D'100'		;MOVIENDO EL VALOR DE 100 A W
        MOVWF   VAR			;CARGANDO LA VARIABLE DE CONTEO A 100
        GOTO    N3			;SALTANDO A LA ETIQUETA N3

        END
        

