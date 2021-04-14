$PBExportHeader$w_act_amortizaciones.srw
forward
global type w_act_amortizaciones from w_int_con_empresa
end type
type st_1 from statictext within w_act_amortizaciones
end type
type em_delemento from u_em_campo within w_act_amortizaciones
end type
type st_2 from statictext within w_act_amortizaciones
end type
type em_helemento from u_em_campo within w_act_amortizaciones
end type
type st_helemento from statictext within w_act_amortizaciones
end type
type em_fecha from u_em_campo within w_act_amortizaciones
end type
type st_4 from statictext within w_act_amortizaciones
end type
type cb_1 from u_boton within w_act_amortizaciones
end type
type cb_2 from u_boton within w_act_amortizaciones
end type
type uo_ejercicio from u_ejercicio within w_act_amortizaciones
end type
type st_delemento from statictext within w_act_amortizaciones
end type
type st_generadas from statictext within w_act_amortizaciones
end type
type kk from structure within w_act_amortizaciones
end type
end forward

type kk from structure
	string		empresa
	decimal {0}	elemento
	integer		amortizacion
	decimal {0}	ejercicio
	decimal {0}	clase_inmobilizado
	string		familia
	decimal {0}	bien
	decimal {0}	periodo
	string		tipo_amor
	decimal {0}	porcentaje_amor
	string		cuenta_activo
	string		cuenta_cargo
	string		cuenta_abono
	string		seccion
	string		centro_coste
	date		fecha_contable
	decimal {0}	asiento
	string		actualizado
	date		fecha_amor
	decimal {0}	importe_amor
	decimal {0}	importe_amorfis
end type

global type w_act_amortizaciones from w_int_con_empresa
integer width = 2706
integer height = 768
string title = "Generación de Amortizaciones"
string menuname = ""
st_1 st_1
em_delemento em_delemento
st_2 st_2
em_helemento em_helemento
st_helemento st_helemento
em_fecha em_fecha
st_4 st_4
cb_1 cb_1
cb_2 cb_2
uo_ejercicio uo_ejercicio
st_delemento st_delemento
st_generadas st_generadas
end type
global w_act_amortizaciones w_act_amortizaciones

type variables
Integer 	insertadas
end variables

forward prototypes
public function date f_obtenerfechadefecto ()
public subroutine f_borratodon (string empresa, decimal elemento, date fecha1)
public function boolean f_verifecha (date dfecha)
public subroutine f_proceso (string empresa, date dfecha, string delemento, string helemento)
public function boolean f_versiamortizo (string empresa, decimal elemento, date fecha2, ref date ultimafecha, ref decimal amortizado, ref decimal amortizadofis, ref decimal xbase)
public subroutine f_calculaamort (character padre, string empresa, decimal elemento, amortizaciones am, decimal amortizado, decimal amortizadofis, decimal xbase, datetime fecha1, datetime fecha2)
public subroutine f_creaamortizacion (string padre, string empresa, decimal elemento, datetime fecha1, datetime fecha2, decimal amortizado, decimal amortizadofis, decimal xbase)
end prototypes

public function date f_obtenerfechadefecto ();date   xfecha, hoy

hoy = Today()

IF month(hoy) = 12 THEN
 xfecha = mdy(month(hoy),31,year(hoy))
ELSE
 xfecha = RelativeDate(mdy(month(hoy)+1,1,year(hoy)),-1)
end IF

RETURN xfecha

end function

public subroutine f_borratodon (string empresa, decimal elemento, date fecha1);Datetime	desde,hasta

desde = datetime(mdy(01,01,year(fecha1)))
hasta	= datetime(mdy(12,31,year(fecha1)))

DELETE FROM act_amortizaciones
 WHERE act_amortizaciones.empresa = :empresa
   AND act_amortizaciones.elemento = :elemento
   AND act_amortizaciones.actualizado = "N"
   AND act_amortizaciones.fecha_amor 
      BETWEEN :desde AND :hasta;
		
		
