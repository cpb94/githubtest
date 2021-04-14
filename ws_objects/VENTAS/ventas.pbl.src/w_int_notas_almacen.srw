$PBExportHeader$w_int_notas_almacen.srw
forward
global type w_int_notas_almacen from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_notas_almacen
end type
type st_1 from statictext within w_int_notas_almacen
end type
type st_2 from statictext within w_int_notas_almacen
end type
type st_3 from statictext within w_int_notas_almacen
end type
type em_asunto from u_em_campo within w_int_notas_almacen
end type
type cb_imprimir from u_boton within w_int_notas_almacen
end type
type cb_consulta from u_boton within w_int_notas_almacen
end type
type notas from multilineedit within w_int_notas_almacen
end type
type cb_nuevo from u_boton within w_int_notas_almacen
end type
type cb_grabar from u_boton within w_int_notas_almacen
end type
type gb_1 from groupbox within w_int_notas_almacen
end type
type dw_listado from datawindow within w_int_notas_almacen
end type
type uo_destino from u_em_campo_2 within w_int_notas_almacen
end type
type st_4 from statictext within w_int_notas_almacen
end type
type em_fecha from u_em_campo within w_int_notas_almacen
end type
type dw_consulta from datawindow within w_int_notas_almacen
end type
end forward

global type w_int_notas_almacen from w_int_con_empresa
integer width = 2907
integer height = 1632
pb_1 pb_1
st_1 st_1
st_2 st_2
st_3 st_3
em_asunto em_asunto
cb_imprimir cb_imprimir
cb_consulta cb_consulta
notas notas
cb_nuevo cb_nuevo
cb_grabar cb_grabar
gb_1 gb_1
dw_listado dw_listado
uo_destino uo_destino
st_4 st_4
em_fecha em_fecha
dw_consulta dw_consulta
end type
global w_int_notas_almacen w_int_notas_almacen

type variables
String  modo,var_listado
Dec var_orden
String acceso
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_recuperar (integer elemento)
end prototypes

public subroutine f_control ();IF modo = "I" Then
	var_listado         = "N"
	em_asunto.enabled   = TRUE
	uo_destino.em_campo.enabled = TRUE
	notas.enabled       = TRUE
	cb_grabar.enabled   = TRUE
	cb_imprimir.enabled = FALSE
ELSE
	em_asunto.enabled           = FALSE
	uo_destino.em_campo.enabled = FALSE
	notas.enabled               = FALSE
	cb_grabar.enabled           = FALSE
	IF var_listado = "S" Then
		IF acceso = "1" Then
			cb_imprimir.enabled   = True
		ELSE
			cb_imprimir.enabled   = False
		END IF
	ELSE
		cb_imprimir.enabled      = TRUE
	END IF
END IF
end subroutine

public subroutine f_recuperar (integer elemento);IF elemento <> 0 Then
	em_asunto.text  = dw_consulta.GetItemString(elemento,"asunto")
	uo_destino.em_campo.text = dw_consulta.GetItemString(elemento,"destino")
	uo_destino.em_codigo.text = dw_consulta.GetItemString(elemento,"destino")
	notas.text    = dw_consulta.GetItemString(elemento,"observaciones")
	var_orden     = dw_consulta.GetItemNumber(elemento,"orden")
	var_listado   = dw_consulta.GetItemString(elemento,"listado")
	em_fecha.text = string(dw_consulta.GetItemdatetime(elemento,"falta"))
END IF
dw_consulta.visible = FALSE
dw_consulta.Reset()
modo = "X"
f_control()
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Notas Almacen"
This.title=istr_parametros.s_titulo_ventana
modo = "I"
f_control()
dw_consulta.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
acceso = f_control_acceso(nombre_usuario)
f_activar_campo(uo_destino.em_campo)
end event

on w_int_notas_almacen.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_asunto=create em_asunto
this.cb_imprimir=create cb_imprimir
this.cb_consulta=create cb_consulta
this.notas=create notas
this.cb_nuevo=create cb_nuevo
this.cb_grabar=create cb_grabar
this.gb_1=create gb_1
this.dw_listado=create dw_listado
this.uo_destino=create uo_destino
this.st_4=create st_4
this.em_fecha=create em_fecha
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.em_asunto
this.Control[iCurrent+6]=this.cb_imprimir
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.notas
this.Control[iCurrent+9]=this.cb_nuevo
this.Control[iCurrent+10]=this.cb_grabar
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.uo_destino
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.em_fecha
this.Control[iCurrent+16]=this.dw_consulta
end on

