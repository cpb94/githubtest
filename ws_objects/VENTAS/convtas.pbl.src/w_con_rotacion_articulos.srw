$PBExportHeader$w_con_rotacion_articulos.srw
forward
global type w_con_rotacion_articulos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_rotacion_articulos
end type
type dw_listado from datawindow within w_con_rotacion_articulos
end type
type pb_imprimir_preli from picturebutton within w_con_rotacion_articulos
end type
type cb_continuar from u_boton within w_con_rotacion_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_rotacion_articulos
end type
type gb_64 from groupbox within w_con_rotacion_articulos
end type
type gb_2 from groupbox within w_con_rotacion_articulos
end type
type gb_1 from groupbox within w_con_rotacion_articulos
end type
type gb_4 from groupbox within w_con_rotacion_articulos
end type
type gb_3 from groupbox within w_con_rotacion_articulos
end type
type gb_67 from groupbox within w_con_rotacion_articulos
end type
type uo_formato from u_em_campo_2 within w_con_rotacion_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_rotacion_articulos
end type
type uo_g4 from u_em_campo_2 within w_con_rotacion_articulos
end type
type uo_tm from u_em_campo_2 within w_con_rotacion_articulos
end type
type ddlb_deposito from dropdownlistbox within w_con_rotacion_articulos
end type
type cbx_mensual from checkbox within w_con_rotacion_articulos
end type
type rb_36 from radiobutton within w_con_rotacion_articulos
end type
type rb_24 from radiobutton within w_con_rotacion_articulos
end type
type rb_todos from radiobutton within w_con_rotacion_articulos
end type
type uo_g2 from u_em_campo_2 within w_con_rotacion_articulos
end type
type uo_g1 from u_em_campo_2 within w_con_rotacion_articulos
end type
type gb_5 from groupbox within w_con_rotacion_articulos
end type
type gb_7 from groupbox within w_con_rotacion_articulos
end type
type gb_6 from groupbox within w_con_rotacion_articulos
end type
type cb_semielaborados from commandbutton within w_con_rotacion_articulos
end type
type st_contador from statictext within w_con_rotacion_articulos
end type
type dw_1 from datawindow within w_con_rotacion_articulos
end type
type dw_consumo_semielaborados from datawindow within w_con_rotacion_articulos
end type
type ddlb_n from dropdownlistbox within w_con_rotacion_articulos
end type
type uo_familia from u_em_campo_2 within w_con_rotacion_articulos
end type
type gb_125 from groupbox within w_con_rotacion_articulos
end type
type gb_8 from groupbox within w_con_rotacion_articulos
end type
end forward

global type w_con_rotacion_articulos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5609
integer height = 3160
long backcolor = 134217750
pb_2 pb_2
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
cb_continuar cb_continuar
uo_articulo uo_articulo
gb_64 gb_64
gb_2 gb_2
gb_1 gb_1
gb_4 gb_4
gb_3 gb_3
gb_67 gb_67
uo_formato uo_formato
uo_cliente uo_cliente
uo_g4 uo_g4
uo_tm uo_tm
ddlb_deposito ddlb_deposito
cbx_mensual cbx_mensual
rb_36 rb_36
rb_24 rb_24
rb_todos rb_todos
uo_g2 uo_g2
uo_g1 uo_g1
gb_5 gb_5
gb_7 gb_7
gb_6 gb_6
cb_semielaborados cb_semielaborados
st_contador st_contador
dw_1 dw_1
dw_consumo_semielaborados dw_consumo_semielaborados
ddlb_n ddlb_n
uo_familia uo_familia
gb_125 gb_125
gb_8 gb_8
end type
global w_con_rotacion_articulos w_con_rotacion_articulos

type variables
String ante_articulo,retrasos,variable
String marcado = "1"
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string cliente, formato, articulo, g1, g2, g4, tm, tipopedido, filtro_meses, n, familia

dw_1.Setredraw(False)


