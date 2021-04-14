$PBExportHeader$wi_mant_ventipolin.srw
$PBExportComments$Mant. tipos de lineas de ventas.
forward
global type wi_mant_ventipolin from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_ventipolin
end type
end forward

global type wi_mant_ventipolin from wi_mvent_con_empresa
integer width = 2272
integer height = 1460
pb_calculadora pb_calculadora
end type
global wi_mant_ventipolin wi_mant_ventipolin

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"comision","S")
   dw_1.setitem(dw_1.getrow(),"descuento","S")
  dw_1.setitem(dw_1.getrow(),"control_almacen","N")
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "ventipolin"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

event open;call super::open;	tipo_mantenimiento = "C"
   istr_parametros.s_titulo_ventana = "Mantenimiento de Tipos de lineas ventas"
	istr_parametros.s_listado        = "report_ventipolin"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_ventipolin.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_ventipolin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ventipolin
integer x = 23
integer y = 252
integer width = 1728
integer height = 1024
string dataobject = "dw_ventipolin"
end type

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"cuenta")
end on

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
  CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
  CASE "cuenta2"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_ventipolin"
CHOOSE CASE ls_objeto
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pbcuenta2'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta2")
   OpenWithParm(wi_mant_contaplan,lstr_param)  

END CHOOSE





end event

event dw_1::rbuttondown;bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
   CASE "cuenta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
  CASE "cuenta2"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ventipolin
integer x = 155
integer y = 148
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ventipolin
integer x = 1765
integer y = 260
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ventipolin
integer x = 1765
integer y = 380
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ventipolin
integer x = 443
integer y = 136
integer height = 92
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_ventipolin"
ue_titulo     =  "AYUDA SELECCION TIPOS DE LINEAS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ventipolin
integer x = 1765
integer y = 500
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ventipolin
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_ventipolin
integer y = 88
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ventipolin
integer width = 2121
end type

type pb_calculadora from u_calculadora within wi_mant_ventipolin
integer x = 709
integer y = 136
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From ventipolin
 Where  ventipolin.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,ventipolin.codigo)+1)
  Into   :sle_valor.text
  From   ventipolin
  Where  ventipolin.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