on w_int_notas_almacen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_asunto)
destroy(this.cb_imprimir)
destroy(this.cb_consulta)
destroy(this.notas)
destroy(this.cb_nuevo)
destroy(this.cb_grabar)
destroy(this.gb_1)
destroy(this.dw_listado)
destroy(this.uo_destino)
destroy(this.st_4)
destroy(this.em_fecha)
destroy(this.dw_consulta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_notas_almacen
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_notas_almacen
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_notas_almacen
integer x = 27
integer y = 8
integer width = 2606
end type

type pb_1 from upb_salir within w_int_notas_almacen
integer x = 2706
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_1 from statictext within w_int_notas_almacen
integer y = 220
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "A la Atención:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_notas_almacen
integer x = 14
integer y = 308
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Asunto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_notas_almacen
integer x = 14
integer y = 396
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Nota:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_asunto from u_em_campo within w_int_notas_almacen
integer x = 430
integer y = 300
integer width = 2327
integer taborder = 20
boolean bringtotop = true
end type

type cb_imprimir from u_boton within w_int_notas_almacen
event clicked pbm_bnclicked
integer x = 1102
integer y = 1236
integer width = 517
integer height = 68
integer taborder = 0
string text = "&Imprimir"
end type

event clicked;call super::clicked;DateTime fecha 

fecha = DateTime(Today())
dw_listado.retrieve(codigo_empresa,var_orden)
IF f_imprimir_datawindow(dw_listado) Then
	var_listado = "S"
	Update vennotasalmacen Set flistado = :fecha,
	                           listado = "S"
   Where empresa = :codigo_empresa
	And   orden   = :var_orden;
	COMMIT;
	f_control()
END IF
end event

type cb_consulta from u_boton within w_int_notas_almacen
event clicked pbm_bnclicked
integer x = 581
integer y = 1236
integer width = 517
integer height = 68
integer taborder = 0
string text = "&Consultar"
end type

event clicked;call super::clicked;dw_consulta.Retrieve(codigo_empresa,nombre_usuario)
dw_consulta.visible = TRUE

end event

type notas from multilineedit within w_int_notas_almacen
integer x = 430
integer y = 384
integer width = 2327
integer height = 812
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_nuevo from u_boton within w_int_notas_almacen
integer x = 1623
integer y = 1236
integer width = 517
integer height = 68
integer taborder = 0
string text = "&Nuevo Mensaje"
end type

event clicked;call super::clicked;em_asunto.text = ""
uo_destino.em_campo.text = ""
uo_destino.em_codigo.text = ""
notas.text = ""
em_fecha.text = ""
modo = "I"
f_control()
f_activar_campo(uo_destino.em_campo)
end event

type cb_grabar from u_boton within w_int_notas_almacen
event clicked pbm_bnclicked
integer x = 2144
integer y = 1236
integer width = 512
integer height = 68
integer taborder = 0
string text = "&Grabar Mensaje"
end type

event clicked;call super::clicked;Dec     orden
DateTime falta,flistado
String   lista,destino,asunto,nota

falta    = Datetime(Today(),Now())
em_fecha.text = string(datetime(falta))
SetNull(flistado)
lista  = "N"

destino = uo_destino.em_codigo.text 
asunto  = em_asunto.text
nota    = notas.text

IF Trim(destino) = "" Then
	f_mensaje("Error en Introduccionde datos","Introduzca el destino")
	f_activar_campo(uo_destino.em_campo)
	Return
END IF
IF Trim(asunto) = "" Then
	f_mensaje("Error en Introduccionde datos","Introduzca el asunto")
	f_activar_campo(em_asunto)
	Return
END IF
IF Trim(nota) = "" Then
	f_mensaje("Error en Introduccionde datos","Introduzca la nota")
	notas.SetFocus()
	Return
END IF

if modo = "I" then
		Select Max(vennotasalmacen.orden) Into :orden From vennotasalmacen
		Where  vennotasalmacen.empresa = :codigo_empresa;
		IF IsNull(orden) Then orden = 0
		orden = orden + 1
		INSERT INTO vennotasalmacen  
				(empresa,orden,usuario,falta,destino,asunto,observaciones,
				 flistado,listado)  
		VALUES(:codigo_empresa,:orden,:nombre_usuario,:falta,:destino,:asunto,
				 :nota,:flistado,:listado);
		COMMIT;
	else
		
		UPDATE vennotasalmacen  
      SET observaciones = :nota
      WHERE ( vennotasalmacen.empresa = :codigo_empresa ) AND  
            ( vennotasalmacen.orden   = :var_orden )   ;
	   COMMIT;
	End if

var_orden = orden
f_activar_campo(uo_destino.em_campo)
modo = "X"
f_control()
end event

type gb_1 from groupbox within w_int_notas_almacen
integer x = 571
integer y = 1204
integer width = 2094
integer height = 108
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_listado from datawindow within w_int_notas_almacen
boolean visible = false
integer x = 18
integer y = 124
integer width = 494
integer height = 52
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_notas_almacen1"
boolean livescroll = true
end type

type uo_destino from u_em_campo_2 within w_int_notas_almacen
integer x = 430
integer y = 212
integer width = 1307
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;String des
des = f_nombre_usuario(uo_destino.em_codigo.text)
IF Trim(des) <> "" Then uo_destino.em_campo.text= des

//IF Trim(uo_destino.em_campo.text)="" THEN 
// IF Trim(uo_destino.em_codigo.text)<>"" Then uo_destino.em_campo.SetFocus()
// uo_destino.em_campo.text=""
// uo_destino.em_codigo.text=""
//END IF
end event

event getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo     = "Ayuda seleccion de usuarios"
ue_datawindow = "dw_ayuda_usuarios"
ue_filtro     = ""
end event

on uo_destino.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_notas_almacen
integer x = 1829
integer y = 212
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_notas_almacen
integer x = 2043
integer y = 208
integer width = 713
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy    hh:mm:ss"
string displaydata = ""
end type

type dw_consulta from datawindow within w_int_notas_almacen
boolean visible = false
integer y = 204
integer width = 2811
integer height = 1212
integer taborder = 60
string dataobject = "dw_notas_almacen"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;f_recuperar(row)
end event

