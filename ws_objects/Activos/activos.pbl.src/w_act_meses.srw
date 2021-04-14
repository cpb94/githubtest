$PBExportHeader$w_act_meses.srw
forward
global type w_act_meses from w_int_con_empresa
end type
type cb_1 from u_boton within w_act_meses
end type
type cb_2 from u_boton within w_act_meses
end type
type uo_marca from u_marca_lista within w_act_meses
end type
type uo_ejercicio from u_ejercicio within w_act_meses
end type
type st_1 from statictext within w_act_meses
end type
type uo_marca2 from u_marca_lista within w_act_meses
end type
type st_2 from statictext within w_act_meses
end type
type dw_1 from u_datawindow_consultas within w_act_meses
end type
type pb_1 from picturebutton within w_act_meses
end type
type pb_2 from picturebutton within w_act_meses
end type
type cb_3 from u_boton within w_act_meses
end type
type cb_4 from u_boton within w_act_meses
end type
type em_fconta from u_em_campo within w_act_meses
end type
type st_11 from statictext within w_act_meses
end type
type st_3 from statictext within w_act_meses
end type
type em_asiento from u_em_campo within w_act_meses
end type
end forward

shared variables

end variables

global type w_act_meses from w_int_con_empresa
integer width = 2857
integer height = 1764
string title = "Actualizacón por Meses"
cb_1 cb_1
cb_2 cb_2
uo_marca uo_marca
uo_ejercicio uo_ejercicio
st_1 st_1
uo_marca2 uo_marca2
st_2 st_2
dw_1 dw_1
pb_1 pb_1
pb_2 pb_2
cb_3 cb_3
cb_4 cb_4
em_fconta em_fconta
st_11 st_11
st_3 st_3
em_asiento em_asiento
end type
global w_act_meses w_act_meses

type variables
w_lista	sc_lista[12]
integer	mes
end variables

forward prototypes
public subroutine f_proceso ()
public subroutine f_marca_meses (string empresa, string ejercicio)
public function integer f_mes (string fmes)
public subroutine f_muestraamort (string empresa, string ejercicio, string fmes)
public subroutine f_marcaamort (string empresa, string ejercicio, string fmes)
public subroutine f_muestraasiento (string empresa, string ejercicio)
public function boolean f_asientos (string empresa, decimal ejercicio, datetime fechacon, ref str_contaapun conapu, ref boolean abortar)
public function boolean f_asientos_analitica (string empresa, decimal ejercicio, datetime fechacon, ref boolean abortar)
end prototypes

