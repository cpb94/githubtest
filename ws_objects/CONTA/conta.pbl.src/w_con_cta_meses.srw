$PBExportHeader$w_con_cta_meses.srw
$PBExportComments$€
forward
global type w_con_cta_meses from w_int_con_empresa
end type
type em_fechadesde from u_em_campo within w_con_cta_meses
end type
type gb_1 from groupbox within w_con_cta_meses
end type
type cb_consulta from u_boton within w_con_cta_meses
end type
type em_fechahasta from u_em_campo within w_con_cta_meses
end type
type st_1 from statictext within w_con_cta_meses
end type
type pb_imprimir_preli from picturebutton within w_con_cta_meses
end type
type dw_1 from datawindow within w_con_cta_meses
end type
type ddlb_origen from dropdownlistbox within w_con_cta_meses
end type
type st_3 from statictext within w_con_cta_meses
end type
type pb_2 from upb_salir within w_con_cta_meses
end type
type dw_listado from datawindow within w_con_cta_meses
end type
type uo_cuenta from u_em_campo within w_con_cta_meses
end type
type st_nom from statictext within w_con_cta_meses
end type
type gb_cuenta from groupbox within w_con_cta_meses
end type
end forward

global type w_con_cta_meses from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2958
integer height = 2200
string title = "Consulta de Movimientos"
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
ddlb_origen ddlb_origen
st_3 st_3
pb_2 pb_2
dw_listado dw_listado
uo_cuenta uo_cuenta
st_nom st_nom
gb_cuenta gb_cuenta
end type
global w_con_cta_meses w_con_cta_meses

type variables
Integer mes,anyo
String moneda_emp
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public function integer f_dias_mes (integer el_mes, integer el_anyo)
public function decimal f_debe_mes (integer ejer1, string emp, string cuenta, datetime fd, datetime fh, string origend, string origenh)
public function decimal f_haber_mes (integer ejer1, string emp, string cuenta, datetime fd, datetime fh, string origend, string origenh)
end prototypes

public subroutine f_cargar (datawindow dw_data);
String  	origend,origenh,fechin,cuenta
DateTime	fecapu,fperdesde,fperhasta,fejedesde,fejehasta
datetime prime_dia[],ulti_dia[]
int nivel_cuenta,i
int dias[],meses[],anyos[],ejer1,ejer2
date f1,f2
long h 
dec debe,haber

setpointer(hourglass!)

// Controlamos los origenes contables
CHOOSE CASE ddlb_origen.text	
	CASE "Antes Explotación"
		origend = '0'
		origenh = '96'
	CASE "Antes Cierre"
		origend = '0'
		origenh = '97'
	CASE "Todos"
		origend = '0'
		origenh = '99999'
END CHOOSE

cuenta = uo_cuenta.text

ejer1 = year(date(em_fechadesde.text))
ejer2=	year(date(em_fechadesde.text))




f1 = date(em_fechadesde.text)
f2 = date(em_fechahasta.text)

dw_data.SetTransObject(SQLCA)
dw_data.Reset()
dw_data.Retrieve(codigo_empresa,f1,f2,moneda_emp,cuenta)



// meses y años sobre los que se hace la consulta
meses[1] = month(f1)
anyos[1] = year(f1)
prime_dia[1]	=	datetime(date("1/"+string(meses[1])+"/"+string(anyos[1])))
dias[1]			=	f_dias_mes(meses[1],anyos[1])
ulti_dia[1]		=	datetime(date(string(dias[1])+"/"+string(meses[1])+"/"+string(anyos[1])))


for i = 2 to 12
	if meses[i - 1] < 12 then
		meses[i] = meses[i - 1] + 1	
		anyos[i]	= anyos[i - 1]			
	else
		meses[i] =	meses[i - 1] - 12 + 1
		anyos[i]	=	anyos[i - 1] + 1
	end if
	dias[i]	= 	f_dias_mes(meses[i],anyos[i])
	prime_dia[i]	=	datetime(date("1/"+string(meses[i])+"/"+string(anyos[i])))
	ulti_dia[i]		=	datetime(date(string(dias[i])+"/"+string(meses[i])+"/"+string(anyos[i])))
next





