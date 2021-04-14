$PBExportHeader$wi_mant_almacenes.srw
$PBExportComments$Mantenimiento de Almacenes
forward
global type wi_mant_almacenes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_almacenes
end type
type dw_2 from datawindow within wi_mant_almacenes
end type
end forward

global type wi_mant_almacenes from wi_mvent_con_empresa
integer width = 2473
integer height = 988
pb_calculadora pb_calculadora
dw_2 dw_2
end type
global wi_mant_almacenes wi_mant_almacenes

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;

   istr_parametros.s_titulo_ventana = "Mantenimiento de Almacenes"
	istr_parametros.s_listado        = "report_almacenes"
   title = istr_parametros.s_titulo_ventana
   
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

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
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
tabla         = "almalmacen"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_almacenes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_2
end on

on wi_mant_almacenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_2)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almacenes
integer x = 64
integer y = 324
integer width = 1765
integer height = 464
string dataobject = "dw_almacenes"
end type

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipoalm"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almtipoalm"
  	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipoalm")
f_valores_numericos(dw_1,"codcli")
end on

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipoalm"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almtipoalm"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_tipoalm'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipoalm")
   OpenWithParm(wi_mant_almtipoalm,lstr_param)  
CASE 'pb_codcli'
   lstr_param.s_argumentos[2]="C"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codcli")
   OpenWithParm(wi_mant_clipro,lstr_param)  

END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almacenes
integer x = 201
integer width = 315
string text = "Almacén"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almacenes
integer x = 1861
integer y = 340
end type

event cb_insertar::clicked;IF dw_1.GetRow() <> 0 Then
 dw_1.AcceptText()
 String var_descripcion,var_resumido,var_codcli,var_tipoalm,des_codcli,des_tipoalm
 var_descripcion  = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
 var_resumido     = dw_1.GetItemString(dw_1.GetRow(),"resumido")
 var_tipoalm      = dw_1.GetItemString(dw_1.GetRow(),"tipoalm")
 des_tipoalm      = dw_1.GetItemString(dw_1.GetRow(),"descripcion_tipoalm")
if cb_insertar.enabled = TRUE THEN
 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
  MessageBox("Campo Obligatorio","Introduzca la descripcion del tipo de almacen",Exclamation!,Ok!,1)
  dw_1.SetColumn("descripcion")
  dw_1.SetFocus()
  Return
 END IF
If Trim(var_resumido) = ""  or ISNULL(var_resumido) Then
  MessageBox("Campo Obligatorio","Introduzca el resumido del tipo de almacen",Exclamation!,Ok!,1)
  dw_1.SetColumn("resumido")
  dw_1.SetFocus()
  Return
 END IF
 If Trim(var_tipoalm) = ""  or ISNULL(var_tipoalm) Then
  MessageBox("Campo Obligatorio","Introduzca el tipo de almacen",Exclamation!,Ok!,1)
  dw_1.SetColumn("tipoalm")
  dw_1.SetFocus()
  Return
 END IF

 If Trim(des_tipoalm) = ""  or ISNULL(des_tipoalm)Then
  MessageBox("Campo Obligatorio","El tipo de almacen no existe",Exclamation!,Ok!,1)
  dw_1.SetColumn("tipoalm")
  dw_1.SetFocus()
  Return
 END IF
END IF
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almacenes
integer x = 1861
integer y = 460
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almacenes
integer x = 526
string mask = "!!!!!!!!!!!!!!!!!!"
string displaydata = "xlÇ"
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;   ue_datawindow     = "dw_ayuda_almacenes"
   ue_titulo         = "AYUDA SELECCION DE ALMACENES"
   ue_filtro         = ""
   isle_campo        = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almacenes
integer x = 1861
integer y = 608
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almacenes
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almacenes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almacenes
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_almacenes
integer x = 791
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From almalmacen
 Where  almalmacen.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,almalmacen.codigo)+1)
  Into   :sle_valor.text
  From   almalmacen
  Where  almalmacen.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_2 from datawindow within wi_mant_almacenes
boolean visible = false
integer x = 1778
integer y = 172
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_cursor_promlindetalleped"
boolean livescroll = true
end type

