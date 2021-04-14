$PBExportHeader$wi_mant_pagos_plantillas.srw
forward
global type wi_mant_pagos_plantillas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_pagos_plantillas
end type
type gb_1 from groupbox within wi_mant_pagos_plantillas
end type
end forward

global type wi_mant_pagos_plantillas from wi_mvent_con_empresa
integer width = 2610
integer height = 1692
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_pagos_plantillas wi_mant_pagos_plantillas

type variables

end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Pantillas pagos"
	istr_parametros.s_listado         = "report_carpagos_plantillas"
   This.title = istr_parametros.s_titulo_ventana
   f_mascara_columna(dw_1,"posx1",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posx11",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posx7",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posx12",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posx13",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posx14",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posx15",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posx16",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posy11",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy12",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy13",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy14",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy15",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy16",f_mascara_decimales(0))
	f_mascara_columna(dw_1,"posy7",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posx2",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posx3",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posx4",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posy1",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posy2",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posy3",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"posy4",f_mascara_decimales(0))
   f_mascara_columna(dw_1,"anchura",f_mascara_decimales(4))
	
		f_mascara_columna(dw_1,"posy8",f_mascara_decimales(0))
		f_mascara_columna(dw_1,"posy9",f_mascara_decimales(0))
		f_mascara_columna(dw_1,"posy10",f_mascara_decimales(0))
		f_mascara_columna(dw_1,"posx8",f_mascara_decimales(0))
		f_mascara_columna(dw_1,"posx9",f_mascara_decimales(0))
		f_mascara_columna(dw_1,"posx10",f_mascara_decimales(0))
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
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
tabla         =  "carpagos_plantillas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_pagos_plantillas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_pagos_plantillas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_pagos_plantillas
integer x = 0
integer y = 268
integer width = 2505
integer height = 1120
string dataobject = "dw_pagos_plantillas"
end type

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipodoc"
 		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
 
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key



end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipodoc"
 		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
 
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown



end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_pagos_plantillas
integer x = 155
integer y = 160
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_pagos_plantillas
integer x = 1175
integer y = 164
integer width = 398
integer height = 80
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_pagos_plantillas
integer x = 1577
integer y = 164
integer width = 398
integer height = 80
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_pagos_plantillas
integer x = 448
integer y = 156
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_carpagos_plantillas"
ue_titulo      = "AYUDA SELECCION DE PLANTILLAS PAGOS"
ue_filtro      =""
isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_pagos_plantillas
integer x = 1979
integer y = 164
integer width = 398
integer height = 80
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_pagos_plantillas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_pagos_plantillas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_pagos_plantillas
integer width = 2491
end type

type pb_calculadora from u_calculadora within wi_mant_pagos_plantillas
integer x = 713
integer y = 148
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   carpagos_plantillas
 Where  carpagos_plantillas.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,carpagos_plantillas.codigo)+1)
  Into   :sle_valor.text
  From   carpagos_plantillas
  Where  carpagos_plantillas.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type gb_1 from groupbox within wi_mant_pagos_plantillas
integer x = 1166
integer y = 132
integer width = 1221
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