if uo_formato.em_codigo.text = "" then 
	formato = "%"
else
	formato = uo_formato.em_campo.text
end if

if uo_articulo.em_codigo.text = "" then 
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

if uo_g1.em_campo.text = "" then
	g1 = '%' 
else
	g1 = uo_g1.em_campo.text
end if

if uo_g2.em_campo.text = "" then 
	g2 = "%"
else
	g2 = uo_g2.em_campo.text
end if

if uo_g4.em_campo.text = "" then 
	g4 = "%"
else
	g4 = uo_g4.em_campo.text
end if

if ddlb_n.text = ""  or isnull (ddlb_n.text) or ddlb_n.text = "Todo" then 
	n = "%"
else
	n = ddlb_n.text
end if

dw_1.Retrieve(codigo_empresa,formato, articulo, g1, g2, g4, n)

if ddlb_deposito.text = "TODOS" or ddlb_deposito.text = "" then
	tipopedido = ""
end if
if ddlb_deposito.text = "DEPOSITO" then
	tipopedido = "venarticulosdeposito_articulo <> ''"
end if
if ddlb_deposito.text = "NORMAL" then
	tipopedido = "isnull(venarticulosdeposito_articulo) or venarticulosdeposito_articulo = ''"
end if



filtro_meses = ''
if rb_24.checked then
	filtro_meses = " ( isnull(dos_anyos) or dos_anyos = 0 ) and isnull(articulos_fecha_anulado) "
end if
if rb_36.checked then
	filtro_meses = " ( isnull(tres_anyos) or tres_anyos = 0 ) and isnull(articulos_fecha_anulado) "
end if

if filtro_meses <> '' then
	filtro = filtro_meses
else
	filtro = tipopedido
end if

if uo_tm.em_campo.text <> "" then 
	tm = uo_tm.em_codigo.text
	if filtro <> "" then
		filtro = filtro + " AND articulos_relieve = '"+tm+"' " 
	else
		filtro = " articulos_relieve = '"+tm+"' " 
	end if
end if

if uo_familia.em_campo.text <> "" then 
	familia = uo_familia.em_codigo.text
	if filtro <> "" then
		filtro = filtro + " AND articulos_familia = '"+familia+"' " 
	else
		filtro = " articulos_familia = '"+familia+"' " 
	end if
end if

if uo_cliente.em_codigo.text <> "" then 
	if filtro <> "" then
		filtro = filtro + " AND articulos_cliente = '"+uo_cliente.em_codigo.text+"' " 
	else
		filtro = " articulos_cliente = '"+uo_cliente.em_codigo.text+"' " 
	end if
end if


//filtro = tipopedido 
dw_1.SetRedraw(false)
dw_1.SetFilter("")
dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.Groupcalc()
dw_1.SetRedraw(true)


dw_1.Setredraw(True)



end subroutine

event ue_listar;dw_report = dw_1
CALL Super::ue_listar
end event

event open;call super::open;String mascara

dw_1.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = " Rotación de Artículos"
dw_consumo_semielaborados.settransobject(SQLCA)

ddlb_deposito.text = "TODOS"

//f_activar_campo(uo_articulo)


end event

