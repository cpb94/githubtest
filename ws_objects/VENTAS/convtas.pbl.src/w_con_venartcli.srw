$PBExportHeader$w_con_venartcli.srw
forward
global type w_con_venartcli from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_venartcli
end type
type st_1 from statictext within w_con_venartcli
end type
type dw_listado from datawindow within w_con_venartcli
end type
type em_cliente from u_em_campo within w_con_venartcli
end type
type st_nomcliente from statictext within w_con_venartcli
end type
type uo_1 from u_manejo_datawindow within w_con_venartcli
end type
type pb_2 from upb_imprimir within w_con_venartcli
end type
type dw_articulos from datawindow within w_con_venartcli
end type
end forward

global type w_con_venartcli from w_int_con_empresa
integer width = 2729
integer height = 2148
pb_1 pb_1
st_1 st_1
dw_listado dw_listado
em_cliente em_cliente
st_nomcliente st_nomcliente
uo_1 uo_1
pb_2 pb_2
dw_articulos dw_articulos
end type
global w_con_venartcli w_con_venartcli

type variables
string filtro,moneda

end variables

on ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa,em_cliente.text)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta articulos por cliente"
This.title=istr_parametros.s_titulo_ventana

dw_articulos.SetTransObject(SQLCA)


end event

on w_con_venartcli.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_listado=create dw_listado
this.em_cliente=create em_cliente
this.st_nomcliente=create st_nomcliente
this.uo_1=create uo_1
this.pb_2=create pb_2
this.dw_articulos=create dw_articulos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_cliente
this.Control[iCurrent+5]=this.st_nomcliente
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.dw_articulos
end on

on w_con_venartcli.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.em_cliente)
destroy(this.st_nomcliente)
destroy(this.uo_1)
destroy(this.pb_2)
destroy(this.dw_articulos)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

event activate;call super::activate;w_con_venartcli = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_venartcli
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_venartcli
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_venartcli
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_venartcli
integer x = 2574
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean default = true
boolean originalsize = true
end type

type st_1 from statictext within w_con_venartcli
integer x = 82
integer y = 164
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_venartcli
boolean visible = false
integer x = 96
integer width = 494
integer height = 152
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_vencliart"
boolean livescroll = true
end type

type em_cliente from u_em_campo within w_con_venartcli
integer x = 329
integer y = 152
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,"C",em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF
dw_articulos.Retrieve(codigo_empresa,em_cliente.text,f_moneda_genter(codigo_empresa,"C",em_cliente.text))

end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 		



end event

type st_nomcliente from statictext within w_con_venartcli
integer x = 603
integer y = 164
integer width = 1189
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type uo_1 from u_manejo_datawindow within w_con_venartcli
integer x = 1934
integer y = 124
integer height = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data       = dw_articulos
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_cliente)
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_con_venartcli
integer x = 2409
integer y = 172
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(em_cliente)
end event

type dw_articulos from datawindow within w_con_venartcli
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 73
integer y = 292
integer width = 2487
integer height = 1612
string dataobject = "dw_con_artcli11"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=4
  lstr_param.s_argumentos[2]=This.GetItemString(Row,"cliente")
  lstr_param.s_argumentos[3]=This.GetItemString(Row,"articulo")
  lstr_param.s_argumentos[4]=This.GetItemString(Row,"calidad")
  OpenWithParm(wi_mant_venartcli,lstr_param) 
ELSE
  
  datawindow var_datawindow
  
  CHOOSE CASE f_objeto_datawindow(This)
    
  CASE 'pb_carpeta'
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=em_cliente.text
   OpenWithParm(wi_mant_venartcli,lstr_param)  

  END CHOOSE

END IF

end event

