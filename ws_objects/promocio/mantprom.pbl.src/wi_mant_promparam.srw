$PBExportHeader$wi_mant_promparam.srw
forward
global type wi_mant_promparam from wi_mant_ventanas
end type
type st_nombre from statictext within wi_mant_promparam
end type
end forward

global type wi_mant_promparam from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2341
integer height = 1396
st_nombre st_nombre
end type
global wi_mant_promparam wi_mant_promparam

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Parametros promocion"
istr_parametros.s_listado        = "report_promparam"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
  sle_valor.text=istr_parametros.s_argumentos[2]
  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
   	dw_1.Retrieve(sle_valor.text)
  END IF
END IF

f_mascara_columna(dw_1,"costepanelmano","###,##0.00")
f_mascara_columna(dw_1,"pventapanelmano","###,##0.00")
f_mascara_columna(dw_1,"pesopanelmano","###,##0.00")
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;  dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       = This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "promparam"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_promparam.create
int iCurrent
call super::create
this.st_nombre=create st_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre
end on

on wi_mant_promparam.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre)
end on

event activate;call super::activate;wi_mant_promparam = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_promparam
integer x = 59
integer y = 212
integer width = 1737
integer height = 932
string dataobject = "dw_promparam"
end type

event dw_1::rbuttondown; valor_empresa = TRUE
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES "
 		bus_datawindow = "dw_ayuda_calidades"
   CASE "tarifa"
		bus_titulo 		 ="VENTANA DE SELECCION DE TARIFAS"
		bus_datawindow	 = "dw_ayuda_ventarifas"
   CASE "clase_panel"
		bus_titulo 		 ="VENTANA DE SELECCION CLASE PANELES"
		bus_datawindow	 = "dw_ayuda_promclasepanel"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::key;if KeyDown(KeyEnter!) or KeyDown(KeyTab!) then 
 valor_empresa = TRUE
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES "
 		bus_datawindow = "dw_ayuda_calidades"
   CASE "tarifa"
		bus_titulo 		 ="VENTANA DE SELECCION DE TARIFAS"
		bus_datawindow	 = "dw_ayuda_ventarifas"
   CASE "clase_panel"
		bus_titulo 		 ="VENTANA DE SELECCION CLASE PANELES"
		bus_datawindow	 = "dw_ayuda_promclasepanel"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
End if
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_promparam
integer x = 169
integer y = 88
integer width = 315
integer height = 76
string text = "Empresa"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_promparam
integer x = 1833
integer y = 212
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_promparam
integer x = 1838
integer y = 332
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_promparam
integer x = 498
integer y = 84
boolean bringtotop = true
end type

event sle_valor::modificado;call super::modificado;st_nombre.text=f_nombre_empresa(codigo_empresa)
IF Trim(st_nombre.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
 Return
END IF
end event

event sle_valor::getfocus;call super::getfocus;valor_empresa     = FALSE	
ue_titulo         = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow     = "dw_ayuda_empresas"
ue_filtro         = "" 
isle_campo        = This  
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_promparam
integer x = 1842
integer y = 452
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_promparam
end type

type st_nombre from statictext within wi_mant_promparam
integer x = 777
integer y = 88
integer width = 987
integer height = 80
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

