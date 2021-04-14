$PBExportHeader$w_plan_amortizaciones.srw
forward
global type w_plan_amortizaciones from w_int_con_empresa
end type
type st_1 from statictext within w_plan_amortizaciones
end type
type em_delemento from u_em_campo within w_plan_amortizaciones
end type
type st_2 from statictext within w_plan_amortizaciones
end type
type em_helemento from u_em_campo within w_plan_amortizaciones
end type
type st_helemento from statictext within w_plan_amortizaciones
end type
type cb_1 from u_boton within w_plan_amortizaciones
end type
type cb_2 from u_boton within w_plan_amortizaciones
end type
type st_delemento from statictext within w_plan_amortizaciones
end type
type st_generadas from statictext within w_plan_amortizaciones
end type
type kk from structure within w_plan_amortizaciones
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
	string		clase_amor
end type

global type w_plan_amortizaciones from w_int_con_empresa
integer width = 2761
integer height = 720
string title = "Generación de Amortizaciones"
st_1 st_1
em_delemento em_delemento
st_2 st_2
em_helemento em_helemento
st_helemento st_helemento
cb_1 cb_1
cb_2 cb_2
st_delemento st_delemento
st_generadas st_generadas
end type
global w_plan_amortizaciones w_plan_amortizaciones

type variables
Integer 	insertadas
String	ultima
end variables

forward prototypes
public function boolean f_veranual (string empresa, decimal elemento)
public subroutine f_planprovis (string empresa, decimal elemento)
public subroutine f_proceso ()
public subroutine f_sacadehasta (string empresa, decimal elemento, datetime lafe, ref decimal dias, ref decimal elpe, ref datetime f2)
end prototypes

public function boolean f_veranual (string empresa, decimal elemento);Dec	amortizado,importe,restoprevisto

amortizado = 0

SELECT sum(importe_amor) 
into :amortizado
  FROM act_amortizaciones
 WHERE act_amortizaciones.empresa = :empresa
   AND act_amortizaciones.elemento = :elemento
   AND act_amortizaciones.actualizado = "S";
	
IF isnull(amortizado) THEN amortizado = 0 

DELETE FROM act_amortizaciones
 WHERE act_amortizaciones.empresa = :empresa
   AND act_amortizaciones.elemento = :elemento
   AND act_amortizaciones.actualizado = "N";
	
  SELECT act_bienesdet.importe,   
         act_bienesdet.restoprevisto  
    INTO :importe,
	 		:restoprevisto   
    FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :empresa) AND  
         ( act_bienesdet.elemento = :elemento )   ;
	
	
IF amortizado > importe - restoprevisto THEN
  f_mensaje("ERROR","SE PASA")
//  MESSAGEBOX("ELEMENTO",ELEMENTO)
  RETURN True
 ELSE
  RETURN False
END IF
end function

public subroutine f_planprovis (string empresa, decimal elemento);Amortizaciones	a
DateTime	dt1,dt2,dt3
Datetime		fechain,fecha_nula,fecha2
Integer	diasanyo
Dec		amortizado,inicial,xbajabase,xbajaamor,xbajaresto,diasperiodo,base,pte 
Dec		importe,restoprevisto,porcentaje_amor,n12,n1,n3,valor,cuota_amor
Dec		fiscal,amortizado_fiscal,importe_amor_min,importe_amorfis_min,coef_degr
String	c1,c2,c3,c4,clase_amor,c6,c7,c8,c9,c10,c11

SELECT act_bienesdet.clase_inmobilizado,   
	act_bienesdet.familia,   
	act_bienesdet.bien,   
	act_bienesdet.tipo_amor,   
	act_bienesdet.clase_amor,   
	act_bienesdet.porcentaje_amor,   
	act_bienesdet.cuenta_activo,   
	act_bienesdet.cuenta_cargo,   
	act_bienesdet.cuenta_abono,   
	act_bienesdet.seccion,   
	act_bienesdet.centro_coste,
	act_bienesdet.fechainamor,
	act_bienesdet.importe,
	act_bienesdet.restoprevisto,
	act_bienesdet.cuota_amor,
	act_bienesdet.fiscal,
	act_bienesdet.coef_degr
