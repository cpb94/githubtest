$PBExportHeader$wi_mant_venmapatarifas.srw
$PBExportComments$Mant. mapa de tarifas.
forward
global type wi_mant_venmapatarifas from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_venmapatarifas
end type
type st_nombre_tarifa from statictext within wi_mant_venmapatarifas
end type
type dw_fechas from datawindow within wi_mant_venmapatarifas
end type
type gb_1 from groupbox within wi_mant_venmapatarifas
end type
type sle_tarifa from u_em_campo within wi_mant_venmapatarifas
end type
type dw_textos_idioma from datawindow within wi_mant_venmapatarifas
end type
end forward

global type wi_mant_venmapatarifas from wi_mvent_con_empresa
integer width = 2839
integer height = 1708
st_almacen st_almacen
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
gb_1 gb_1
sle_tarifa sle_tarifa
dw_textos_idioma dw_textos_idioma
end type
global wi_mant_venmapatarifas wi_mant_venmapatarifas

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();Datetime fecha

fecha = DateTime(Date(String(sle_valor.Text)))
dw_fechas.Retrieve(codigo_empresa,sle_tarifa.text)

If sle_valor.text = "00-00-00" Then
 dw_1.Reset()
 Return
End IF
dw_1.Retrieve(codigo_empresa,sle_tarifa.text,fecha)
dw_textos_idioma.Retrieve(codigo_empresa,sle_tarifa.text,fecha)


end subroutine

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"tarifa",sle_tarifa.text)
dw_1.setitem(dw_1.getrow(),"fecha",Datetime(Date(string(sle_valor.text))))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"automatico","S")
dw_1.setitem(dw_1.getrow(),"f_alta",DateTime(today(),now()))


end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento mapa de tarifas"
istr_parametros.s_listado        = "report_venmapatarifas"
This.title=istr_parametros.s_titulo_ventana
dw_fechas.SetTransObject(SQLCA)
dw_textos_idioma.SetTransObject(SQLCA)
sle_valor.text = String(Today())
tipo_mantenimiento = "C"
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


f_control()

CALL Super::ue_recuperar
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;dw_fechas.Retrieve(codigo_empresa,sle_tarifa.text)
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_tarifa.enabled=FALSE
dw_textos_idioma.enabled = FALSE

end event

on wi_mant_venmapatarifas.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.gb_1=create gb_1
this.sle_tarifa=create sle_tarifa
this.dw_textos_idioma=create dw_textos_idioma
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_tarifa
this.Control[iCurrent+3]=this.dw_fechas
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.sle_tarifa
this.Control[iCurrent+6]=this.dw_textos_idioma
end on

on wi_mant_venmapatarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.gb_1)
destroy(this.sle_tarifa)
destroy(this.dw_textos_idioma)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_tarifa.enabled=TRUE
dw_textos_idioma.enabled = TRUE
end event

event ue_borra_fila;call super::ue_borra_fila;DateTime fecha
fecha    = DateTime(Date(sle_valor.text))

Delete From venlintarifas
Where   venlintarifas.empresa = :codigo_empresa
And     venlintarifas.tarifa  = :sle_tarifa.text
And     venlintarifas.fecha   = :fecha;

Delete From ventarfamfor
Where   ventarfamfor.empresa = :codigo_empresa
And     ventarfamfor.tarifa  = :sle_tarifa.text
And     ventarfamfor.fecha   = :fecha;

Delete From venmapatarifas_idiomas
Where   venmapatarifas_idiomas.empresa = :codigo_empresa
And     venmapatarifas_idiomas.tarifa  = :sle_tarifa.text
And     venmapatarifas_idiomas.fecha   = :fecha;

COMMIT;
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venmapatarifas
integer x = 18
integer y = 484
integer width = 2711
integer height = 484
string dataobject = "dw_venmapatarifas"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venmapatarifas
integer x = 55
integer y = 348
integer width = 256
integer height = 80
string text = "Fecha:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venmapatarifas
integer x = 869
integer y = 376
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venmapatarifas
integer x = 1280
integer y = 376
end type

event cb_borrar::clicked;DateTime fecha 
date fecha_activa
string f_activa

Select ventarifas.activa 
Into   :fecha
From   ventarifas
Where  ventarifas.empresa = :codigo_empresa
And    ventarifas.codigo  = :sle_tarifa.text;

