$PBExportHeader$wi_mant_venartcli.srw
$PBExportComments$Mant. Articulos por clientes.
forward
global type wi_mant_venartcli from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_venartcli
end type
type st_nombre_calidad from statictext within wi_mant_venartcli
end type
type st_cliente from statictext within wi_mant_venartcli
end type
type sle_cliente from u_em_campo within wi_mant_venartcli
end type
type st_nombre_cliente from statictext within wi_mant_venartcli
end type
type uo_articulo from u_em_campo_2 within wi_mant_venartcli
end type
type dw_calidades from datawindow within wi_mant_venartcli
end type
end forward

global type wi_mant_venartcli from wi_mvent_con_empresa
integer width = 2354
integer height = 1596
st_almacen st_almacen
st_nombre_calidad st_nombre_calidad
st_cliente st_cliente
sle_cliente sle_cliente
st_nombre_cliente st_nombre_cliente
uo_articulo uo_articulo
dw_calidades dw_calidades
end type
global wi_mant_venartcli wi_mant_venartcli

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();IF Trim(sle_cliente.text)= "" or Trim(uo_articulo.em_codigo.text) = "" or &
Trim(sle_valor.Text)=""  THEN
  dw_1.Reset()
ELSE
  dw_1.Retrieve(codigo_empresa,sle_cliente.text,uo_articulo.em_codigo.text,sle_valor.Text)
END IF

end subroutine

on ue_actualiza_dw;call wi_mvent_con_empresa::ue_actualiza_dw;dw_calidades.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(sle_cliente.text))
criterio[2]   =  trim(sle_cliente.text)+space(20-longitud)

longitud      =  len(trim(uo_articulo.em_codigo.text))
criterio[3]   =  trim(uo_articulo.em_codigo.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[4]   =  trim(sle_valor.text)+space(20-longitud)

seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
tabla         =  "venartcli"


dw_1.Retrieve(codigo_empresa,sle_cliente.text,uo_articulo.em_codigo.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de articulos/clientes"
istr_parametros.s_listado        = "report_venartcli"
This.title=istr_parametros.s_titulo_ventana
dw_calidades.SetTransObject(SQLCA)

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",uo_articulo.em_codigo.text)
dw_1.setitem(dw_1.getrow(),"calidad",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"cliente",sle_cliente.text)
dw_1.setitem(dw_1.getrow(),"montajeart",f_componer_artcal(uo_articulo.em_codigo.text,sle_valor.text))
dw_1.setitem(dw_1.getrow(),"f_alta",DateTime(today(),now()))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"familia",f_familia_articulo(codigo_empresa,uo_articulo.em_codigo.text))
dw_1.setitem(dw_1.getrow(),"formato",f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))


end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;uo_articulo.enabled=FALSE
sle_cliente.enabled=FALSE
end on

on wi_mant_venartcli.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_calidad=create st_nombre_calidad
this.st_cliente=create st_cliente
this.sle_cliente=create sle_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.uo_articulo=create uo_articulo
this.dw_calidades=create dw_calidades
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_calidad
this.Control[iCurrent+3]=this.st_cliente
this.Control[iCurrent+4]=this.sle_cliente
this.Control[iCurrent+5]=this.st_nombre_cliente
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.dw_calidades
end on

on wi_mant_venartcli.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_calidad)
destroy(this.st_cliente)
destroy(this.sle_cliente)
destroy(this.st_nombre_cliente)
destroy(this.uo_articulo)
destroy(this.dw_calidades)
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;uo_articulo.enabled=TRUE
sle_cliente.enabled=TRUE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venartcli
integer x = 59
integer y = 492
integer width = 1765
integer height = 400
string dataobject = "dw_venartcli"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venartcli
integer x = 256
integer y = 380
integer width = 256
integer height = 80
string text = "Calidad:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venartcli
integer x = 1861
integer y = 500
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venartcli
integer x = 1861
integer y = 628
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venartcli
integer x = 562
integer y = 364
integer width = 219
integer taborder = 30
end type

on sle_valor::getfocus;ue_titulo       	= "AYUDA SELECCION DE CALIDADES "
ue_datawindow   	= "dw_ayuda_calidades"
ue_filtro 		   = "" 
isle_campo        = This
ue_campo          = This

IF trim(uo_articulo.em_codigo.text)= "" THEN f_activar_campo(uo_articulo.em_campo)
IF trim(sle_valor.text)  = "" THEN f_control()

end on

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venartcli
integer x = 1861
integer y = 756
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venartcli
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venartcli
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venartcli
end type

type st_almacen from statictext within wi_mant_venartcli
integer x = 247
integer y = 272
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_calidad from statictext within wi_mant_venartcli
integer x = 814
integer y = 376
integer width = 631
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_cliente from statictext within wi_mant_venartcli
integer x = 247
integer y = 164
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_cliente from u_em_campo within wi_mant_venartcli
integer x = 562
integer y = 156
integer width = 357
integer taborder = 10
end type

event modificado;call super::modificado;st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
dw_calidades.Retrieve(codigo_empresa,sle_cliente.text)
IF Trim(st_nombre_cliente.text)="" THEN 
 IF Trim(sle_cliente.text)<>"" Then  f_activar_campo(sle_cliente)
 sle_cliente.text=""
END IF

end event

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE CLIENTES"
 ue_datawindow = "dw_ayuda_clientes"
 ue_filtro     = "" 	
 isle_campo    = This
 sle_valor.text = ""
 f_control()
         
 IF istr_parametros.i_nargumentos>1 THEN
     sle_cliente.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_cliente)
     sle_cliente.TriggerEvent("modificado")
	  uo_articulo.em_codigo.text=istr_parametros.s_argumentos[3]	
     f_no_nulo(uo_articulo.em_codigo)
     uo_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[4]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
     IF Trim(sle_valor.text)<>"" and Trim(uo_articulo.em_codigo.text)<>"" and Trim(sle_cliente.text)<>""THEN
          f_activar_campo(sle_valor)
          Parent.TriggerEvent("ue_recuperar")
	  END IF
 END IF







end event

type st_nombre_cliente from statictext within wi_mant_venartcli
integer x = 946
integer y = 164
integer width = 1298
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within wi_mant_venartcli
integer x = 562
integer y = 260
integer width = 622
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
     uo_articulo.em_campo.SetFocus()
 end if
 uo_articulo.em_campo.text  =""
 uo_articulo.em_codigo.text =""
END IF

 // Selecciono abreviado del la unidad del articulo
  string  codigo_articulo,texto_unidad,cod_familia
  codigo_articulo=uo_articulo.em_codigo.text


end on

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
sle_valor.text = ""

end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type dw_calidades from datawindow within wi_mant_venartcli
event clicked pbm_dwnlbuttonclk
integer x = 105
integer y = 892
integer width = 1678
integer height = 456
boolean bringtotop = true
string dataobject = "dw_venartcli1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

uo_articulo.em_codigo.text = This.GetItemString(Row,"venartcli_articulo")
uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
sle_valor.text  = This.GetItemString(Row,"venartcli_calidad")
st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
wi_mant_venartcli.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

