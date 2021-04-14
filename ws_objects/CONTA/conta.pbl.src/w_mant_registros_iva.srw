$PBExportHeader$w_mant_registros_iva.srw
forward
global type w_mant_registros_iva from w_int_con_empresa
end type
type dw_iva from u_datawindow within w_mant_registros_iva
end type
type uo_ejercicio from u_ejercicio within w_mant_registros_iva
end type
type st_2 from statictext within w_mant_registros_iva
end type
type em_fasiento from u_em_campo within w_mant_registros_iva
end type
type pb_salir from upb_salir within w_mant_registros_iva
end type
type cb_nuevo from commandbutton within w_mant_registros_iva
end type
type cb_buscar from commandbutton within w_mant_registros_iva
end type
type em_registro from u_em_campo within w_mant_registros_iva
end type
type st_1 from statictext within w_mant_registros_iva
end type
end forward

global type w_mant_registros_iva from w_int_con_empresa
integer width = 3026
integer height = 1296
dw_iva dw_iva
uo_ejercicio uo_ejercicio
st_2 st_2
em_fasiento em_fasiento
pb_salir pb_salir
cb_nuevo cb_nuevo
cb_buscar cb_buscar
em_registro em_registro
st_1 st_1
end type
global w_mant_registros_iva w_mant_registros_iva

forward prototypes
public subroutine f_ok ()
end prototypes

public subroutine f_ok ();Dec 		ejer,imponible,poriva
Dec{0}	impiva
String 	tp,tipocta
String	var_empresa,var_cuenta,var_diario,var_concepto,var_ampliacion,var_tipoapu,var_documento
String   var_tipoiva,var_deducible,var_actualizado,var_listado,var_origen,var_tipoter,var_clipro
String   var_conciliado,var_nif,var_punteado,var_docpunteo,var_coste,var_moneda,var_factura
Long     var_ejercicio,var_asiento,var_apunte,var_debe,var_haber,var_imponible,var_iva,var_divisas
Long     var_registro,var_cambio,var_mes,var_orden_apunte
Datetime var_fapunte,var_ffactura,var_fvalor,var_fregistro
Dec{3}   var_cambio_euros

ejer = Dec(uo_ejercicio.em_ejercicio.text)

imponible  = dw_iva.GetItemNumber(1,"imponible")
poriva	  = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.GetItemString(1,"tipo_iva"))
tp 		  = dw_iva.GetItemString(1,"tipo_iva")

impiva = imponible * poriva / 100
IF impiva <> dw_iva.GetItemNumber(1,"importe") THEN
	f_mensaje("DESCUADRE","La base imponible no se corresponde con el importe de IVA")
	RETURN
END IF

dw_iva.accepttext()

var_ejercicio    = Dec(uo_ejercicio.em_ejercicio.text)
var_empresa      = codigo_empresa
var_asiento      = 0
var_apunte       = 0
var_cuenta       = "0000000000"
var_fapunte      = dw_iva.GetItemDateTime(1,"fregistro")
SetNull(var_diario)
var_concepto     = "52"
var_ampliacion   = "Registro de IVA Manual "+trim(nombre_usuario)
var_tipoapu      = f_libro_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.GetItemString(1,"tipo_iva"))
var_documento    = dw_iva.GetItemString(1,"factura")
var_factura      = dw_iva.GetItemString(1,"factura")
var_ffactura     = dw_iva.GetItemDateTime(1,"ffactura")
var_imponible    = imponible
var_tipoiva      = tp
var_iva          = poriva
var_divisas      = 0
var_deducible    = "S"
var_actualizado  = "N"
var_listado      = "N"
var_registro     = dw_iva.GetItemNumber(1,"registro")
var_origen       = "0"
var_tipoter      = dw_iva.GetItemString(1,"tipoter")
var_clipro       = dw_iva.GetItemString(1,"clipro")
var_conciliado   = "N"
var_nif          = dw_iva.GetItemString(1,"nif")
var_punteado     = "N"
SetNull(var_fvalor)
SetNull(var_docpunteo)
SetNull(var_coste)
var_fregistro    = dw_iva.GetItemDateTime(1,"fregistro")
var_cambio       = f_cambio_moneda(moneda_empresa_primaria)
var_moneda       = moneda_empresa_primaria
var_mes          = month(date(dw_iva.GetItemDateTime(1,"fregistro")))
var_orden_apunte = var_apunte
var_cambio_euros = 166.386


IF f_tipo_cta_libro(ejer,codigo_empresa,f_libro_contaiva(ejer,codigo_empresa,tp)) = "H" Then
	if dw_iva.GetItemNumber(1,"importe")>0 then
		var_haber = dw_iva.GetItemNumber(1,"importe")
	else
		var_debe  = abs(dw_iva.GetItemNumber(1,"importe"))
	end if
