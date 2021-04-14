$PBExportHeader$wi_mant_contaorigen.srw
forward
global type wi_mant_contaorigen from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_contaorigen
end type
end forward

global type wi_mant_contaorigen from wi_mvent_con_empresa
integer width = 2519
integer height = 1068
pb_calculadora pb_calculadora
end type
global wi_mant_contaorigen wi_mant_contaorigen

type variables

end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de origenes contables"
	istr_parametros.s_listado         = "report_contaorigen"
   This.title = istr_parametros.s_titulo_ventana
	tipo_mantenimiento = "C"
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	f_mascara_columna(dw_1,"asientoinicial","###,##0")
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end on

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contaorigen"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_contaorigen.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_contaorigen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaorigen
integer x = 46
integer y = 336
integer width = 1742
integer height = 472
string dataobject = "dw_contaorigen"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaorigen
integer x = 270
integer width = 270
string text = "Origen:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaorigen
integer x = 1865
integer y = 340
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaorigen
integer x = 1865
integer y = 460
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaorigen
integer x = 571
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_contaorigen"
ue_titulo      = "AYUDA SELECCION DE ORIGENES CONTABLES"
ue_filtro      =""
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaorigen
integer x = 1865
integer y = 580
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaorigen
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaorigen
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaorigen
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_contaorigen
integer x = 837
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   contaorigen
 Where  contaorigen.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,contaorigen.codigo)+1)
  Into   :sle_valor.text
  From   contaorigen
  Where  contaorigen.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

