$PBExportHeader$wi_mant_almendamados.srw
forward
global type wi_mant_almendamados from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_almendamados
end type
type dw_detalle from datawindow within wi_mant_almendamados
end type
type uo_articulo from u_em_campo_2 within wi_mant_almendamados
end type
type st_3 from statictext within wi_mant_almendamados
end type
type cb_grabar_detalle from u_boton within wi_mant_almendamados
end type
type cb_borrar_detalle from u_boton within wi_mant_almendamados
end type
end forward

global type wi_mant_almendamados from wi_mvent_con_empresa
integer width = 2569
integer height = 1648
pb_calculadora pb_calculadora
dw_detalle dw_detalle
uo_articulo uo_articulo
st_3 st_3
cb_grabar_detalle cb_grabar_detalle
cb_borrar_detalle cb_borrar_detalle
end type
global wi_mant_almendamados wi_mant_almendamados

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Endamados"
	istr_parametros.s_listado         = "report_almendamados"
   This.title = istr_parametros.s_titulo_ventana
   dw_detalle.SetTransObject(SQLCA)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

f_activar_campo(sle_valor)	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"tono","S")
 dw_1.setitem(dw_1.getrow(),"calibre","S")
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "almendamados"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on wi_mant_almendamados.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_detalle=create dw_detalle
this.uo_articulo=create uo_articulo
this.st_3=create st_3
this.cb_grabar_detalle=create cb_grabar_detalle
this.cb_borrar_detalle=create cb_borrar_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_grabar_detalle
this.Control[iCurrent+6]=this.cb_borrar_detalle
end on

on wi_mant_almendamados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_detalle)
destroy(this.uo_articulo)
destroy(this.st_3)
destroy(this.cb_grabar_detalle)
destroy(this.cb_borrar_detalle)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_borra_fila;call super::ue_borra_fila;String codigo
codigo = sle_valor.text

Delete from almendamadosdetalle
Where  empresa = :codigo_empresa
And    codigo  = :codigo;
COMMIT;
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almendamados
integer y = 288
integer width = 1874
integer height = 368
string dataobject = "dw_almendamados"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almendamados
integer x = 306
integer y = 180
integer width = 251
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almendamados
integer x = 2034
integer y = 292
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almendamados
integer x = 2034
integer y = 404
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almendamados
integer x = 567
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_almendamados"
ue_titulo      = "AYUDA SELECCION DE ENDAMADOS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almendamados
integer x = 2034
integer y = 516
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almendamados
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almendamados
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almendamados
integer width = 2249
end type

type pb_calculadora from u_calculadora within wi_mant_almendamados
integer x = 832
integer y = 172
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   almendamados
 Where  almendamados.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,almendamados.codigo)+1)
  Into   :sle_valor.text
  From   almendamados
  Where  almendamados.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type dw_detalle from datawindow within wi_mant_almendamados
integer x = 73
integer y = 656
integer width = 1874
integer height = 568
boolean bringtotop = true
string dataobject = "dw_almendamados2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if row=0 then return

uo_articulo.em_campo.text  = dw_detalle.GetItemString(row,"descripcion")
uo_articulo.em_codigo.text = dw_detalle.GetItemString(row,"articulo")

uo_articulo.ue_valor_anterior = uo_articulo.em_campo.text

f_activar_campo(uo_articulo.em_campo)
end event

type uo_articulo from u_em_campo_2 within wi_mant_almendamados
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 73
integer y = 1324
integer width = 1143
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_almendamados
integer x = 73
integer y = 1244
integer width = 1147
integer height = 76
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_grabar_detalle from u_boton within wi_mant_almendamados
integer x = 1289
integer y = 1264
integer width = 329
integer height = 76
integer taborder = 0
string text = "&Grabar"
end type

event clicked;call super::clicked;String   endamado,articulo
Integer  numero

endamado = sle_valor.text
articulo = uo_articulo.em_codigo.text
IF Trim(articulo) = "" Then
	f_activar_campo(uo_articulo.em_campo)
	f_mensaje("Campo Obligatorio","Introduzca el articulo")
	Return
END IF

Select Count(*) Into :numero From almendamadosdetalle
Where  almendamadosdetalle.empresa = :codigo_empresa
And    almendamadosdetalle.codigo  = :endamado
And    almendamadosdetalle.articulo= :articulo;
iF IsNull(numero) Then numero = 0
IF numero = 0 Then
  INSERT INTO almendamadosdetalle 
         (empresa,codigo,articulo)  
  VALUES (:codigo_empresa,:endamado,:articulo);
END IF
COMMIT;
dw_detalle.Retrieve(codigo_empresa,endamado)
f_activar_campo(uo_articulo.em_campo)
end event

type cb_borrar_detalle from u_boton within wi_mant_almendamados
integer x = 1289
integer y = 1340
integer width = 329
integer height = 76
integer taborder = 0
boolean bringtotop = true
string text = "B&orrar"
end type

event clicked;call super::clicked;String   endamado,articulo
Integer  numero

endamado = sle_valor.text
articulo = uo_articulo.em_codigo.text

Delete From almendamadosdetalle
Where  almendamadosdetalle.empresa = :codigo_empresa
And    almendamadosdetalle.codigo  = :endamado
And    almendamadosdetalle.articulo= :articulo;
COMMIT;
dw_detalle.Retrieve(codigo_empresa,endamado)

uo_articulo.em_campo.text  = ""
uo_articulo.em_codigo.text = ""

f_activar_campo(uo_articulo.em_campo)
end event