public subroutine f_proceso ();/*
------------------------------------------------------------------------
FUNCTION MuestraAsiento(xempresa,xejercicio)
------------------------------------------------------------------------
  DEFINE xempresa,xejercicio decimal(4,0),
	dasiento LIKE contaapun.asiento,
	fechacon date,
	bien char(1),
	am RECORD LIKE act_amortizaciones.*,
	sc_datos  ARRAY [12] OF RECORD 
 	  cuenta  char(15),
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	sc_lista  ARRAY [12] OF RECORD 
 	  cuenta  char(15),
	  descripcion  LIKE act_bienesdet.descripcion,
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	apu RECORD 
 	  cuenta  char(15),
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	tecla char,
	numfila		decimal(15,0),
	linpant, m, n	integer,
	maxlin, contador, i, fintabla, iniciotabla, salida smallint,
	titulo char(50),
	t1,t2,t3,t4  char(15),
	numtotal	smallint,
	counter		smallint,
	hay    		smallint,
	abortar		smallint

OPEN WINDOW w4 AT 5,3 WITH FORM "act022p4"
ATTRIBUTE (border,message line 2)
LET titulo = "VISUALIZACION DEL ASIENTO RESUMIDO"
let t1="CUENTA"
let t2="DEBE"
let t3="HABER"
DISPLAY BY NAME titulo,t1,t2,t3 attribute(reverse,cyan)

INSERT INTO tmp_apun
 SELECT cuenta_cargo,SUM(importe_amor),0
   FROM tmp_amor
  GROUP BY 1,3
INSERT INTO tmp_apun
 SELECT cuenta_abono,0,SUM(importe_amor)
   FROM tmp_amor
  GROUP BY 1,2
DECLARE capunt SCROLL CURSOR FOR
 SELECT * FROM tmp_apun
 
OPEN capunt  
LET counter=1
LET salida=0
LET m=1
LET fintabla=0
LET maxlin = 12

WHILE TRUE
    FOR i=1 TO maxlin STEP 1
	  LET n=(m-1)*maxlin+counter
	  FETCH ABSOLUTE n capunt INTO apu.*
	IF status=100 THEN LET fintabla=1
			   EXIT FOR
	END IF

	LET sc_datos[counter].cuenta = apu.cuenta
	LET sc_datos[counter].debe   = apu.debe
	LET sc_datos[counter].haber  = apu.haber

	LET sc_lista[counter].cuenta = apu.cuenta
	LET sc_lista[counter].debe   = apu.debe
	LET sc_lista[counter].haber  = apu.haber
	LET cond = "contaplan.ejercicio =",xejercicio
	LET sc_lista[counter].descripcion = 
		des_cod("contaplan","cuenta",apu.cuenta,"titulo",cond)
	LET counter=counter+1
    END FOR
    LET numtotal = counter - 1
    IF numtotal = 0 AND m = 1 THEN
		CALL mensaje(0,-3,"NO Hay Apuntes  !")
			RETURNING oky
		LET salida = 2
		EXIT WHILE
    END IF

    CALL win_teclas_p(counter,maxlin,m,6,10,"1Confirma,2Adelante,3Atras,8 Salir")

     FOR i = 1 TO numtotal 
	DISPLAY sc_lista[i].* TO sc_act022p4[i].* attribute(green) 
     END FOR 
     LET counter = 1 
     INPUT BY NAME tecla attribute(black) 
	BEFORE FIELD tecla
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
				attribute(reverse,white,blink)
	AFTER FIELD tecla
	NEXT FIELD tecla

	ON KEY (up)
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
						attribute(green)
	IF counter > 1 THEN  LET counter = counter -1 END IF 
	NEXT FIELD tecla

	ON KEY (down,tab)
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
						attribute(green)
	IF counter < numtotal THEN LET counter = counter + 1 END IF
	NEXT FIELD tecla 

	ON KEY  (F1,CONTROL-F)
	  
	 LET salida = 1
	 EXIT INPUT

	ON KEY (F2,CONTROL-G)
	IF fintabla=0 THEN LET m=m+1 
	   CLOSE capunt OPEN capunt 
	   EXIT INPUT  
         ELSE NEXT FIELD tecla	
	END IF

	ON KEY (F3,CONTROL-V)
	LET m=m-1
	IF m=0 THEN	LET m=1 
			NEXT FIELD tecla
	       ELSE 	CLOSE capunt OPEN capunt 
			EXIT INPUT 
	END IF
  
	ON KEY (escape,f8)
	LET salida=2
	EXIT INPUT  

     END INPUT
     IF salida=2 or salida = 1 THEN EXIT WHILE END IF  

     LET fintabla=0
     LET counter=1
     FOR i=1 TO numtotal
          INITIALIZE sc_datos[i].* TO NULL
	  CLEAR sc_act022p4[i].* 
     END FOR
END WHILE
IF salida = 1 THEN 
  LET abortar = FALSE
  BEGIN  WORK
  LET fechacon = TODAY
  INPUT BY NAME fechacon
   AFTER FIELD fechacon  
     IF fechacon IS null THEN
       NEXT FIELD fechacon
     END IF
     CALL compruebafecconta(fechacon,YEAR(fechacon)) 
        RETURNING bien,abortar
     IF bien = "N" THEN
	 ERROR "FECHA CONTABLE NO ACCESIBLE"
	 NEXT FIELD fechacon
     END IF
  END INPUT 
  IF NOT abortar THEN
    CALL asientos(xempresa,xejercicio,fechacon) 
	  RETURNING dasiento,abortar

    IF NOT abortar THEN
      DECLARE curupd  CURSOR FOR
       SELECT * FROM tmp_amor
      FOREACH curupd INTO am.*
        UPDATE act_amortizaciones
           SET (actualizado,asiento,fecha_contable) =
	  ("S",dasiento,fechacon)
         where act_amortizaciones.empresa = am.empresa
           and act_amortizaciones.elemento = am.elemento
           and act_amortizaciones.amortizacion = am.amortizacion
        IF STATUS <> 0 then
    CALL mensaje(0,-3,"No Actualizo Amortizaciones , Error!!") 
						RETURNING oky
	  LET abortar = TRUE
        END IF
      END FOREACH
    END IF
  END IF
  IF NOT abortar THEN COMMIT WORK
    ELSE
     ROLLBACK WORK
  END IF
END IF
CLEAR t1,t2,t3,titulo
FOR i=1 TO numtotal CLEAR sc_act022p4[i].* END FOR
CLOSE WINDOW  w4
END FUNCTION
-----------------------------------------------------------------------
 FUNCTION asientos(xempresa,xejercicio,fechacon)
-----------------------------------------------------------------------
   DEFINE 
	xejercicio,xempresa decimal(4,0),
	fechacon date,
	conapu		RECORD LIKE contaapun.*,
	apun		RECORD LIKE genapunte.*,
	asientin	LIKE contaparam.asiento,
	apuntin		decimal(7,0),
	abortar		smallint

LET abortar = false

CALL CojoAsiento(xempresa,YEAR(fechacon)) RETURNING abortar,asientin
IF abortar THEN
	RETURN abortar
END IF
				   ----- relleno contaapun -----
				   ----- con valores comunes ---
				   -----      para         -----
				   ----- todos los apuntes -----
CALL RellenoApunte(xempresa,YEAR(fechacon), asientin) 
						RETURNING conapu.*
LET conapu.fapunte     = fechacon
LET conapu.fvalor      = fechacon
LET conapu.fregistro   = fechacon
LET apuntin            = 0

DECLARE curvafin CURSOR FOR SELECT cuenta,debe,haber
   FROM tmp_apun
 ORDER by cuenta desc
FOREACH curvafin INTO conapu.cuenta,conapu.debe,conapu.haber
 IF conapu.cuenta IS null THEN
   CALL mensaje(0,-3,"Cta. No definida. No se Procesa !!")
			RETURNING oky
   LET abortar = true
   RETURN 0,abortar
 END IF
 IF conapu.debe > 0 THEN
				------ apunte de debe----
   CALL LeoApunte(xempresa,101) RETURNING apun.*, abortar
   IF abortar = true THEN
    CALL mensaje(0,-3,"No grabo Asiento , Error linea 857!!") 
						RETURNING oky
	RETURN 0,abortar
   END IF
  LET conapu.apunte	= apuntin + 1
  LET conapu.cuenta   	= conapu.cuenta
  LET conapu.concepto 	= apun.concepto
  LET conapu.ampliacion	= "AMORTIZACION A ",fechacon USING "dd-mm-yyyy"
  LET conapu.diario       = apun.tipodiario
  CALL DH(apun.dh,conapu.debe) RETURNING conapu.debe, conapu.haber
  CALL GraboApunte(conapu.*) RETURNING abortar
  IF abortar THEN
    CALL mensaje(0,-3,"No grabo Asiento , Error!!") 
						RETURNING oky
    RETURN 0,abortar
  END IF

  ELSE
				------ apunte de debe----
   CALL LeoApunte(xempresa,102) RETURNING apun.*, abortar
   IF abortar = true THEN
    CALL mensaje(0,-3,"No grabo Asiento , Error linea 865!!") 
						RETURNING oky
	RETURN 0,abortar
   END IF
   CALL LeoApunte(xempresa,102) RETURNING apun.*, abortar
   IF abortar = true THEN
    CALL mensaje(0,-3,"No grabo Asiento , Error linea 865!!") 
						RETURNING oky
	RETURN 0,abortar
   END IF
  LET conapu.apunte	= apuntin + 1
  LET conapu.cuenta   	= conapu.cuenta
  LET conapu.concepto 	= apun.concepto
  LET conapu.ampliacion	= "AMORTIZACION A ",fechacon USING "dd-mm-yyyy"
  LET conapu.diario       = apun.tipodiario
  CALL DH(apun.dh,conapu.haber) RETURNING conapu.debe, conapu.haber
  CALL GraboApunte(conapu.*) RETURNING abortar
  IF abortar THEN
    CALL mensaje(0,-3,"No grabo Asiento , Error!!") 
						RETURNING oky
    RETURN 0,abortar
  END IF
 END IF
  LET apuntin = apuntin + 1
END FOREACH
RETURN asientin,abortar
END FUNCTION
*/
end subroutine

public subroutine f_marca_meses (string empresa, string ejercicio);String	cadena,tit,t1,t2,t3
DataStore	ds_meses
Integer	counter,salida,m,maxlin,i,n,numtotal,rr,xx
Boolean	fintabla

tit = "ESCOGER MES A CONTABILIZAR"
t1 = "MES A ACTUALIZAR"
t2 = "Amortizaciones"
t3 = "Importe Amortizaciones"

cadena = "SELECT fecha_amor as fecha ,count(*) as cuenta," +&
			" sum(importe_amor) as suma" +&
     		" FROM act_amortizaciones" +&
   		" WHERE act_amortizaciones.empresa= '" + empresa + "'" +&
     		" AND act_amortizaciones.ejercicio = " + uo_ejercicio.em_ejercicio.text +&
     		" AND act_amortizaciones.actualizado IN ('N','A')" + &
   		" GROUP BY fecha_amor ORDER BY fecha_amor"

//ds_meses = f_cargar_cursor(cadena)
f_cargar_cursor_nuevo(cadena, ds_meses)
rr = ds_meses.RowCount()
counter=1
salida=0
m=1
fintabla=False
maxlin = 12

FOR i=1 TO maxlin //de 1 a 12
	sc_lista[i].nommes = f_nombre_mes(i) 			
	sc_lista[i].amortizaciones  = 0
	sc_lista[i].importes  = 0
NEXT