on w_con_rotacion_articulos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_continuar=create cb_continuar
this.uo_articulo=create uo_articulo
this.gb_64=create gb_64
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_67=create gb_67
this.uo_formato=create uo_formato
this.uo_cliente=create uo_cliente
this.uo_g4=create uo_g4
this.uo_tm=create uo_tm
this.ddlb_deposito=create ddlb_deposito
this.cbx_mensual=create cbx_mensual
this.rb_36=create rb_36
this.rb_24=create rb_24
this.rb_todos=create rb_todos
this.uo_g2=create uo_g2
this.uo_g1=create uo_g1
this.gb_5=create gb_5
this.gb_7=create gb_7
this.gb_6=create gb_6
this.cb_semielaborados=create cb_semielaborados
this.st_contador=create st_contador
this.dw_1=create dw_1
this.dw_consumo_semielaborados=create dw_consumo_semielaborados
this.ddlb_n=create ddlb_n
this.uo_familia=create uo_familia
this.gb_125=create gb_125
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.cb_continuar
this.Control[iCurrent+5]=this.uo_articulo
this.Control[iCurrent+6]=this.gb_64
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_67
this.Control[iCurrent+12]=this.uo_formato
this.Control[iCurrent+13]=this.uo_cliente
this.Control[iCurrent+14]=this.uo_g4
this.Control[iCurrent+15]=this.uo_tm
this.Control[iCurrent+16]=this.ddlb_deposito
this.Control[iCurrent+17]=this.cbx_mensual
this.Control[iCurrent+18]=this.rb_36
this.Control[iCurrent+19]=this.rb_24
this.Control[iCurrent+20]=this.rb_todos
this.Control[iCurrent+21]=this.uo_g2
this.Control[iCurrent+22]=this.uo_g1
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.gb_7
this.Control[iCurrent+25]=this.gb_6
this.Control[iCurrent+26]=this.cb_semielaborados
this.Control[iCurrent+27]=this.st_contador
this.Control[iCurrent+28]=this.dw_1
this.Control[iCurrent+29]=this.dw_consumo_semielaborados
this.Control[iCurrent+30]=this.ddlb_n
this.Control[iCurrent+31]=this.uo_familia
this.Control[iCurrent+32]=this.gb_125
this.Control[iCurrent+33]=this.gb_8
end on

on w_con_rotacion_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.cb_continuar)
destroy(this.uo_articulo)
destroy(this.gb_64)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_67)
destroy(this.uo_formato)
destroy(this.uo_cliente)
destroy(this.uo_g4)
destroy(this.uo_tm)
destroy(this.ddlb_deposito)
destroy(this.cbx_mensual)
destroy(this.rb_36)
destroy(this.rb_24)
destroy(this.rb_todos)
destroy(this.uo_g2)
destroy(this.uo_g1)
destroy(this.gb_5)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.cb_semielaborados)
destroy(this.st_contador)
destroy(this.dw_1)
destroy(this.dw_consumo_semielaborados)
destroy(this.ddlb_n)
destroy(this.uo_familia)
destroy(this.gb_125)
destroy(this.gb_8)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_con_rotacion_articulos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_rotacion_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_rotacion_articulos
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_rotacion_articulos
integer x = 27
integer y = 12
integer width = 2478
integer height = 96
integer textsize = -12
long textcolor = 24076881
long backcolor = 134217750
long bordercolor = 16777215
end type

type pb_2 from upb_salir within w_con_rotacion_articulos
integer x = 4919
integer y = 28
integer width = 114
integer height = 96
integer taborder = 0
long backcolor = 134217750
end type

type dw_listado from datawindow within w_con_rotacion_articulos
boolean visible = false
integer x = 526
integer width = 160
integer height = 92
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_bloqueo_promocion"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_rotacion_articulos
integer x = 4763
integer y = 28
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
long backcolor = 134217750
end type

event clicked;if dw_consumo_semielaborados.visible = true then
	f_imprimir_datawindow(dw_consumo_semielaborados)
else
	Parent.TriggerEvent("ue_listar")
end if
end event

type cb_continuar from u_boton within w_con_rotacion_articulos
integer x = 4754
integer y = 140
integer width = 293
integer height = 92
integer taborder = 0
fontcharset fontcharset = ansi!
string text = "&Continuar"
end type

event clicked;
if dw_consumo_semielaborados.visible then
	dw_consumo_semielaborados.visible = false
	st_contador.text = ''
end if
f_control()
//f_activar_campo(em_1)
end event

type uo_articulo from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 1253
integer y = 188
integer width = 594
integer taborder = 30
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type gb_64 from groupbox within w_con_rotacion_articulos
integer x = 3698
integer y = 120
integer width = 398
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "¿Depósito?"
end type

