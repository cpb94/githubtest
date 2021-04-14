$PBExportHeader$wi_mant_cartas.srw
$PBExportComments$Mantenimiento de cartas.
forward
global type wi_mant_cartas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_cartas
end type
type lb_firmas from listbox within wi_mant_cartas
end type
type p_firma from picture within wi_mant_cartas
end type
end forward

global type wi_mant_cartas from wi_mvent_con_empresa
integer width = 2907
integer height = 1732
pb_calculadora pb_calculadora
lb_firmas lb_firmas
p_firma p_firma
end type
global wi_mant_cartas wi_mant_cartas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_firma ()
end prototypes

public subroutine f_firma ();String fichero
If wi_mant_cartas.visible= FALSE or dw_1.getRow()=0 Then
  lb_firmas.visible= FALSE
  Return
END IF


lb_firmas.visible= TRUE
fichero = dw_1.GetItemString(dw_1.GetRow(),"firma")
If trim(fichero) = "" or IsNull(fichero ) Then
	p_firma.picturename=""
Else
p_firma.picturename="\firmas\"+ Trim(fichero) + ".bmp"
END IF
If Not IsNull(fichero) and Trim(fichero) <> "" then
  p_firma.visible=TRUE
Else
  p_firma.visible=FALSE
End If

end subroutine

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   f_firma()
end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Cartas"
	istr_parametros.s_listado        = "report_cartas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	lb_firmas.dirlist("\firmas\*.bmp",0)
end on

on ue_recuperar;
// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "mcartas"
dw_1.Retrieve(codigo_empresa,sle_valor.Text)

f_firma()

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_cartas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.lb_firmas=create lb_firmas
this.p_firma=create p_firma
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.lb_firmas
this.Control[iCurrent+3]=this.p_firma
end on

on wi_mant_cartas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.lb_firmas)
destroy(this.p_firma)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_cartas
integer x = 18
integer y = 236
integer width = 2830
integer height = 1268
string dataobject = "dw_cartas"
end type

on dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_carta"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CARTAS "
 		bus_datawindow = "dw_ayuda_tipo_cartas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end on

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
  
CASE 'pb_tipo_carta'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_carta")
   OpenWithParm(wi_mant_tipo_cartas,lstr_param)  
END CHOOSE





end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipo_carta")
end on

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_carta"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CARTAS "
 		bus_datawindow = "dw_ayuda_tipo_cartas"
   
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_cartas
integer y = 140
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_cartas
integer x = 1586
integer y = 136
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_cartas
integer x = 1998
integer y = 136
integer width = 411
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_cartas
integer x = 375
integer y = 132
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_cartas"
ue_titulo     =  "AYUDA SELECCION CARTAS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_cartas
integer x = 2414
integer y = 136
integer width = 425
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_cartas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_cartas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_cartas
integer x = 14
integer y = 12
integer width = 2720
end type

type pb_calculadora from u_calculadora within wi_mant_cartas
integer x = 640
integer y = 128
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From mcartas
 Where  mcartas.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,mcartas.codigo)+1)
  Into   :sle_valor.text
  From   mcartas
  Where  mcartas.empresa = :codigo_empresa;
 END IF

dw_1.TriggerEvent("Clicked")
end event

type lb_firmas from listbox within wi_mant_cartas
boolean visible = false
integer x = 1070
integer y = 1372
integer width = 539
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//Integer  registro,numero
//String   firma
//numero   = SelectedIndex()
//registro = dw_1.GetRow()
//If registro = 0 Then return
//firma=Item[numero]
//dw_1.SetItem(registro,"firma",firma)
end on

type p_firma from picture within wi_mant_cartas
boolean visible = false
integer x = 1609
integer y = 1204
integer width = 1216
integer height = 260
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

