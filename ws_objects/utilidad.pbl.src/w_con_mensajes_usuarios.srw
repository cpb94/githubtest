$PBExportHeader$w_con_mensajes_usuarios.srw
forward
global type w_con_mensajes_usuarios from w_int_con_empresa
end type
type pb_salir from upb_salir within w_con_mensajes_usuarios
end type
type dw_mensajes from datawindow within w_con_mensajes_usuarios
end type
end forward

global type w_con_mensajes_usuarios from w_int_con_empresa
integer width = 2912
integer height = 1680
pb_salir pb_salir
dw_mensajes dw_mensajes
end type
global w_con_mensajes_usuarios w_con_mensajes_usuarios

type variables

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Aviso Mensajes"
This.title=istr_parametros.s_titulo_ventana
dw_mensajes.SetTransObject(sqlca)
dw_mensajes.Retrieve(codigo_empresa,nombre_usuario) 
BEEP(5)
end event

on w_con_mensajes_usuarios.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.dw_mensajes=create dw_mensajes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.dw_mensajes
end on

on w_con_mensajes_usuarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.dw_mensajes)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_mensajes_usuarios
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_mensajes_usuarios
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_mensajes_usuarios
integer x = 27
integer y = 8
integer width = 2606
end type

type pb_salir from upb_salir within w_con_mensajes_usuarios
boolean visible = false
integer x = 2779
integer y = 8
integer width = 114
integer height = 104
integer taborder = 0
end type

type dw_mensajes from datawindow within w_con_mensajes_usuarios
integer y = 136
integer width = 2885
integer height = 1352
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_con_mensajes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF f_objeto_datawindow(This) = "borrar" Then
	IF GetRow() <> 0 Then 
		DeleteRow(GetRow())
		Update()
		COMMIT;
		Accepttext()
		IF RowCount() = 0 Then pb_salir.TriggerEvent(Clicked!)
		control_mensajes= "S"
	END IF
END IF
end event