type gb_2 from groupbox within w_con_rotacion_articulos
integer x = 2400
integer y = 120
integer width = 498
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "RELIEVE"
end type

type gb_1 from groupbox within w_con_rotacion_articulos
integer x = 2235
integer y = 120
integer width = 169
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "G4"
end type

type gb_4 from groupbox within w_con_rotacion_articulos
integer x = 347
integer y = 120
integer width = 873
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_rotacion_articulos
integer x = 32
integer y = 120
integer width = 315
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Formato"
end type

type gb_67 from groupbox within w_con_rotacion_articulos
integer x = 1230
integer y = 120
integer width = 645
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Articulo"
end type

type uo_formato from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 46
integer y = 188
integer width = 279
integer height = 80
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

IF Trim(uo_formato.em_campo.text)="" THEN 
 	IF Trim(uo_formato.em_codigo.text)<>"" Then 
		uo_formato.em_campo.SetFocus()
	END IF
 	uo_formato.em_campo.text=""
 	uo_formato.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de formatos"
ue_datawindow = "dw_ayuda_formatos"
ue_filtro     = ""

end event

type uo_cliente from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 366
integer y = 188
integer width = 837
integer height = 80
integer taborder = 20
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type uo_g4 from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 2258
integer y = 188
integer width = 119
integer taborder = 60
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_g4.destroy
call u_em_campo_2::destroy
end on

event modificado;string g4
select descripcion_abr 
into :g4
from art_grupo4
where empresa = :codigo_empresa
and codigo = :uo_g4.em_codigo.text;

uo_g4.em_campo.text= g4
IF Trim(uo_g4.em_campo.text)="" THEN 
	IF Trim(uo_g4.em_codigo.text)<>"" Then uo_g4.em_campo.SetFocus()
	uo_g4.em_campo.text=""
	uo_g4.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Grupo 4"
ue_datawindow = "dw_ayuda_art_grupo4"
ue_filtro     = ""

end event

type uo_tm from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 2423
integer y = 188
integer width = 457
integer taborder = 70
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_tm.destroy
call u_em_campo_2::destroy
end on

event modificado;string tm

select descripcion_abr 
into :tm
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :uo_tm.em_codigo.text;

uo_tm.em_campo.text= tm
IF Trim(uo_tm.em_campo.text)="" THEN 
	IF Trim(uo_tm.em_codigo.text)<>"" Then uo_tm.em_campo.SetFocus()
	uo_tm.em_campo.text=""
	uo_tm.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipo Relieve"
ue_datawindow = "dw_ayuda_art_tipomoldura"
ue_filtro     = ""

end event

type ddlb_deposito from dropdownlistbox within w_con_rotacion_articulos
integer x = 3712
integer y = 176
integer width = 370
integer height = 336
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
boolean vscrollbar = true
string item[] = {"TODOS","DEPOSITO","NORMAL"}
borderstyle borderstyle = stylelowered!
end type

type cbx_mensual from checkbox within w_con_rotacion_articulos
integer x = 3520
integer y = 32
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "Mostrar Mensual"
end type

event clicked;if cbx_mensual.checked then
	dw_1.Modify("DataWindow.Detail.Height=144")
	dw_1.object.l_separa.y1 = 136
	dw_1.object.l_separa.y2 = 136
else
	dw_1.Modify("DataWindow.Detail.Height=70")
	dw_1.object.l_separa.y1 = 64
	dw_1.object.l_separa.y2 = 64
end if


end event

type rb_36 from radiobutton within w_con_rotacion_articulos
integer x = 4187
integer y = 60
integer width = 425
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "36 meses = 0"
end type

type rb_24 from radiobutton within w_con_rotacion_articulos
integer x = 4187
integer y = 128
integer width = 434
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "24 meses = 0"
end type

