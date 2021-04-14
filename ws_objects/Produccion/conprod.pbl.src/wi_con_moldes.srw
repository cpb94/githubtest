$PBExportHeader$wi_con_moldes.srw
forward
global type wi_con_moldes from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_moldes
end type
type pb_imprimir from upb_imprimir within wi_con_moldes
end type
type uo_manejo from u_manejo_datawindow within wi_con_moldes
end type
type cb_1 from u_boton within wi_con_moldes
end type
type st_1 from statictext within wi_con_moldes
end type
type ddlb_1 from dropdownlistbox within wi_con_moldes
end type
type st_2 from statictext within wi_con_moldes
end type
type ddlb_2 from dropdownlistbox within wi_con_moldes
end type
type cbx_solo_moldes from checkbox within wi_con_moldes
end type
type dw_2 from datawindow within wi_con_moldes
end type
type dw_1 from datawindow within wi_con_moldes
end type
end forward

global type wi_con_moldes from w_int_con_empresa
integer x = 187
integer y = 4
integer width = 3630
integer height = 2656
pb_1 pb_1
pb_imprimir pb_imprimir
uo_manejo uo_manejo
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
st_2 st_2
ddlb_2 ddlb_2
cbx_solo_moldes cbx_solo_moldes
dw_2 dw_2
dw_1 dw_1
end type
global wi_con_moldes wi_con_moldes

on wi_con_moldes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.cbx_solo_moldes=create cbx_solo_moldes
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.ddlb_2
this.Control[iCurrent+9]=this.cbx_solo_moldes
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.dw_1
end on

on wi_con_moldes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.cbx_solo_moldes)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Moldes y Platos"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)

dw_2.SetTransObject(SQLCA)
dw_2.SetRowFocusIndicator(Hand!)

ddlb_1.text = "Sí"
ddlb_2.text = "Sí"



end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;string formato

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
////	f_activar_campo(uo_1.em_campo)
////	return
//	formato = "%"
//else
//	formato = uo_1.em_codigo.text
//end if
dw_1.Retrieve(codigo_empresa,"%")
dw_report =dw_1
Call Super::ue_listar
end event

event activate;call super::activate;wi_con_moldes = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_moldes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_moldes
integer x = 2871
integer y = 812
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_moldes
end type

type pb_1 from upb_salir within wi_con_moldes
integer x = 3451
integer y = 100
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir from upb_imprimir within wi_con_moldes
event clicked pbm_bnclicked
integer x = 3287
integer y = 104
integer taborder = 0
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


//Parent.triggerEvent("ue_listar")
//f_activar_campo(uo_1.em_campo)

if cbx_solo_moldes.checked = true then

	if dw_2.rowcount() > 0 then
		
		f_imprimir_datawindow(dw_2)
		
	end if
	
else
	
	if dw_1.rowcount() > 0 then
		
		f_imprimir_datawindow(dw_1)
		
	end if
	
end if
end event

type uo_manejo from u_manejo_datawindow within wi_con_moldes
event valores pbm_custom01
integer x = 2811
integer y = 56
integer width = 622
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
//f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within wi_con_moldes
integer x = 2491
integer y = 96
integer width = 315
integer height = 104
integer taborder = 20
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string molde, molde_activo,plato_activo



//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
	molde = "%"
//else
//	formato = uo_1.em_codigo.text
//end if

choose case ddlb_1.text
		
	case 'Sí'
		
		molde_activo = 'S'
		
	case 'No'
		
		molde_activo = 'N'
		
	case 'Todos'
		
		molde_activo = '%'

end choose

if cbx_solo_moldes.checked = false then
	
	dw_1.visible = true
	dw_2.visible = false
	
	choose case ddlb_2.text
			
		case 'Sí'
			
			plato_activo = 'S'
			
		case 'No'
			
			plato_activo = 'N'
			
		case 'Todos'
			
			plato_activo = '%'
	
	end choose
	dw_1.Retrieve(codigo_empresa,molde,molde_activo,plato_activo)
	
	if dw_1.RowCount() = 0 then
		messagebox("Atención","No hay datos")
	end if

else
	
	dw_1.visible = false
	dw_2.visible = true
	
	dw_2.Retrieve(codigo_empresa,molde,molde_activo)
	
	if dw_2.RowCount() = 0 then
		messagebox("Atención","No hay datos")
	end if

end if
end event

type st_1 from statictext within wi_con_moldes
integer x = 32
integer y = 120
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Molde Activo"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within wi_con_moldes
integer x = 439
integer y = 104
integer width = 407
integer height = 400
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Sí","No","Todos"}
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within wi_con_moldes
integer x = 869
integer y = 120
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Plato Activo"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within wi_con_moldes
integer x = 1248
integer y = 104
integer width = 407
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Sí","No","Todos"}
borderstyle borderstyle = styleraised!
end type

type cbx_solo_moldes from checkbox within wi_con_moldes
integer x = 1728
integer y = 116
integer width = 663
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Mostrar solo moldes"
end type

type dw_2 from datawindow within wi_con_moldes
boolean visible = false
integer x = 18
integer y = 232
integer width = 3529
integer height = 2228
integer taborder = 40
string title = "none"
string dataobject = "dw_con_moldes_sinplatos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within wi_con_moldes
integer x = 9
integer y = 232
integer width = 3538
integer height = 2224
string dataobject = "dw_con_moldes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
  OpenWithParm(wi_mant_prodmoldes,lstr_param)

end event