if sqlca.sqlcode <> 0 then
	messagebox("Error","Borrando las amortizaciones no actualizadas")		
end if
		
end subroutine

public function boolean f_verifecha (date dfecha);IF Day(RelativeDate(dfecha,1)) <> 1 THEN
 RETURN False
ELSE
 RETURN True
END IF
end function

public subroutine f_proceso (string empresa, date dfecha, string delemento, string helemento);DataStore	ds_bienesdet
String		cadena,emp
Integer		rr,xx,cuantos
Dec			cant,elemento,amortizado,amortizadofis, xbase,ele
Date			fechain
DateTime		fecha

insertadas = 0

ds_bienesdet = CREATE DataStore
ds_bienesdet.DataObject = "ds_bienesdet"
ds_bienesdet.SetTransObject(sqlca)

//f_mensaje("Retrieve",empresa + char(13) + delemento + char(13) + helemento)
			 
ds_bienesdet.Retrieve(empresa,Dec(delemento),Dec(helemento))
rr = ds_bienesdet.RowCount()

//f_mensaje("debug", string(rr) + " elementos")

FOR xx = 1 to rr 
  	empresa = trim(ds_bienesdet.GetItemString(xx,"empresa"))
  	elemento = ds_bienesdet.GetItemDecimal(xx,"elemento")
	fecha = ds_bienesdet.GetItemDateTime(xx,"fechabaja")
	IF NOT isnull(fecha) THEN 
//		f_mensaje ("debug","voy a continuar, no tengo que amortizar el elemento " + string(elemento) +&
//		" porque es una baja.")		
		CONTINUE  // si tiene fecha de baja no procesar
	end if
  	cant = ds_bienesdet.GetItemDecimal(xx,"porcentaje_amor")
  IF isnull(cant) or cant= 0 THEN 
//		f_mensaje ("debug","voy a continuar, no tengo que amortizar el elemento " + string(elemento) +&
//		" porque no tiene % de amortizacion")		
	CONTINUE // si no tiene % de amort. no procesar
  end if
	
	datetime dfecha_datetime 
	
	dfecha_datetime = datetime(dfecha)
	

	
  SELECT COUNT(*) INTO :cuantos FROM act_amortizaciones
   WHERE act_amortizaciones.empresa = :empresa
     AND act_amortizaciones.elemento = :elemento
     AND act_amortizaciones.actualizado ='S'
     AND act_amortizaciones.fecha_amor > :dfecha_datetime;

	  if sqlca.sqlcode <> 0 then
		messagebox("Error","Comprobando nº de amortizaciones acualizadas ")
	end if

  IF isnull(cuantos) THEN cuantos = 0 
  IF cuantos > 0 THEN 
//		f_mensaje ("debug","voy a continuar, no tengo que amortizar el elemento " + string(elemento) +&
//		" porque tiene amort. act. con fecha > ")		
		CONTINUE // si tiene amort. act. con fecha > no procesar
  end if
  f_borratodoN(empresa,elemento,dfecha) //borra amortizaciones no actualizadas
  If not f_VersiAmortizo(empresa,elemento,dfecha,fechain,amortizado,amortizadofis,xbase) THEN	
//	f_mensaje ("debug","voy a continuar, no tengo que amortizar el elemento " + string(elemento))
	CONTINUE 
  end if
  F_CreaAmortizacion("P",empresa,elemento,DateTime(fechain),DateTime(dfecha),amortizado,amortizadofis,xbase) 
	
	
  dec elemento_decimal
	elemento_decimal = dec(elemento)


   SELECT act_bienesdet.empresa,act_bienesdet.elemento
	INTO :emp,:ele
	FROM act_bienesdet
   WHERE act_bienesdet.empresa = :empresa
   AND act_bienesdet.elemento <> :elemento_decimal
   AND act_bienesdet.padre = :elemento_decimal ;
	