INTO :n1,   
	:c2,   
	:n3,   
	:c4,   
	:clase_amor,   
	:porcentaje_amor,   
	:c7,   
	:c8,   
	:c9,   
	:c10,   
	:c11,
	:dt1,
	:importe,
	:restoprevisto,
	:cuota_amor,
	:fiscal,
	:coef_degr
FROM act_bienesdet  
WHERE ( act_bienesdet.empresa = :codigo_empresa ) AND  
	( act_bienesdet.elemento = :elemento )   ;


c2 			= trim(c2)
c4 			= trim(c4)
clase_amor 	= trim(clase_amor)
c6				= trim(c6)
c7				=	trim(c7)
c8				=	trim(c8)
c9				=	trim(c9)
c10			=	trim(c10)
c11			=	trim(c11)




SetNull(fecha_nula)

If sqlca.sqlcode= 0 then
	
	a.empresa = empresa
	a.elemento = elemento
	a.fecha_contable = fecha_nula
	a.asiento = 0
	a.actualizado = "N"

	If not isnull(n1) then a.clase_inmobilizado = n1
	If not isnull(c2) then a.familia = c2
	If not isnull(n3) then a.bien = n3
	If not isnull(c4) then a.tipo_amor = c4
	If not isnull(clase_amor) then a.clase_amor = clase_amor
	If not isnull(porcentaje_amor) then a.porcentaje_amor = porcentaje_amor
	If not isnull(fiscal) then a.fiscal = fiscal
	If not isnull(c7) then a.cuenta_activo = c7
	If not isnull(c8) then a.cuenta_cargo = c8
	If not isnull(c9) then a.cuenta_abono = c9
	If not isnull(c10) then a.seccion = c10
	If not isnull(c11) then a.centro_coste = c11
	
	If not isnull(dt1) then fecha2 = dt1	
	If isnull(restoprevisto) then restoprevisto = 0
	If isnull(importe) then importe = 0
	If isnull(cuota_amor) then cuota_amor = 0
Else
	f_mensaje("Error en select",String(sqlca.sqlcode) + ' ' + sqlca.sqlerrtext)
End If

ultima = "N"

 SetNull(dt3)
 
 SELECT max(fecha_amor) 
 INTO :dt3
  FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
    AND act_amortizaciones.elemento = :elemento;
	 
IF isnull(dt3) THEN 
	fechain = fecha2
Else
	fechain = datetime(RelativeDate(date(dt3),1))
End If
 
a.ejercicio = year(date(fechain))

f_sacadehasta(empresa,elemento,fechain,diasperiodo,a.periodo,a.fecha_amor)
// cambia el valor de diasperiodo,a.periodo,a.fecha_amor

 SELECT sum(importe_amor) 
 INTO :amortizado
   FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
    AND act_amortizaciones.elemento = :elemento
    AND act_amortizaciones.fecha_amor < :fechain;
	 
 IF isnull(amortizado) THEN amortizado = 0 

   SELECT act_bienesdet.amor_acumulada  
    INTO :inicial  
    FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :empresa ) AND  
         ( act_bienesdet.elemento = :elemento )   ;
	 
 IF isnull(inicial) THEN inicial = 0 
 
 amortizado = amortizado + inicial