type rb_todos from radiobutton within w_con_rotacion_articulos
integer x = 4187
integer y = 196
integer width = 343
integer height = 72
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "Todos"
boolean checked = true
end type

type uo_g2 from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 2066
integer y = 188
integer width = 151
integer taborder = 50
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_g2.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g2.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo2
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g2.em_campo.text = descripcion
IF Trim(uo_g2.em_campo.text)="" THEN 
 IF Trim(uo_g2.em_codigo.text)<>"" Then uo_g2.em_campo.SetFocus()
 uo_g2.em_campo.text=""
 uo_g2.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G2"
ue_datawindow = "dw_ayuda_art_grupo2"
ue_filtro     = ""

end event

type uo_g1 from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 1893
integer y = 188
integer width = 142
integer taborder = 40
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_g1.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g1.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo1
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g1.em_campo.text = descripcion
IF Trim(uo_g1.em_campo.text)="" THEN 
 IF Trim(uo_g1.em_codigo.text)<>"" Then uo_g1.em_campo.SetFocus()
 uo_g1.em_campo.text=""
 uo_g1.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G1"
ue_datawindow = "dw_ayuda_art_grupo1"
ue_filtro     = ""

end event

type gb_5 from groupbox within w_con_rotacion_articulos
integer x = 4123
integer y = 4
integer width = 544
integer height = 272
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "Filtro"
end type

type gb_7 from groupbox within w_con_rotacion_articulos
integer x = 2048
integer y = 120
integer width = 187
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "G2"
end type

type gb_6 from groupbox within w_con_rotacion_articulos
integer x = 1879
integer y = 120
integer width = 169
integer height = 184
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "G1"
end type

type cb_semielaborados from commandbutton within w_con_rotacion_articulos
integer x = 5061
integer y = 140
integer width = 480
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Semielaborados"
end type

event clicked;long i, j, k, fila_actual
integer indice
str_escandallo vector_escandallo[300]
decimal factor_acumulado, stock_sugerido
string articulo, descripcion, control_stock, uso, formato
datetime fecha_alta
integer nivel

cb_continuar.triggerevent(clicked!)
dw_consumo_semielaborados.visible = true
//dw_consumo_semielaborados.setredraw(false)
dw_consumo_semielaborados.reset()
	
for i = 1 to dw_1.rowcount()
	st_contador.text = string(int (i * 100 / dw_1.rowcount()))+ " %"
	for k = 1 to 300
		setnull(vector_escandallo[k].articulo)		
		setnull(vector_escandallo[k].version)		
		setnull(vector_escandallo[k].factor)		
	next
	indice = 1
	factor_acumulado = 1
	articulo = dw_1.object.articulos_codigo[i]
	fecha_alta = dw_1.object.articulos_fecha_alta[i]

	f_escandallo_factores ( vector_escandallo, articulo, indice, factor_acumulado, nivel )
	for j= 1 to indice
		select articulos.descripcion, articulos.control_stock, articulos.uso, articulos.stocksugerido, formatos.abreviado
		into :descripcion, :control_stock, :uso, :stock_sugerido, :formato
		from articulos, formatos
		where articulos.empresa = :codigo_empresa
		and articulos.empresa = formatos.empresa
		and articulos.formato = formatos.codigo
		and articulos.codigo = :vector_escandallo[j].articulo;
		
		
		if control_stock = 'S' and uso <> '1' and uso <> '3' then
			fila_Actual = dw_consumo_semielaborados.insertrow(0)
			dw_consumo_semielaborados.object.articulo[fila_Actual] = vector_escandallo[j].articulo
			dw_consumo_semielaborados.object.descripcion[fila_Actual] = descripcion
			dw_consumo_semielaborados.object.formato[fila_Actual] = formato
			dw_consumo_semielaborados.object.fecha_alta[fila_Actual] = fecha_alta
			dw_consumo_semielaborados.object.stock_sugerido[fila_Actual] = stock_sugerido
			dw_consumo_semielaborados.object.m3[fila_Actual] = dw_1.object.tres_meses[i] / vector_escandallo[j].factor
			dw_consumo_semielaborados.object.m6[fila_Actual] = dw_1.object.seis_meses[i] / vector_escandallo[j].factor
			dw_consumo_semielaborados.object.m12[fila_Actual] = dw_1.object.doce_meses[i] / vector_escandallo[j].factor
			dw_consumo_semielaborados.object.m24[fila_Actual] = dw_1.object.dos_anyos[i] / vector_escandallo[j].factor
			//dw_consumo_semielaborados.object.stock[fila_Actual] = f_stock_Articulo (codigo_empresa, vector_escandallo[j].articulo, datetime(today()))
			dw_consumo_semielaborados.object.stock[fila_Actual] = f_stock_Articulo (codigo_empresa, vector_escandallo[j].articulo)
		end if
	next
