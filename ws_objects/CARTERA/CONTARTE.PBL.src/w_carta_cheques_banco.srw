$PBExportHeader$w_carta_cheques_banco.srw
$PBExportComments$€
forward
global type w_carta_cheques_banco from w_int_con_empresa
end type
type pb_2 from upb_salir within w_carta_cheques_banco
end type
type cb_consulta from u_boton within w_carta_cheques_banco
end type
type pb_imprimir_preli from picturebutton within w_carta_cheques_banco
end type
type uo_cliente from u_em_campo_2 within w_carta_cheques_banco
end type
type st_1 from statictext within w_carta_cheques_banco
end type
type uo_banco from u_em_campo_2 within w_carta_cheques_banco
end type
type ddlb_1 from dropdownlistbox within w_carta_cheques_banco
end type
type st_11 from statictext within w_carta_cheques_banco
end type
type st_21 from statictext within w_carta_cheques_banco
end type
type dw_1 from datawindow within w_carta_cheques_banco
end type
type dw_listado from datawindow within w_carta_cheques_banco
end type
type em_fcarta from u_em_campo within w_carta_cheques_banco
end type
type st_22 from statictext within w_carta_cheques_banco
end type
type cbx_1 from checkbox within w_carta_cheques_banco
end type
end forward

global type w_carta_cheques_banco from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2985
integer height = 2224
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
uo_cliente uo_cliente
st_1 st_1
uo_banco uo_banco
ddlb_1 ddlb_1
st_11 st_11
st_21 st_21
dw_1 dw_1
dw_listado dw_listado
em_fcarta em_fcarta
st_22 st_22
cbx_1 cbx_1
end type
global w_carta_cheques_banco w_carta_cheques_banco

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String cli1,cli2,naci,tipo1,tipo2,tipo3,tipo4


dw_data.reset()
dw_data.visible   = FALSE



dw_data.SetTransObject(sqlca)



if tipo_vista="Nacional" then 
	naci = "S"
end if

if tipo_vista="Exportacion" then 
	naci = "N"	
end if


iF Trim(uo_cliente.em_codigo.text) = "" Then
   cli1 = "."
   cli2 = "Z"
ELSE
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF


if ddlb_1.text = "Cheque y pagaré" then
	tipo1 = "5"
	tipo2 = "5"
	tipo3 = "7"
	tipo4	= "7"
else
	tipo1 = "0"
	tipo2 = "9999"
	tipo3 = "0"
	tipo4	= "9999"
	
end if




dw_data.Retrieve(codigo_empresa,cli1,cli2,tipo1,tipo2,tipo3,tipo4)

registros = dw_data.RowCount()
If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
This.title = " CARTA DE NOTIFICACIÓN"

dw_1.SetTransObject(sqlca)
dw_listado.settransobject(sqlca)

dw_1.Setfocus()

ddlb_1.text = "Cheque y pagaré"

cbx_1.checked = true

f_activar_campo(uo_cliente.em_campo)


str_paramemp em
int dec_moneda

em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)


f_mascara_columna(dw_1,"importe",f_mascara_decimales(dec_moneda))

end event

on w_carta_cheques_banco.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.uo_banco=create uo_banco
this.ddlb_1=create ddlb_1
this.st_11=create st_11
this.st_21=create st_21
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.em_fcarta=create em_fcarta
this.st_22=create st_22
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_banco
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.st_11
this.Control[iCurrent+9]=this.st_21
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.em_fcarta
this.Control[iCurrent+13]=this.st_22
this.Control[iCurrent+14]=this.cbx_1
end on

