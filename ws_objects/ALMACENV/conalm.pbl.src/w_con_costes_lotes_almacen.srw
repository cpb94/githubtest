$PBExportHeader$w_con_costes_lotes_almacen.srw
forward
global type w_con_costes_lotes_almacen from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_con_costes_lotes_almacen
end type
type dw_1 from datawindow within w_con_costes_lotes_almacen
end type
type cb_consulta from u_boton within w_con_costes_lotes_almacen
end type
type pb_1 from upb_salir within w_con_costes_lotes_almacen
end type
type gb_articulo from groupbox within w_con_costes_lotes_almacen
end type
type uo_articulo from u_em_campo_2 within w_con_costes_lotes_almacen
end type
type cb_2 from commandbutton within w_con_costes_lotes_almacen
end type
type cb_3 from commandbutton within w_con_costes_lotes_almacen
end type
type cb_4 from commandbutton within w_con_costes_lotes_almacen
end type
type sle_cajas from singlelineedit within w_con_costes_lotes_almacen
end type
type sle_alturas from singlelineedit within w_con_costes_lotes_almacen
end type
type sle_planos from singlelineedit within w_con_costes_lotes_almacen
end type
type st_1 from statictext within w_con_costes_lotes_almacen
end type
type st_2 from statictext within w_con_costes_lotes_almacen
end type
type st_3 from statictext within w_con_costes_lotes_almacen
end type
type r_1 from rectangle within w_con_costes_lotes_almacen
end type
type p_cursor from picture within w_con_costes_lotes_almacen
end type
type fecha_stock from datepicker within w_con_costes_lotes_almacen
end type
type gb_1 from groupbox within w_con_costes_lotes_almacen
end type
end forward

global type w_con_costes_lotes_almacen from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 6414
integer height = 3628
string title = "Consumo de bases"
pb_imprimir pb_imprimir
dw_1 dw_1
cb_consulta cb_consulta
pb_1 pb_1
gb_articulo gb_articulo
uo_articulo uo_articulo
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
sle_cajas sle_cajas
sle_alturas sle_alturas
sle_planos sle_planos
st_1 st_1
st_2 st_2
st_3 st_3
r_1 r_1
p_cursor p_cursor
fecha_stock fecha_stock
gb_1 gb_1
end type
global w_con_costes_lotes_almacen w_con_costes_lotes_almacen

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string articulo
datetime fecha


dw_1.reset()

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

fecha = datetime(string('yyyy/mm/dd',fecha_stock.text))

dw_1.Retrieve(codigo_empresa,articulo, fecha)


end subroutine

on w_con_costes_lotes_almacen.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_consulta=create cb_consulta
this.pb_1=create pb_1
this.gb_articulo=create gb_articulo
this.uo_articulo=create uo_articulo
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.sle_cajas=create sle_cajas
this.sle_alturas=create sle_alturas
this.sle_planos=create sle_planos
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.r_1=create r_1
this.p_cursor=create p_cursor
this.fecha_stock=create fecha_stock
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.gb_articulo
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.sle_cajas
this.Control[iCurrent+11]=this.sle_alturas
this.Control[iCurrent+12]=this.sle_planos
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.r_1
this.Control[iCurrent+17]=this.p_cursor
this.Control[iCurrent+18]=this.fecha_stock
this.Control[iCurrent+19]=this.gb_1
end on

