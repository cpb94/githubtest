$PBExportHeader$w_con_reservas_articulos.srw
forward
global type w_con_reservas_articulos from w_int_con_empresa
end type
type st_3 from statictext within w_con_reservas_articulos
end type
type pb_2 from upb_salir within w_con_reservas_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_reservas_articulos
end type
type dw_1 from u_datawindow_consultas within w_con_reservas_articulos
end type
type pb_1 from upb_imprimir within w_con_reservas_articulos
end type
type dw_listado from datawindow within w_con_reservas_articulos
end type
type uo_1 from u_manejo_datawindow within w_con_reservas_articulos
end type
type st_formato from statictext within w_con_reservas_articulos
end type
end forward

global type w_con_reservas_articulos from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 2939
integer height = 1700
string title = "Consulta reservas por articulos"
st_3 st_3
pb_2 pb_2
uo_articulo uo_articulo
dw_1 dw_1
pb_1 pb_1
dw_listado dw_listado
uo_1 uo_1
st_formato st_formato
end type
global w_con_reservas_articulos w_con_reservas_articulos

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string is_filtro="",tono
String referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad
dec{2}  existencias,disponible,preparado,reservado
Integer calibre

dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text )
IF dw_1.RowCount() = 0 Then  Return

IF Trim(var_calidad) <> "" Then
   IF Trim(is_filtro)<>"" Then 
      is_filtro =  is_filtro + " and "
   END IF
   is_filtro=is_filtro + "calidad = '" + var_calidad + "'"
END IF
IF Trim(var_tipo_pallet) <> "" Then
    IF Trim(is_filtro)<> ""  Then
       is_filtro =  is_filtro + " and "
    END IF
    is_filtro= is_filtro + "tipo_pallet = '" + var_tipo_pallet + "'"
END IF
IF Trim(var_caja) <> "" Then
    IF Trim(is_filtro)<> ""  Then
       is_filtro =  is_filtro + " and "
    END IF
    is_filtro= is_filtro + "caja = '" + var_caja + "'"
END IF
IF Not IsNull(var_tono) and var_tono <>"" Then
    IF Trim(is_filtro) <> ""  Then 
       is_filtro =  is_filtro + " and "
    END IF
    is_filtro=is_filtro + "tonochar = '" + Trim(var_tono)+"'"
END IF
IF Not IsNull(var_calibre) and var_calibre <>0 Then
    IF Trim(is_filtro) <> ""  Then
        is_filtro =  is_filtro + " and "
    END IF
    is_filtro=is_filtro + "calibre = " + String(var_calibre)
END IF
dw_1.SetFilter(is_filtro)
dw_1.Filter()
dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)


end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
devolver = "N"
This.title = "Consulta reservas por articulos"
istr_parametros = Message.PowerObjectParm

IF istr_parametros.i_nargumentos>1 THEN
   f_posicion_inicio(This)
	devolver = "S"
   uo_articulo.em_codigo.text =   istr_parametros.s_argumentos[2]
   uo_articulo.em_campo.text  =   f_nombre_articulo(codigo_empresa,   uo_articulo.em_codigo.text)
   var_calidad                =   istr_parametros.s_argumentos[3]
   var_tono                   =   Trim(istr_parametros.s_argumentos[4])
   var_calibre                =   Integer(istr_parametros.s_argumentos[5])
   var_tipo_pallet            =   istr_parametros.s_argumentos[6]
   var_caja                   =   istr_parametros.s_argumentos[7]	
	uo_articulo.enabled        =   FALSE
   uo_articulo.TabOrder       =   0 

   f_control()
   
   IF dw_1.RowCount() =0 Then
      IF dw_1.RowCount() =0 Then
       MessageBox("Articulo sin reservas","No Hay lineas reservadas",Exclamation!, OK!,1)   
       CloseWithReturn(This,-1)
		 Return
      END IF
   END IF
   
   dw_1.Setfocus()
   Return
  END IF
  f_activar_campo(uo_articulo.em_campo)
end event

on w_con_reservas_articulos.create
int iCurrent
call super::create
this.st_3=create st_3
this.pb_2=create pb_2
this.uo_articulo=create uo_articulo
this.dw_1=create dw_1
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.uo_1=create uo_1
this.st_formato=create st_formato
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.st_formato
end on

on w_con_reservas_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.uo_articulo)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.uo_1)
destroy(this.st_formato)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.triggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.triggerEvent("linea_arriba")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.triggerEvent("pagina_arriba")

end event

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
CALL Super::ue_listar
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.triggerEvent("pagina_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_reservas_articulos
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_reservas_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_reservas_articulos
integer y = 20
integer width = 2587
end type

type st_3 from statictext within w_con_reservas_articulos
integer x = 64
integer y = 184
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_reservas_articulos
integer x = 2697
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type uo_articulo from u_em_campo_2 within w_con_reservas_articulos
integer x = 320
integer y = 168
integer width = 1179
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
st_formato.text = f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
IF uo_articulo.em_codigo.text <> ante_articulo Then
   f_control()
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""
ante_articulo = uo_articulo.em_codigo.text
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type dw_1 from u_datawindow_consultas within w_con_reservas_articulos
integer x = 18
integer y = 296
integer width = 2848
integer height = 1164
integer taborder = 50
string dataobject = "dw_con_reservas_articulos2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long  ll_fila_actual
str_parametros valores
ll_fila_actual = row
IF ll_fila_actual <> 0  and devolver = "S" THEN
   valores.s_argumentos[1]=uo_articulo.em_codigo.text
	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"calidad")
	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
	CloseWithReturn(Parent,valores)
END IF
end event

on tecla_enter;call u_datawindow_consultas::tecla_enter;long  ll_fila_actual
str_parametros valores
ll_fila_actual = dw_1.GetRow()
IF ll_fila_actual <> 0  and devolver = "S" THEN
   valores.s_argumentos[1]=uo_articulo.em_codigo.text
	valores.s_argumentos[2]=dw_1.getitemString(ll_fila_actual,"calidad")
	valores.s_argumentos[3]=string(dw_1.getitemNumber(ll_fila_actual,"tono"))
	valores.s_argumentos[4]=string(dw_1.getitemNumber(ll_fila_actual,"calibre"))
	valores.s_argumentos[5]=dw_1.getitemString(ll_fila_actual,"tipo_pallet")
	CloseWithReturn(Parent,valores)
END IF
end on

type pb_1 from upb_imprimir within w_con_reservas_articulos
integer x = 2734
integer y = 188
integer width = 96
integer height = 84
integer taborder = 20
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;Parent.TriggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_con_reservas_articulos
boolean visible = false
integer x = 37
integer y = 4
integer width = 494
integer height = 236
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_con_reservas_articulo"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_reservas_articulos
integer x = 2254
integer y = 140
end type

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data=dw_1

end event

type st_formato from statictext within w_con_reservas_articulos
integer x = 1518
integer y = 168
integer width = 411
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

