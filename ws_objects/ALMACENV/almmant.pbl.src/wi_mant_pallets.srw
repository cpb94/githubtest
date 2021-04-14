$PBExportHeader$wi_mant_pallets.srw
$PBExportComments$Mant. de pallets.
forward
global type wi_mant_pallets from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_pallets
end type
type r_1 from rectangle within wi_mant_pallets
end type
end forward

global type wi_mant_pallets from wi_mvent_con_empresa
integer width = 2267
integer height = 1220
pb_calculadora pb_calculadora
r_1 r_1
end type
global wi_mant_pallets wi_mant_pallets

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Pallets"
	istr_parametros.s_listado        = "report_pallets"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
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
tabla         = "pallets"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end on

on wi_mant_pallets.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.r_1
end on

on wi_mant_pallets.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.r_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_pallets
integer x = 55
integer y = 336
integer width = 2121
integer height = 672
string dataobject = "dw_pallets"
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE ls_objeto
 
CASE 'pb_proveedor'
   lstr_param.s_argumentos[2]="P"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(wi_mant_clipro,lstr_param)  
CASE 'pb_clasepallet'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"clase")
   OpenWithParm(wi_mant_clipro,lstr_param)  
CASE 'pb_mprima'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo_compras")
   OpenWithParm(w_mant_venmprima2,lstr_param)  

END CHOOSE





end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"proveedor")
end on

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES "
 		bus_datawindow = "dw_ayuda_proveedores"
  CASE "clase"
      bus_titulo     = "VENTANA SELECCION CLASE DE PALLETS"
 		bus_datawindow = "dw_ayuda_almclasepallet"
   CASE "codigo_compras"
      bus_titulo     = "VENTANA SELECCION MAT. PRIMA"
 		bus_datawindow = "dw_ayuda_venmprima"
		 
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
 		bus_datawindow = "dw_ayuda_proveedores"
   CASE "clase"
      bus_titulo     = "VENTANA SELECCION CLASE DE PALLETS"
 		bus_datawindow = "dw_ayuda_almclasepallet"
   CASE "codigo_compras"
      bus_titulo     = "VENTANA SELECCION MAT. PRIMA"
 		bus_datawindow = "dw_ayuda_venmprima"
		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_pallets
integer x = 55
integer width = 233
string text = "Pallet"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_pallets
integer x = 1079
integer y = 212
integer width = 352
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_pallets
integer x = 1440
integer y = 212
integer width = 352
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_pallets
integer x = 302
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow = "dw_ayuda_pallets"
ue_titulo     = "AYUDA SELECCION DE PALLETS"
ue_filtro     = ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_pallets
integer x = 1801
integer y = 212
integer width = 352
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_pallets
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_pallets
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_pallets
integer x = 9
integer y = 52
integer width = 2167
integer height = 76
end type

type pb_calculadora from u_calculadora within wi_mant_pallets
integer x = 562
integer y = 208
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From pallets
 Where  pallets.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,pallets.codigo)+1)
  Into   :sle_valor.text
  From   pallets
  Where  pallets.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type r_1 from rectangle within wi_mant_pallets
integer linethickness = 4
long fillcolor = 12639424
integer x = 1056
integer y = 200
integer width = 1115
integer height = 116
end type

