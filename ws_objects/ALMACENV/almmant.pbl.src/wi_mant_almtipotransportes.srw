$PBExportHeader$wi_mant_almtipotransportes.srw
forward
global type wi_mant_almtipotransportes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_almtipotransportes
end type
type gb_1 from groupbox within wi_mant_almtipotransportes
end type
end forward

global type wi_mant_almtipotransportes from wi_mvent_con_empresa
integer width = 2711
integer height = 1216
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_almtipotransportes wi_mant_almtipotransportes

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Tipos de Transporte"
	istr_parametros.s_listado        = "report_almtipotransportes"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

f_mascara_columna(dw_1,"largo",f_mascara_decimales(2))
f_mascara_columna(dw_1,"ancho",f_mascara_decimales(2))
f_mascara_columna(dw_1,"alto",f_mascara_decimales(2))
f_mascara_columna(dw_1,"volumen",f_mascara_decimales(2))
f_mascara_columna(dw_1,"pesomax",f_mascara_decimales(2))
	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "almtipotransportes"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on wi_mant_almtipotransportes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_almtipotransportes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almtipotransportes
integer x = 82
integer y = 312
integer width = 2464
integer height = 640
string dataobject = "dw_almtipotransportes"
end type

event dw_1::clicked;call super::clicked;


CHOOSE CASE f_objeto_datawindow(This)
		 
CASE 'calculadora'
	
	decimal var_volumen, var_largo, var_alto, var_ancho
	var_largo=dw_1.GetItemNumber(dw_1.getrow(),"largo")
	var_alto=dw_1.GetItemNumber(dw_1.getrow(),"alto")
	var_ancho=dw_1.GetItemNumber(dw_1.getrow(),"ancho")
	var_volumen=var_largo * var_alto * var_ancho
   dw_1.setitem(dw_1.getrow(),"volumen",var_volumen)
	
END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almtipotransportes
integer x = 137
integer y = 208
integer width = 471
string text = "Tipo transporte:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almtipotransportes
integer x = 1312
integer y = 196
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almtipotransportes
integer x = 1723
integer y = 196
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almtipotransportes
integer x = 613
integer y = 204
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_almtipotransportes"
ue_titulo     = "AYUDA SELECCION DE PALLETS"
ue_filtro     = ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almtipotransportes
integer x = 2130
integer y = 196
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almtipotransportes
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almtipotransportes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almtipotransportes
integer width = 2633
end type

type pb_calculadora from u_calculadora within wi_mant_almtipotransportes
integer x = 873
integer y = 196
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From almtipotransportes
 Where  almtipotransportes.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,almtipotransportes.codigo)+1)
  Into   :sle_valor.text
  From   almtipotransportes
  Where  almtipotransportes.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type gb_1 from groupbox within wi_mant_almtipotransportes
integer x = 1294
integer y = 160
integer width = 1257
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