IF rr>0 then
//	f_mensaje("debug",string(rr) + " registros")
	FOR i=1 TO rr //de 1 a 12
		long cuenta
		datetime fecha
//		IF i<=rr then 
			cuenta = ds_meses.GetItemDecimal(i,"cuenta")
			If isnull(cuenta) or cuenta = 0	then exit
			fecha = ds_meses.GetItemDateTime(i,"fecha")
			if not isnull(fecha) then 
				n = Month(Date(fecha))				
				sc_lista[n].nummes = n
				sc_lista[n].amortizaciones = sc_lista[n].amortizaciones + ds_meses.GetItemDecimal(i,"cuenta")
				sc_lista[n].importes  = sc_lista[n].importes + ds_meses.GetItemDecimal(i,"suma")
				
				// **** La función f_smes no está, pero parece que lo que hará, será 
				// devolver el nombre del mes
	//			sc_lista[n].nommes = f_nombre_mes(n) 			
//				f_mensaje("debug",string(fecha) +char(13) + string(n) +char(13) + string(sc_lista[n].amortizaciones) +char(13) +&
//							string(sc_lista[n].importes) +char(13) +sc_lista[n].nommes)
				counter=counter+1
			Else
				messagebox("fecha inutil","")
			End If
//		End If
	NEXT
END IF

//f_mensaje("debug","Fin de la 1ª parte del proceso")

numtotal = counter - 1
IF numtotal = 0 AND m = 1 THEN
	f_mensaje("Aviso","NO Hay Amortizaciones Pendientes !")
	salida = 2
//  RETURN 0,0,0,0
ELSE
  FOR i = maxlin to 1 step - 1
//		If sc_lista[i].nummes = i then
			uo_marca.dw_marca.InsertRow(1)
			uo_marca.dw_marca.SetItem(1,"codigo",sc_lista[i].nommes)
			cadena = String(sc_lista[i].amortizaciones) + " Am. (" +&
						String(sc_lista[i].importes,f_mascara_moneda(f_paramemp_moneda_emp( empresa ))) +&
						 + " " + f_nombre_moneda_abr(f_paramemp_moneda_emp( empresa )) + ")"
//			f_mensaje("debug",sc_lista[i].nommes+char(13) + cadena)
			uo_marca.dw_marca.SetItem(1,"texto",cadena)		
//		End If
  NEXT 
  counter = 1 
end if

destroy ds_meses
end subroutine

public function integer f_mes (string fmes);Integer	xmes

CHOOSE CASE lower(fmes)
 CASE "enero"
	xmes = 1		
 CASE "febrero"
	xmes = 2
 CASE "marzo"
	xmes = 3		
 CASE "abril"
	xmes = 4		
 CASE "mayo"
	xmes = 5		
 CASE "junio"
	xmes = 6		
 CASE "julio"
	xmes = 7		
 CASE "agosto"
	xmes = 8		
 CASE "septiembre"
	xmes = 9		
 CASE "octubre"
	xmes = 10		
 CASE "noviembre"
	xmes = 11		
 CASE "diciembre"
	xmes = 12		
END CHOOSE

Return xmes
end function

public subroutine f_muestraamort (string empresa, string ejercicio, string fmes);DateTime		inicio,fin
Integer		xx,ii,marcados,elementos[]
String		codigo

ii = uo_marca2.dw_marca.RowCount()

If ii = 0 then return

marcados = 0
For xx = 1 to ii
	If f_valor_columna(uo_marca2.dw_marca,xx,"marca") = "S" then
		codigo = f_valor_columna(uo_marca2.dw_marca,xx,"codigo")		
		marcados = marcados + 1
		elementos[marcados] = Dec(codigo)
	End If
Next

If marcados = 0 then return

inicio = DateTime(mdy(integer(fmes),1,integer(ejercicio)))
If fmes = '12' then
	fin = DateTime(mdy(12,31,integer(ejercicio)))
Else
	// ultimo dia del mes
	fin = DateTime(RelativeDate(mdy(integer(fmes)+1,1,integer(ejercicio)),-1))
End If

dw_1.Reset()
dw_1.Retrieve(empresa,integer(ejercicio),elementos[],inicio,fin)
end subroutine

public subroutine f_marcaamort (string empresa, string ejercicio, string fmes);String		cadena,c1,c2,fin
DataStore	ds_amort
Integer		xx,rr

//f_mensaje("debug",empresa + char(13) + ejercicio + char(13) +fmes)

If fmes = '12' then
//	fin = '12/31/'+ ejercicio + " 00:00:00"
	fin = '31/12/'+ ejercicio 
Else
	// ultimo dia del mes
//	fin = fmes + '/' + String(Day(RelativeDate(Date(integer(ejercicio),integer(fmes)+1,1),-1))) + '/' + ejercicio + " 00:00:00"
	fin = String(Day(RelativeDate(Date(integer(ejercicio),integer(fmes)+1,1),-1))) +'/'+fmes + '/' + ejercicio 
End If
// Esta sentencia no funciona en Informix
//cadena = "SELECT elemento, importe_amor FROM act_amortizaciones" +&
//  			" WHERE act_amortizaciones.empresa = '" + empresa +"'" +&
// 		   " AND act_amortizaciones.ejercicio = " + ejercicio +&
//			" and act_amortizaciones.actualizado IN ('N','A')" +&
//			" AND act_amortizaciones.fecha_amor >= '" + &
//			fmes + '/1/' + ejercicio +  " 00:00:00' and" +&
//			" act_amortizaciones.fecha_amor <= '" + fin + "' ORDER BY elemento DESC"

// Esta otra sí que funciona
cadena = "SELECT elemento,amortizacion,importe_amor FROM act_amortizaciones" +&
  			" WHERE act_amortizaciones.empresa = '" + empresa +"'" +&
 		   " AND act_amortizaciones.ejercicio = " + ejercicio +&
			" and act_amortizaciones.actualizado IN ('N','A')" +&
			" AND act_amortizaciones.fecha_amor between" +&
			" '1/" + fmes + '/' + ejercicio + "' and" +&
			" '" + fin + "' ORDER BY elemento DESC"

//ds_amort = f_cargar_cursor(cadena)
f_cargar_cursor_nuevo(cadena, ds_amort)

rr = ds_amort.RowCount()

//f_mensaje("debug",string(rr) + " registros" + char(13) + cadena)

uo_marca2.dw_marca.Reset()

For xx = 1 to rr
	uo_marca2.dw_marca.InsertRow(1)
	c1 = String(ds_amort.GetItemDecimal(xx,"elemento"))
	c2 = String(ds_amort.GetItemDecimal(xx,"importe_amor"),f_mascara_moneda(f_paramemp_moneda_emp( empresa ))) +&
		 + " " + f_nombre_moneda_abr(f_paramemp_moneda_emp( empresa )) 
	uo_marca2.dw_marca.SetItem(1,"codigo",c1)
	uo_marca2.dw_marca.SetItem(1,"texto",c2)	
//	f_mensaje("debug",c1 + char(13) + c2)	
Next

Destroy ds_amort
end subroutine

public subroutine f_muestraasiento (string empresa, string ejercicio);

