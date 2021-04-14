$PBExportHeader$w_con_distribuidores_provincias.srw
forward
global type w_con_distribuidores_provincias from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_distribuidores_provincias
end type
type st_1 from statictext within w_con_distribuidores_provincias
end type
type uo_pais from u_em_campo_2 within w_con_distribuidores_provincias
end type
type dw_proceso_provincias from datawindow within w_con_distribuidores_provincias
end type
type pb_2 from upb_salir within w_con_distribuidores_provincias
end type
type pb_3 from upb_imprimir within w_con_distribuidores_provincias
end type
type dw_listado from datawindow within w_con_distribuidores_provincias
end type
type dw_subdistribuidores from datawindow within w_con_distribuidores_provincias
end type
type dw_distribuidores from datawindow within w_con_distribuidores_provincias
end type
type uo_manejo from u_manejo_datawindow within w_con_distribuidores_provincias
end type
type uo_provincias from u_marca_lista within w_con_distribuidores_provincias
end type
type cb_consultar from u_boton within w_con_distribuidores_provincias
end type
end forward

global type w_con_distribuidores_provincias from w_int_con_empresa
integer width = 2926
integer height = 1916
pb_1 pb_1
st_1 st_1
uo_pais uo_pais
dw_proceso_provincias dw_proceso_provincias
pb_2 pb_2
pb_3 pb_3
dw_listado dw_listado
dw_subdistribuidores dw_subdistribuidores
dw_distribuidores dw_distribuidores
uo_manejo uo_manejo
uo_provincias uo_provincias
cb_consultar cb_consultar
end type
global w_con_distribuidores_provincias w_con_distribuidores_provincias

type variables
string filtro
end variables

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
String montaje
Integer numero,registros,x1,y1
y1=0

dw_report.Setfilter("")
dw_report.filter()

numero = uo_provincias.dw_marca.RowCount()
IF numero =0 Then return
FOR x1 = 1 To numero
IF uo_provincias.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF y1=1 Then
    montaje = " provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
    montaje = " Or provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtro = filtro + montaje
END IF
NEXT
dw_report.Setfilter(filtro)
dw_report.filter()
dw_report.retrieve(codigo_empresa,uo_pais.em_codigo.text)
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta distribuidores"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_subdistribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
uo_pais.em_codigo.text = "11"
uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
dw_proceso_provincias.SetTransObject(SQLCA)

uo_pais.TriggerEvent("modificado")
uo_pais.em_campo.SetFocus()

end event

on w_con_distribuidores_provincias.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_pais=create uo_pais
this.dw_proceso_provincias=create dw_proceso_provincias
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_listado=create dw_listado
this.dw_subdistribuidores=create dw_subdistribuidores
this.dw_distribuidores=create dw_distribuidores
this.uo_manejo=create uo_manejo
this.uo_provincias=create uo_provincias
this.cb_consultar=create cb_consultar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_pais
this.Control[iCurrent+4]=this.dw_proceso_provincias
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.pb_3
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.dw_subdistribuidores
this.Control[iCurrent+9]=this.dw_distribuidores
this.Control[iCurrent+10]=this.uo_manejo
this.Control[iCurrent+11]=this.uo_provincias
this.Control[iCurrent+12]=this.cb_consultar
end on

on w_con_distribuidores_provincias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_pais)
destroy(this.dw_proceso_provincias)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_listado)
destroy(this.dw_subdistribuidores)
destroy(this.dw_distribuidores)
destroy(this.uo_manejo)
destroy(this.uo_provincias)
destroy(this.cb_consultar)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_distribuidores)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_distribuidores)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_distribuidores_provincias
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_distribuidores_provincias
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_distribuidores_provincias
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_distribuidores_provincias
integer x = 2697
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_1 from statictext within w_con_distribuidores_provincias
integer x = 37
integer y = 164
integer width = 151
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pais"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pais from u_em_campo_2 within w_con_distribuidores_provincias
integer x = 215
integer y = 156
integer width = 617
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;Integer registros,x1
String  var_codigo,var_texto,marca

uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

IF Trim(uo_pais.em_campo.text)="" THEN 
 IF Trim(uo_pais.em_codigo.text)<>"" Then uo_pais.em_campo.SetFocus()
 uo_pais.em_campo.text=""
 uo_pais.em_codigo.text=""
END IF