ELSE
	if dw_iva.GetItemNumber(1,"importe")>0 then
		var_debe  = dw_iva.GetItemNumber(1,"importe")
	else
		var_haber = abs(dw_iva.GetItemNumber(1,"importe"))
	end if
END IF
end subroutine

on w_mant_registros_iva.create
int iCurrent
call super::create
this.dw_iva=create dw_iva
this.uo_ejercicio=create uo_ejercicio
this.st_2=create st_2
this.em_fasiento=create em_fasiento
this.pb_salir=create pb_salir
this.cb_nuevo=create cb_nuevo
this.cb_buscar=create cb_buscar
this.em_registro=create em_registro
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_iva
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_fasiento
this.Control[iCurrent+5]=this.pb_salir
this.Control[iCurrent+6]=this.cb_nuevo
this.Control[iCurrent+7]=this.cb_buscar
this.Control[iCurrent+8]=this.em_registro
this.Control[iCurrent+9]=this.st_1
end on

on w_mant_registros_iva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_iva)
destroy(this.uo_ejercicio)
destroy(this.st_2)
destroy(this.em_fasiento)
destroy(this.pb_salir)
destroy(this.cb_nuevo)
destroy(this.cb_buscar)
destroy(this.em_registro)
destroy(this.st_1)
end on

event open;call super::open;This.title = " INTRODUCCION DE REGISTROS DE IVA"
em_fasiento.text = String(Today(),"dd-mm-yy")

dw_iva.SetTransObject(SQLCA)

em_fasiento.SetFocus()

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_registros_iva
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_registros_iva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_registros_iva
integer width = 2706
end type

type dw_iva from u_datawindow within w_mant_registros_iva
integer x = 46
integer y = 480
integer width = 2871
integer height = 560
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_int_registro_iva"
end type

event clicked;call super::clicked;
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_int_registros_iva"

CHOOSE CASE f_objeto_datawindow(dw_iva)
  	CASE 'pb_tipoiva'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_iva")
		OpenWithParm(wi_mant_contaiva,lstr_param)  
	CASE 'ok'
		f_ok()
	CASE 'borrar'
		f_ok()
	CASE 'actualizar'
		f_ok()
END CHOOSE
end event

event itemchanged;Dec imponible,iva
Dec{0} importe,ejer
string tp

AcceptText()
tp = dw_iva.getItemSTring(1,"tipo_iva")
ejer = Dec(uo_ejercicio.em_ejercicio.text)
IF f_tipo_libro(ejer,codigo_empresa,f_libro_contaiva(ejer,codigo_empresa,tp)) = "V" Then
	dw_iva.SetItem(1,"tipoter","C")
ELSE
	dw_iva.SetItem(1,"tipoter","P")
END IF

IF f_objeto_datawindow(dw_iva) = "imponible" Then
	iva = f_iva_contaiva(ejer,codigo_empresa,tp)
	IF IsNull(iva ) Then iva = 0
	imponible = dw_iva.GetItemNumber(1,"imponible")
	IF IsNull(imponible) Then imponible = 0
	importe = imponible * iva / 100
	dw_iva.SetItem(1,"importe",importe)
END IF

end event

event itemfocuschanged;call super::itemfocuschanged;String 	clipro,tipoter,nif,nif2
Dec 		imponible,iva
Dec{0} 	importe,ejer
string 	tp
DateTime f_factura,f_registro

// Santiago - 20/09/00 La fecha del registro de IVA debe ser la fecha de factura
//IF String(Date(dw_iva.getItemDateTime(1,"fregistro"))) = "00-00-00" THEN
f_factura  = dw_iva.GetItemDateTime(1,"ffactura")
f_registro = dw_iva.GetItemDateTime(1,"fregistro")
if isnull(f_registro) or String(Date(dw_iva.getItemDateTime(1,"fregistro"))) = "00-00-00" then
	dw_iva.SetItem(1,"fregistro",f_factura)
end if
//END IF
// Santiago - 20/09/00 La fecha del registro de IVA debe ser la fecha de factura

accepttext()

tp = dw_iva.getItemSTring(1,"tipo_iva")

IF Trim(tp) = "" THEN RETURN

ejer = Dec(uo_ejercicio.em_ejercicio.text)
clipro 	= dw_iva.GetItemString(1,"clipro")
tipoter 	= dw_iva.GetItemString(1,"tipoter")
nif 		= f_cif_genter(codigo_empresa,tipoter,clipro)
nif2 		= dw_iva.GetItemString(1,"nif")

IF IsNUll(nif2) OR Trim(nif2) = "" THEN
	dw_iva.SetItem(1,"nif",nif)
