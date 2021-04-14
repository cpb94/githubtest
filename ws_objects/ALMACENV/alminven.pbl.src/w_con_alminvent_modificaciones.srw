$PBExportHeader$w_con_alminvent_modificaciones.srw
forward
global type w_con_alminvent_modificaciones from w_int_con_empresa
end type
type st_2 from statictext within w_con_alminvent_modificaciones
end type
type em_periodo from u_em_campo within w_con_alminvent_modificaciones
end type
type dw_1 from datawindow within w_con_alminvent_modificaciones
end type
type pb_1 from upb_salir within w_con_alminvent_modificaciones
end type
type dw_inv from datawindow within w_con_alminvent_modificaciones
end type
type cb_2 from u_boton within w_con_alminvent_modificaciones
end type
type cb_3 from u_boton within w_con_alminvent_modificaciones
end type
type dw_listado from datawindow within w_con_alminvent_modificaciones
end type
type dw_zonas from datawindow within w_con_alminvent_modificaciones
end type
type zonas from radiobutton within w_con_alminvent_modificaciones
end type
type gb_1 from groupbox within w_con_alminvent_modificaciones
end type
end forward

global type w_con_alminvent_modificaciones from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 2953
integer height = 2188
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
pb_1 pb_1
dw_inv dw_inv
cb_2 cb_2
cb_3 cb_3
dw_listado dw_listado
dw_zonas dw_zonas
zonas zonas
gb_1 gb_1
end type
global w_con_alminvent_modificaciones w_con_alminvent_modificaciones

type variables
String filtro
end variables

event open;call super::open;
istr_parametros.s_titulo_ventana="Consulta modificaciones Inventario"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_zonas.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		
dw_zonas.SetRowFocusIndicator(Hand!)		
em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))




end event

on w_con_alminvent_modificaciones.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_periodo=create em_periodo
this.dw_1=create dw_1
this.pb_1=create pb_1
this.dw_inv=create dw_inv
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_listado=create dw_listado
this.dw_zonas=create dw_zonas
this.zonas=create zonas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_periodo
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.dw_inv
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.dw_zonas
this.Control[iCurrent+10]=this.zonas
this.Control[iCurrent+11]=this.gb_1
end on

on w_con_alminvent_modificaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_periodo)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.dw_inv)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_listado)
destroy(this.dw_zonas)
destroy(this.zonas)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_alminvent_modificaciones
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_alminvent_modificaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_alminvent_modificaciones
integer y = 12
integer width = 2638
end type

type st_2 from statictext within w_con_alminvent_modificaciones
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_periodo from u_em_campo within w_con_alminvent_modificaciones
integer x = 325
integer y = 164
integer taborder = 60
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_con_alminvent_modificaciones
integer x = 599
integer y = 160
integer width = 1573
integer height = 356
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_alminvent1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

event rowfocuschanged;IF GetRow() = 0 Then Return
dw_zonas.retrieve(codigo_empresa,GetItemDateTime(GetRow(),"fecha_inv"),GetItemSTring(GetRow(),"almacen"))
end event

event retrieveend;IF rowcount = 0 Then Return
dw_zonas.retrieve(codigo_empresa,GetItemDateTime(1,"fecha_inv"),GetItemSTring(1,"almacen"))
end event

type pb_1 from upb_salir within w_con_alminvent_modificaciones
integer x = 2693
integer y = 8
integer width = 119
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_inv from datawindow within w_con_alminvent_modificaciones
event key pbm_dwnkey
integer x = 9
integer y = 532
integer width = 2843
integer height = 1420
string dataobject = "dw_con_alminvent2_modificaciones"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from u_boton within w_con_alminvent_modificaciones
integer x = 23
integer y = 424
integer width = 274
integer height = 84
integer taborder = 40
string text = "&Consultar"
end type

event clicked;call super::clicked;dw_inv.SetFilter("")
dw_inv.Filter()
IF Not zonas.checked Then
	dw_inv.SetFilter("zona = '"+dw_zonas.GetItemSTring(dw_zonas.GetRow(),"zona")+"'")
	dw_inv.Filter()
END IF
dw_inv.Retrieve(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),&
                          dw_1.GetItemString(dw_1.Getrow(),"almacen"))
                        
end event

type cb_3 from u_boton within w_con_alminvent_modificaciones
integer x = 297
integer y = 424
integer width = 274
integer height = 84
integer taborder = 50
string text = "&Imprimir"
end type

event clicked;call super::clicked;dw_listado.SetFilter("")
dw_listado.Filter()
IF Not zonas.checked Then
	dw_listado.SetFilter("zona = '"+dw_zonas.GetItemSTring(dw_zonas.GetRow(),"zona")+"'")
	dw_listado.Filter()
END IF
dw_listado.Retrieve(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),&
                          dw_1.GetItemString(dw_1.Getrow(),"almacen"))
                        
f_imprimir_datawindow(dw_listado)                        
end event

type dw_listado from datawindow within w_con_alminvent_modificaciones
boolean visible = false
integer x = 55
integer y = 252
integer width = 494
integer height = 328
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_alminvent_modificaciones"
boolean livescroll = true
end type

type dw_zonas from datawindow within w_con_alminvent_modificaciones
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 2171
integer y = 160
integer width = 475
integer height = 356
integer taborder = 30
string dataobject = "dw_con_alminvent"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on getfocus;This.BorderStyle=StyleLowered!
end on

on losefocus;This.BorderStyle=StyleRaised!
end on

type zonas from radiobutton within w_con_alminvent_modificaciones
integer x = 32
integer y = 312
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Todas Las Zonas"
boolean checked = true
boolean automatic = false
boolean lefttext = true
end type

event clicked;IF checked Then
	checked = FALSE
ELSE
	checked = TRUE
END IF
end event

type gb_1 from groupbox within w_con_alminvent_modificaciones
integer x = 9
integer y = 388
integer width = 576
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