uo_provincias.dw_marca.Reset()
registros=dw_proceso_provincias.retrieve(uo_pais.em_codigo.text)

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso_provincias.GetItemString(x1,"provincia")
  var_texto   = dw_proceso_provincias.GetItemString(x1,"nombre")
  marca="S"
  uo_provincias.dw_marca.InsertRow(x1)
  uo_provincias.dw_marca.setitem(x1,"marca",marca)
  uo_provincias.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_provincias.dw_marca.setitem(x1,"texto",var_texto)
 NEXT
END IF

uo_provincias.st_titulo1.text="Provincia"
uo_provincias.st_titulo2.text="Nombre"



end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de paises"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
valor_empresa = FALSE

end on

on uo_pais.destroy
call u_em_campo_2::destroy
end on

type dw_proceso_provincias from datawindow within w_con_distribuidores_provincias
boolean visible = false
integer width = 873
integer height = 88
boolean bringtotop = true
string dataobject = "dw_proceso_provincias"
boolean livescroll = true
end type

type pb_2 from upb_salir within w_con_distribuidores_provincias
boolean visible = false
integer x = 18
integer y = 280
integer width = 105
integer height = 92
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

event clicked;dw_distribuidores.visible    = FALSE
pb_2.visible                 = FALSE
dw_subdistribuidores.visible = FALSE
uo_manejo.visible            = FALSE
pb_3.visible                 = FALSE

uo_provincias.visible = TRUE
cb_consultar.visible  = TRUE
f_activar_campo(uo_pais.em_campo)

end event

type pb_3 from upb_imprimir within w_con_distribuidores_provincias
boolean visible = false
integer x = 2683
integer y = 176
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

on clicked;call upb_imprimir::clicked;Parent.TriggerEvent("ue_listar")
end on

type dw_listado from datawindow within w_con_distribuidores_provincias
boolean visible = false
integer x = 2249
integer y = 4
integer width = 251
integer height = 112
boolean bringtotop = true
string dataobject = "report_con_distribuidores_provincias"
boolean livescroll = true
end type

type dw_subdistribuidores from datawindow within w_con_distribuidores_provincias
boolean visible = false
integer x = 1659
integer y = 272
integer width = 1179
integer height = 1420
boolean bringtotop = true
string dataobject = "dw_con_distribuidores_provincias2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo_cliente")
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_distribuidores,lstr_param) 

end event

type dw_distribuidores from datawindow within w_con_distribuidores_provincias
boolean visible = false
integer x = 14
integer y = 272
integer width = 1646
integer height = 1420
string dataobject = "dw_con_distribuidores_provincias1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF This.GetRow()= 0 Then Return

dw_subdistribuidores.retrieve(codigo_empresa,This.GetItemString(This.GetRow(),"genter_codigo"))

end event

event rowfocuschanged;This.TriggerEvent(clicked!)
end event

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"genter_codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 


end event

type uo_manejo from u_manejo_datawindow within w_con_distribuidores_provincias
event valores pbm_custom01
event destroy ( )
boolean visible = false
integer x = 2203
integer y = 128
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores
f_activar_campo(uo_pais.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type uo_provincias from u_marca_lista within w_con_distribuidores_provincias
integer x = 974
integer y = 160
integer width = 1431
end type

on uo_provincias.destroy
call u_marca_lista::destroy
end on

type cb_consultar from u_boton within w_con_distribuidores_provincias
integer x = 2427
integer y = 160
integer width = 334
integer height = 96
integer taborder = 0
string text = "&Consultar"
end type

event clicked;call super::clicked;String montaje
dw_distribuidores.visible = TRUE
pb_2.visible = TRUE
Integer numero,registros,x1,y1
y1=0
filtro=""

numero = uo_provincias.dw_marca.RowCount()
IF numero =0 Then return

FOR x1 = 1 To numero
IF uo_provincias.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF y1=1 Then
    montaje = " provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
    montaje = " Or provincia = '" + uo_provincias.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtro = filtro + montaje
END IF
NEXT


uo_provincias.visible = FALSE
cb_consultar.visible  = FALSE
dw_subdistribuidores.visible= TRUE
uo_manejo.visible = TRUE
pb_3.visible = TRUE

dw_distribuidores.Setfilter("")
dw_distribuidores.filter()

dw_distribuidores.Setfilter(filtro)
dw_distribuidores.filter()
dw_distribuidores.retrieve(codigo_empresa,uo_pais.em_codigo.text)
f_activar_campo(uo_pais.em_campo)

end event