next

dw_consumo_semielaborados.sort()
dw_consumo_semielaborados.groupcalc()
//dw_consumo_semielaborados.setredraw(true)



end event

type st_contador from statictext within w_con_rotacion_articulos
integer x = 5051
integer y = 28
integer width = 471
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 134217750
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_rotacion_articulos
integer x = 23
integer y = 304
integer width = 5509
integer height = 2660
string dataobject = "dw_con_rotacion_articulos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;string tipopedido

this.SetRedraw(false)

IF dwo.name= "total" Then
	this.SetSort("cantidad_total_bis D")
	this.Sort()
END IF
IF dwo.name= "t_36" Then
	this.SetSort("tres_anyos_bis D")
	this.Sort()
END IF

IF dwo.name= "t_24" Then
	this.SetSort("dos_anyos_bis D")
	this.Sort()
END IF
IF dwo.name= "doce" Then
	this.SetSort("doce_meses_bis D")
	this.Sort()
END IF
IF dwo.name= "seis" Then
	this.SetSort("seis_meses_bis D")
	this.Sort()
END IF
IF dwo.name= "tres" Then
	this.SetSort("tres_meses_bis D")
	this.Sort()
END IF

this.SetRedraw(true)

end event

type dw_consumo_semielaborados from datawindow within w_con_rotacion_articulos
boolean visible = false
integer x = 27
integer y = 304
integer width = 4279
integer height = 2204
integer taborder = 40
string title = "none"
string dataobject = "dw_consumo_semielaborados"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;
IF dwo.name= "t_m3" Then
	this.SetSort("total_m3 D")
	this.Sort()
END IF

IF dwo.name= "t_m6" Then
	this.SetSort("total_m6 D")
	this.Sort()
END IF

IF dwo.name= "t_m12" Then
	this.SetSort("total_m12 D")
	this.Sort()
END IF

IF dwo.name= "t_m24" Then
	this.SetSort("total_m24 D")
	this.Sort()
END IF

IF dwo.name= "t_descripcion" Then
	this.SetSort("descripcion A")
	this.Sort()
END IF

IF dwo.name= "t_formato" Then
	this.SetSort("formato A")
	this.Sort()
END IF

end event

type ddlb_n from dropdownlistbox within w_con_rotacion_articulos
integer x = 3406
integer y = 176
integer width = 270
integer height = 336
integer taborder = 210
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
boolean sorted = false
string item[] = {"Todo","S","N"}
borderstyle borderstyle = stylelowered!
end type

type uo_familia from u_em_campo_2 within w_con_rotacion_articulos
event destroy ( )
integer x = 2912
integer y = 184
integer width = 270
integer taborder = 70
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_125 from groupbox within w_con_rotacion_articulos
integer x = 3392
integer y = 120
integer width = 293
integer height = 140
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "B. Cliente"
end type

type gb_8 from groupbox within w_con_rotacion_articulos
integer x = 2898
integer y = 120
integer width = 311
integer height = 184
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "FAMILIA"
end type