END IF

iva = f_iva_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva"))

IF IsNull(iva ) THEN iva = 0

imponible 	= dw_iva.GetItemNumber(1,"imponible")
IF IsNull(imponible) Then imponible = 0

// Santiago - 20/09/00 Siempre debe calcular el importe del iva
//IF dw_iva.GetItemNumber(1,"importe") = 0 THEN
	importe 		= imponible * iva / 100
	dw_iva.SetItem(1,"importe",importe)
//END IF
// Santiago - 20/09/00 Siempre debe calcular el importe del iva

Dec 		regis
String 	tipo_contador

regis= dw_iva.GetItemNumber(1,"registro") 
IF IsNUll(regis) or regis = 0 THEN
	tipo_contador = f_tipo_contador_contalibros(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,f_libro_contaiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva")))
	IF tipo_contador = "C" THEN
		regis = f_registro_tipoiva(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,dw_iva.getItemSTring(1,"tipo_iva"))
		dw_iva.SetItem(1,"registro",regis)
	END IF
	IF tipo_contador = "F" Then
		dw_iva.SetItem(1,"registro",Dec(dw_iva.getItemSTring(1,"factura")))
	END IF

END IF

end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "tipo_iva"
	bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS"
	bus_datawindow = "dw_ayuda_contaiva"
	bus_filtro     = "ejercicio= " + uo_ejercicio.em_ejercicio.text 
CASE "clipro"
	IF dw_iva.GetITemString(1,"tipoter") = "C" Then
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
	ELSE
		bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
		bus_datawindow = "dw_ayuda_proveedores"
	END IF
	bus_filtro    = ""			

CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key
end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "tipo_iva"
	bus_titulo     = "VENTANA SELECCION DE TIPO DE IVAS"
	bus_datawindow = "dw_ayuda_contaiva"
//		bus_filtro     = "ctaiva = '"+dw_iva.GetItemString(1,"cuenta")+"' and ejercicio= " + uo_ejercicio.em_ejercicio.text 
	bus_filtro     = "ejercicio= " + uo_ejercicio.em_ejercicio.text 
CASE "clipro"
	IF dw_iva.GetITemString(1,"tipoter") = "C" Then
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
	ELSE
		bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
		bus_datawindow = "dw_ayuda_proveedores"
	END IF
	bus_filtro    = ""		
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event valores_numericos;f_valores_numericos(This,"tipo_iva")
f_valores_numericos(This,"clipro")
end event

type uo_ejercicio from u_ejercicio within w_mant_registros_iva
event destroy ( )
integer x = 32
integer y = 160
integer height = 276
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type st_2 from statictext within w_mant_registros_iva
boolean visible = false
integer x = 2245
integer y = 164
integer width = 498
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Fecha Registro"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fasiento from u_em_campo within w_mant_registros_iva
boolean visible = false
integer x = 2245
integer y = 244
integer width = 498
integer taborder = 50
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

event losefocus;call super::losefocus;//IF Dec(Year(date(em_fasiento.text))) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
//	MessageBox("Fecha de Asiento","No coincide el ejercicio con el año de la fecha",Exclamation!)
//	f_activar_campo(em_fasiento)
//END IF
end event

event modified;IF Dec(Year(date(em_fasiento.text))) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
	MessageBox("Fecha de Asiento","No coincide el ejercicio con el año de la fecha",Exclamation!)
	f_activar_campo(em_fasiento)
END IF
IF date(em_fasiento.text) > Today() THEN
	MessageBox("Fecha de Asiento","La fecha es superior a la fecha del sistema",Exclamation!)
	f_activar_campo(em_fasiento)
END IF
end event

type pb_salir from upb_salir within w_mant_registros_iva
integer x = 2830
integer y = 4
integer width = 110
integer height = 96
integer taborder = 20
boolean cancel = false
boolean originalsize = true
string picturename = "exit!"
end type

type cb_nuevo from commandbutton within w_mant_registros_iva
integer x = 731
integer y = 164
integer width = 448
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo Registro"
end type

type cb_buscar from commandbutton within w_mant_registros_iva
integer x = 1198
integer y = 164
integer width = 475
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar Registro"
end type

event clicked;st_1.visible = true
st_2.visible = true
em_registro.visible = true
em_fasiento.visible = true
end event

type em_registro from u_em_campo within w_mant_registros_iva
boolean visible = false
integer x = 1728
integer y = 244
integer width = 498
integer taborder = 11
boolean bringtotop = true
end type

type st_1 from statictext within w_mant_registros_iva
boolean visible = false
integer x = 1728
integer y = 164
integer width = 498
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 15780518
boolean enabled = false
string text = "Nº Registro"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