/*  DEFINE xempresa,xejercicio decimal(4,0),
	dasiento LIKE contaapun.asiento,
	fechacon date,
	bien char(1),
	am RECORD LIKE act_amortizaciones.*,
	sc_datos  ARRAY [12] OF RECORD 
 	  cuenta  char(15),
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	sc_lista  ARRAY [12] OF RECORD 
 	  cuenta  char(15),
	  descripcion  LIKE act_bienesdet.descripcion,
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	apu RECORD 
 	  cuenta  char(15),
	  debe    LIKE contaapun.debe,
	  haber   LIKE contaapun.haber
	END RECORD,
	tecla char,
	numfila		decimal(15,0),
	linpant, m, n	integer,
	maxlin, contador, i, fintabla, iniciotabla, salida smallint,
	titulo char(50),
	t1,t2,t3,t4  char(15),
	numtotal	smallint,
	counter		smallint,
	hay    		smallint,
	abortar		smallint

OPEN WINDOW w4 AT 5,3 WITH FORM "act022p4"
ATTRIBUTE (border,message line 2)
LET titulo = "VISUALIZACION DEL ASIENTO RESUMIDO"
let t1="CUENTA"
let t2="DEBE"
let t3="HABER"
DISPLAY BY NAME titulo,t1,t2,t3 attribute(reverse,cyan)

// Inserta en una tabla temporal los importes en las cuentas de cargo y abono

INSERT INTO tmp_apun
 SELECT cuenta_cargo,SUM(importe_amor),0
   FROM tmp_amor
  GROUP BY 1,3
INSERT INTO tmp_apun
 SELECT cuenta_abono,0,SUM(importe_amor)
   FROM tmp_amor
  GROUP BY 1,2
DECLARE capunt SCROLL CURSOR FOR
 SELECT * FROM tmp_apun
 
OPEN capunt  
LET counter=1
LET salida=0
LET m=1
LET fintabla=0
LET maxlin = 12

// Muestra los apuntes generados y que están guardados en la tabla tmp_amor
WHILE TRUE
    FOR i=1 TO maxlin STEP 1
	  LET n=(m-1)*maxlin+counter
	  FETCH ABSOLUTE n capunt INTO apu.*
	IF status=100 THEN LET fintabla=1
			   EXIT FOR
	END IF

	LET sc_datos[counter].cuenta = apu.cuenta
	LET sc_datos[counter].debe   = apu.debe
	LET sc_datos[counter].haber  = apu.haber

	LET sc_lista[counter].cuenta = apu.cuenta
	LET sc_lista[counter].debe   = apu.debe
	LET sc_lista[counter].haber  = apu.haber
	LET cond = "contaplan.ejercicio =",xejercicio
	LET sc_lista[counter].descripcion = 
		des_cod("contaplan","cuenta",apu.cuenta,"titulo",cond)
	LET counter=counter+1
    END FOR
    LET numtotal = counter - 1
    IF numtotal = 0 AND m = 1 THEN
		CALL mensaje(0,-3,"NO Hay Apuntes  !")
			RETURNING oky
		LET salida = 2
		EXIT WHILE
    END IF

    CALL win_teclas_p(counter,maxlin,m,6,10,"1Confirma,2Adelante,3Atras,8 Salir")

     FOR i = 1 TO numtotal 
	DISPLAY sc_lista[i].* TO sc_act022p4[i].* attribute(green) 
     END FOR 
     LET counter = 1 
     INPUT BY NAME tecla attribute(black) 
	BEFORE FIELD tecla
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
				attribute(reverse,white,blink)
	AFTER FIELD tecla
	NEXT FIELD tecla

	ON KEY (up)
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
						attribute(green)
	IF counter > 1 THEN  LET counter = counter -1 END IF 
	NEXT FIELD tecla

	ON KEY (down,tab)
	DISPLAY sc_lista[counter].* TO sc_act022p4[counter].* 
						attribute(green)
	IF counter < numtotal THEN LET counter = counter + 1 END IF
	NEXT FIELD tecla 

	ON KEY  (F1,CONTROL-F)
	  
	 LET salida = 1
	 EXIT INPUT

	ON KEY (F2,CONTROL-G)
	IF fintabla=0 THEN LET m=m+1 
	   CLOSE capunt OPEN capunt 
	   EXIT INPUT  
         ELSE NEXT FIELD tecla	
	END IF

	ON KEY (F3,CONTROL-V)
	LET m=m-1
	IF m=0 THEN	LET m=1 
			NEXT FIELD tecla
	       ELSE 	CLOSE capunt OPEN capunt 
			EXIT INPUT 
	END IF
  
	ON KEY (escape,f8)
	LET salida=2
	EXIT INPUT  

     END INPUT
     IF salida=2 or salida = 1 THEN EXIT WHILE END IF  

     LET fintabla=0
     LET counter=1
     FOR i=1 TO numtotal
          INITIALIZE sc_datos[i].* TO NULL
	  CLEAR sc_act022p4[i].* 
     END FOR
END WHILE
// aquí se realiza la grabación de los apuntes
IF salida = 1 THEN 
  LET abortar = FALSE
  BEGIN  WORK
  LET fechacon = TODAY
// pide la fecha de contabilización(por defecto, fecha del día)
  INPUT BY NAME fechacon
   AFTER FIELD fechacon  
     IF fechacon IS null THEN
       NEXT FIELD fechacon
     END IF
     CALL compruebafecconta(fechacon,YEAR(fechacon)) 
        RETURNING bien,abortar
     IF bien = "N" THEN
	 ERROR "FECHA CONTABLE NO ACCESIBLE"
	 NEXT FIELD fechacon
     END IF
  END INPUT 
  IF NOT abortar THEN
    CALL asientos(xempresa,xejercicio,fechacon) 
	  RETURNING dasiento,abortar

    IF NOT abortar THEN
      DECLARE curupd  CURSOR FOR
       SELECT * FROM tmp_amor
      FOREACH curupd INTO am.*
        UPDATE act_amortizaciones
           SET (actualizado,asiento,fecha_contable) =
	  ("S",dasiento,fechacon)
         where act_amortizaciones.empresa = am.empresa
           and act_amortizaciones.elemento = am.elemento
           and act_amortizaciones.amortizacion = am.amortizacion
        IF STATUS <> 0 then
    CALL mensaje(0,-3,"No Actualizo Amortizaciones , Error!!") 
						RETURNING oky
	  LET abortar = TRUE
        END IF
      END FOREACH
    END IF
  END IF
  IF NOT abortar THEN COMMIT WORK
    ELSE
     ROLLBACK WORK
  END IF
END IF
CLEAR t1,t2,t3,titulo
FOR i=1 TO numtotal CLEAR sc_act022p4[i].* END FOR
CLOSE WINDOW  w4
END FUNCTION
*/
end subroutine

public function boolean f_asientos (string empresa, decimal ejercicio, datetime fechacon, ref str_contaapun conapu, ref boolean abortar);/*   DEFINE 
	xejercicio,xempresa decimal(4,0),
	fechacon date,
	conapu		RECORD LIKE contaapun.*,
	apun		RECORD LIKE genapunte.*,
	asientin	LIKE contaparam.asiento,
	apuntin		decimal(7,0),
	abortar		smallint
*/
abortar = false