//	if sqlca.sqlcode <> 0 then
//		messagebox("Error","Detalle de elemento " )
//	end if
	
	emp = trim(emp)

	
  IF sqlca.sqlcode = 0 THEN // --Tiene hijo
    f_borratodoN(emp,ele,dfecha)  //--borra amortizaciones no actualizadas
   
    If f_VersiAmortizo(emp,ele,dfecha,fechain,amortizado,amortizadofis,xbase) then
      F_CreaAmortizacion("H", emp,ele,DateTime(fechain), DateTime(dfecha), amortizado, amortizadofis, xbase) 
    END IF
  END IF
NEXT

Destroy ds_bienesdet

f_mensaje("Aviso","PROCESO CONCLUIDO") 
end subroutine

public function boolean f_versiamortizo (string empresa, decimal elemento, date fecha2, ref date ultimafecha, ref decimal amortizado, ref decimal amortizadofis, ref decimal xbase);Decimal	xbajabase,xbajaamor,importe,inicial
DateTime	fechahora,fecha2_datetime
Date		fechainamor


SELECT act_bienesdet.fechainamor,   
		act_bienesdet.importe,
		act_bienesdet.amor_acumulada
 INTO :fechahora,   
		:importe,
		:inicial
 FROM act_bienesdet  
WHERE ( act_bienesdet.empresa = :empresa ) AND  
		( act_bienesdet.elemento = :elemento )   ;

if sqlca.sqlcode <> 0 then
	messagebox("Error","Comprobando la amortización")	
end if	

fechainamor = Date(fechahora)
IF isnull(inicial) THEN inicial = 0 

SetNull(fechahora)

 SELECT max(fecha_amor) INTO :fechahora  
 FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
   AND act_amortizaciones.elemento = :elemento
   AND act_amortizaciones.actualizado = 'S';

	if sqlca.sqlcode <> 0 then
	 messagebox("Error de selección","2ª selección f_versiamortizo")
	end if


IF isnull(fechahora) THEN 
	ultimafecha = RelativeDate(fechainamor,-1)
Else
	ultimafecha = Date(fechahora)
End If
	

IF ultimafecha >= fecha2 THEN    Return False 

IF YEAR(ultimafecha) < YEAR(fecha2) THEN 
   ultimafecha = mdy(1,1,YEAR(fecha2))
ELSE 
   ultimafecha = RelativeDate(ultimafecha , 1)
 END IF


 SELECT sum(importe_amor),SUM(importe_amorfis) 
   INTO :amortizado,:amortizadofis
   FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
    AND act_amortizaciones.elemento = :elemento
    AND act_amortizaciones.actualizado = 'S';

	if sqlca.sqlcode <> 0 then
	 messagebox("Error de selección","3ª selección f_versiamortizo")
	end if	 
	 
 IF isnull(amortizado) THEN amortizado = 0 
 IF isnull(amortizadofis) THEN amortizadofis = 0 
 
 amortizado = amortizado + inicial
 amortizadofis = amortizadofis + inicial

fecha2_datetime = datetime(fecha2)

 SELECT sum(ibajabase),sum(ibajaamor)
 INTO :xbajabase,:xbajaamor 
 FROM act_bajas
  WHERE act_bajas.empresa = :empresa
    AND act_bajas.elemento = :elemento
    AND act_bajas.fechaba  < :fecha2_datetime;

	if sqlca.sqlcode <> 0 then
	 messagebox("Error de selección","4ª selección f_versiamortizo")
	end if

 IF isnull(xbajabase) then xbajabase = 0 
 IF isnull(xbajaamor) then xbajaamor = 0 
 amortizado = amortizado - xbajaamor
 xbase      = importe - xbajabase
 IF amortizado > xbase THEN 
	Return False
 Else
	Return True
 End If
end function

