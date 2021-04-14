$PBExportHeader$wi_mant_seglinventas.srw
forward
global type wi_mant_seglinventas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_seglinventas
end type
type st_3 from statictext within wi_mant_seglinventas
end type
type em_anyo from u_em_campo within wi_mant_seglinventas
end type
type gb_1 from groupbox within wi_mant_seglinventas
end type
end forward

global type wi_mant_seglinventas from wi_mvent_con_empresa
integer width = 2926
integer height = 1672
pb_calculadora pb_calculadora
st_3 st_3
em_anyo em_anyo
gb_1 gb_1
end type
global wi_mant_seglinventas wi_mant_seglinventas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;	tipo_mantenimiento = "N"

   istr_parametros.s_titulo_ventana = "Mantenimiento de lineas ventas"
	istr_parametros.s_listado        = "report_seglinventas"
   This.title = istr_parametros.s_titulo_ventana
	em_anyo.text = String(Year(Today()))

      f_mascara_columna(dw_1,"recibo",f_mascara_decimales(0))
 
   // Si recibo el codigo lo visualizo
   
	IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF len(sle_valor.text) <> 0  and len(em_anyo.text)<> 0 Then
       This.TriggerEvent("ue_recuperar")
		 f_activar_campo(sle_valor)
      END IF
   END IF
	
	
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
em_anyo.enabled        = TRUE

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
em_anyo.enabled        = FALSE

end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"anyo",Dec(em_anyo.text))
   dw_1.setitem(dw_1.getrow(),"orden",Dec(sle_valor.text))
   dw_1.setitem(dw_1.getrow(),"moneda","5")
   dw_1.setitem(dw_1.getrow(),"declarado","N")
   dw_1.setitem(dw_1.getrow(),"situacion","1")
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  trim(em_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         = "seglinventas"
dw_1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.Text))
CALL Super::ue_recuperar
end event

on wi_mant_seglinventas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.st_3=create st_3
this.em_anyo=create em_anyo
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.gb_1
end on

on wi_mant_seglinventas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.st_3)
destroy(this.em_anyo)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_seglinventas
integer x = 14
integer y = 276
integer width = 2784
integer height = 1120
string dataobject = "dw_seglinventas"
end type

event dw_1::rbuttondown; valor_empresa = TRUE
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "moneda"
      bus_titulo     = "VENTANA SELECCION DE MONEDAS"
 		bus_datawindow = "dw_ayuda_divisas"
		valor_empresa = FALSE 
	CASE "companyia"
	   bus_titulo     = "VENTANA SELECCION DE COMPAÑIAS"
 		bus_datawindow = "dw_ayuda_segcompanyias"
	CASE "forma_pago"
      bus_titulo     = "VENTANA SELECCION DE FORMAS DE PAGO "
 		bus_datawindow = "dw_ayuda_carforpag"		 
 	CASE "cuenta"
	   bus_titulo     = "VENTANA SELECCION DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = " ejercicio = " + String(f_ejercicio_activo(codigo_empresa))		 		 
   CASE "cliente"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_clientes"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"cliente")
f_valores_numericos(dw_1,"cuenta")
f_valores_numericos(dw_1,"companyia")
f_valores_numericos(dw_1,"moneda")

end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "moneda"
      bus_titulo     = "VENTANA SELECCION DE MONEDAS "
		bus_datawindow = "dw_ayuda_divisas"
      valor_empresa = FALSE
   CASE "forma_pago"
      bus_titulo     = "VENTANA SELECCION DE FORMAS DE PAGO "
 		bus_datawindow = "dw_ayuda_carforpag"
	CASE "companyia"
	   bus_titulo     = "VENTANA SELECCION DE COMPAÑIAS"
 		bus_datawindow = "dw_ayuda_segcompanyias"
 	CASE "cuenta"
	   bus_titulo     = "VENTANA SELECCION DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = " ejercicio = " + String(f_ejercicio_activo(codigo_empresa))		 
   CASE "cliente"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_clientes"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_seglinventas"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_cliente'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   OpenWithParm(wi_mant_clientes2,lstr_param)  
CASE 'pb_forma_pago'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)  
CASE 'pb_companyia'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"companyia")
   OpenWithParm(wi_mant_segcompanyias,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
END CHOOSE





end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;IF GetRow() = 0 Then Return
f_mascara_columna(This,"importe",f_mascara_moneda(f_valor_columna(This,GetRow(),"moneda")))
IF Dec(f_valor_columna(This,GetRow(),"cambiofra"))= 0 Then
	f_asignar_columna(This,GetRow(),"cambiofra",String(f_cambio_moneda(f_valor_columna(This,GetRow(),"moneda"))))
END IF
IF len(f_valor_columna(This,GetRow(),"cuenta"))= 0 Then
dw_1.setitem(dw_1.getrow(),"cuenta",f_cuenta_genter(codigo_empresa,"C",f_valor_columna(This,GetRow(),"cliente")))
END IF
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_seglinventas
integer x = 672
integer y = 176
integer width = 219
integer height = 84
string text = "Orden:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_seglinventas
integer x = 1623
integer y = 180
integer width = 389
integer height = 76
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_seglinventas
integer x = 2011
integer y = 180
integer width = 389
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_seglinventas
integer x = 901
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;      isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_seglinventas
integer x = 2400
integer y = 180
integer width = 389
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_seglinventas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_seglinventas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_seglinventas
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_seglinventas
integer x = 1161
integer y = 168
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
Dec{0} var_anyo
var_anyo =   Dec(em_anyo.text)

 Integer registros
 Select count(*) Into :registros From seglinventas
 Where  seglinventas.empresa = :codigo_empresa
 and    seglinventas.anyo   =  :var_anyo;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,seglinventas.orden)+1)
  Into   :sle_valor.text
  From   seglinventas
  Where  seglinventas.empresa = :codigo_empresa
  And    seglinventas.anyo    = :var_anyo;

 END IF
 dw_1.TriggerEvent("Clicked")
end event

type st_3 from statictext within wi_mant_seglinventas
integer x = 206
integer y = 176
integer width = 165
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within wi_mant_seglinventas
integer x = 389
integer y = 176
integer taborder = 0
end type

type gb_1 from groupbox within wi_mant_seglinventas
integer x = 1609
integer y = 144
integer width = 1193
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