//	relleno contaapun con valores comunes para todos los apuntes 

String	c1,c2,cadena
Boolean	res
Dec		elemento,apuntin,amortizacion
DataStore	ds_tmp_amor
Integer	rr,xx

// Valores comunes a todos los apuntes de todos los asientos
conapu.ejercicio  = ejercicio
conapu.empresa    = empresa
conapu.origen		= f_origen_amort()
conapu.asiento    = f_ultimo_asiento(conapu.ejercicio,conapu.empresa,month(Date(fechacon)),conapu.origen)
conapu.mes			= Month(Date(fechacon))
conapu.fapunte    = fechacon
conapu.fvalor		= conapu.fapunte

SetNUll(conapu.diario)
SetNUll(conapu.tipoapu)
SetNUll(conapu.documento)
SetNUll(conapu.factura)
SetNUll(conapu.ffactura)
SetNUll(conapu.imponible)
SetNUll(conapu.tipoiva)
SetNull(conapu.iva)
SetNull(conapu.divisas)
SetNull(conapu.deducible)
SetNull(conapu.actualizado)
SetNull(conapu.listado)
SetNull(conapu.registro)
SetNull(conapu.tipoter)
SetNull(conapu.clipro)
SetNull(conapu.conciliado)
SetNull(conapu.nif)
SetNull(conapu.punteado)
SetNull(conapu.docpunteo)
SetNull(conapu.coste)
SetNull(conapu.fregistro)

conapu.cambio = 1
conapu.moneda = f_paramemp_moneda_emp(codigo_empresa)
conapu.mes    = Month(Date(fechacon))

conapu.fapunte     = fechacon
conapu.fvalor      = fechacon
conapu.fregistro   = fechacon
apuntin            = f_ultimo_asiento(conapu.ejercicio,conapu.empresa,conapu.mes,conapu.origen)


ds_tmp_amor = CREATE DataStore
ds_tmp_amor.DataObject = "ds_act_tmp_apun"
ds_tmp_amor.SetTransObject(sqlca)
ds_tmp_amor.Retrieve()
rr = ds_tmp_amor.RowCount()

//	f_mensaje("f_asientos","1")
For xx = 1 to rr
//	f_mensaje("f_asientos","2")
	elemento = ds_tmp_amor.GetItemDecimal(xx,"elemento")
	conapu.cuenta = ds_tmp_amor.GetItemString(xx,"cuenta")
	conapu.debe = ds_tmp_amor.GetItemDecimal(xx,"debe")
	conapu.haber = ds_tmp_amor.GetItemDecimal(xx,"haber")
	IF isnull(conapu.cuenta) THEN
		f_mensaje("Aviso","Cta. No definida. No se Procesa !!")
		abortar = true
		RETURN False
	END IF
 	IF conapu.debe > 0 THEN
					//apunte de debe
		  conapu.concepto = f_concepto_contagene(empresa,'601') 
		  conapu.apunte	= apuntin + 1
		  conapu.cuenta   	= conapu.cuenta
//		  conapu.ampliacion	= "AMORTIZACION A " + String(fechacon,"dd-mm-yyyy")
		  conapu.ampliacion	= String(elemento)

		  conapu.coste   		= ds_tmp_amor.GetItemString(xx,"coste")
		  
		  If not f_insert_contaapun(conapu) then abortar = True
		  IF abortar THEN
			 f_mensaje("Error","No grabo Asiento.") 
			 RETURN False
		  END IF
	
	 ELSE
						//apunte de haber
		  conapu.concepto = f_concepto_contagene(empresa,'602') 
		  conapu.apunte	= apuntin + 1
		  conapu.cuenta   	= conapu.cuenta
//		  conapu.ampliacion	= "AMORTIZACION A " + String(fechacon,"dd-mm-yyyy")
		  conapu.ampliacion	= String(elemento)

		  SetNull(conapu.coste)
		  If not f_insert_contaapun(conapu) then abortar = True
		  IF abortar THEN
			 f_mensaje("Error","No grabo Asiento.") 
			 RETURN False
		  END IF
	
	END IF
  	apuntin = apuntin + 1

   IF NOT abortar THEN
//		f_mensaje("f_asientos","3")
		elemento = ds_tmp_amor.GetItemDecimal(xx,"elemento")
		amortizacion = ds_tmp_amor.GetItemDecimal(xx,"amortizacion")
		  
	  UPDATE act_amortizaciones
	  SET actualizado = 'S',
			asiento = :conapu.asiento,
			fecha_contable = :fechacon
		where act_amortizaciones.empresa = :codigo_empresa and
		act_amortizaciones.elemento = :elemento and 
		act_amortizaciones.amortizacion = :amortizacion;	
			
//			f_mensaje("debug","Actualizando elemento " + string(elemento) + char(13) +&
//							"Amortización " + string(amortizacion) )
			  
        IF sqlca.sqlcode <> 0 then
    		f_mensaje("Error","No Actualizo Amortizaciones.") 
		   abortar = TRUE
        END IF
    END IF

NEXT


Destroy ds_tmp_amor
//	f_mensaje("f_asientos","4")

IF abortar THEN
	RETURN False
Else
	em_asiento.text = string(conapu.asiento)
	RETURN True
END IF
end function

public function boolean f_asientos_analitica (string empresa, decimal ejercicio, datetime fechacon, ref boolean abortar);Str_costesapu	costes

abortar = false

//	relleno contaapun con valores comunes para todos los apuntes 

String	c1,c2,cadena
Boolean	res
Dec		elemento,apuntin,amortizacion
DataStore	ds_tmp_amor
Integer	rr,xx

// Valores comunes a todos los apuntes de todos los asientos
costes.ejercicio  = ejercicio
costes.empresa    = empresa
costes.origen		= f_origen_amort()
costes.asiento    = f_ultimo_asiento(costes.ejercicio,costes.empresa,month(Date(fechacon)),costes.origen)
costes.mes			= Month(Date(fechacon))
costes.fapunte    = fechacon

costes.mes    = Month(Date(fechacon))

costes.fapunte     = fechacon
apuntin            = f_ultimo_asiento_analitica(costes.ejercicio,costes.empresa,costes.mes,costes.origen)


ds_tmp_amor = CREATE DataStore
ds_tmp_amor.DataObject = "ds_act_tmp_apun"
ds_tmp_amor.SetTransObject(sqlca)
ds_tmp_amor.Retrieve()
rr = ds_tmp_amor.RowCount()