public subroutine f_calculaamort (character padre, string empresa, decimal elemento, amortizaciones am, decimal amortizado, decimal amortizadofis, decimal xbase, datetime fecha1, datetime fecha2);Decimal	pte,ptefis,xnetopadre,xbasepadre,importe_amor_min,importe_amorfis_min
Decimal	amortizadopadre,xbajabase,xbajaamor
Integer 	diasanyo,diasperiodo,importepadre,xbajabasepadre,xbajaamorpadre 			
String	a_clase_amor	
Decimal  a_importe,a_porcentaje_amor,a_cuota_amor,a_fiscal,a_padre,a_clasinmob,coef_degr
DateTime	a_fechacompra



  SELECT act_bienesdet.importe,   
         act_bienesdet.porcentaje_amor,   
         act_bienesdet.clase_amor,   
         act_bienesdet.cuota_amor,
         act_bienesdet.fiscal,
         act_bienesdet.padre,
			act_bienesdet.fechacompra,
			act_bienesdet.clase_inmobilizado,
			act_bienesdet.coef_degr
    INTO :a_importe,   
         :a_porcentaje_amor,   
         :a_clase_amor,   
         :a_cuota_amor,
			:a_fiscal,
			:a_padre,
			:a_fechacompra,
			:a_clasinmob,
			:coef_degr
    FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :empresa) AND  
         ( act_bienesdet.elemento = :elemento )   ;

if sqlca.sqlcode <> 0 then
	messagebox("Error"," 1º Selección en f_calculaamort")	
end if



 a_clase_amor   	=	 trim(a_clase_amor)	


 IF padre = "P" THEN
   diasanyo=DaysAfter(mdy(01,01,am.ejercicio),mdy(12,31,am.ejercicio)) + 1
	diasperiodo = DaysAfter(Date(fecha1), Date(fecha2) ) + 1
   CHOOSE CASE a_clase_amor
      case "L"
       // --cuota anual
       am.importe_amor 	= ((xbase * a_porcentaje_amor) / 100)
       am.importe_amorfis	= ((xbase * a_fiscal) / 100)
       // --cuota del periodo
       am.importe_amor 	= (am.importe_amor * diasperiodo) / diasanyo
       am.importe_amorfis	= (am.importe_amorfis * diasperiodo) / diasanyo
       IF amortizado + am.importe_amor > xbase THEN
         am.importe_amor 	= xbase - amortizado
       END IF
       IF amortizadofis + am.importe_amorfis > xbase THEN
         am.importe_amorfis = xbase - amortizadofis
       END IF
		 
		case "R"
       pte 	= a_importe - amortizado
       ptefis	= a_importe - amortizadofis
       // --cuota anual
       am.importe_amor 	= (pte) * a_porcentaje_amor / 100
       am.importe_amorfis	= (ptefis) * a_fiscal / 100
       // --cuota del periodo
       am.importe_amor 	= (am.importe_amor * diasperiodo) / diasanyo
       am.importe_amorfis	= (am.importe_amorfis * diasperiodo) / diasanyo


		// FSF 28/09/99
		// Cambio de criterio en Cerámicas Mijares
		// ¿Aplicable a otras empresas?

		// Nuevo criterio : 
		// si la amortización degresiva es menor que la calculada con un cierto coeficiente que indica
		// un porcentaje mínimo, entonces hay que amortizar todo lo pendiente

		f_mensaje("debug","xbase: " + string(xbase)+char(13)+"Coef:" + string(coef_degr))
		
		
       importe_amor_min 	= ((xbase * coef_degr) / 100)
       importe_amor_min	= (importe_amor_min * diasperiodo) / diasanyo
       importe_amorfis_min	= importe_amor_min
       IF amortizado + importe_amor_min > xbase THEN
         importe_amor_min 	= xbase - amortizado
       END IF
       IF amortizadofis + importe_amorfis_min > xbase THEN
         importe_amorfis_min = xbase - amortizadofis
       END IF

		//f_mensaje("debug","Calc: " + string(am.importe_amor)+char(13)+"Min:" + string(importe_amor_min))
		
		If am.importe_amor < importe_amor_min then am.importe_amor = a_importe - amortizado
		If am.importe_amorfis < importe_amorfis_min then am.importe_amorfis = a_importe - amortizadofis

		
		// Antiguo criterio : 
		// si la amortización degresiva es menor que la cálculada para la amortización lineal 
		// con el porcentaje mínimo, entonces hay que amortizar todo lo pendiente

			 
