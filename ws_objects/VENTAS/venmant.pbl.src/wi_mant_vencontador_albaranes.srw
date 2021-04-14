$PBExportHeader$wi_mant_vencontador_albaranes.srw
forward
global type wi_mant_vencontador_albaranes from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_vencontador_albaranes
end type
type sle_anyo from u_em_campo within wi_mant_vencontador_albaranes
end type
type st_nombre_serie from statictext within wi_mant_vencontador_albaranes
end type
end forward

global type wi_mant_vencontador_albaranes from wi_mvent_con_empresa
integer width = 2354
integer height = 1052
st_almacen st_almacen
sle_anyo sle_anyo
st_nombre_serie st_nombre_serie
end type
global wi_mant_vencontador_albaranes wi_mant_vencontador_albaranes

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();integer periodo

periodo   =  Integer(sle_anyo.text)
dw_1.Retrieve(codigo_empresa,periodo,sle_valor.Text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento contadores Albaranes"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

sle_anyo.text  = string(Year(today()))

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",Dec(sle_anyo.text))
dw_1.setitem(dw_1.getrow(),"serie",sle_valor.text)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_anyo.text))
criterio[2]   =  trim(sle_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "venparamalb"


f_control()

CALL Super::ue_recuperar
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_anyo.enabled=FALSE
end event

on wi_mant_vencontador_albaranes.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.sle_anyo=create sle_anyo
this.st_nombre_serie=create st_nombre_serie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.sle_anyo
this.Control[iCurrent+3]=this.st_nombre_serie
end on

on wi_mant_vencontador_albaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.sle_anyo)
destroy(this.st_nombre_serie)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_anyo.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencontador_albaranes
integer x = 59
integer y = 448
integer width = 1650
integer height = 316
string dataobject = "dw_vencontador_albaranes"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencontador_albaranes
integer x = 279
integer y = 320
integer width = 242
integer height = 80
string text = "Serie"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencontador_albaranes
integer x = 1801
integer y = 448
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencontador_albaranes
integer x = 1801
integer y = 560
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencontador_albaranes
integer x = 562
integer y = 312
integer width = 242
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo       	= "AYUDA SELECCION DE SERIES"
ue_datawindow   	= "dw_ayuda_venseries"
ue_filtro 		   = "" 
isle_campo        = sle_valor

IF trim(sle_anyo.text)= "" THEN f_activar_campo(sle_anyo)


end event

event sle_valor::modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencontador_albaranes
integer x = 1801
integer y = 672
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencontador_albaranes
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencontador_albaranes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencontador_albaranes
end type

type st_almacen from statictext within wi_mant_vencontador_albaranes
integer x = 256
integer y = 200
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
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_anyo from u_em_campo within wi_mant_vencontador_albaranes
integer x = 562
integer y = 188
integer width = 242
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event getfocus;call super::getfocus;sle_valor.text = ""
st_nombre_serie.text = ""
end event

type st_nombre_serie from statictext within wi_mant_vencontador_albaranes
integer x = 818
integer y = 316
integer width = 786
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