//	f_mensaje("f_asientos","1")
For xx = 1 to rr
//	f_mensaje("f_asientos","2")
	elemento = ds_tmp_amor.GetItemDecimal(xx,"elemento")
	costes.cuenta = ds_tmp_amor.GetItemString(xx,"cuenta")
	costes.coste  = ds_tmp_amor.GetItemString(xx,"coste")
	costes.debe = ds_tmp_amor.GetItemDecimal(xx,"debe")
	costes.haber = ds_tmp_amor.GetItemDecimal(xx,"haber")
	IF isnull(costes.cuenta) THEN
		f_mensaje("Aviso","Cta. No definida. No se Procesa !!")
		abortar = true
		RETURN False
	END IF

	// FSF 08/07/99
	// si no tiene centro de coste, no hacer analítica

	If isnull(costes.coste) or trim(costes.coste)='' then Return True 

  costes.concepto = f_concepto_contagene(empresa,'601') 
  costes.apunte	= apuntin + 1
  costes.cuenta   	= costes.cuenta
//  costes.ampliacion	= "AMORTIZACION A " + String(fechacon,"dd-mm-yyyy")
  costes.ampliacion	= String(elemento)
  If not f_insert_costesapu(costes) then abortar = True
  IF abortar THEN
	 f_mensaje("Error","No grabo Asiento.") 
	 RETURN False
  END IF
	
  	apuntin = apuntin + 1

NEXT

Destroy ds_tmp_amor
//	f_mensaje("f_asientos","4")

IF abortar THEN
	RETURN False
Else
	RETURN True
END IF
end function

on w_act_meses.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_marca=create uo_marca
this.uo_ejercicio=create uo_ejercicio
this.st_1=create st_1
this.uo_marca2=create uo_marca2
this.st_2=create st_2
this.dw_1=create dw_1
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.em_fconta=create em_fconta
this.st_11=create st_11
this.st_3=create st_3
this.em_asiento=create em_asiento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.uo_marca
this.Control[iCurrent+4]=this.uo_ejercicio
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_marca2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.em_fconta
this.Control[iCurrent+14]=this.st_11
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.em_asiento
end on

on w_act_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_marca)
destroy(this.uo_ejercicio)
destroy(this.st_1)
destroy(this.uo_marca2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.em_fconta)
destroy(this.st_11)
destroy(this.st_3)
destroy(this.em_asiento)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Actualización por meses" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

uo_marca.cb_marcar.visible = False
uo_marca.cb_desmarcar.visible = False
uo_marca.st_titulo1.text = "Mes"
uo_marca.st_titulo2.text = "Amortizaciones"
uo_marca2.st_titulo1.text = "Elemento"
uo_marca2.st_titulo2.text = "Importe"

f_marca_meses(codigo_empresa,uo_ejercicio.em_ejercicio.text)

dw_1.SetTransObject(sqlca)

em_asiento.text = '0'
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_act_meses
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_act_meses
end type