/*			SELECT act_clase.por_minlineal  
			 INTO :pormin  
			 FROM act_clase  
			WHERE ( act_clase.empresa = empresa ) AND  
					( act_clase.clase = :a_clasinmob )   ;
					
       importe_amor_lin 	= ((xbase * pormin) / 100)
       importe_amorfis_lin	= ((xbase * a_fiscal) / 100)
       // --cuota del periodo
       importe_amor_lin	= (importe_amor_lin * diasperiodo) / diasanyo
       importe_amorfis_lin	= (importe_amorfis_lin * diasperiodo) / diasanyo
       IF amortizado + importe_amor_lin > xbase THEN
         importe_amor_lin 	= xbase - amortizado
       END IF
       IF amortizadofis + importe_amorfis_lin > xbase THEN
         importe_amorfis_lin = xbase - amortizadofis
       END IF


			If am.importe_amor < importe_amor_lin then am.importe_amor = a_importe - amortizado
			If am.importe_amorfis < importe_amorfis_lin then am.importe_amorfis = a_importe - amortizadofis
	*/	 
		case "F"
       am.importe_amor 	= a_cuota_amor
       am.importe_amorfis	= a_cuota_amor
       IF amortizado + am.importe_amor > xbase THEN
         am.importe_amor 	= xbase - amortizado
       END IF
       IF amortizadofis + am.importe_amorfis > xbase THEN
         am.importe_amorfis = xbase - amortizadofis
       END IF
	 END choose
    amortizado 	= amortizado + am.importe_amor 
    amortizadofis 	= amortizadofis + am.importe_amorfis
 ELSE
    // --Valor neto contable del padre a fecha de alta del hijo


    SELECT sum(importe_amor) 
	 INTO :amortizadopadre 
	 FROM act_amortizaciones
     WHERE act_amortizaciones.empresa = :empresa
       AND act_amortizaciones.elemento = :a_padre   
       AND act_amortizaciones.actualizado = "S"
       AND act_amortizaciones.fecha_amor <= :a_fechacompra;
		 
		If sqlca.sqlcode<>0 then 
//			f_mensaje("debug","Error 2º selecciób en f_calculaamort")
		End If
		 
    IF isnull(amortizadopadre) THEN amortizadopadre = 0 


    SELECT sum(ibajabase),sum(ibajaamor)
	 INTO :xbajabasepadre,:xbajaamorpadre
      FROM act_bajas
     WHERE act_bajas.empresa = :empresa
       AND act_bajas.elemento = :a_padre    
       AND act_bajas.fechaba  <= :a_fechacompra ;
		 
		If sqlca.sqlcode<>0 then 
//			f_mensaje("debug","Error 3ª selección en f_calculaamort")
		End If
		
    IF isnull(xbajabasepadre) then xbajabasepadre = 0 
    IF isnull(xbajaamorpadre) then xbajaamorpadre = 0 
	 


    SELECT importe 
	 INTO :importepadre 
	 FROM act_bienesdet
     WHERE act_bienesdet.empresa = :empresa
       AND act_bienesdet.elemento = :a_padre;

 		If sqlca.sqlcode<>0 then 
