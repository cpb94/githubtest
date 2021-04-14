$PBExportHeader$wi_mant_venmapatarifas_idiomas.srw
forward
global type wi_mant_venmapatarifas_idiomas from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_venmapatarifas_idiomas
end type
type st_nombre_tarifa from statictext within wi_mant_venmapatarifas_idiomas
end type
type dw_fechas from datawindow within wi_mant_venmapatarifas_idiomas
end type
type gb_1 from groupbox within wi_mant_venmapatarifas_idiomas
end type
type sle_tarifa from u_em_campo within wi_mant_venmapatarifas_idiomas
end type
type em_fecha from u_em_campo within wi_mant_venmapatarifas_idiomas
end type
type st_nombre_idioma from statictext within wi_mant_venmapatarifas_idiomas
end type
type st_2 from statictext within wi_mant_venmapatarifas_idiomas
end type
end forward

global type wi_mant_venmapatarifas_idiomas from wi_mvent_con_empresa
integer width = 2839
integer height = 1604
st_almacen st_almacen
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
gb_1 gb_1
sle_tarifa sle_tarifa
em_fecha em_fecha
st_nombre_idioma st_nombre_idioma
st_2 st_2
end type
global wi_mant_venmapatarifas_idiomas wi_mant_venmapatarifas_idiomas

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();Datetime fecha

fecha = DateTime(Date(String(em_fecha.Text)))
dw_fechas.Retrieve(codigo_empresa,sle_tarifa.text)

If em_fecha.text = "00-00-00"  or Trim(sle_tarifa.text) = "" or trim(sle_valor.text)= "" Then
 dw_1.Reset()
 Return
End IF
dw_1.Retrieve(codigo_empresa,sle_tarifa.text,fecha,sle_valor.text)


end subroutine

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"tarifa",sle_tarifa.text)
dw_1.setitem(dw_1.getrow(),"idioma",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"fecha",Datetime(Date(string(em_fecha.text))))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"f_alta",DateTime(today(),now()))


end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento textos tarifas por idiomas"
istr_parametros.s_listado        = "report_venmapatarifas_idiomas"
This.title=istr_parametros.s_titulo_ventana
dw_fechas.SetTransObject(SQLCA)
tipo_mantenimiento = "N"
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(sle_tarifa.text))
criterio[2]   =  trim(sle_tarifa.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "venmapatarifas"



if em_fecha.text = "00-00-00" then
    f_activar_campo(sle_valor)
    Return
End if

f_control()

CALL Super::ue_recuperar
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;dw_fechas.Retrieve(codigo_empresa,sle_tarifa.text)
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_tarifa.enabled=FALSE

end event

on wi_mant_venmapatarifas_idiomas.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.gb_1=create gb_1
this.sle_tarifa=create sle_tarifa
this.em_fecha=create em_fecha
this.st_nombre_idioma=create st_nombre_idioma
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_tarifa
this.Control[iCurrent+3]=this.dw_fechas
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.sle_tarifa
this.Control[iCurrent+6]=this.em_fecha
this.Control[iCurrent+7]=this.st_nombre_idioma
this.Control[iCurrent+8]=this.st_2
end on

on wi_mant_venmapatarifas_idiomas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.gb_1)
destroy(this.sle_tarifa)
destroy(this.em_fecha)
destroy(this.st_nombre_idioma)
destroy(this.st_2)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_tarifa.enabled=TRUE
end event

event ue_borra_fila;call super::ue_borra_fila;DateTime fecha
fecha    = DateTime(Date(sle_valor.text))
Delete From venlintarifas
Where   venlintarifas.empresa = :codigo_empresa
And     venlintarifas.tarifa  = :sle_tarifa.text
And     venlintarifas.fecha   = :fecha;
COMMIT;
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venmapatarifas_idiomas
integer x = 0
integer y = 452
integer width = 2711
integer height = 728
string dataobject = "dw_venmapatarifas_idiomas"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venmapatarifas_idiomas
integer x = 0
integer y = 308
integer width = 256
integer height = 80
string text = "Idioma:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venmapatarifas_idiomas
integer x = 1481
integer y = 1208
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venmapatarifas_idiomas
integer x = 1893
integer y = 1208
end type

