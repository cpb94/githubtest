$PBExportHeader$w_con_prov_forma_pago.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_prov_forma_pago from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_prov_forma_pago
end type
type cb_2 from commandbutton within w_con_prov_forma_pago
end type
type pb_imprimir_preli from upb_imprimir within w_con_prov_forma_pago
end type
type st_titulo from statictext within w_con_prov_forma_pago
end type
type p_logo from picture within w_con_prov_forma_pago
end type
type dw_1 from datawindow within w_con_prov_forma_pago
end type
type sle_banco from singlelineedit within w_con_prov_forma_pago
end type
type st_1 from statictext within w_con_prov_forma_pago
end type
type st_2 from statictext within w_con_prov_forma_pago
end type
type sle_forma from singlelineedit within w_con_prov_forma_pago
end type
end forward

global type w_con_prov_forma_pago from w_int_con_empresa
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
sle_banco sle_banco
st_1 st_1
st_2 st_2
sle_forma sle_forma
end type
global w_con_prov_forma_pago w_con_prov_forma_pago

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia


This.title = "Listado de Proveedores por Forma de Pago"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)

end event

on w_con_prov_forma_pago.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.sle_banco=create sle_banco
this.st_1=create st_1
this.st_2=create st_2
this.sle_forma=create sle_forma
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.st_titulo
this.Control[iCurrent+5]=this.p_logo
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.sle_banco
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.sle_forma
end on

on w_con_prov_forma_pago.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.sle_banco)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_forma)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prov_forma_pago
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prov_forma_pago
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prov_forma_pago
boolean visible = false
integer width = 5038
integer height = 84
end type

type pb_2 from upb_salir within w_con_prov_forma_pago
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

type cb_2 from commandbutton within w_con_prov_forma_pago
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
if sle_banco.text <> "" then
	filtro = "carbancos_banco = '"+sle_banco.text+"'"
else
	filtro = "1 = 1"
end if

if sle_forma.text <> "" then
	filtro = filtro + " AND carforpag_forma = '"+sle_forma.text+"'"
end if

dw_1.reset()
dw_1.retrieve()
dw_1.setfilter(filtro)
dw_1.Filter()
dw_1.setsort("carbancos_nombre A, carforpag_texto1 A, genter_razon A")	
dw_1.sort()		
dw_1.GroupCalc()




end event

type pb_imprimir_preli from upb_imprimir within w_con_prov_forma_pago
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

type st_titulo from statictext within w_con_prov_forma_pago
integer x = 41
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

type p_logo from picture within w_con_prov_forma_pago
integer x = 4658
integer y = 16
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_prov_forma_pago
integer x = 27
integer y = 276
integer width = 5138
integer height = 2668
integer taborder = 80
string title = "none"
string dataobject = "dw_prov_formapago"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type sle_banco from singlelineedit within w_con_prov_forma_pago
event key pbm_keydown
integer x = 357
integer y = 136
integer width = 256
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

consulta_busqueda =  "SELECT carbancos.banco, carbancos.nombre "+&
							"FROM carbancos "+&
							"ORDER BY carbancos.nombre ASC"

busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"

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

type st_1 from statictext within w_con_prov_forma_pago
integer x = 41
integer y = 140
integer width = 325
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
string text = "Banco:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_prov_forma_pago
integer x = 695
integer y = 144
integer width = 480
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
string text = "Forma de Pago:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_forma from singlelineedit within w_con_prov_forma_pago
event key pbm_keydown
integer x = 1193
integer y = 136
integer width = 261
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

consulta_busqueda =  "SELECT carforpag.forma, carforpag.texto1 "+&
							"FROM carforpag "+&
							"ORDER BY carforpag.texto1 ASC"

busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"

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

