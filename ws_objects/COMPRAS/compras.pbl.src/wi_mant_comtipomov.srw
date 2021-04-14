$PBExportHeader$wi_mant_comtipomov.srw
forward
global type wi_mant_comtipomov from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_comtipomov
end type
end forward

global type wi_mant_comtipomov from wi_mvent_con_empresa
integer width = 2377
integer height = 1132
string icon = "\bmp\RINO.ICO"
pb_calculadora pb_calculadora
end type
global wi_mant_comtipomov wi_mant_comtipomov

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"tipomov",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"tipo","V")
   dw_1.setitem(dw_1.getrow(),"interno","N")
end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de tipos de movimientos"
	istr_parametros.s_listado         = "report_almtipomov"
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

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "comtipomov"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_comtipomov.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_comtipomov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_comtipomov
integer x = 69
integer y = 384
integer width = 1742
integer height = 444
string dataobject = "dw_comtipomov"
end type

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_grupo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_almgrupos,lstr_param)  
End Choose
end event

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "grupo"
		bus_titulo     = "VENTANA SELECCION DE GRUPOS"
 		bus_datawindow = "dw_ayuda_almgrupos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "grupo"
      bus_titulo     = "VENTANA SELECCION DE GRUPOS"
 		bus_datawindow = "dw_ayuda_almgrupos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_comtipomov
integer x = 302
integer y = 268
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_comtipomov
integer x = 1865
integer y = 388
end type

event cb_insertar::clicked;IF dw_1.GetRow() <> 0 Then
	 dw_1.AcceptText()
	 String var_descripcion,var_resumido,var_codcli,var_tipoalm,des_codcli,des_tipoalm
	 var_descripcion  = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	 var_resumido     = dw_1.GetItemString(dw_1.GetRow(),"resumido")
	if cb_insertar.enabled = TRUE THEN
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			  MessageBox("Campo Obligatorio","Introduzca la descripcion del tipo de movimiento",Exclamation!,Ok!,1)
				dw_1.SetColumn("descripcion")
		  dw_1.SetFocus()
		  Return
		 END IF
		If Trim(var_resumido) = ""  or ISNULL(var_resumido) Then
		  MessageBox("Campo Obligatorio","Introduzca el resumido del tipo de movimiento",Exclamation!,Ok!,1)
		  dw_1.SetColumn("resumido")
		  dw_1.SetFocus()
		  Return
		END IF
	END IF
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_comtipomov
integer x = 1865
integer y = 516
string text = "&Borrar  "
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_comtipomov
integer x = 581
integer y = 264
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_comtipomov"
ue_titulo      = "AYUDA SELECCION DE TIPOS MOVIMENTOS DE COMPRAS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_comtipomov
integer x = 1865
integer y = 644
fontcharset fontcharset = defaultcharset!
string text = "&Salir    "
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_comtipomov
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_comtipomov
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_comtipomov
integer x = 27
integer width = 2240
integer height = 100
integer textsize = -14
fontcharset fontcharset = defaultcharset!
long textcolor = 128
end type

type pb_calculadora from u_calculadora within wi_mant_comtipomov
integer x = 846
integer y = 260
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   comtipomov
 Where  comtipomov.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,comtipomov.tipomov)+1)
  Into   :sle_valor.text
  From   comtipomov
  Where  comtipomov.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