event cb_borrar::clicked;DateTime fecha 
Select activa Into :fecha From ventarifas
Where  ventarifas.empresa = :codigo_empresa
And    ventarifas.codigo  = :sle_tarifa.text;

IF Date(fecha) <> Date(sle_valor.text) Then
   CALL Super::Clicked
	Return
Else
	f_mensaje("Esta fecha activa "," No se puede borrar em mapa")
	Return
END IF	
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venmapatarifas_idiomas
integer x = 293
integer y = 296
integer width = 256
integer taborder = 20
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = "˜"
end type

event sle_valor::losefocus;call super::losefocus;//IF KEYDOWN (KeyTab!) Then
//IF Not f_verifica_fecha(DateTime(Date(sle_valor.text))) Then sle_valor.text = "00-00-00"
//IF sle_valor.text = "00-00-00" Then Return
//CALL Super::losefocus
//END IF
end event

event sle_valor::getfocus;call super::getfocus;  ue_titulo     = "AYUDA SELECCION DE IDIOMAS"
  ue_datawindow = "dw_ayuda_idiomas"
  ue_filtro     = ""
  valor_empresa = FALSE
  isle_campo    = sle_valor
end event

event sle_valor::modificado;call super::modificado;st_nombre_idioma.text=f_nombre_idioma(sle_valor.text)
IF Trim(st_nombre_idioma.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venmapatarifas_idiomas
integer x = 2304
integer y = 1208
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venmapatarifas_idiomas
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venmapatarifas_idiomas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venmapatarifas_idiomas
end type

type st_almacen from statictext within wi_mant_venmapatarifas_idiomas
integer y = 208
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
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_tarifa from statictext within wi_mant_venmapatarifas_idiomas
integer x = 558
integer y = 200
integer width = 1033
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fechas from datawindow within wi_mant_venmapatarifas_idiomas
integer x = 2126
integer y = 140
integer width = 594
integer height = 288
boolean bringtotop = true
string dataobject = "dw_venmapatarifas1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return


em_fecha.text  = String(Date(This.GetItemDateTime(row,"fecha")))
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type gb_1 from groupbox within wi_mant_venmapatarifas_idiomas
integer x = 1472
integer y = 1176
integer width = 1248
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type sle_tarifa from u_em_campo within wi_mant_venmapatarifas_idiomas
integer x = 293
integer y = 200
integer taborder = 10
end type

event getfocus;call super::getfocus;    ue_titulo     = "AYUDA SELECCION DE TARIFAS"
	 ue_datawindow = "dw_ayuda_ventarifas"
	 ue_filtro     = ""
    valor_empresa = TRUE
    isle_campo    = sle_tarifa
    f_control()
   
IF istr_parametros.i_nargumentos>1 THEN
     istr_parametros.i_nargumentos=0
	  em_fecha.text   =  istr_parametros.s_argumentos[3]	
     sle_tarifa.text  =  istr_parametros.s_argumentos[2]
	  sle_valor.text  =  istr_parametros.s_argumentos[4]
     f_no_nulo(sle_valor)
	  sle_tarifa.triggerEvent("modificado")
  	  sle_valor.triggerEvent("modificado")
     IF Trim(sle_valor.text)<> "" and  em_fecha.text <> "00-00-00" and  Trim(sle_tarifa.text) <> "" Then
	     Parent.TriggerEvent("ue_recuperar")
		  f_activar_campo(sle_valor)
		  Return
     END IF
END IF




end event

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,sle_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(sle_tarifa.text)<>"" Then  f_activar_campo(sle_tarifa)
 sle_tarifa.text=""
END IF
em_fecha.text = String(f_activa_ventarifas(codigo_empresa,sle_tarifa.text),"dd-mm-yy")
f_control()
end event

type em_fecha from u_em_campo within wi_mant_venmapatarifas_idiomas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1632
integer y = 204
integer width = 315
integer taborder = 0
boolean enabled = false
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
end type

type st_nombre_idioma from statictext within wi_mant_venmapatarifas_idiomas
integer x = 558
integer y = 308
integer width = 1033
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within wi_mant_venmapatarifas_idiomas
integer x = 1637
integer y = 144
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