//			f_mensaje("debug","Error 4º selección en f_calculaamort ")
		End If	 
	 
	 //--base del padre a la creacion del hijo

    amortizadopadre	= amortizadopadre - xbajaamorpadre
    xbasepadre 	= importepadre - xbajabasepadre
    xnetopadre 	= xbasepadre -amortizadopadre
    IF amortizadopadre 	= xbasepadre THEN
      am.importe_amor = xbase - amortizado
     ELSE
		

		
      SELECT sum(importe_amor) 
		INTO :amortizadopadre 
		FROM act_amortizaciones
       WHERE act_amortizaciones.empresa = :empresa
         AND act_amortizaciones.elemento = :a_padre   
		   AND act_amortizaciones.fecha_amor BETWEEN :fecha1 AND :fecha2;
			
 		If sqlca.sqlcode<>0 then 
//			f_mensaje("debug","Error 5º selección en f_calculaamort ")
		End If	 

			
      IF isnull(amortizadopadre) THEN amortizadopadre = 0 
		//--amortizacion padre / valor neto inicial padre * importe hijo
      am.importe_amor = (amortizadopadre/xnetopadre)* a_importe 
    END IF
END IF
 IF am.importe_amor < 1 THEN
//	f_mensaje("debug","El importe es de " + string(am.importe_amor ))
   RETURN 
 END IF
 


 SELECT MAX(amortizacion) 
 INTO :am.amortizacion 
 FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
    AND act_amortizaciones.elemento = :am.elemento
    AND act_amortizaciones.amortizacion >= 0 ;

		If sqlca.sqlcode<>0 then 
//			f_mensaje("debug","Error 6º selección en f_calculaamort ")
		End If	 	 
	 
 IF isnull(am.amortizacion) THEN am.amortizacion = 0 
 am.amortizacion = am.amortizacion + 1
 IF isnull(am.importe_amorfis) THEN am.importe_amorfis = 0 
 

// f_mensaje("debug","Insertando las amortizaciones.")

  INSERT INTO act_amortizaciones  
         ( empresa,   
           elemento,   
           amortizacion,   
           ejercicio,   
           clase_inmobilizado,   
           familia,   
           bien,   
           periodo,   
           fecha_amor,   
           tipo_amor,   
           clase_amor,   
           porcentaje_amor,   
           importe_amor,   
           cuenta_activo,   
           cuenta_cargo,   
           cuenta_abono,   
           seccion,   
           centro_coste,   
           fecha_contable,   
           asiento,   
           actualizado,   
           importe_amorfis )  
  VALUES ( :empresa,   
           :elemento,   
           :am.amortizacion,   
           :am.ejercicio,   
           :am.clase_inmobilizado,   
           :am.familia,   
           :am.bien,   
           :am.periodo,   
           :am.fecha_amor,   
           :am.tipo_amor,   
           :a_clase_amor,   
           :am.porcentaje_amor,   
           :am.importe_amor,   
           :am.cuenta_activo,   
           :am.cuenta_cargo,   
           :am.cuenta_abono,   
           :am.seccion,   
           :am.centro_coste,   
           :am.fecha_contable,   
           :am.asiento,   
           :am.actualizado,   
           :am.importe_amorfis )  ;
       	  
			  
 If sqlca.sqlcode<>0 then f_mensaje("Error"," En f_calculaamort insertando amortización " + sqlca.sqlerrtext)

 insertadas = insertadas + 1
 
 st_generadas.text = "Amortizaciones Generadas : " + string(insertadas)
end subroutine

public subroutine f_creaamortizacion (string padre, string empresa, decimal elemento, datetime fecha1, datetime fecha2, decimal amortizado, decimal amortizadofis, decimal xbase);Decimal	laamor,xbajabase,xbajaamor,diasanyo,diasperiodo
String   familia,cuenta_activo,cuenta_cargo,tipo_amor,centro_coste,clase_inmobilizado
Decimal  bien ,porcentaje_amor	
amortizaciones	am

