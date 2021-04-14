$PBExportHeader$wi_mant_tipollamada.srw
$PBExportComments$Mantenimientos de tipos de llamadas.
forward
global type wi_mant_tipollamada from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_tipollamada
end type
end forward

global type wi_mant_tipollamada from wi_mvent_con_empresa
integer width = 2679
integer height = 1220
pb_calculadora pb_calculadora
end type
global wi_mant_tipollamada wi_mant_tipollamada

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "mtiposllamadas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Tipos de Llamadas"
	istr_parametros.s_listado        = "report_tiposllamadas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_tipollamada.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_tipollamada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_tipollamada
integer x = 41
integer y = 324
integer width = 2053
integer height = 656
string dataobject = "dw_tipos_llamadas"
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
  
CASE 'pb_carta'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"carta")
   OpenWithParm(wi_mant_cartas,lstr_param)  

END CHOOSE





end event

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "carta"
      bus_titulo     = "VENTANA SELECCION DE CARTA "
 		bus_datawindow = "dw_ayuda_cartas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

on dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "carta"
      bus_titulo     = "VENTANA SELECCION DE CARTAS "
 		bus_datawindow = "dw_ayuda_cartas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end on

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"carta")
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_tipollamada
integer x = 201
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_tipollamada
integer x = 2162
integer y = 324
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_tipollamada
integer x = 2162
integer y = 444
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_tipollamada
integer x = 489
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_tiposllamadas"
ue_titulo     =  "AYUDA SELECCION TIPOS DE LLAMADAS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_tipollamada
integer x = 2162
integer y = 564
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_tipollamada
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_tipollamada
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_tipollamada
integer width = 2523
end type

type pb_calculadora from u_calculadora within wi_mant_tipollamada
integer x = 754
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From mtiposllamadas
 Where  mtiposllamadas.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,mtiposllamadas.codigo)+1)
  Into   :sle_valor.text
  From   mtiposllamadas
  Where  mtiposllamadas.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

