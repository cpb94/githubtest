$PBExportHeader$w_con_proveedores_iva.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_proveedores_iva from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_proveedores_iva
end type
type cb_2 from commandbutton within w_con_proveedores_iva
end type
type pb_imprimir_preli from upb_imprimir within w_con_proveedores_iva
end type
type st_titulo from statictext within w_con_proveedores_iva
end type
type p_logo from picture within w_con_proveedores_iva
end type
type dw_1 from datawindow within w_con_proveedores_iva
end type
type sle_iva from singlelineedit within w_con_proveedores_iva
end type
type st_1 from statictext within w_con_proveedores_iva
end type
type st_2 from statictext within w_con_proveedores_iva
end type
type em_ejercicio from editmask within w_con_proveedores_iva
end type
end forward

global type w_con_proveedores_iva from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5216
integer height = 3104
string title = "Estadística comparativa de Compras por Productos y Familias"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
st_titulo st_titulo
p_logo p_logo
dw_1 dw_1
sle_iva sle_iva
st_1 st_1
st_2 st_2
em_ejercicio em_ejercicio
end type
global w_con_proveedores_iva w_con_proveedores_iva

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia


This.title = "Listado de Proveedores por tipo de IVA"
this.st_titulo.text = this.st_empresa.text

em_ejercicio.text = String(Year(Today()))

dw_1.SetTransObject(sqlca)

end event

on w_con_proveedores_iva.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.sle_iva=create sle_iva
this.st_1=create st_1
this.st_2=create st_2
this.em_ejercicio=create em_ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.st_titulo
this.Control[iCurrent+5]=this.p_logo
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.sle_iva
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_ejercicio
end on

on w_con_proveedores_iva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.sle_iva)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_ejercicio)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proveedores_iva
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proveedores_iva
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_proveedores_iva
boolean visible = false
integer width = 5038
integer height = 84
end type

type pb_2 from upb_salir within w_con_proveedores_iva
integer x = 5019
integer y = 128
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_2 from commandbutton within w_con_proveedores_iva
event clicked pbm_bnclicked
integer x = 4462
integer y = 128
integer width = 361
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String consulta, filtro, anyo, mes, dia
Long fecha1
Int i

filtro = ""
if sle_iva.text <> "" then
	filtro = "contaiva_tipoiva = '"+sle_iva.text+"'"
end if
dw_1.reset()
dw_1.retrieve(String(em_ejercicio.text))
dw_1.setfilter(filtro)
dw_1.Filter()
dw_1.sort()		
dw_1.GroupCalc()




end event

type pb_imprimir_preli from upb_imprimir within w_con_proveedores_iva
event clicked pbm_bnclicked
integer x = 4846
integer y = 128
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;f_imprimir_datawindow(dw_1)

end event

type st_titulo from statictext within w_con_proveedores_iva
integer x = 27
integer y = 20
integer width = 1710
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within w_con_proveedores_iva
integer x = 4658
integer y = 16
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_proveedores_iva
integer x = 27
integer y = 276
integer width = 5138
integer height = 2668
integer taborder = 80
string title = "none"
string dataobject = "dw_proveedor_tipoiva"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;String filtro, orden

dw_1.SetRedraw(false)
if row = 0 then
	if not isnull(dwo) then
		choose case dwo.name
			/*
			case "t_codigo"
				orden = "comproveedores_codigo D"
			*/
			case "t_razon"
				orden = "genter_razon A"
			/*
			case "t_tipoiva"
				orden = "contaiva_tipoiva D"
			*/
			case "t_descripcion"
				orden = "contaiva_descripcion A"
			/*
			case "t_iva"
				orden = "contaiva_iva D"
			*/
		end choose
	end if
end if

filtro = ""
if sle_iva.text <> "" then
	filtro = "contaiva_tipoiva = '"+sle_iva.text+"'"
end if
dw_1.setfilter(filtro)
dw_1.Filter()
dw_1.setsort(orden)
dw_1.sort()		
dw_1.GroupCalc()
dw_1.SetRedraw(true)
end event

type sle_iva from singlelineedit within w_con_proveedores_iva
event key pbm_keydown
integer x = 1184
integer y = 132
integer width = 279
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
end type

event key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT contaiva.tipoiva, contaiva.descripcion, contaiva.iva "+&
							"FROM contaiva "+&
							"WHERE contaiva.ejercicio = '"+String(em_ejercicio.text)+"'"+&
							"ORDER BY contaiva.tipoiva ASC"

busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"
busqueda.titulos[3] = "IVA"

IF not isnull(this.text) and this.text <> "" THEN
	//busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		busqueda.filtro = this.text
		//busqueda.filtro_es_codigo = false
	else
		//Es código
		busqueda.filtro_es_codigo = true
	end if
END IF

IF KeyDown(KeyEnter!) OR (not isnull(Message.LongParm) and Message.LongParm = 1001) THEN  
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado > 0 then
		this.text = resultado.valores[1]
	end if
END IF
end event

type st_1 from statictext within w_con_proveedores_iva
integer x = 736
integer y = 144
integer width = 439
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de IVA:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_proveedores_iva
integer x = 41
integer y = 144
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ejercicio:"
boolean focusrectangle = false
end type

type em_ejercicio from editmask within w_con_proveedores_iva
integer x = 379
integer y = 132
integer width = 306
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
boolean spin = true
double increment = 1
string minmax = "2001~~"
end type