// amort. fiscal
  SELECT sum(importe_amorfis) 
 INTO :amortizado_fiscal
   FROM act_amortizaciones
  WHERE act_amortizaciones.empresa = :empresa
    AND act_amortizaciones.elemento = :elemento
    AND act_amortizaciones.fecha_amor < :fechain;
	 
 IF isnull(amortizado_fiscal) THEN amortizado_fiscal= 0 
 amortizado_fiscal = amortizado_fiscal + inicial

   SELECT sum(ibajabase),sum(ibajaamor),sum(ibajaresto)
     INTO :xbajabase,:xbajaamor,:xbajaresto
     FROM act_bajas
    WHERE act_bajas.empresa = :empresa
      AND act_bajas.elemento =:elemento
      AND act_bajas.fechaba < :fechain;
		
 IF isnull(xbajabase) then xbajabase = 0 
 IF isnull(xbajaamor) then xbajaamor = 0 
 IF isnull(xbajaresto) then xbajaresto = 0 
 amortizado = amortizado - xbajaamor
 amortizado_fiscal = amortizado_fiscal - xbajaamor
 base = importe - xbajabase - (restoprevisto -xbajaresto)

 diasanyo=DaysAfter(mdy(1,1,a.ejercicio),mdy(12,31,a.ejercicio)) + 1

DO WHILE amortizado <= base
	
  CHOOSE CASE clase_amor
    CASE "L"
	   a.importe_amor = ((base * porcentaje_amor) / 100)
   	a.importe_amor = (a.importe_amor * diasperiodo) / diasanyo
	   IF amortizado + a.importe_amor > base THEN
   		a.importe_amor = base - amortizado
	   END IF
		// amortizacion fiscal
	   a.importe_amorfis = ((base * fiscal) / 100)
   	a.importe_amorfis = (a.importe_amorfis * diasperiodo) / diasanyo
	   IF amortizado_fiscal  + a.importe_amorfis > base THEN
   		a.importe_amorfis = base - amortizado_fiscal 
	   END IF		
   CASE "F"
		a.importe_amor = cuota_amor
	  	IF amortizado + a.importe_amor > base THEN
			a.importe_amor = base - amortizado
		END IF
		// amortizacion fiscal
		a.importe_amorfis = cuota_amor
	  	IF amortizado_fiscal  + a.importe_amorfis > base THEN
			a.importe_amorfis = base - amortizado_fiscal 
		END IF
	case "R" 
      pte = base - amortizado
      a.importe_amor = (pte) * porcentaje_amor / 100
      a.importe_amor = (a.importe_amor * diasperiodo) / diasanyo	  
	   IF amortizado + a.importe_amor > base THEN
   		a.importe_amor = base - amortizado
	   END IF
		// amortizacion fiscal
      pte = base - amortizado_fiscal 
      a.importe_amorfis = (pte) * fiscal / 100
      a.importe_amorfis = (a.importe_amorfis * diasperiodo) / diasanyo	  
	   IF amortizado_fiscal  + a.importe_amorfis > base THEN
   		a.importe_amorfis = base - amortizado_fiscal 
	   END IF
		
		
		// FSF 28/09/99
		// Cambio de criterio en Cerámicas Mijares
		// ¿Aplicable a otras empresas?

		// Nuevo criterio : 
		// si la amortización degresiva es menor que la calculada con un cierto coeficiente que indica
		// un porcentaje mínimo, entonces hay que amortizar todo lo pendiente

       importe_amor_min 	= ((base * coef_degr) / 100)
       // --cuota del periodo
       importe_amor_min	= (importe_amor_min * diasperiodo) / diasanyo
		 importe_amorfis_min = importe_amor_min
       IF amortizado + importe_amor_min > base THEN
         importe_amor_min 	= base - amortizado
       END IF
       IF amortizado_fiscal + importe_amorfis_min > base THEN
         importe_amorfis_min = base - amortizado_fiscal
       END IF


		If a.importe_amor < importe_amor_min then a.importe_amor = base - amortizado
		If a.importe_amorfis < importe_amorfis_min then a.importe_amorfis = base - amortizado_fiscal 
		
		// Antiguo criterio : 
		// si la amortización degresiva es menor que la cálculada para la amortización lineal 
		// con el porcentaje mínimo, entonces hay que amortizar todo lo pendiente
			 
		/*	SELECT act_clase.por_minlineal  
			 INTO :pormin  
			 FROM act_clase  
			WHERE ( act_clase.empresa = empresa ) AND  
					( act_clase.clase = :a.clase_inmobilizado )   ;
					
       importe_amor_lin 	= ((base * pormin) / 100)
       importe_amorfis_lin	= ((base * fiscal) / 100)
       // --cuota del periodo
       importe_amor_lin	= (importe_amor_lin * diasperiodo) / diasanyo
       importe_amorfis_lin	= (importe_amorfis_lin * diasperiodo) / diasanyo
       IF amortizado + importe_amor_lin > base THEN
         importe_amor_lin 	= base - amortizado
       END IF
       IF amortizado_fiscal + importe_amorfis_lin > base THEN
         importe_amorfis_lin = base - amortizado_fiscal
       END IF


		If a.importe_amor < importe_amor_lin then a.importe_amor = base - amortizado
		If a.importe_amorfis < importe_amorfis_lin then a.importe_amorfis = base - amortizado_fiscal 
*/
	
	END CHOOSE


	amortizado = amortizado + a.importe_amor 
	amortizado_fiscal = amortizado_fiscal+ a.importe_amorfis

