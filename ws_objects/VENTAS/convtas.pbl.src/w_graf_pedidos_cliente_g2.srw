$PBExportHeader$w_graf_pedidos_cliente_g2.srw
forward
global type w_graf_pedidos_cliente_g2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_graf_pedidos_cliente_g2
end type
type pb_2 from upb_imprimir within w_graf_pedidos_cliente_g2
end type
type cb_1 from commandbutton within w_graf_pedidos_cliente_g2
end type
type gb_1 from groupbox within w_graf_pedidos_cliente_g2
end type
type gb_6 from groupbox within w_graf_pedidos_cliente_g2
end type
type em_fdesde from u_em_campo within w_graf_pedidos_cliente_g2
end type
type em_fhasta from u_em_campo within w_graf_pedidos_cliente_g2
end type
type rb_grafica from radiobutton within w_graf_pedidos_cliente_g2
end type
type rb_datos from radiobutton within w_graf_pedidos_cliente_g2
end type
type gb_2 from groupbox within w_graf_pedidos_cliente_g2
end type
type sle_mes1 from singlelineedit within w_graf_pedidos_cliente_g2
end type
type sle_mes2 from singlelineedit within w_graf_pedidos_cliente_g2
end type
type sle_anyo1 from singlelineedit within w_graf_pedidos_cliente_g2
end type
type sle_anyo2 from singlelineedit within w_graf_pedidos_cliente_g2
end type
type gb_3 from groupbox within w_graf_pedidos_cliente_g2
end type
type gb_5 from groupbox within w_graf_pedidos_cliente_g2
end type
type uo_cliente from u_em_campo_2 within w_graf_pedidos_cliente_g2
end type
type gb_4 from groupbox within w_graf_pedidos_cliente_g2
end type
type uo_agente from u_em_campo_2 within w_graf_pedidos_cliente_g2
end type
type gb_7 from groupbox within w_graf_pedidos_cliente_g2
end type
type dw_datos from datawindow within w_graf_pedidos_cliente_g2
end type
type dw_informe from datawindow within w_graf_pedidos_cliente_g2
end type
end forward

global type w_graf_pedidos_cliente_g2 from w_int_con_empresa
integer width = 4567
integer height = 2860
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
em_fdesde em_fdesde
em_fhasta em_fhasta
rb_grafica rb_grafica
rb_datos rb_datos
gb_2 gb_2
sle_mes1 sle_mes1
sle_mes2 sle_mes2
sle_anyo1 sle_anyo1
sle_anyo2 sle_anyo2
gb_3 gb_3
gb_5 gb_5
uo_cliente uo_cliente
gb_4 gb_4
uo_agente uo_agente
gb_7 gb_7
dw_datos dw_datos
dw_informe dw_informe
end type
global w_graf_pedidos_cliente_g2 w_graf_pedidos_cliente_g2

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string mes, cliente, agente
dec{0} total_cenefas, total_bico, total_3f, total_4f, total_mold3f, total_mold4f, total_pedidos
dec{0} total_dec, total_esq, total_tacos
long fila_actual

data.SetTransObject(SQLCA)
data.Reset()
fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)


if uo_cliente.em_codigo.text = "" or isnull(uo_cliente.em_codigo.text) then
	cliente = "%"
else 
	cliente = uo_cliente.em_codigo.text	
end if

if uo_agente.em_codigo.text = "" or isnull(uo_agente.em_codigo.text) then
	agente = "%"
else 
	agente = uo_agente.em_codigo.text	
end if

data.retrieve(codigo_empresa, fecha1, fecha2, cliente, long(sle_anyo1.text), long(sle_anyo2.text), long(sle_mes1.text), long(sle_mes2.text), agente)
data.setredraw(false)		
data.object.T1.text = "Desde "+sle_mes1.text+'-'+sle_anyo1.text+" Hasta "+sle_mes2.text+'-'+sle_anyo2.text
if uo_cliente.em_campo.text <> '' and uo_agente.em_campo.text <> ''  then
	data.object.T2.text = uo_cliente.em_campo.text+" / "+uo_agente.em_campo.text	
elseif uo_cliente.em_campo.text = '' then
	data.object.T2.text = uo_agente.em_campo.text
else
	data.object.T2.text = uo_cliente.em_campo.text
end if




data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

rb_grafica.checked = false
rb_datos.checked = true

istr_parametros.s_titulo_ventana="Pedidos por Cliente entre Períodos y G2"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-01-01"
em_fhasta.text = string(today(),"dd-mm-yy")

sle_anyo1.text = '2001'
sle_anyo2.text = string (year(today()))
sle_mes1.text = '1'
sle_mes2.text =  string ( month(today()) - 1 )



end event

