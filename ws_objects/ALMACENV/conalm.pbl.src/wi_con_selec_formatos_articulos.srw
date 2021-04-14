$PBExportHeader$wi_con_selec_formatos_articulos.srw
forward
global type wi_con_selec_formatos_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_selec_formatos_articulos
end type
type pb_imprimir from upb_imprimir within wi_con_selec_formatos_articulos
end type
type uo_manejo from u_manejo_datawindow within wi_con_selec_formatos_articulos
end type
type cb_1 from u_boton within wi_con_selec_formatos_articulos
end type
type uo_formatos from u_marca_lista within wi_con_selec_formatos_articulos
end type
type cb_2 from u_boton within wi_con_selec_formatos_articulos
end type
type dw_1 from datawindow within wi_con_selec_formatos_articulos
end type
type dw_formatos from datawindow within wi_con_selec_formatos_articulos
end type
type dw_listado from datawindow within wi_con_selec_formatos_articulos
end type
end forward

global type wi_con_selec_formatos_articulos from w_int_con_empresa
integer width = 2930
integer height = 1644
pb_1 pb_1
pb_imprimir pb_imprimir
uo_manejo uo_manejo
cb_1 cb_1
uo_formatos uo_formatos
cb_2 cb_2
dw_1 dw_1
dw_formatos dw_formatos
dw_listado dw_listado
end type
global wi_con_selec_formatos_articulos wi_con_selec_formatos_articulos

forward prototypes
public function any f_filtro ()
end prototypes

public function any f_filtro ();Integer indice,total,ind_form
String formatos[1 to 50]

FOR indice = 1 To 50
	formatos[indice] = ""
next

ind_form = 0
total = uo_formatos.dw_marca.RowCount()
IF total > 0 Then 

	FOR indice = 1 To total
   	IF uo_formatos.dw_marca.GetItemString(indice,"marca") = "S" THEN
			ind_form = ind_form +1
			formatos[indice] = uo_formatos.dw_marca.GetItemString(indice,"codigo")
  		END IF
	NEXT
end if


return formatos


end function

on wi_con_selec_formatos_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.uo_formatos=create uo_formatos
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_formatos=create dw_formatos
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_formatos
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_formatos
this.Control[iCurrent+9]=this.dw_listado
end on

on wi_con_selec_formatos_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.uo_formatos)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_formatos)
destroy(this.dw_listado)
end on

event open;call super::open;Integer x2,registros2 
String var_codigo2,var_texto2,marca2

istr_parametros.s_titulo_ventana =   "Consulta de Artículos por formato"
istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

dw_formatos.SetTransObject(SQLCA)
registros2 = dw_formatos.retrieve(codigo_empresa,"%")
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_formatos.GetItemString(x2,"codigo")
  var_texto2   = dw_formatos.GetItemString(x2,"descripcion")
  marca2="S"
  uo_formatos.dw_marca.InsertRow(x2)
  uo_formatos.dw_marca.setitem(x2,"marca",marca2)
  uo_formatos.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_formatos.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_formatos.st_titulo1.text="Codigo"
uo_formatos.st_titulo2.text="Formato"


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;Integer indice,total,ind_form
String formatos[1 to 50]

FOR indice = 1 To 50
	formatos[indice] = ""
next

ind_form = 0
total = uo_formatos.dw_marca.RowCount()
IF total > 0 Then 

	FOR indice = 1 To total
   	IF uo_formatos.dw_marca.GetItemString(indice,"marca") = "S" THEN
			ind_form = ind_form +1
			formatos[indice] = uo_formatos.dw_marca.GetItemString(indice,"codigo")
  		END IF
	NEXT
end if

dw_listado.Retrieve(codigo_empresa,formatos)

dw_report =dw_listado
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_selec_formatos_articulos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_selec_formatos_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_selec_formatos_articulos
end type

type pb_1 from upb_salir within wi_con_selec_formatos_articulos
integer x = 2711
integer y = 28
integer width = 123
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type pb_imprimir from upb_imprimir within wi_con_selec_formatos_articulos
event clicked pbm_bnclicked
integer x = 2706
integer y = 172
integer taborder = 0
string picturename = "print!"
end type

event clicked;
Parent.triggerEvent("ue_listar")

end event

type uo_manejo from u_manejo_datawindow within wi_con_selec_formatos_articulos
event valores pbm_custom01
integer x = 2226
integer y = 128
integer width = 635
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from u_boton within wi_con_selec_formatos_articulos
integer x = 1911
integer y = 168
integer width = 315
integer height = 104
integer taborder = 30
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;Integer indice,total,ind_form
String formatos[1 to 50]

FOR indice = 1 To 50
	formatos[indice] = ""
next

ind_form = 0
total = uo_formatos.dw_marca.RowCount()
IF total > 0 Then 

	FOR indice = 1 To total
   	IF uo_formatos.dw_marca.GetItemString(indice,"marca") = "S" THEN
			ind_form = ind_form +1
			formatos[indice] = uo_formatos.dw_marca.GetItemString(indice,"codigo")
  		END IF
	NEXT
end if

uo_formatos.visible = false
dw_1.Retrieve(codigo_empresa,formatos)
if dw_1.rowcount() > 0 then
	dw_1.visible = true
end if
end event

type uo_formatos from u_marca_lista within wi_con_selec_formatos_articulos
event destroy ( )
boolean visible = false
integer x = 439
integer y = 284
integer width = 1445
integer height = 652
integer taborder = 50
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type cb_2 from u_boton within wi_con_selec_formatos_articulos
integer x = 1577
integer y = 168
integer width = 315
integer height = 104
integer taborder = 20
boolean bringtotop = true
string text = "Formatos"
end type

event clicked;uo_formatos.visible = true

dw_1.visible = FALSE
end event

type dw_1 from datawindow within wi_con_selec_formatos_articulos
integer x = 5
integer y = 284
integer width = 2834
integer height = 1136
string dataobject = "dw_con_selec_formatos_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="wi_con_formatos_articulos"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
  OpenWithParm(wi_mant_articulos,lstr_param)

end event

type dw_formatos from datawindow within wi_con_selec_formatos_articulos
boolean visible = false
integer x = 576
integer y = 164
integer width = 494
integer height = 360
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ayuda_formatos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado from datawindow within wi_con_selec_formatos_articulos
boolean visible = false
integer x = 133
integer y = 48
integer width = 521
integer height = 208
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_selec_formatos_articulos"
boolean livescroll = true
end type

