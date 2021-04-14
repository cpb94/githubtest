$PBExportHeader$wi_con_cant_form_articulos.srw
forward
global type wi_con_cant_form_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_cant_form_articulos
end type
type dw_1 from datawindow within wi_con_cant_form_articulos
end type
type dw_listado from datawindow within wi_con_cant_form_articulos
end type
type pb_imprimir from upb_imprimir within wi_con_cant_form_articulos
end type
type cb_1 from commandbutton within wi_con_cant_form_articulos
end type
type gb_1 from groupbox within wi_con_cant_form_articulos
end type
type em_fechadesde from u_em_campo within wi_con_cant_form_articulos
end type
type em_fechahasta from u_em_campo within wi_con_cant_form_articulos
end type
type cb_detalle from commandbutton within wi_con_cant_form_articulos
end type
end forward

global type wi_con_cant_form_articulos from w_int_con_empresa
integer width = 2866
integer height = 1624
pb_1 pb_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
cb_1 cb_1
gb_1 gb_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_detalle cb_detalle
end type
global wi_con_cant_form_articulos wi_con_cant_form_articulos

forward prototypes
public subroutine f_procesar (datawindow data)
end prototypes

public subroutine f_procesar (datawindow data);datastore articulos
datastore formulas
string seleccion1,seleccion2,seleccion3,var_version,aplicacion
long indice1,indice2,indice3
long total1,total2,total3
string articulo,familia,formato,calidad,formula
real cantidad,cant_formula
datetime fecha,fmin	
long donde

data.Reset()
data.SetRedraw(FALSE)
if data = dw_listado then
	data.retrieve (codigo_empresa,STring(Date(em_fechadesde.text)),STring(Date(em_fechahasta.text)))
else
	data.retrieve (codigo_empresa)
end if
seleccion1 ="select articulo,familia,formato,cantidad,fecha from proddiaria "+&
				"where empresa = '"+codigo_empresa+"' and "+&
				"fecha between '"+STring(Date(em_fechadesde.text),"mm/dd/yy")+"' and '"+STring(Date(em_fechahasta.text),"mm/dd/yy")+"'"+&
				" order by fecha,articulo,familia,formato"
	
//articulos = f_cargar_cursor(seleccion1)
f_cargar_cursor_nuevo(seleccion1, articulos)

total1 = articulos.rowcount()
	
if total1 > 0 then
	for indice1 = 1 to total1
		articulo = articulos.getitemstring(indice1,"articulo")
		familia = articulos.getitemstring(indice1,"familia")
		formato = articulos.getitemstring(indice1,"formato")
		cantidad = articulos.getitemdecimal(indice1,"cantidad")
		fecha = articulos.getitemdatetime(indice1,"fecha")
		var_version = f_version_activa_articulo(codigo_empresa,articulo)
		seleccion2 ="select aplicacion,formulacion,gramaje from proddetartic "+&
						"where empresa = '"+codigo_empresa+"' and "+&
						"articulo = '"+articulo+"' and "+&
						"version = '"+var_version+"'"
		
		//formulas = f_cargar_cursor (seleccion2)
		f_cargar_cursor_nuevo(seleccion2, formulas)
		total2 = formulas.rowcount()
		if total2 > 0 then
			for indice2 = 1 to total2
				aplicacion = formulas.getitemstring(indice2,"aplicacion")
				formula = formulas.getitemstring(indice2,"formulacion")
				cant_formula = formulas.getitemdecimal(indice2,"gramaje")
				donde = data.insertrow(0)
				data.setitem(donde,"empresa",codigo_empresa)
				data.setitem(donde,"articulo",articulo)
				data.setitem(donde,"familia",familia)
				data.setitem(donde,"formato",formato)
				data.setitem(donde,"formula",formula)
				data.setitem(donde,"cant_dia",f_incremento_formula_en_aplicacion(codigo_empresa,aplicacion,(cant_formula * cantidad)/1000))
				data.setitem(donde,"aplicacion",f_nombre_aplicacion_abr(codigo_empresa,aplicacion))
				data.setitem(donde,"dia",fecha)
			next
		end if
   next
end if
destroy articulos 
destroy formulas
data.SetRedraw(TRUE)
data.Sort()
data.GroupCalc()



end subroutine

on wi_con_cant_form_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.gb_1=create gb_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_detalle=create cb_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.cb_detalle
end on

on wi_con_cant_form_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_detalle)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Necesidades Formulación"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(em_fechadesde)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;
if trim(em_fechadesde.text)<>"" then
	if trim(em_fechahasta.text)<>"" then
			//dw_listado.retrieve(codigo_empresa,date(em_fechadesde.text),date(em_fechahasta.text))
			f_procesar(dw_listado)
			dw_report = dw_listado
			Call Super::ue_listar
	else
		messagebox ("Error","Debe introducir el valor de la fecha tope")
		setfocus(em_fechahasta)
	end if
else
	messagebox ("Error","Debe introducir el valor de la fecha inicio")
	setfocus(em_fechadesde)
end if

end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_cant_form_articulos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_cant_form_articulos
integer x = 1586
integer y = 24
integer width = 352
integer height = 312
fontcharset fontcharset = ansi!
end type

event getfocus;//f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_cant_form_articulos
integer width = 837
end type

type pb_1 from upb_salir within wi_con_cant_form_articulos
integer x = 2688
integer y = 40
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_1 from datawindow within wi_con_cant_form_articulos
integer x = 78
integer y = 356
integer width = 2546
integer height = 1016
boolean bringtotop = true
string dataobject = "dw_con_cant_form_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within wi_con_cant_form_articulos
boolean visible = false
integer y = 4
integer width = 329
integer height = 160
boolean bringtotop = true
string dataobject = "report_con_cant_form_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within wi_con_cant_form_articulos
event clicked pbm_bnclicked
integer x = 2437
integer y = 208
integer taborder = 50
end type

event clicked;PArent.triggerEvent("ue_listar")

end event

type cb_1 from commandbutton within wi_con_cant_form_articulos
integer x = 832
integer y = 192
integer width = 293
integer height = 148
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;
if trim(em_fechadesde.text)<>"" then
	if trim(em_fechahasta.text)<>"" then
			//dw_1.retrieve(codigo_empresa,date(em_fechadesde.text),date(em_fechahasta.text))
			f_procesar (dw_1)
	else
		messagebox ("Error","Debe introducir el valor de la fecha tope")
		setfocus(em_fechahasta)
	end if
else
	messagebox ("Error","Debe introducir el valor de la fecha inicio")
	setfocus(em_fechadesde)
end if


end event

type gb_1 from groupbox within wi_con_cant_form_articulos
integer x = 82
integer y = 160
integer width = 736
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type em_fechadesde from u_em_campo within wi_con_cant_form_articulos
integer x = 105
integer y = 232
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within wi_con_cant_form_articulos
integer x = 475
integer y = 232
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_detalle from commandbutton within wi_con_cant_form_articulos
integer x = 1801
integer y = 256
integer width = 622
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ocultar detalle dias"
end type

event clicked;if this.text = "Ver detalle dias" then
	this.text = "Ocultar detalle dias"
	dw_1.modify("datawindow.detail.height=72")
	dw_listado.modify("datawindow.detail.height=72")

else
	this.text = "Ver detalle dias"
	dw_1.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")

end if

end event