on w_carta_cheques_banco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.uo_banco)
destroy(this.ddlb_1)
destroy(this.st_11)
destroy(this.st_21)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.em_fcarta)
destroy(this.st_22)
destroy(this.cbx_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_carta_cheques_banco
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_carta_cheques_banco
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_carta_cheques_banco
integer x = 37
integer y = 20
integer width = 2629
integer height = 92
end type

type pb_2 from upb_salir within w_carta_cheques_banco
integer x = 2757
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_carta_cheques_banco
integer x = 2190
integer y = 136
integer width = 379
integer height = 76
integer taborder = 50
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.visible   = TRUE
f_activar_campo(uo_cliente.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_carta_cheques_banco
integer x = 2757
integer y = 128
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;int i,fila,dec_moneda
string marca,cliente_anterior,cliente_nuevo,referencia,moneda,banco,idioma

datetime ffra,fvto
dec importe
boolean alguno


str_paramemp em
em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)



if dw_1.rowcount() <= 0 then 
	messagebox("Error","No se ha consultado o no hay efectos")
	return
end if

if uo_banco.em_codigo.text = "" then 
	messagebox("Error de datos","Ha de introducir el banco")
	uo_banco.em_campo.setfocus()
	return
end if

string cab
if cbx_1.checked then 
	cab = "S"	
else
	cab = "N"
end if

dw_listado.settransobject(sqlca)
dw_listado.retrieve(codigo_empresa,uo_banco.em_codigo.text,datetime(date(em_fcarta.text)),cab)
		


DataWindowChild dw_hija

dw_listado.GetChild('report_detalle', dw_hija)


dw_hija.settransobject(sqlca)
dw_hija.retrieve()


dec divisa
string cliente,numero
for i = 1 to dw_1.rowcount()
	marca = dw_1.getitemstring(i,"marcar")
	if marca = "S" then
						
		alguno = true
		
		banco			= dw_1.getitemstring(i,"nombre_banco")	 		
		
		divisa		= dw_1.getitemnumber(i,"divisas")
		moneda		= dw_1.getitemstring(i,"monedas")
		importe		= round(dw_1.getitemnumber(i,"importe"),dec_moneda)
		cliente		= dw_1.getitemstring(i,"cliente")
		numero		= dw_1.getitemstring(i,"numero")	
		referencia	= dw_1.getitemstring(i,"referencia")	
		
		fila = dw_hija.insertrow(0)
		
		dw_hija.setitem(fila,"emp",codigo_empresa)
		dw_hija.setitem(fila,"referencia",referencia)
		dw_hija.setitem(fila,"divisa",divisa)
		dw_hija.setitem(fila,"importe",importe)
		dw_hija.setitem(fila,"moneda",moneda)
		dw_hija.setitem(fila,"cliente",cliente)
		dw_hija.setitem(fila,"numero",numero)
		dw_hija.setitem(fila,"banco_cobro",banco)
		
		
	end if
next

if alguno then
	dw_listado.print()
else
	messagebox("Atención","No se han seleccionado efectos")
	return
end if


end event

type uo_cliente from u_em_campo_2 within w_carta_cheques_banco
event destroy ( )
integer x = 32
integer y = 196
integer width = 626
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"

end event

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

dw_1.Reset()
//dw_1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
end event

type st_1 from statictext within w_carta_cheques_banco
integer x = 32
integer y = 132
integer width = 631
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_banco from u_em_campo_2 within w_carta_cheques_banco
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1262
integer y = 192
integer width = 590
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type ddlb_1 from dropdownlistbox within w_carta_cheques_banco
integer x = 658
integer y = 196
integer width = 599
integer height = 228
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Cheque y pagaré","Todos"}
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within w_carta_cheques_banco
integer x = 663
integer y = 132
integer width = 599
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tipo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_21 from statictext within w_carta_cheques_banco
integer x = 1262
integer y = 132
integer width = 590
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Banco Carta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_carta_cheques_banco
integer x = 9
integer y = 308
integer width = 2853
integer height = 1588
string dataobject = "dw_con_carta_cheques_banco"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long i

if dwo.name = "m" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"marcar","S")		
	next
	setpointer(arrow!)
end if


if dwo.name = "d" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"marcar","N")		
	next
	setpointer(arrow!)
end if
end event

event rbuttondown;CHOOSE CASE f_objeto_datawindow(This)
		
	case "banco_cobro"
		
		string banco
		str_parametros astr_parametros
		
		astr_parametros.s_criterio_busqueda = ""
		astr_parametros.s_nom_datawindow = "dw_ayuda_carbancos"
		astr_parametros.s_filtro = ""
		astr_parametros.s_titulo_ayuda = "VENTANA AYUDA BANCOS"
		astr_parametros.b_empresa	=	true
		
		openwithparm(w_busquedas,astr_parametros)
		
		banco = message.stringparm
		
		dw_1.setitem(row,"banco_cobro",banco)
		dw_1.setitem(row,"nombre_banco",f_nombre_banco(codigo_empresa,banco))

		
		
	
		
end choose
end event

event itemchanged;string banco,nombre
if dwo.name = "banco_cobro" then
	
	dw_1.setitem(row,"nombre_banco",f_nombre_banco(codigo_empresa,data))
	
	
end if
end event

type dw_listado from datawindow within w_carta_cheques_banco
boolean visible = false
integer x = 667
integer width = 786
integer height = 308
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_carta_cheques3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fcarta from u_em_campo within w_carta_cheques_banco
integer x = 1851
integer y = 192
integer width = 306
integer height = 88
integer taborder = 40
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type st_22 from statictext within w_carta_cheques_banco
integer x = 1851
integer y = 132
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "F. Carta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_carta_cheques_banco
integer x = 2194
integer y = 216
integer width = 379
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cabecera"
end type