for i = 1 to 12
	
	h = h + 1	
	dw_data.insertrow(h)	
	dw_data.setitem(h,"mes",meses[i])

	
	debe = f_debe_mes(anyos[i],codigo_empresa,cuenta,prime_dia[i],ulti_dia[i],origend,origenh)
	haber = f_haber_mes(anyos[i],codigo_empresa,cuenta,prime_dia[i],ulti_dia[i],origend,origenh)
	
	
	dw_data.setitem(h,"debe",debe)
	dw_data.setitem(h,"haber",haber)
	
next


setpointer(arrow!)
end subroutine

public function integer f_dias_mes (integer el_mes, integer el_anyo);int 		resto,dia


CHOOSE CASE  el_mes
	CASE 1,3,5,7,8,10,12
		dia = 31
	CASE 4,6,9,11
		dia = 30
	CASE 2
		resto = mod(el_anyo,4) 
		IF resto = 0 THEN
			dia = 29
		ELSE
			dia = 28
		END IF
end CHOOSE



RETURN dia
end function

public function decimal f_debe_mes (integer ejer1, string emp, string cuenta, datetime fd, datetime fh, string origend, string origenh);dec retorno

cuenta=trim(cuenta)+"%"



  SELECT sum( debe ) 
    INTO :retorno  
    FROM contaapun  
   WHERE 	( contaapun.ejercicio 	= :ejer1 ) 			and
				( contaapun.empresa 		= :emp ) 			AND  
         	( contaapun.cuenta like :cuenta) 			AND
				( contaapun.fapunte between :fd AND :fh) 	and
	  		 	(contaapun.origen BETWEEN :origend AND :origenh
           		OR contaapun.origen = '99' OR contaapun.origen = '100') ;



 
 
 


if isnull(retorno) then retorno=0
return retorno
end function

public function decimal f_haber_mes (integer ejer1, string emp, string cuenta, datetime fd, datetime fh, string origend, string origenh);dec retorno
cuenta=trim(cuenta)+"%"

  SELECT sum( haber ) 
    INTO :retorno  
    FROM contaapun  
   WHERE 	( contaapun.ejercicio 	= :ejer1 ) 			and
				( contaapun.empresa 		= :emp ) 			AND  
         	( contaapun.cuenta like :cuenta) 			AND
				( contaapun.fapunte between :fd AND :fh) 	and
	  		 	(contaapun.origen BETWEEN :origend AND :origenh
           		OR contaapun.origen = '99' OR contaapun.origen = '100') ;

if isnull(retorno) then retorno=0
return retorno
end function

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;str_paramemp	e
int dec_moneda

This.title = "EXTRACTO DE UNA CUENTA POR MESES"

em_fechadesde.text = String(MDY(01,01,Year(Today())))


mes  = Month(Date(em_fechadesde.text))
anyo = Year(today())


e = f_paramemp(codigo_empresa)

moneda_emp = e.moneda_emp

ddlb_origen.text = "Antes Explotación"


f_activar_campo(em_fechadesde)

