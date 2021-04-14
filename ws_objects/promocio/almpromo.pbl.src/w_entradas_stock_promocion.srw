$PBExportHeader$w_entradas_stock_promocion.srw
forward
global type w_entradas_stock_promocion from w_int_con_empresa
end type
type st_2 from statictext within w_entradas_stock_promocion
end type
type ddlb_tipo from dropdownlistbox within w_entradas_stock_promocion
end type
type st_nombre from statictext within w_entradas_stock_promocion
end type
type st_4 from statictext within w_entradas_stock_promocion
end type
type pb_1 from upb_salir within w_entradas_stock_promocion
end type
type pb_2 from picturebutton within w_entradas_stock_promocion
end type
type sle_valor from u_em_campo within w_entradas_stock_promocion
end type
type st_1 from statictext within w_entradas_stock_promocion
end type
type dw_1 from datawindow within w_entradas_stock_promocion
end type
end forward

global type w_entradas_stock_promocion from w_int_con_empresa
integer width = 2560
integer height = 1348
st_2 st_2
ddlb_tipo ddlb_tipo
st_nombre st_nombre
st_4 st_4
pb_1 pb_1
pb_2 pb_2
sle_valor sle_valor
st_1 st_1
dw_1 dw_1
end type
global w_entradas_stock_promocion w_entradas_stock_promocion

on w_entradas_stock_promocion.create
int iCurrent
call super::create
this.st_2=create st_2
this.ddlb_tipo=create ddlb_tipo
this.st_nombre=create st_nombre
this.st_4=create st_4
this.pb_1=create pb_1
this.pb_2=create pb_2
this.sle_valor=create sle_valor
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.ddlb_tipo
this.Control[iCurrent+3]=this.st_nombre
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.sle_valor
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_1
end on

on w_entradas_stock_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.ddlb_tipo)
destroy(this.st_nombre)
destroy(this.st_4)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.sle_valor)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Introducción de entradas de stock de promoción"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
ddlb_tipo.text = "Panel"
sle_valor.Setfocus()
end event

event activate;call super::activate;w_entradas_stock_promocion = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_entradas_stock_promocion
integer taborder = 0
boolean border = true
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_entradas_stock_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_entradas_stock_promocion
integer width = 2345
end type

type st_2 from statictext within w_entradas_stock_promocion
integer x = 91
integer y = 180
integer width = 475
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_tipo from dropdownlistbox within w_entradas_stock_promocion
integer x = 87
integer y = 272
integer width = 485
integer height = 236
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Panel","Expositor"}
borderstyle borderstyle = stylelowered!
end type

type st_nombre from statictext within w_entradas_stock_promocion
integer x = 827
integer y = 272
integer width = 1088
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_entradas_stock_promocion
integer x = 827
integer y = 180
integer width = 1088
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Descripción"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_entradas_stock_promocion
boolean visible = false
integer x = 2235
integer y = 200
integer taborder = 0
boolean bringtotop = true
end type

type pb_2 from picturebutton within w_entradas_stock_promocion
integer x = 2075
integer y = 204
integer width = 155
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "exit!"
end type

event clicked;integer total,i
string  var_procesado

total = dw_1.RowCount()

for i=1 to total
	var_procesado = dw_1.GetItemString(i,"procesado")
	if isnull(var_procesado) or var_procesado = "" then
		messagebox("Atencion","Hay movimientos pendientes de procesar")
		dw_1.SetFocus()
		return
	end if
next
pb_1.TriggerEvent(clicked!)
end event

type sle_valor from u_em_campo within w_entradas_stock_promocion
integer x = 571
integer y = 272
integer height = 92
integer taborder = 20
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;if ddlb_tipo.text = "Panel" then
	ue_datawindow =  "dw_ayuda_prompaneles"
	ue_titulo     =  "AYUDA SELECCION PANELES"
else
	ue_datawindow =  "dw_ayuda_promcabexpositores"
	ue_titulo     =  "AYUDA SELECCION EXPOSITORES"
end if
ue_filtro     =  ""
end event

event modificado;integer fila

if ddlb_tipo.text = "Panel" then
	st_nombre.text = f_nombre_prompaneles(codigo_empresa,sle_valor.text)
else
	st_nombre.text = f_nombre_promcabexpositores(codigo_empresa,sle_valor.text)
end if

fila = dw_1.InsertRow(0)
dw_1.SetItem(fila,"empresa",codigo_empresa)
if ddlb_tipo.text = "Panel" then
	dw_1.SetItem(fila,"tipo","1")
else
	dw_1.SetItem(fila,"tipo","2")
end if
dw_1.SetItem(fila,"articulo",sle_valor.text)

end event

type st_1 from statictext within w_entradas_stock_promocion
integer x = 571
integer y = 180
integer width = 251
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Codigo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_entradas_stock_promocion
integer x = 87
integer y = 412
integer width = 2299
integer height = 664
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_promo_entradas_stock"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//integer fila
//string  var_articulo,var_tipo
//dec{0}  var_stock,stock_aux
//
//if f_objeto_datawindow(This) = "procesar" then
//	fila = dw_1.GetRow()
//	var_tipo     = dw_1.GetItemstring(fila,"tipo")
//	var_articulo = dw_1.GetItemstring(fila,"articulo")
//	var_stock    = dw_1.GetItemnumber(fila,"stock")
//	
//	if var_stock <> 0 then
//		select stock
//		into   :stock_aux
//		where  tipo  = :var_tipo and
//				 articulo = :var_articulo;
//		if isnull(stock_aux) then
//			insert
//			
//		else
//			update
//			
//		end if
//	end if
//
//if f_objeto_datawindow(This) = "borrar" then
//	
//end if
//
//sle_valor.SetFocus()
end event