f_activa = string(Date(fecha))

if isNull(f_activa) then 
	fecha_activa = date("00-00-00")
 else
	fecha_activa = date(fecha)
end if

IF fecha_activa <> Date(sle_valor.text) Then
   CALL Super::Clicked
   sle_valor.text = String(Today())
	Return
Else
	f_mensaje("Esta fecha es la activa en la tarifa."," No se puede borrar em mapa")
	Return
END IF	
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venmapatarifas
integer x = 338
integer y = 336
integer width = 315
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event sle_valor::losefocus;call super::losefocus;//IF KEYDOWN (KeyTab!) Then
//IF Not f_verifica_fecha(DateTime(Date(sle_valor.text))) Then sle_valor.text = "00-00-00"
//IF sle_valor.text = "00-00-00" Then Return
//CALL Super::losefocus
//END IF
end event

event sle_valor::getfocus;call super::getfocus;    ue_titulo     = ""
	 ue_datawindow = ""
	 ue_filtro     = ""
	 isle_campo    = sle_valor
	 
	 // Solo para que refresque el dato por ser una fecha ya que le
	 // da el valor inicial cuando entramos en el programa.
	 ue_ante_valor = ""
    sle_valor.text = String(Today())
	 f_control()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venmapatarifas
integer x = 1691
integer y = 376
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venmapatarifas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venmapatarifas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venmapatarifas
end type

type st_almacen from statictext within wi_mant_venmapatarifas
integer x = 46
integer y = 232
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

type st_nombre_tarifa from statictext within wi_mant_venmapatarifas
integer x = 626
integer y = 224
integer width = 1225
integer height = 80
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

type dw_fechas from datawindow within wi_mant_venmapatarifas
integer x = 2126
integer y = 164
integer width = 594
integer height = 308
boolean bringtotop = true
string dataobject = "dw_venmapatarifas1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return


sle_valor.text  = String(Date(This.GetItemDateTime(row,"fecha")))
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type gb_1 from groupbox within wi_mant_venmapatarifas
integer x = 859
integer y = 344
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

type sle_tarifa from u_em_campo within wi_mant_venmapatarifas
integer x = 338
integer y = 224
integer taborder = 10
end type

event getfocus;call super::getfocus;    ue_titulo     = "AYUDA SELECCION DE TARIFAS"
	 ue_datawindow = "dw_ayuda_ventarifas"
	 ue_filtro     = ""
    isle_campo    = sle_tarifa
    f_control()
   
IF istr_parametros.i_nargumentos>1 THEN
     istr_parametros.i_nargumentos=0
	  sle_valor.text   =  istr_parametros.s_argumentos[3]	
     sle_tarifa.text  =  istr_parametros.s_argumentos[2]
     f_no_nulo(sle_valor)
     IF Trim(sle_valor.text)<> "" and  Trim(sle_tarifa.text) <> "" Then
		  sle_tarifa.TriggerEvent("modificado")
		  f_activar_campo(sle_tarifa)
	    // Parent.TriggerEvent("ue_recuperar")
		  Return
     END IF
  
END IF




end event

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,sle_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(sle_tarifa.text)<>"" Then  f_activar_campo(sle_tarifa)
 sle_tarifa.text=""
END IF
f_control()
end event

type dw_textos_idioma from datawindow within wi_mant_venmapatarifas
integer x = 23
integer y = 976
integer width = 2734
integer height = 476
boolean bringtotop = true
string dataobject = "dw_venmapatarifas2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_ventarifas"
CHOOSE CASE f_objeto_datawindow(This)
  
CASE 'conexion'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]  = sle_tarifa.text
   lstr_param.s_argumentos[3]  = sle_valor.text
   OpenWithParm(wi_mant_venmapatarifas_idiomas,lstr_param)  
CASE ELSE
   IF row = 0 Then Return
   
	lstr_param.i_nargumentos    = 2
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]  = sle_tarifa.text
   lstr_param.s_argumentos[3]  = sle_valor.text
   lstr_param.s_argumentos[4]  = GetItemString(row,"idioma")
   OpenWithParm(wi_mant_venmapatarifas_idiomas,lstr_param)  
	
END CHOOSE

end event