// David 28-03-2007 Ponía menor que 1 y lo cambio por 0.001
	IF a.importe_amor < 0.001 THEN 
		EXIT      
	end if
  
	SELECT max(amortizacion) 
	INTO :a.amortizacion
	FROM act_amortizaciones
	WHERE act_amortizaciones.empresa = :empresa
	AND act_amortizaciones.elemento = :elemento;

	IF isnull(a.amortizacion) THEN a.amortizacion = 0 
	a.amortizacion = a.amortizacion + 1

	
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
           :a.amortizacion,   
           :a.ejercicio,   
           :a.clase_inmobilizado,   
           :a.familia,   
           :a.bien,   
           :a.periodo,   
           :a.fecha_amor,   
           :a.tipo_amor,   
           :a.clase_amor,   
           :a.porcentaje_amor,   
           :a.importe_amor,   
           :a.cuenta_activo,   
           :a.cuenta_cargo,   
           :a.cuenta_abono,   
           :a.seccion,   
           :a.centro_coste,   
           :a.fecha_contable,   
           :a.asiento,   
           :a.actualizado,   
           :a.importe_amorfis )  ;

  
 insertadas = insertadas + 1
 
 st_generadas.text = "Amortizaciones Generadas : " + String(insertadas)
 
 fechain = datetime(RelativeDate(date(a.fecha_amor), 1))
 a.ejercicio = year(date(fechain))
 diasanyo = DaysAfter( mdy(01,01,a.ejercicio) , mdy(12,31,a.ejercicio) ) + 1 
 f_sacadehasta(empresa,elemento,fechain,diasperiodo,a.periodo,a.fecha_amor)
// if amortizado = base then
//	exit
// end if
LOOP
end subroutine

public subroutine f_proceso ();DataStore	ds_elementos
String		cadena
Integer		rr,xx
Dec			elemento
Boolean		ok

cadena = "select empresa,elemento FROM act_bienesdet WHERE act_bienesdet.empresa = '" +& 
			codigo_empresa + "' AND act_bienesdet.elemento between " +&
			em_delemento.text + " and " + em_helemento.text + " " +&
			"AND act_bienesdet.fechabaja is null"
//ds_elementos = f_cargar_cursor(cadena)			
f_cargar_cursor_nuevo(cadena, ds_elementos)

insertadas = 0

rr = ds_elementos.RowCount()

FOR xx=1 to rr
	elemento = ds_elementos.GetItemDecimal(xx,"elemento")	
	ok = f_veranual(codigo_empresa,elemento) 
   ultima ="N"
   IF ok THEN CONTINUE 
   f_planprovis(codigo_empresa,elemento)
NEXT

destroy ds_elementos
end subroutine

public subroutine f_sacadehasta (string empresa, decimal elemento, datetime lafe, ref decimal dias, ref decimal elpe, ref datetime f2);decimal	elej 
datetime		f1
String	tipo_amor

