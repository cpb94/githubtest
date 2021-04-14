$PBExportHeader$wi_mant_almartcal.srw
$PBExportComments$Mantenimiento de calidades por articulos.
forward
global type wi_mant_almartcal from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_almartcal
end type
type st_nombre_articulo from statictext within wi_mant_almartcal
end type
type sle_articulo from u_em_campo within wi_mant_almartcal
end type
type st_nombre_calidad from statictext within wi_mant_almartcal
end type
type dw_calidades from datawindow within wi_mant_almartcal
end type
end forward

global type wi_mant_almartcal from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3227
integer height = 2220
long backcolor = 32764915
st_almacen st_almacen
st_nombre_articulo st_nombre_articulo
sle_articulo sle_articulo
st_nombre_calidad st_nombre_calidad
dw_calidades dw_calidades
end type
global wi_mant_almartcal wi_mant_almartcal

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.Text)
dw_calidades.Retrieve(codigo_empresa,sle_articulo.text)

end subroutine

on open;call wi_mvent_con_empresa::open;istr_parametros.s_titulo_ventana = "Mantenimiento de calidades por Articulo"
istr_parametros.s_listado        = "report_almartcal"
This.title=istr_parametros.s_titulo_ventana
dw_calidades.SetTransObject(SQLCA)

end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"calidad",sle_valor.text)
dw_1.setitem(dw_1.GetRow(),"fecha_alta",today())
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "almartcal"


f_control()

CALL Super::ue_recuperar
end on

on ue_actualiza_dw;call wi_mvent_con_empresa::ue_actualiza_dw;dw_calidades.Retrieve(codigo_empresa,sle_articulo.text)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_articulo.enabled=FALSE
end on

on wi_mant_almartcal.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_articulo=create st_nombre_articulo
this.sle_articulo=create sle_articulo
this.st_nombre_calidad=create st_nombre_calidad
this.dw_calidades=create dw_calidades
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_articulo
this.Control[iCurrent+3]=this.sle_articulo
this.Control[iCurrent+4]=this.st_nombre_calidad
this.Control[iCurrent+5]=this.dw_calidades
end on

on wi_mant_almartcal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_articulo)
destroy(this.sle_articulo)
destroy(this.st_nombre_calidad)
destroy(this.dw_calidades)
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_articulo.enabled=TRUE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almartcal
integer x = 91
integer y = 448
integer width = 2597
integer height = 908
string dataobject = "dw_almartcal"
end type

event dw_1::itemchanged;call super::itemchanged;decimal valor, porcentaje_liquidacion, precio_liquidacion
string articulo
datetime fecha_liquidacion


valor = dec(data)

if dwo.name = "porcentaje_liquidacion" and (not isnull(data) or data <> "") and valor <> 0   then
		
	valor = dec(data)
	
	//precio_liquidacion = (dw_1.object.precio[row] * valor) / 100
	precio_liquidacion = (dw_1.object.precio[row] * (100-valor)) / 100
	dw_1.object.precio_liquidacion[row] = precio_liquidacion
	dw_1.object.porcentaje_liquidacion[row] = valor
	//if isnull(dw_1.object.fecha_liquidacion[row]) then
	if isnull(dw_1.object.fecha_liquidacion[row]) and valor <> 0 then
		dw_1.object.fecha_liquidacion[row] = date(today())
	end if
end if

if dwo.name = "precio_liquidacion" and (not isnull(data) or data <> "" or data <> "0") and valor <> 0  then
		
	valor = dec(data)
	
	//dw_1.object.porcentaje_liquidacion[row] = (valor / dw_1.object.precio[row] ) * 100 
	dw_1.object.porcentaje_liquidacion[row] = 100 - ((valor / dw_1.object.precio[row] ) * 100 )
	dw_1.object.precio_liquidacion[row] = valor
	//if isnull(dw_1.object.fecha_liquidacion[row]) then
	if isnull(dw_1.object.fecha_liquidacion[row]) and valor <> 0 then	
		dw_1.object.fecha_liquidacion[row] = date(today())
	end if
end if

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almartcal
integer x = 1856
integer y = 320
integer width = 338
integer height = 80
long textcolor = 16777215
long backcolor = 21642288
string text = "Calidad"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almartcal
integer x = 2779
integer y = 752
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almartcal
integer x = 2779
integer y = 880
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almartcal
integer x = 2222
integer y = 316
integer width = 219
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 553648127
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo       	= "AYUDA SELECCION DE CALIDADES "
ue_datawindow   	= "dw_ayuda_calidades"
ue_filtro 		   = "" 
isle_campo        = sle_valor

IF trim(sle_articulo.text)= "" THEN f_activar_campo(sle_articulo)
//IF trim(sle_valor.text)  = "" THEN f_control()

end event

event sle_valor::modificado;call super::modificado;st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almartcal
integer x = 2779
integer y = 1008
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almartcal
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almartcal
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almartcal
integer width = 2903
end type

type st_almacen from statictext within wi_mant_almartcal
integer x = 91
integer y = 320
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 21642288
boolean enabled = false
string text = "Artículo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_articulo from statictext within wi_mant_almartcal
integer x = 955
integer y = 320
integer width = 809
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 553648127
boolean enabled = false
boolean focusrectangle = false
end type

type sle_articulo from u_em_campo within wi_mant_almartcal
integer x = 462
integer y = 316
integer width = 466
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 553648127
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
 ue_datawindow = "dw_ayuda_articulos"
 ue_filtro     = ""
 isle_campo    = sle_articulo
 
 f_control()
sle_valor.text = ""         
 IF istr_parametros.i_nargumentos>1 THEN
	  sle_articulo.text=istr_parametros.s_argumentos[2]	
     sle_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
		 else
			 f_activar_campo(sle_valor)
			 Return
     END IF
END IF







end event

on modificado;call u_em_campo::modificado;st_nombre_articulo.text=f_nombre_articulo(codigo_empresa,sle_articulo.text)
IF Trim(st_nombre_articulo.text)="" THEN 
 IF Trim(sle_articulo.text)<>"" Then  f_activar_campo(sle_articulo)
 sle_articulo.text=""
END IF
end on

type st_nombre_calidad from statictext within wi_mant_almartcal
integer x = 2473
integer y = 320
integer width = 535
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 553648127
boolean enabled = false
boolean focusrectangle = false
end type

type dw_calidades from datawindow within wi_mant_almartcal
integer x = 1019
integer y = 1436
integer width = 741
integer height = 456
boolean bringtotop = true
string dataobject = "dw_almartcal1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = This.GetItemString(Row,"calidad")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

