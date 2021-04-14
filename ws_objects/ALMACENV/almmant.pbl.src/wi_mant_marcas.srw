$PBExportHeader$wi_mant_marcas.srw
forward
global type wi_mant_marcas from wi_mvent_con_empresa
end type
type st_familia from statictext within wi_mant_marcas
end type
type st_nombre_familia from statictext within wi_mant_marcas
end type
type sle_familia from u_em_campo within wi_mant_marcas
end type
type st_marcas_descripcion from statictext within wi_mant_marcas
end type
type dw_marcas_familia from datawindow within wi_mant_marcas
end type
type pb_calculadora from u_calculadora within wi_mant_marcas
end type
end forward

global type wi_mant_marcas from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2373
integer height = 1596
st_familia st_familia
st_nombre_familia st_nombre_familia
sle_familia sle_familia
st_marcas_descripcion st_marcas_descripcion
dw_marcas_familia dw_marcas_familia
pb_calculadora pb_calculadora
end type
global wi_mant_marcas wi_mant_marcas

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_familia.text,sle_valor.text)

dw_marcas_familia.Retrieve(codigo_empresa,sle_familia.text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Marcas"
istr_parametros.s_listado        = "report_marcas"
This.title=istr_parametros.s_titulo_ventana
dw_marcas_familia.SetTransObject(SQLCA)

f_activar_campo(sle_familia)

//  IF istr_parametros.i_nargumentos>1 THEN
// 	  sle_familia.text=istr_parametros.s_argumentos[2]	
//     sle_familia.TriggerEvent("modificado")
//     sle_valor.text=istr_parametros.s_argumentos[3]
//     sle_valor.TriggerEvent("modificado")
//     istr_parametros.i_nargumentos=0
//	  IF Trim(sle_valor.text)<>"" and Trim(sle_familia.text)<>"" THEN
//          Parent.TriggerEvent("ue_recuperar")
//			 f_activar_campo(sle_marca)
//			 Return
//		else
//			 f_activar_campo(sle_marca)
//			 Return
//     END IF
//  END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.object.empresa[dw_1.getrow()] = codigo_empresa
dw_1.object.familias_codigo[dw_1.getrow()] = sle_familia.text
dw_1.object.codigo[dw_1.getrow()] = sle_valor.text
dw_1.object.descripcion[dw_1.getrow()] = ''
dw_1.object.descripcion_abr[dw_1.getrow()] = ''

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_familia.text))
criterio[2]   =  trim(sle_familia.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "marcas"

f_control()
CALL Super::ue_recuperar
end event

on wi_mant_marcas.create
int iCurrent
call super::create
this.st_familia=create st_familia
this.st_nombre_familia=create st_nombre_familia
this.sle_familia=create sle_familia
this.st_marcas_descripcion=create st_marcas_descripcion
this.dw_marcas_familia=create dw_marcas_familia
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_familia
this.Control[iCurrent+2]=this.st_nombre_familia
this.Control[iCurrent+3]=this.sle_familia
this.Control[iCurrent+4]=this.st_marcas_descripcion
this.Control[iCurrent+5]=this.dw_marcas_familia
this.Control[iCurrent+6]=this.pb_calculadora
end on

on wi_mant_marcas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_familia)
destroy(this.st_nombre_familia)
destroy(this.sle_familia)
destroy(this.st_marcas_descripcion)
destroy(this.dw_marcas_familia)
destroy(this.pb_calculadora)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_familia.enabled=FALSE
sle_valor.enabled=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;sle_familia.enabled=TRUE
sle_valor.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_marcas
integer x = 27
integer y = 468
integer width = 2304
integer height = 296
string dataobject = "dw_mant_marcas"
borderstyle borderstyle = stylelowered!
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_marcas
integer x = 46
integer y = 348
integer width = 297
integer height = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string text = "Marca:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_marcas
integer x = 1979
integer y = 164
integer width = 352
end type

event cb_insertar::clicked;call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_marcas
integer x = 1984
integer y = 268
integer width = 352
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_marcas
integer x = 352
integer y = 348
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event sle_valor::modificado;call super::modificado;st_marcas_descripcion.text=f_marcas_descripcion(codigo_empresa,sle_familia.text,sle_valor.text)
IF Trim(st_marcas_descripcion.text)="" THEN 
// IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
// sle_valor.text=""
 dw_1.TriggerEvent("Clicked")
END IF
//f_control()
end event

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE MARCAS"
ue_datawindow = "dw_ayuda_marcas"
ue_filtro     = "familias_codigo = '"+sle_familia.text+"'"
isle_campo    = This

IF trim(sle_familia.text)= "" THEN
	f_activar_campo(sle_familia)
	Return	 
End if	

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_marcas
integer x = 1984
integer y = 368
integer width = 352
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_marcas
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_marcas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_marcas
integer x = 9
integer width = 2313
end type

type st_familia from statictext within wi_mant_marcas
integer x = 101
integer y = 164
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Familia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_familia from statictext within wi_mant_marcas
integer x = 722
integer y = 164
integer width = 1230
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 30146300
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type sle_familia from u_em_campo within wi_mant_marcas
integer x = 352
integer y = 164
integer width = 352
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE FAMILIAS"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""
isle_campo    = This
sle_valor.Text = ""
end event

event modificado;call super::modificado;st_nombre_familia.text=f_nombre_familia(codigo_empresa,sle_familia.text)
IF Trim(st_nombre_familia.text)="" THEN 
 IF Trim(sle_familia.text)<>"" Then  f_activar_campo(sle_familia)
 sle_familia.text=""
END IF

f_control()
end event

type st_marcas_descripcion from statictext within wi_mant_marcas
integer x = 722
integer y = 348
integer width = 1230
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 30146300
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_marcas_familia from datawindow within wi_mant_marcas
integer x = 9
integer y = 764
integer width = 2350
integer height = 664
boolean bringtotop = true
string dataobject = "dw_mant_marcas2"
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = This.GetItemString(Row,"codigo")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

type pb_calculadora from u_calculadora within wi_mant_marcas
integer x = 599
integer y = 344
integer height = 92
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE or sle_familia.text = '' THEN Return

Integer registros
Select count(*) 
Into :registros 
From marcas
Where  marcas.empresa = :codigo_empresa;

IF registros=0  Then
	sle_valor.text="1"
ELSE
	Select max(convert(int,marcas.codigo)+1)
	Into   :sle_valor.text
	From   marcas
	Where  marcas.empresa = :codigo_empresa;
END IF

// Parent.TriggerEvent("ue_recuperar")
sle_valor.ue_ante_valor = sle_valor.text
sle_valor.TriggerEvent("modificado")

//dw_1.TriggerEvent("Clicked")
end event

