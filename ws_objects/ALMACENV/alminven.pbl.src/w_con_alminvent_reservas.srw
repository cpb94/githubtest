$PBExportHeader$w_con_alminvent_reservas.srw
forward
global type w_con_alminvent_reservas from w_int_con_empresa
end type
type st_2 from statictext within w_con_alminvent_reservas
end type
type em_periodo from u_em_campo within w_con_alminvent_reservas
end type
type dw_1 from datawindow within w_con_alminvent_reservas
end type
type pb_1 from upb_salir within w_con_alminvent_reservas
end type
type dw_inv from datawindow within w_con_alminvent_reservas
end type
type cb_2 from u_boton within w_con_alminvent_reservas
end type
type cb_3 from u_boton within w_con_alminvent_reservas
end type
type dw_listado from datawindow within w_con_alminvent_reservas
end type
type gb_1 from groupbox within w_con_alminvent_reservas
end type
end forward

global type w_con_alminvent_reservas from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 2875
integer height = 2144
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
pb_1 pb_1
dw_inv dw_inv
cb_2 cb_2
cb_3 cb_3
dw_listado dw_listado
gb_1 gb_1
end type
global w_con_alminvent_reservas w_con_alminvent_reservas

type variables
String filtro
end variables

event open;call super::open;
istr_parametros.s_titulo_ventana="Consulta inventarios reservas clientes"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)

dw_listado.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		

em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))




end event

on w_con_alminvent_reservas.create
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
this.Control[iCurrent+9]=this.gb_1
end on

on w_con_alminvent_reservas.destroy
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
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_alminvent_reservas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_alminvent_reservas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_alminvent_reservas
integer y = 12
integer width = 2638
end type

type st_2 from statictext within w_con_alminvent_reservas
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

type em_periodo from u_em_campo within w_con_alminvent_reservas
integer x = 325
integer y = 164
integer taborder = 50
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_con_alminvent_reservas
integer x = 599
integer y = 160
integer width = 768
integer height = 356
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_invent_reservas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

type pb_1 from upb_salir within w_con_alminvent_reservas
integer x = 2693
integer y = 8
integer width = 119
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_inv from datawindow within w_con_alminvent_reservas
event key pbm_dwnkey
integer x = 9
integer y = 532
integer width = 2793
integer height = 1372
string dataobject = "dw_con_alminvent_reservas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from u_boton within w_con_alminvent_reservas
integer x = 1403
integer y = 420
integer width = 274
integer height = 84
integer taborder = 30
string text = "&Consultar"
end type

event clicked;call super::clicked;dw_inv.SetFilter("")
dw_inv.Filter()
dw_inv.Retrieve(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"))
                        
end event

type cb_3 from u_boton within w_con_alminvent_reservas
integer x = 1678
integer y = 420
integer width = 274
integer height = 84
integer taborder = 40
string text = "&Imprimir"
end type

event clicked;call super::clicked;dw_listado.SetFilter("")
dw_listado.Filter()
dw_listado.Retrieve(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"))
                        
f_imprimir_datawindow(dw_listado)                        
end event

type dw_listado from datawindow within w_con_alminvent_reservas
boolean visible = false
integer x = 55
integer y = 252
integer width = 494
integer height = 328
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_alminvent_reservas"
boolean livescroll = true
end type

type gb_1 from groupbox within w_con_alminvent_reservas
integer x = 1390
integer y = 384
integer width = 576
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

