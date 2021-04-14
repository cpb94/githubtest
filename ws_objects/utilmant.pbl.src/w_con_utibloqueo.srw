$PBExportHeader$w_con_utibloqueo.srw
forward
global type w_con_utibloqueo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_utibloqueo
end type
type dw_consulta from datawindow within w_con_utibloqueo
end type
type dw_listado from datawindow within w_con_utibloqueo
end type
type pb_2 from upb_imprimir within w_con_utibloqueo
end type
type cb_consultar from u_boton within w_con_utibloqueo
end type
type cb_borrar from u_boton within w_con_utibloqueo
end type
type cb_borrar_uno from u_boton within w_con_utibloqueo
end type
end forward

global type w_con_utibloqueo from w_int_con_empresa
integer width = 3497
integer height = 1724
pb_1 pb_1
dw_consulta dw_consulta
dw_listado dw_listado
pb_2 pb_2
cb_consultar cb_consultar
cb_borrar cb_borrar
cb_borrar_uno cb_borrar_uno
end type
global w_con_utibloqueo w_con_utibloqueo

type variables
string filtro
end variables

on open;call w_int_con_empresa::open;istr_parametros.s_titulo_ventana="Consulta bloqueos"
This.title=istr_parametros.s_titulo_ventana
dw_consulta.SetTransobject(SQLCA)
cb_consultar.TriggerEvent(Clicked!)


end on

on ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve()
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end on

on w_con_utibloqueo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_consulta=create dw_consulta
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.cb_consultar=create cb_consultar
this.cb_borrar=create cb_borrar
this.cb_borrar_uno=create cb_borrar_uno
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.cb_consultar
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.cb_borrar_uno
end on

on w_con_utibloqueo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_consulta)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.cb_consultar)
destroy(this.cb_borrar)
destroy(this.cb_borrar_uno)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_utibloqueo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_utibloqueo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_utibloqueo
integer x = 9
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_con_utibloqueo
integer x = 2702
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_consulta from datawindow within w_con_utibloqueo
integer x = 14
integer y = 284
integer width = 3415
integer height = 1108
boolean bringtotop = true
string dataobject = "dw_con_utibloqueo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return
selectrow(0,false)
selectrow(row,true)

end event

type dw_listado from datawindow within w_con_utibloqueo
boolean visible = false
integer x = 14
integer y = 124
integer width = 494
integer height = 152
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_utibloqueos"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_utibloqueo
integer x = 2363
integer y = 156
integer taborder = 50
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type cb_consultar from u_boton within w_con_utibloqueo
integer x = 32
integer y = 156
integer width = 777
integer height = 96
integer taborder = 20
string text = "&Consultar"
end type

on clicked;call u_boton::clicked;dw_consulta.Retrieve()
end on

type cb_borrar from u_boton within w_con_utibloqueo
integer x = 1586
integer y = 156
integer width = 777
integer height = 96
integer taborder = 40
string text = "&Borrar bloqueos"
end type

on clicked;call u_boton::clicked;
Integer opcion
opcion = messageBox("Proceso borrado de bloqueos","Desea Borrar los bloqueos?",Question!, YesNo!,2)
IF opcion=2 Then Return
If opcion=1 Then
 Delete from uti_bloqueo;
 COMMIT;
END IF
cb_consultar.TriggerEvent(clicked!)
end on

type cb_borrar_uno from u_boton within w_con_utibloqueo
event clicked pbm_bnclicked
integer x = 809
integer y = 156
integer width = 777
integer height = 96
integer taborder = 30
string text = "Borrar bloqueo selecionado"
end type

event clicked;call super::clicked;long linea_seleccionada
linea_seleccionada=dw_consulta.getselectedrow(0)
if linea_seleccionada<>0 then
	Integer opcion
	string u,b
	u=dw_consulta.getitemstring(linea_seleccionada,"usuario")
	b=dw_consulta.getitemstring(linea_seleccionada,"titulo")		
	opcion = messageBox("Proceso borrado de bloqueos",u+": "+b+char(13)+"Desea borrar este bloqueo?",Question!, YesNo!,2)
	IF opcion=2 Then Return
	If opcion=1 Then
		string t,c
		t=dw_consulta.getitemstring(linea_seleccionada,"tabla")
		c=dw_consulta.getitemstring(linea_seleccionada,"codigo")		
		Delete from uti_bloqueo
		where tabla=:t 
		and  codigo=:c;
		COMMIT;
	END IF
	cb_consultar.TriggerEvent(clicked!)
end if
end event