on w_con_costes_lotes_almacen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_consulta)
destroy(this.pb_1)
destroy(this.gb_articulo)
destroy(this.uo_articulo)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.sle_cajas)
destroy(this.sle_alturas)
destroy(this.sle_planos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.r_1)
destroy(this.p_cursor)
destroy(this.fecha_stock)
destroy(this.gb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Encajados"
istr_parametros.s_listado        =   "dw_con_encajados"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

dw_1.SetTransObject(SQLCA)
//dw_1.SetRowFocusIndicator(Hand!)
dw_1.SetRowFocusIndicator(p_cursor)




end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

event activate;call super::activate;w_con_encajado = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_costes_lotes_almacen
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_costes_lotes_almacen
integer x = 55
integer y = 12
integer width = 320
integer height = 52
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_costes_lotes_almacen
integer y = 4
integer width = 6354
integer textsize = -8
end type

type pb_imprimir from upb_imprimir within w_con_costes_lotes_almacen
event clicked pbm_bnclicked
integer x = 6103
integer y = 140
integer taborder = 0
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_con_costes_lotes_almacen
integer x = 27
integer y = 280
integer width = 6341
integer height = 3136
string dataobject = "dw_con_articulos_costes_lotes_almacen"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

type cb_consulta from u_boton within w_con_costes_lotes_almacen
integer x = 5797
integer y = 136
integer width = 297
integer height = 104
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_costes_lotes_almacen
integer x = 6222
integer y = 140
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

type gb_articulo from groupbox within w_con_costes_lotes_almacen
integer x = 23
integer y = 84
integer width = 763
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within w_con_costes_lotes_almacen
event destroy ( )
integer x = 46
integer y = 140
integer width = 713
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_caja

select descripcion
into :des_caja
from articulos
where empresa = :codigo_empresa
and codigo = :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = des_caja
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

type cb_2 from commandbutton within w_con_costes_lotes_almacen
boolean visible = false
integer x = 3429
integer y = 3288
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar Todos"
end type

event clicked;long i

for i=1 to dw_1.rowcount()
	dw_1.object.articulos_marca[i] = 'S'
next
end event

type cb_3 from commandbutton within w_con_costes_lotes_almacen
boolean visible = false
integer x = 3959
integer y = 3288
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desmarcar Todos"
end type

event clicked;long i

for i=1 to dw_1.rowcount()
	dw_1.object.articulos_marca[i] = 'N'
next
end event

type cb_4 from commandbutton within w_con_costes_lotes_almacen
boolean visible = false
integer x = 1915
integer y = 3288
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;long i
string articulo, codigo, caja
int cajaspallet, planospallet, alturas

IF MessageBox("Atención", "Seguro que deseea Modificar los paletizados?", Exclamation!, OKCancel!, 2) = 1 THEN
	for i = 1 to dw_1.rowcount()
		if dw_1.object.articulos_marca[i] = 'S' then
			articulo = dw_1.object.palarticulo_articulo[i]
			codigo = dw_1.object.pallets_codigo[i]
			caja = dw_1.object.palarticulo_caja[i]
			cajaspallet = dw_1.object.palarticulo_cajaspallet[i]
			planospallet = dw_1.object.palarticulo_planospallet[i]
			alturas = dw_1.object.palarticulo_alturas[i]
			
			if sle_cajas.text <> '' and not isnull(sle_cajas.text) then
				cajaspallet = integer(sle_cajas.text)
			end if
			if sle_planos.text <> '' and not isnull(sle_planos.text) then
				planospallet = integer(sle_planos.text)
			end if
			if sle_alturas.text <> '' and not isnull(sle_alturas.text) then
				alturas = integer(sle_alturas.text)
			end if
			
			update palarticulo
			set cajaspallet = :cajaspallet, planospallet = :planospallet, alturas = :alturas
			where empresa = :codigo_empresa
			and articulo = :articulo
			and codigo = :codigo
			and caja = :caja
			using SQLCA;
			
			if SQLCA.SQLCode = 0 then
				commit;
			else
				rollback;
				messagebox("Aviso", "Se ha producido un error durante el proceso")
			end if		
		end if
	next
ELSE

 // Process CANCEL.

END IF

cb_consulta.TriggerEvent(clicked!)
end event

type sle_cajas from singlelineedit within w_con_costes_lotes_almacen
boolean visible = false
integer x = 315
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_alturas from singlelineedit within w_con_costes_lotes_almacen
boolean visible = false
integer x = 1531
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_planos from singlelineedit within w_con_costes_lotes_almacen
boolean visible = false
integer x = 914
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_costes_lotes_almacen
boolean visible = false
integer x = 91
integer y = 3300
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Cajas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_costes_lotes_almacen
boolean visible = false
integer x = 1307
integer y = 3304
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Alturas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_costes_lotes_almacen
boolean visible = false
integer x = 686
integer y = 3304
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Planos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_con_costes_lotes_almacen
boolean visible = false
integer linethickness = 4
long fillcolor = 15780518
integer x = 41
integer y = 3280
integer width = 1851
integer height = 104
end type

type p_cursor from picture within w_con_costes_lotes_almacen
integer x = 2533
integer y = 1684
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Next!"
boolean focusrectangle = false
end type

type fecha_stock from datepicker within w_con_costes_lotes_almacen
integer x = 832
integer y = 140
integer width = 745
integer height = 100
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean allowedit = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-02-25"), Time("13:59:31.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
weekday firstdayofweek = monday!
boolean todaysection = true
boolean todaycircle = true
end type

type gb_1 from groupbox within w_con_costes_lotes_almacen
integer x = 818
integer y = 84
integer width = 763
integer height = 160
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha stock"
end type

