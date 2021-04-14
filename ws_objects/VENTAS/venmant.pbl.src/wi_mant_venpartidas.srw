$PBExportHeader$wi_mant_venpartidas.srw
forward
global type wi_mant_venpartidas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_venpartidas
end type
type dw_familias from datawindow within wi_mant_venpartidas
end type
type gb_1 from groupbox within wi_mant_venpartidas
end type
end forward

global type wi_mant_venpartidas from wi_mvent_con_empresa
integer width = 2405
integer height = 1708
pb_calculadora pb_calculadora
dw_familias dw_familias
gb_1 gb_1
end type
global wi_mant_venpartidas wi_mant_venpartidas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venpartidas"


dw_familias.Reset()
IF dw_1.Retrieve(codigo_empresa,sle_valor.Text) <> 0 Then
	dw_familias.Retrieve(codigo_empresa,sle_valor.Text)
END IF
CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Partidas Estadisticas"
	istr_parametros.s_listado        = "report_venpartidas"
   This.title = istr_parametros.s_titulo_ventana
   dw_familias.SetTransObject(SQLCA)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         This.TriggerEvent("ue_recuperar")
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_venpartidas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_familias=create dw_familias
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_familias
this.Control[iCurrent+3]=this.gb_1
end on

on wi_mant_venpartidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_familias)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venpartidas
integer x = 23
integer y = 296
integer width = 2281
integer height = 480
string dataobject = "dw_venpartidas"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;String par
		IF GetRow() = 0 Then Return
		par = GetItemString(GetRow(),"valor2")
		IF IsNUll(par) Then par = ""
		
		AccepTText()
		IF Trim(par)= "" Then
			SetItem(GetRow(),"valor2",GetItemString(GetRow(),"valor1"))
		END IF

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venpartidas
integer x = 279
integer y = 184
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venpartidas
integer x = 1243
integer y = 188
integer width = 343
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venpartidas
integer x = 1586
integer y = 188
integer width = 343
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venpartidas
integer x = 567
integer y = 184
integer width = 238
integer height = 80
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venpartidas"
ue_titulo     =  "AYUDA SELECCION Partidas"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venpartidas
integer x = 1934
integer y = 188
integer width = 329
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venpartidas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venpartidas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venpartidas
integer width = 2053
end type

type pb_calculadora from u_calculadora within wi_mant_venpartidas
integer x = 823
integer y = 172
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From venpartidas
 Where  venpartidas.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,venpartidas.codigo)+1)
  Into   :sle_valor.text
  From   venpartidas
  Where  venpartidas.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type dw_familias from datawindow within wi_mant_venpartidas
boolean visible = false
integer x = 23
integer y = 696
integer width = 2281
integer height = 720
boolean bringtotop = true
string dataobject = "dw_venpartidas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String partida,familia
IF row = 0 Then Return
partida = sle_valor.text
familia = GetItemString(row,"codigo")
IF  f_venpartidas_familia(codigo_empresa,partida,familia) then
	delete from venpartidasfamilias
	where empresa = :codigo_empresa
	And   partida = :partida
	And   familia = :familia;
	COMMIT;
ELSE
	INSERT INTo venpartidasfamilias VALUES (:codigo_empresa,:partida,:familia);
	COMMIT;
END IF
dw_familias.SetItem(row,"empresa",codigo_empresa)
end event

type gb_1 from groupbox within wi_mant_venpartidas
integer x = 1230
integer y = 152
integer width = 1047
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