f1 = lafe
elej = year(date(lafe))
f2 = datetime(mdy(12,31,elej))

  SELECT act_bienesdet.tipo_amor  
    INTO :tipo_amor  
    FROM act_bienesdet  
   WHERE ( act_bienesdet.empresa = :empresa ) AND  
         ( act_bienesdet.elemento = :elemento )   ;

tipo_amor = trim(tipo_amor)


CHOOSE CASE tipo_amor
   CASE "A"
		elpe = 1
	   f2 = datetime(mdy(12,31,year(date(lafe))))
   CASE "S" 
		IF month(date(lafe)) < 7 THEN
	     f2 = datetime(mdy(06,30,year(date(lafe))))
	     elpe = 1
	   ELSE
	     elpe = 2
      END IF
   CASE "T" 
		IF month(date(lafe)) < 13 THEN
	     elpe       = 4
      END IF
      IF month(date(lafe)) < 10 THEN
			f2 = datetime(mdy(09,30,year(date(lafe))))
		   elpe = 3
      END IF
      IF month(date(lafe)) < 7 THEN
	   	f2 = datetime(mdy(06,30,year(date(lafe))))
			elpe       = 2
      END IF
      IF month(date(lafe)) < 4 THEN
	   	f2 = datetime(mdy(03,31,year(date(lafe))))
			elpe       = 1
		END IF
   CASE "M"
		elpe = month(date(lafe))
	   IF elpe  <> 12 THEN
	   	f2 = datetime(RelativeDate(mdy((elpe+1),01,year(date(lafe))), -1))
		END IF
END CHOOSE


dias = DaysAfter(date(f1),date(f2)) + 1
end subroutine

on w_plan_amortizaciones.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_delemento=create em_delemento
this.st_2=create st_2
this.em_helemento=create em_helemento
this.st_helemento=create st_helemento
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_delemento=create st_delemento
this.st_generadas=create st_generadas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_delemento
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_helemento
this.Control[iCurrent+5]=this.st_helemento
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_delemento
this.Control[iCurrent+9]=this.st_generadas
end on

on w_plan_amortizaciones.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_delemento)
destroy(this.st_2)
destroy(this.em_helemento)
destroy(this.st_helemento)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_delemento)
destroy(this.st_generadas)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Generación de Amortizaciones" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana


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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_plan_amortizaciones
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_plan_amortizaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_plan_amortizaciones
end type

type st_1 from statictext within w_plan_amortizaciones
integer x = 37
integer y = 224
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

type em_delemento from u_em_campo within w_plan_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 220
integer width = 393
integer taborder = 10
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

type st_2 from statictext within w_plan_amortizaciones
integer x = 55
integer y = 360
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

type em_helemento from u_em_campo within w_plan_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 356
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
	em_helemento.SetFocus()
	return
Else
	st_helemento.text = cadena
End If

end event

type st_helemento from statictext within w_plan_amortizaciones
integer x = 928
integer y = 360
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

type cb_1 from u_boton within w_plan_amortizaciones
integer x = 2240
integer y = 216
integer width = 329
integer height = 108
integer taborder = 40
string text = "&Procesar"
end type

event clicked;IF isnull(em_delemento.text) or trim(em_delemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento desde.")
	em_delemento.SetFocus()
	Return
END IF


IF isnull(em_helemento.text) or trim(em_helemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento hasta.")
	em_helemento.SetFocus()
	Return
END IF


IF dec(em_helemento.text) < dec(em_delemento.text) THEN
	f_mensaje("Error","DESDE MAYOR QUE HASTA")
	em_delemento.SetFocus()
	Return
END IF

f_proceso()

f_mensaje("","Regeneración del Plan de Amortizaciones Finalizado.")
end event

type cb_2 from u_boton within w_plan_amortizaciones
integer x = 2240
integer y = 344
integer width = 329
integer height = 108
integer taborder = 50
string text = "&Salir"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_delemento from statictext within w_plan_amortizaciones
integer x = 928
integer y = 224
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

type st_generadas from statictext within w_plan_amortizaciones
integer x = 910
integer y = 508
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