dec_moneda = f_decimales_moneda(e.moneda_emp)
f_mascara_columna(dw_1,"debe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"haber",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"total_debe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"total_haber",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"total_saldo",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_listado,"debe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"haber",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"total_debe",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"total_haber",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"total_saldo",f_mascara_decimales(dec_moneda))


end event

on w_con_cta_meses.create
int iCurrent
call super::create
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.ddlb_origen=create ddlb_origen
this.st_3=create st_3
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_cuenta=create uo_cuenta
this.st_nom=create st_nom
this.gb_cuenta=create gb_cuenta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_fechadesde
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.ddlb_origen
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.uo_cuenta
this.Control[iCurrent+13]=this.st_nom
this.Control[iCurrent+14]=this.gb_cuenta
end on

on w_con_cta_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.ddlb_origen)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_cuenta)
destroy(this.st_nom)
destroy(this.gb_cuenta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_cta_meses
integer x = 443
integer y = 1360
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_cta_meses
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_cta_meses
integer y = 20
integer width = 2642
end type

type em_fechadesde from u_em_campo within w_con_cta_meses
integer x = 18
integer y = 196
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;int a_mes,a_anyo,n_dia,n_mes,n_anyo

a_mes = month(date(em_fechadesde.text))
a_anyo = year(date(em_fechadesde.text))


if a_mes <> 1 then
	n_mes = a_mes - 1
	n_anyo = a_anyo + 1
else
	n_mes = 12	
	n_anyo = a_anyo  
end if

n_dia = f_dias_mes(n_mes,n_anyo)

	

em_fechahasta.text = string(n_dia) + "/" + string(n_mes) + "/" + string(n_anyo)
end event

type gb_1 from groupbox within w_con_cta_meses
integer x = 9
integer y = 116
integer width = 640
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_cta_meses
integer x = 2309
integer y = 176
integer width = 334
integer height = 92
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;call super::clicked;integer ejer1,ejer2

dw_1.reset()
dw_1.visible = false

ejer1=year(date(em_fechadesde.text))
ejer2=year(date(em_fechahasta.text))



if date(em_fechahasta.text) < date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

IF uo_cuenta.text = "" THEN
	messagebox("Error de datos ","Debe introducir la cuenta",exclamation!)
	uo_cuenta.setfocus()
	return
END IF

if not f_existe_cuenta(ejer1,codigo_empresa,uo_cuenta.text) then
	messagebox("Atención","No existe la cuenta",exclamation!)
	uo_cuenta.setfocus()
	return
end if

if ejer2 <> ejer1 then
	if ejer1 +1 <> ejer2 then
		messagebox("Atención","El año de la fecha hasta ha de ser consecutivo ",exclamation!)
		em_fechahasta.setfocus()
		return
	
	end if
end if

f_cargar(dw_1)

if dw_1.rowcount() > 0 then
	dw_1.visible = true
else
	dw_1.visible = false
end if
end event

type em_fechahasta from u_em_campo within w_con_cta_meses
integer x = 352
integer y = 196
integer width = 279
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_cta_meses
integer x = 297
integer y = 176
integer width = 59
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_con_cta_meses
integer x = 2683
integer y = 176
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;integer ejer1,ejer2




ejer1=year(date(em_fechadesde.text))
ejer2=year(date(em_fechahasta.text))



if date(em_fechahasta.text) < date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

IF uo_cuenta.text = "" THEN
	messagebox("Error de datos ","Debe introducir la cuenta",exclamation!)
	uo_cuenta.setfocus()
	return
END IF

if not f_existe_cuenta(ejer1,codigo_empresa,uo_cuenta.text) then
	messagebox("Atención","No existe la cuenta",exclamation!)
	uo_cuenta.setfocus()
	return
end if

if ejer2 <> ejer1 then
	if ejer1 +1 <> ejer2 then
		messagebox("Atención","El año de la fecha hasta ha de ser consecutivo ",exclamation!)
		em_fechahasta.setfocus()
		return
	
	end if
end if

f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type dw_1 from datawindow within w_con_cta_meses
boolean visible = false
integer x = 160
integer y = 304
integer width = 2446
integer height = 1596
string dataobject = "dw_con_cta_meses"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type ddlb_origen from dropdownlistbox within w_con_cta_meses
integer x = 1902
integer y = 188
integer width = 366
integer height = 304
integer taborder = 40
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Antes Explotación","Antes Cierre","Todos"}
end type

type st_3 from statictext within w_con_cta_meses
integer x = 1902
integer y = 124
integer width = 361
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Orígenes"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_cta_meses
integer x = 2693
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

type dw_listado from datawindow within w_con_cta_meses
boolean visible = false
integer x = 2619
integer y = 296
integer width = 165
integer height = 268
string dataobject = "report_con_cta_meses"
end type

type uo_cuenta from u_em_campo within w_con_cta_meses
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 667
integer y = 196
integer width = 389
integer taborder = 10
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan"

end event

event modificado;call super::modificado;st_nom.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta.text)
If Trim(st_nom.text)="" then
	st_nom.text=""
	uo_cuenta.text=""
	Return
end if 


end event

type st_nom from statictext within w_con_cta_meses
integer x = 1074
integer y = 200
integer width = 763
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type gb_cuenta from groupbox within w_con_cta_meses
integer x = 649
integer y = 116
integer width = 1225
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