am.empresa = empresa
am.elemento	= elemento

  SELECT act_bienesdet.familia,   
         act_bienesdet.bien,   
         act_bienesdet.cuenta_activo,   
         act_bienesdet.cuenta_cargo,   
         act_bienesdet.cuenta_abono,   
         act_bienesdet.tipo_amor,   
         act_bienesdet.centro_coste,   
         act_bienesdet.seccion,   
         act_bienesdet.clase_inmobilizado,   
         act_bienesdet.porcentaje_amor  
    INTO :am.familia,   
         :am.bien,   
         :am.cuenta_activo,   
         :am.cuenta_cargo,   
         :am.cuenta_abono,   
         :am.tipo_amor,   
         :am.centro_coste,   
         :am.seccion,   
         :am.clase_inmobilizado,   
         :am.porcentaje_amor      
	FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :empresa) AND  
         ( act_bienesdet.elemento = :elemento )   ;

	if sqlca.sqlcode <> 0 then
		messagebox("Error","Recuperando datos proceso de cálculo, función f_creaamortización")
	end if



	am.familia 				= trim(am.familia)
   am.cuenta_activo   	= trim(am.cuenta_activo)
   am.cuenta_cargo   	= trim(am.cuenta_cargo)
   am.cuenta_abono		= trim(am.cuenta_abono)   
   am.tipo_amor   		= trim(am.tipo_amor)	
   am.centro_coste		= trim(am.centro_coste)	   
   am.seccion				= trim(am.seccion)	   

		

   am.asiento 		= 0
   am.actualizado = 'N'
   setnull(am.fecha_contable)

 am.fecha_amor 	= fecha2
 am.ejercicio 	= year(Date(fecha2))

 SetNull(am.periodo)
 
 SELECT max(periodo) 
 INTO :am.periodo  
 FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
   AND act_amortizaciones.elemento = :elemento
   AND act_amortizaciones.actualizado = 'S'
   AND act_amortizaciones.ejercicio = :am.ejercicio;

	if sqlca.sqlcode <> 0 then
		messagebox("Error","Calculando el último periodo sin actualización")
	end if
	
	
 IF isnull(am.periodo) THEN am.periodo = 0 
 am.periodo = am.periodo + 1
 F_CalculaAmort(padre,empresa,elemento,am,amortizado,amortizadofis,xbase,fecha1,fecha2)
end subroutine

on w_act_amortizaciones.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_delemento=create em_delemento
this.st_2=create st_2
this.em_helemento=create em_helemento
this.st_helemento=create st_helemento
this.em_fecha=create em_fecha
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_ejercicio=create uo_ejercicio
this.st_delemento=create st_delemento
this.st_generadas=create st_generadas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_delemento
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_helemento
this.Control[iCurrent+5]=this.st_helemento
this.Control[iCurrent+6]=this.em_fecha
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.uo_ejercicio
this.Control[iCurrent+11]=this.st_delemento
this.Control[iCurrent+12]=this.st_generadas
end on

on w_act_amortizaciones.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_delemento)
destroy(this.st_2)
destroy(this.em_helemento)
destroy(this.st_helemento)
destroy(this.em_fecha)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_ejercicio)
destroy(this.st_delemento)
destroy(this.st_generadas)
end on

event open;call super::open;//f_mensaje("Aviso","Esta aplicación no funciona completamente." + char(13) +&
//"Para generar las amortizaciones, utilice el programa de regeneración del plan de amortizaciones para el/los elemento/s elegido/s.")
//close(this)
//return


istr_parametros.s_titulo_ventana = "Generación de Amortizaciones" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

em_fecha.text=String(today(),"dd-mm-yyyy")

 Integer registros
 String 	cadena
 
 Select count(*) Into :registros From act_bienesdet
 Where  act_bienesdet.empresa = :codigo_empresa;
 IF registros>0  Then
	
	Select max(act_bienesdet.elemento)
		Into   :em_helemento.text
		From   act_bienesdet
	Where  act_bienesdet.empresa = :codigo_empresa;
	
	cadena = f_desc_bienesdet(codigo_empresa,Dec(em_helemento.text))
	st_helemento.text = cadena
	
	Select min(act_bienesdet.elemento)
		Into   :em_delemento.text
		From   act_bienesdet
	Where  act_bienesdet.empresa = :codigo_empresa;
	
	cadena = f_desc_bienesdet(codigo_empresa,Dec(em_delemento.text))
	st_delemento.text = cadena

