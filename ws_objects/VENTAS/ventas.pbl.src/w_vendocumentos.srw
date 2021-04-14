$PBExportHeader$w_vendocumentos.srw
forward
global type w_vendocumentos from w_int_con_empresa
end type
type pb_salir from upb_salir within w_vendocumentos
end type
type cb_actualizar from u_boton within w_vendocumentos
end type
type rb_banco from radiobutton within w_vendocumentos
end type
type rb_cliente from radiobutton within w_vendocumentos
end type
type dw_detalle from u_datawindow_consultas within w_vendocumentos
end type
end forward

global type w_vendocumentos from w_int_con_empresa
integer width = 2587
integer height = 1316
pb_salir pb_salir
cb_actualizar cb_actualizar
rb_banco rb_banco
rb_cliente rb_cliente
dw_detalle dw_detalle
end type
global w_vendocumentos w_vendocumentos

type variables
String var_tipo
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_insertar ()
public subroutine f_borrar ()
end prototypes

public subroutine f_control ();dw_detalle.Retrieve(codigo_empresa,var_tipo)
dw_detalle.SetFocus()
end subroutine

public subroutine f_insertar ();dw_detalle.insertRow(dw_detalle.GetRow() +1)
dw_detalle.SetItem(dw_detalle.GetRow()+1,"empresa",codigo_empresa)
dw_detalle.SetItem(dw_detalle.GetRow()+1,"tipo",var_tipo)
dw_detalle.Setfocus()
dw_detalle.SetRow(dw_detalle.GetRow() +1)
dw_detalle.SetColumn("descripcion")
dw_detalle.ScrollToRow(dw_detalle.GetRow() +1)
end subroutine

public subroutine f_borrar ();IF dw_detalle.GetRow() = 0 Then Return
	dw_detalle.DeleteRow(dw_detalle.GetRow())
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Mapa documentos"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_detalle.SetRowFocusIndicator(Hand!)
rb_cliente.checked = False
rb_banco.checked =true
var_tipo= "1"
f_control()




end event

on w_vendocumentos.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.cb_actualizar=create cb_actualizar
this.rb_banco=create rb_banco
this.rb_cliente=create rb_cliente
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.cb_actualizar
this.Control[iCurrent+3]=this.rb_banco
this.Control[iCurrent+4]=this.rb_cliente
this.Control[iCurrent+5]=this.dw_detalle
end on

on w_vendocumentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.cb_actualizar)
destroy(this.rb_banco)
destroy(this.rb_cliente)
destroy(this.dw_detalle)
end on

event ue_f2;call super::ue_f2;f_insertar()
end event

event ue_f3;call super::ue_f3;f_borrar()
end event

event ue_f5;call super::ue_f5;cb_actualizar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_vendocumentos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_vendocumentos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_vendocumentos
integer x = 27
integer y = 8
integer width = 2382
end type

type pb_salir from upb_salir within w_vendocumentos
integer x = 2423
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_actualizar from u_boton within w_vendocumentos
integer x = 1979
integer y = 132
integer height = 92
integer taborder = 0
string text = "F5 Actualizar"
end type

event clicked;call super::clicked;Integer registro,registros
registros = dw_detalle.RowCount()
 For registro = 1 To registros
	dw_detalle.SetItem(registro,"orden",registro)
 Next


dw_detalle.Update()
COMMIT;
end event

type rb_banco from radiobutton within w_vendocumentos
integer x = 165
integer y = 140
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Banco"
boolean lefttext = true
end type

event clicked;var_tipo = "1"
This.checked = false
rb_banco.checked = true
f_control()
end event

type rb_cliente from radiobutton within w_vendocumentos
integer x = 571
integer y = 140
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Cliente"
boolean lefttext = true
end type

event clicked;var_tipo = "2"
This.checked = True
rb_banco.checked = False
f_control()
end event

type dw_detalle from u_datawindow_consultas within w_vendocumentos
integer y = 252
integer width = 2469
integer height = 472
integer taborder = 10
string dataobject = "dw_vendocumentos"
end type

event clicked;call super::clicked;
IF f_objeto_datawindow(This) = "insertar" Then
	f_insertar()

	
END IF
IF f_objeto_datawindow(This) = "borrar" Then
	f_borrar()
END IF
end event

event key;call super::key;IF  Key = KeyF2! Then w_vendocumentos.TriggerEvent("ue_f2")
IF  Key = KeyF3! Then w_vendocumentos.TriggerEvent("ue_f3")
end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
end event