on w_graf_pedidos_cliente_g2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.rb_grafica=create rb_grafica
this.rb_datos=create rb_datos
this.gb_2=create gb_2
this.sle_mes1=create sle_mes1
this.sle_mes2=create sle_mes2
this.sle_anyo1=create sle_anyo1
this.sle_anyo2=create sle_anyo2
this.gb_3=create gb_3
this.gb_5=create gb_5
this.uo_cliente=create uo_cliente
this.gb_4=create gb_4
this.uo_agente=create uo_agente
this.gb_7=create gb_7
this.dw_datos=create dw_datos
this.dw_informe=create dw_informe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.em_fdesde
this.Control[iCurrent+7]=this.em_fhasta
this.Control[iCurrent+8]=this.rb_grafica
this.Control[iCurrent+9]=this.rb_datos
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.sle_mes1
this.Control[iCurrent+12]=this.sle_mes2
this.Control[iCurrent+13]=this.sle_anyo1
this.Control[iCurrent+14]=this.sle_anyo2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_5
this.Control[iCurrent+17]=this.uo_cliente
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.uo_agente
this.Control[iCurrent+20]=this.gb_7
this.Control[iCurrent+21]=this.dw_datos
this.Control[iCurrent+22]=this.dw_informe
end on

on w_graf_pedidos_cliente_g2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.rb_grafica)
destroy(this.rb_datos)
destroy(this.gb_2)
destroy(this.sle_mes1)
destroy(this.sle_mes2)
destroy(this.sle_anyo1)
destroy(this.sle_anyo2)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.uo_cliente)
destroy(this.gb_4)
destroy(this.uo_agente)
destroy(this.gb_7)
destroy(this.dw_datos)
destroy(this.dw_informe)
end on

event ue_f5;//f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_graf_pedidos_cliente_g2
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_graf_pedidos_cliente_g2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_graf_pedidos_cliente_g2
integer y = 8
integer width = 4142
integer height = 96
end type

type pb_1 from upb_salir within w_graf_pedidos_cliente_g2
integer x = 4215
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_graf_pedidos_cliente_g2
integer x = 4201
integer y = 156
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked; 
if rb_grafica.checked then
	f_imprimir_datawindow(dw_informe)
end if
if rb_datos.checked then
	f_imprimir_datawindow(dw_datos)
end if


end event

type cb_1 from commandbutton within w_graf_pedidos_cliente_g2
integer x = 3904
integer y = 156
integer width = 288
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if rb_grafica.checked then
	dw_informe.visible = true
	dw_datos.visible = false
	f_control(dw_informe)
end if
if rb_datos.checked then
	dw_informe.visible = false
	dw_datos.visible = true
 	f_control(dw_datos)
end if

end event

type gb_1 from groupbox within w_graf_pedidos_cliente_g2
boolean visible = false
integer x = 951
integer y = 116
integer width = 617
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_6 from groupbox within w_graf_pedidos_cliente_g2
integer x = 3886
integer y = 116
integer width = 462
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_fdesde from u_em_campo within w_graf_pedidos_cliente_g2
boolean visible = false
integer x = 965
integer y = 180
integer width = 288
integer height = 76
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_graf_pedidos_cliente_g2
boolean visible = false
integer x = 1262
integer y = 180
integer width = 288
integer height = 76
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type rb_grafica from radiobutton within w_graf_pedidos_cliente_g2
integer x = 3296
integer y = 168
integer width = 274
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gráfica"
end type

event clicked;if rb_grafica.checked then
	dw_datos.visible = false
	dw_informe.visible = true
end if
end event

type rb_datos from radiobutton within w_graf_pedidos_cliente_g2
integer x = 3063
integer y = 168
integer width = 238
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
string text = "Datos"
end type

event clicked;if rb_datos.checked then
	dw_datos.visible = true
	dw_informe.visible = false
end if
end event

type gb_2 from groupbox within w_graf_pedidos_cliente_g2
integer x = 3049
integer y = 116
integer width = 571
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vista"
end type

type sle_mes1 from singlelineedit within w_graf_pedidos_cliente_g2
integer x = 503
integer y = 172
integer width = 192
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
end type

type sle_mes2 from singlelineedit within w_graf_pedidos_cliente_g2
integer x = 704
integer y = 172
integer width = 192
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
end type

type sle_anyo1 from singlelineedit within w_graf_pedidos_cliente_g2
integer x = 55
integer y = 172
integer width = 192
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
end type

type sle_anyo2 from singlelineedit within w_graf_pedidos_cliente_g2
integer x = 256
integer y = 172
integer width = 192
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_graf_pedidos_cliente_g2
integer x = 485
integer y = 116
integer width = 439
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mes"
end type

type gb_5 from groupbox within w_graf_pedidos_cliente_g2
integer x = 37
integer y = 116
integer width = 439
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type uo_cliente from u_em_campo_2 within w_graf_pedidos_cliente_g2
event destroy ( )
integer x = 942
integer y = 168
integer width = 1042
integer height = 80
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_4 from groupbox within w_graf_pedidos_cliente_g2
integer x = 2016
integer y = 116
integer width = 1015
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type uo_agente from u_em_campo_2 within w_graf_pedidos_cliente_g2
event destroy ( )
integer x = 2039
integer y = 168
integer width = 969
integer height = 80
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Agente"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type gb_7 from groupbox within w_graf_pedidos_cliente_g2
integer x = 923
integer y = 116
integer width = 1079
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type dw_datos from datawindow within w_graf_pedidos_cliente_g2
integer x = 18
integer y = 296
integer width = 4389
integer height = 2264
integer taborder = 70
string title = "none"
string dataobject = "dw_datos_pedidos_clientes_g2"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_informe from datawindow within w_graf_pedidos_cliente_g2
integer x = 18
integer y = 296
integer width = 4389
integer height = 2264
string dataobject = "dw_graf_pedidos_cliente_g2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