type st_empresa from w_int_con_empresa`st_empresa within w_act_meses
integer width = 2757
end type

type cb_1 from u_boton within w_act_meses
integer x = 1714
integer y = 176
integer width = 347
integer height = 92
integer taborder = 80
string text = "&Ver Asiento"
end type

event clicked;Integer		rr,xx,yy,ii,salida,contador
String		codigo,cadena,c1,ejercicio,inicio,fin
Dec			elemento,amortizacion
DataStore	ds_amort
Str_parametros	param,param_rec
DateTime		fechacon
Decimal		d1
Boolean		abortar
Str_contaapun	dasiento

delete from act_tmp_apun;
contador = 1

ii = uo_marca2.dw_marca.RowCount()

If ii = 0 then return

ejercicio = uo_ejercicio.em_ejercicio.text

//inicio = String(mes) + '/1/' + ejercicio + " 00:00:00"
inicio = '1/' +String(mes)+ '/' +ejercicio 

If mes = 12 then
//	fin = '12/31/'+ ejercicio + " 00:00:00"
	fin = '31/12/'+ ejercicio 
Else
	// ultimo dia del mes
//	fin = String(mes) + '/' + String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + ejercicio + " 00:00:00"
	fin = String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + String(mes) + '/' +  ejercicio 
End If


For xx = 1 to ii
	If f_valor_columna(uo_marca2.dw_marca,xx,"marca") = "S" then
		codigo = f_valor_columna(uo_marca2.dw_marca,xx,"codigo")	
//		cadena = "SELECT act_amortizaciones.importe_amor, " +&
//					"act_amortizaciones.cuenta_cargo,act_amortizaciones.cuenta_abono " +& 
//					"FROM act_amortizaciones " +&
//					"WHERE ( act_amortizaciones.empresa = '" + codigo_empresa + "') AND " +&
//					"( act_amortizaciones.ejercicio = " + ejercicio + ") AND " +& 
//					"( act_amortizaciones.fecha_amor >=  '" + inicio + "') AND " +& 
//					"( act_amortizaciones.fecha_amor <= '" + fin + "') AND " +& 
//					"( act_amortizaciones.elemento = " + codigo + " )"
		cadena = "SELECT act_amortizaciones.importe_amor, " +&
					"act_amortizaciones.cuenta_cargo,act_amortizaciones.cuenta_abono," +& 
					"act_amortizaciones.elemento,act_amortizaciones.amortizacion " +& 
					"FROM act_amortizaciones " +&
					"WHERE ( act_amortizaciones.empresa = '" + codigo_empresa + "') AND " +&
					"( act_amortizaciones.ejercicio = " + ejercicio + ") AND " +& 
					"( act_amortizaciones.fecha_amor between " +&
					"'" + inicio + "' AND '" + fin + "') AND " +& 
					"( act_amortizaciones.elemento = " + codigo + " )"
					
		//ds_amort = f_cargar_cursor(cadena)
		f_cargar_cursor_nuevo(cadena, ds_amort)
		rr = ds_amort.RowCount()
		
		For yy = 1 to rr
				c1 = trim(ds_amort.GetItemString(yy,"cuenta_cargo"))
				d1 = ds_amort.GetItemDecimal(yy,"importe_amor")
				elemento = ds_amort.GetItemDecimal(yy,"elemento")
				amortizacion = ds_amort.GetItemDecimal(yy,"amortizacion")
			  INSERT INTO act_tmp_apun  
						( cuenta,   
						  debe,   
						  haber ,
						  codigo,
						  elemento,
						  amortizacion,
						  coste)  
			  VALUES ( :c1,   
						  :d1,   
						  0 ,
						  :contador,
						  :elemento,
						  :amortizacion,
						  null)  ;
				contador = contador + 1
				c1 = trim(ds_amort.GetItemString(yy,"cuenta_abono"))
			  INSERT INTO act_tmp_apun  
						( cuenta,   
						  debe,   
						  haber ,
						  codigo,
						  elemento,
						  amortizacion,
						  coste)  						  
			  VALUES ( :c1,   
			  				0,
						  :d1,
						  :contador,
						  :elemento,
						  :amortizacion,
						  null)  ;
				contador = contador + 1						  
		Next
		
	End If
Next

Destroy ds_amort

param.i_nargumentos = 2
param.s_argumentos[1] = codigo_empresa
param.s_argumentos[2] = ejercicio
If mes = 12 then
	param.s_argumentos[3] = '31/12/'+ ejercicio 
Else
	param.s_argumentos[3] = String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + String(mes) + '/' + ejercicio 
End If

//IF not f_control_fecha_apunte(codigo_empresa,Dec(ejercicio),DateTime(Date(param.s_argumentos[3]))) then Return
IF not f_control_fecha_apunte(Dec(ejercicio),DateTime(Date(param.s_argumentos[3]))) then Return


OpenWithParm(w_act_meses_apun,param)


end event

type cb_2 from u_boton within w_act_meses
integer x = 2437
integer y = 176
integer width = 347
integer height = 92
integer taborder = 70
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;Close(Parent)
end event

type uo_marca from u_marca_lista within w_act_meses
integer x = 23
integer y = 460
integer height = 676
integer taborder = 60
end type

on uo_marca.destroy
call u_marca_lista::destroy
end on

event constructor;this.height = 570
dw_marca.height=this.height - 84
end event

type uo_ejercicio from u_ejercicio within w_act_meses
integer x = 27
integer y = 168
integer taborder = 120
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_1 from statictext within w_act_meses
integer x = 50
integer y = 380
integer width = 965
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "ESCOGER MES A CONTABILIZAR"
boolean focusrectangle = false
end type

type uo_marca2 from u_marca_lista within w_act_meses
event constructor pbm_constructor
integer x = 1435
integer y = 460
integer height = 556
integer taborder = 50
end type

event constructor;this.height = 570
call super::constructor
end event

on uo_marca2.destroy
call u_marca_lista::destroy
end on

type st_2 from statictext within w_act_meses
integer x = 1449
integer y = 384
integer width = 795
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "MARCAR AMORTIZACIONES"
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_act_meses
integer x = 133
integer y = 1164
integer width = 2537
integer height = 384
integer taborder = 10
string dataobject = "dw_con_amort_contab"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from picturebutton within w_act_meses
integer x = 1024
integer y = 368
integer width = 137
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "c:\bmp\check_no.bmp"
alignment htextalign = left!
end type

event clicked;Integer  xx,ii,marcados
String	nmes

ii = uo_marca.dw_marca.RowCount()

marcados = 0
For xx = 1 to ii
	If f_valor_columna(uo_marca.dw_marca,xx,"marca") = "S" then
		nmes = f_valor_columna(uo_marca.dw_marca,xx,"codigo")		
		marcados = marcados + 1
	End If
Next

If marcados > 1 then
	f_mensaje("Aviso","Sólo puede marcar un mes.")
	Return
ElseIf marcados= 0 then
	f_mensaje("Aviso","Marque un mes.")
	Return
End If

mes = f_mes(nmes)
If mes = 12 then
	em_fconta.text= '31/12/'+ uo_ejercicio.em_ejercicio.text 
Else
	em_fconta.text = String(Day(RelativeDate(Date(integer(uo_ejercicio.em_ejercicio.text),mes+1,1),-1))) + '/' + String(mes) + '/' + uo_ejercicio.em_ejercicio.text 
End If

f_marcaamort(codigo_empresa,uo_ejercicio.em_ejercicio.text,String(mes))

end event

type pb_2 from picturebutton within w_act_meses
integer x = 2263
integer y = 368
integer width = 137
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "c:\bmp\check_no.bmp"
alignment htextalign = left!
end type

event clicked;f_muestraamort(codigo_empresa,uo_ejercicio.em_ejercicio.text,String(mes))

end event

type cb_3 from u_boton within w_act_meses
integer x = 672
integer y = 180
integer width = 279
integer height = 80
integer taborder = 40
boolean bringtotop = true
string text = "&Refrescar"
end type

event clicked;uo_marca.dw_marca.Reset()
uo_marca2.dw_marca.Reset()
f_marca_meses(codigo_empresa,uo_ejercicio.em_ejercicio.text)

end event

type cb_4 from u_boton within w_act_meses
integer x = 2075
integer y = 176
integer width = 347
integer height = 92
integer taborder = 30
string text = "&Procesar"
end type

event clicked;Integer		rr,xx,yy,ii,salida,contador,resp
String		codigo,cadena,c1,c2,ejercicio,inicio,fin
Dec			elemento,amortizacion
DataStore	ds_amort
Str_parametros	param,param_rec
DateTime		fechacon
Decimal		d1
Boolean		abortar
Str_contaapun	dasiento


resp = MessageBox("Confirmación","¿Desea contabilizar?",Question!,YesNo!,2)
If resp = 2 then Return

delete from act_tmp_apun;
contador = 1

ii = uo_marca2.dw_marca.RowCount()

If ii = 0 then return

ejercicio = uo_ejercicio.em_ejercicio.text

//inicio = String(mes) + '/1/' + ejercicio + " 00:00:00"
inicio = '1/' +String(mes) + "/"+ ejercicio 

If mes = 12 then
//	fin = '12/31/'+ ejercicio + " 00:00:00"
	fin = '31/12/'+ ejercicio 
Else
	// ultimo dia del mes
//	fin = String(mes) + '/' + String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + ejercicio + " 00:00:00"
	fin = String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + String(mes) + '/' +  ejercicio 
End If

For xx = 1 to ii
	If f_valor_columna(uo_marca2.dw_marca,xx,"marca") = "S" then
		codigo = f_valor_columna(uo_marca2.dw_marca,xx,"codigo")	
//		cadena = "SELECT act_amortizaciones.importe_amor, " +&
//					"act_amortizaciones.cuenta_cargo,act_amortizaciones.cuenta_abono " +& 
//					"FROM act_amortizaciones " +&
//					"WHERE ( act_amortizaciones.empresa = '" + codigo_empresa + "') AND " +&
//					"( act_amortizaciones.ejercicio = " + ejercicio + ") AND " +& 
//					"( act_amortizaciones.fecha_amor >=  '" + inicio + "') AND " +& 
//					"( act_amortizaciones.fecha_amor <= '" + fin + "') AND " +& 
//					"( act_amortizaciones.elemento = " + codigo + " )"
		cadena = "SELECT act_amortizaciones.importe_amor, act_amortizaciones.centro_coste," +&
					"act_amortizaciones.cuenta_cargo,act_amortizaciones.cuenta_abono," +& 
					"act_amortizaciones.elemento,act_amortizaciones.amortizacion " +& 
					"FROM act_amortizaciones " +&
					"WHERE ( act_amortizaciones.empresa = '" + codigo_empresa + "') AND " +&
					"( act_amortizaciones.ejercicio = " + ejercicio + ") AND " +& 
					"( act_amortizaciones.fecha_amor between " +&
					"'" + inicio + "' AND '" + fin + "') AND " +& 
					"( act_amortizaciones.elemento = " + codigo + " )"
					
		//ds_amort = f_cargar_cursor(cadena)
		f_cargar_cursor_nuevo(cadena, ds_amort)
		rr = ds_amort.RowCount()
		For yy = 1 to rr
				c1 = trim(ds_amort.GetItemString(yy,"cuenta_cargo"))
				d1 = ds_amort.GetItemDecimal(yy,"importe_amor")
				c2 = trim(ds_amort.GetItemString(yy,"centro_coste"))
				elemento = ds_amort.GetItemDecimal(yy,"elemento")
				amortizacion = ds_amort.GetItemDecimal(yy,"amortizacion")
			  INSERT INTO act_tmp_apun  
						( cuenta,   
						  debe,   
						  haber ,
						  codigo,
						  elemento,
						  amortizacion,
						  coste)  
			  VALUES ( :c1,   
						  :d1,   
						  0 ,
						  :contador,
						  :elemento,
						  :amortizacion,
						  :c2)  ;
				contador = contador + 1
				c1 = trim(ds_amort.GetItemString(yy,"cuenta_abono"))
			  INSERT INTO act_tmp_apun  
						( cuenta,   
						  debe,   
						  haber ,
						  codigo,
						  elemento,
						  amortizacion,
						  coste)  						  
			  VALUES ( :c1,   
			  				0,
						  :d1,
						  :contador,
						  :elemento,
						  :amortizacion,
						  null)  ;
				contador = contador + 1						  
		Next
		
	End If
Next

/*param.i_nargumentos = 2
param.s_argumentos[1] = codigo_empresa
param.s_argumentos[2] = ejercicio
If mes = 12 then
	param.s_argumentos[3] = '31/12/'+ ejercicio 
Else
	param.s_argumentos[3] = String(Day(RelativeDate(Date(integer(ejercicio),mes+1,1),-1))) + '/' + String(mes) + '/' + ejercicio 
End If
*/

fechacon = DateTime(Date(em_fconta.text))

//IF not f_control_fecha_apunte(codigo_empresa,Dec(ejercicio),fechacon) then
IF not f_control_fecha_apunte(Dec(ejercicio),fechacon) then
	f_mensaje("ERROR","FECHA CONTABLE NO ACCESIBLE")
	em_fconta.SetFocus() 
	destroy ds_amort
	Return
END IF

/*
OpenWithParm(w_act_meses_apun,param)

//f_mensaje("","1")
param_rec = Message.PowerObjectParm
IF param_rec.s_argumentos[1] = '1' THEN */
//	fechacon = DateTime(date(param_rec.s_argumentos[2]))
//	f_mensaje("","2")
   f_asientos(codigo_empresa,Dec(ejercicio),fechacon,dasiento,abortar)
//	f_mensaje("","3")
//    IF NOT abortar THEN
//      cadena = "SELECT * FROM act_tmp_apun"
//		ds_amort = f_cargar_cursor(cadena)
//		rr = ds_amort.RowCount()
//		For yy = 1 to rr
//			elemento = ds_amort.GetItemDecimal(yy,"elemento")
//			amortizacion = ds_amort.GetItemDecimal(yy,"amortizacion")
//		  
//        UPDATE act_amortizaciones
//        SET actualizado = 'S',
//			   asiento = :dasiento.asiento,
//			   fecha_contable = :fechacon
//         where act_amortizaciones.empresa = :codigo_empresa and
//         act_amortizaciones.elemento = :elemento and 
//         act_amortizaciones.amortizacion = :amortizacion;	
//			
//			f_mensaje("debug","Actualizando elemento " + string(elemento) + char(13) +&
//							"Amortización " + string(amortizacion) )
//			  
//        IF sqlca.sqlcode <> 0 then
//    		f_mensaje("Error","No Actualizo Amortizaciones.") 
//		   abortar = TRUE
//        END IF
//		NEXT
//    END IF


	// *** AHORA HACEMOS LA ANALITICA

If not abortar then 
	
	delete from act_tmp_apun;
	
	For xx = 1 to ii
		If f_valor_columna(uo_marca2.dw_marca,xx,"marca") = "S" then
			codigo = f_valor_columna(uo_marca2.dw_marca,xx,"codigo")	
			cadena = "SELECT act_amortizaciones.importe_amor, " +&
						"act_amortizaciones.centro_coste,act_amortizaciones.cuenta_cargo," +&			
						"act_amortizaciones.elemento,act_amortizaciones.amortizacion " +& 
						"FROM act_amortizaciones " +&
						"WHERE ( act_amortizaciones.empresa = '" + codigo_empresa + "') AND " +&
						"( act_amortizaciones.ejercicio = " + ejercicio + ") AND " +& 
						"( act_amortizaciones.fecha_amor between " +&
						"'" + inicio + "' AND '" + fin + "') AND " +& 
						"( act_amortizaciones.elemento = " + codigo + " )"
						
			//ds_amort = f_cargar_cursor(cadena)
			f_cargar_cursor_nuevo(cadena, ds_amort)
			rr = ds_amort.RowCount()
			For yy = 1 to rr
					c1 = trim(ds_amort.GetItemString(yy,"centro_coste"))
					c2 = trim(ds_amort.GetItemString(yy,"cuenta_cargo"))
					d1 = ds_amort.GetItemDecimal(yy,"importe_amor")
					elemento = ds_amort.GetItemDecimal(yy,"elemento")
					amortizacion = ds_amort.GetItemDecimal(yy,"amortizacion")
				  INSERT INTO act_tmp_apun  
							( cuenta,   
							  debe,   
							  haber ,
							  codigo,
							  elemento,
							  amortizacion,
							  coste)  
				  VALUES ( :c2,   
							  :d1,   
							  0 ,
							  :contador,
							  :elemento,
							  :amortizacion,
							  :c1)  ;
					contador = contador + 1
			Next
			
		End If
	Next

	f_asientos_analitica(codigo_empresa,Dec(ejercicio),fechacon,abortar)

End If

Destroy ds_amort


IF NOT abortar THEN 
	COMMIT USING SQLCA;
	f_mensaje("Fin del proceso","El proceso ha finalizado con éxito.")
ELSE
	ROLLBACK USING SQLCA;
	f_mensaje("Fin del proceso","No se actualiza.")
END IF 
//END IF

uo_marca.dw_marca.Reset()
uo_marca2.dw_marca.Reset()
dw_1.Reset()
f_marca_meses(codigo_empresa,uo_ejercicio.em_ejercicio.text)
end event

type em_fconta from u_em_campo within w_act_meses
event getfocus pbm_ensetfocus
integer x = 1403
integer y = 172
integer width = 302
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;DateTime	fechacon

fechacon = DateTime(Date(em_fconta.text))
//IF not f_control_fecha_apunte(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),fechacon) then
IF not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),fechacon) then
	f_mensaje("ERROR","FECHA CONTABLE NO ACCESIBLE")
	em_fconta.SetFocus()  
END IF

end event

type st_11 from statictext within w_act_meses
integer x = 983
integer y = 180
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Contable"
boolean focusrectangle = false
end type

type st_3 from statictext within w_act_meses
integer x = 2176
integer y = 280
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Asiento"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_asiento from u_em_campo within w_act_meses
integer x = 2437
integer y = 280
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = decimalmask!
string mask = "######"
end type

event rbuttondown;Str_parametros param

If this.text <> '0' then
	param.i_nargumentos = 5
	param.s_argumentos[2] = uo_ejercicio.em_ejercicio.text
	param.s_argumentos[3] = f_origen_amort()
	param.s_argumentos[4] = em_fconta.text
	param.s_argumentos[5] = em_asiento.text  	
	OpenWithParm(w_int_contaapun, param)
End If
end event

event busqueda;// ahora override
end event