END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_act_amortizaciones
integer x = 59
integer y = 1032
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_act_amortizaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_act_amortizaciones
end type

type st_1 from statictext within w_act_amortizaciones
integer x = 37
integer y = 312
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde Elemento"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_delemento from u_em_campo within w_act_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 308
integer width = 393
integer taborder = 20
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_delemento.SetFocus()
	return
Else
	st_delemento.text = cadena
End If

end event

type st_2 from statictext within w_act_amortizaciones
integer x = 55
integer y = 420
integer width = 466
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta Elemento"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_helemento from u_em_campo within w_act_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 416
integer width = 393
integer taborder = 30
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_helemento.SetFocus()
	return
Else
	st_helemento.text = cadena
End If

end event

type st_helemento from statictext within w_act_amortizaciones
integer x = 928
integer y = 428
integer width = 1129
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_act_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 200
integer width = 293
integer taborder = 10
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event getfocus;call super::getfocus;   ue_datawindow     = ""
   ue_titulo         = ""
   ue_filtro         = ""
end event

event modificado;call super::modificado;// FSF 23/12/98
// El siguiente control no parece muy correcto porque podemos querer
// actualizar un elemento hasta una fecha que no sea fin de mes 
// ya que lo podemos dar de baja a mitad de mes

//If not f_verifecha(Date(em_fecha.text)) then
//	f_mensaje("","Fecha no Permitida. Introduzca el último dia del mes.")
//	em_fecha.SetFocus()
//END IF

end event

type st_4 from statictext within w_act_amortizaciones
integer x = 201
integer y = 208
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F. Amort."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_act_amortizaciones
integer x = 2240
integer y = 216
integer width = 329
integer height = 108
integer taborder = 60
string text = "&Procesar"
end type

event clicked;// FSF 23/12/98
// El siguiente control no parece muy correcto porque podemos querer
// actualizar un elemento hasta una fecha que no sea fin de mes 
// ya que lo podemos dar de baja a mitad de mes

//If not f_verifecha(Date(em_fecha.text)) then
//	f_mensaje("","Fecha no Permitida. Introduzca el último dia del mes.")
//	em_fecha.SetFocus()
//	Return
//END IF


IF isnull(em_delemento.text) or trim(em_delemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento desde.")
	em_delemento.SetFocus()
	Return
END IF


IF isnull(em_helemento.text) or trim(em_helemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento hasta.")
	em_helemento.SetFocus()
	Return
END IF


IF Dec(em_helemento.text) < Dec(em_delemento.text) THEN
	f_mensaje("Error","DESDE MAYOR QUE HASTA")
	em_delemento.SetFocus()
	Return
END IF

f_proceso(codigo_empresa,Date(em_fecha.text),em_delemento.text,em_helemento.text)

end event

type cb_2 from u_boton within w_act_amortizaciones
integer x = 2240
integer y = 344
integer width = 329
integer height = 108
integer taborder = 70
string text = "&Salir"
end type

event clicked;call super::clicked;Close(Parent)
end event

type uo_ejercicio from u_ejercicio within w_act_amortizaciones
event destroy ( )
integer x = 1413
integer y = 200
integer taborder = 40
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_delemento from statictext within w_act_amortizaciones
integer x = 928
integer y = 312
integer width = 1129
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_generadas from statictext within w_act_amortizaciones
integer x = 910
integer y = 552
integer width = 832
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Amortizaciones Generadas : "
boolean focusrectangle = false
end type

