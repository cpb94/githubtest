$PBExportHeader$w_mant_venfamilias.srw
forward
global type w_mant_venfamilias from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_venfamilias
end type
type gb_3 from groupbox within w_mant_venfamilias
end type
type gb_2 from groupbox within w_mant_venfamilias
end type
type gb_1 from groupbox within w_mant_venfamilias
end type
type st_2 from statictext within w_mant_venfamilias
end type
type em_producto from u_em_campo within w_mant_venfamilias
end type
type st_producto from statictext within w_mant_venfamilias
end type
end forward

global type w_mant_venfamilias from wi_mvent_con_empresa
integer width = 2373
integer height = 1224
string icon = "\bmp\RINO.ICO"
pb_calculadora pb_calculadora
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
st_2 st_2
em_producto em_producto
st_producto st_producto
end type
global w_mant_venfamilias w_mant_venfamilias

on w_mant_venfamilias.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_2=create st_2
this.em_producto=create em_producto
this.st_producto=create st_producto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_producto
this.Control[iCurrent+7]=this.st_producto
end on

on w_mant_venfamilias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.em_producto)
destroy(this.st_producto)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Familias"
istr_parametros.s_listado        = "report_venfamilias"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_producto.text = istr_parametros.s_argumentos[2]
	st_producto.text = f_nombre_materia(codigo_empresa,Trim(em_producto.text))
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,em_producto.text,sle_valor.Text)
	END IF
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"tipo_materia",em_producto.text)
 dw_1.setitem(dw_1.getrow(),"familia",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_producto.text))
criterio[2]   =  trim(em_producto.text)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "venfamilias"

dw_1.Retrieve(codigo_empresa,em_producto.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
em_producto.enabled = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
em_producto.enabled = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_venfamilias
integer x = 32
integer y = 464
integer width = 2231
integer height = 524
string dataobject = "dw_venfamilias"
borderstyle borderstyle = stylelowered!
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cuenta"
      	bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES"
 		bus_datawindow = "dw_ayuda_contaplan"
		bus_filtro     = "ejercicio = " + String(f_ejercicio_activo(codigo_empresa))
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::clicked;call super::clicked;string 			ls_objeto
str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_venmateria"

CHOOSE CASE f_objeto_datawindow(dw_1)
  
	CASE 'pb_cuenta'
		lstr_param.s_argumentos[2] = String(f_ejercicio_activo(codigo_empresa))
		lstr_param.s_argumentos[3] = GetItemString(This.GetRow(),"cuenta")
		OpenWithParm(wi_mant_contaplan,lstr_param) 
 
END CHOOSE





end event

event dw_1::rbuttondown;call super::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipocta"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES "
 		bus_datawindow = "dw_ayuda_contaplan"
		bus_filtro     = "ejercicio = " + String(f_ejercicio_activo(codigo_empresa))
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_venfamilias
integer x = 96
integer y = 308
integer width = 251
string text = "Código:"
alignment alignment = left!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_venfamilias
integer x = 969
integer y = 304
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

event cb_insertar::clicked;String	ls_cuenta

IF cb_insertar.enabled THEN
	dw_1.AcceptText()
	ls_cuenta = Trim(dw_1.GetItemString(dw_1.GetRow(),"cuenta"))

	IF ls_cuenta <> "" then
		IF NOT f_existe_cuenta(f_ejercicio_activo(codigo_empresa),codigo_empresa,ls_cuenta) THEN
			f_mensaje("Error de Datos","La cuenta contable no existe.")
			dw_1.SetColumn("cuenta")
			Return
		END IF
	END IF
	Call Super::clicked
ELSE
	Call Super::clicked
END IF

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_venfamilias
integer x = 1403
integer y = 304
integer width = 389
integer textsize = -10
string facename = "Arial"
string text = "&Borrar  "
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_venfamilias
integer x = 352
integer y = 308
integer width = 384
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;IF Trim(em_producto.text)="" THEN
	f_activar_campo(em_producto)
	Return
END IF

ue_titulo ="AYUDA SELECCIÓN DE FAMILIAS"
ue_datawindow ="dw_ayuda_venfamilias"
ue_filtro ="tipo_materia = " + "'" + Trim(em_producto.text) + "'"
isle_campo =this
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_venfamilias
integer x = 1838
integer y = 304
integer width = 389
integer textsize = -10
fontcharset fontcharset = defaultcharset!
string facename = "Arial"
string text = "&Salir    "
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_venfamilias
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_venfamilias
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_venfamilias
integer x = 23
integer y = 40
integer height = 100
integer textsize = -14
fontcharset fontcharset = defaultcharset!
long textcolor = 128
end type

type pb_calculadora from u_calculadora within w_mant_venfamilias
integer x = 750
integer y = 304
integer taborder = 0
vtextalign vtextalign = vcenter!
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN 
	Return
END IF

IF Trim(em_producto.text)="" THEN
	f_activar_campo(em_producto)
	Return
END IF

// Calculamos el siguiente nº de familia para el producto dado
Integer registros
String  produc

produc = Trim(em_producto.text)
SELECT count(*)
	INTO  :registros
	FROM  venfamilias
	WHERE venfamilias.empresa = :codigo_empresa
	  AND venfamilias.tipo_materia = :produc
	USING SQLCA;
	
IF (registros=0) OR (SQLCA.SQLCode<>0) OR IsNull(registros) Then
	sle_valor.text="1"
ELSE
	SELECT max(convert(int,venfamilias.familia)+1)
	INTO  :sle_valor.text
	FROM  venfamilias
	WHERE venfamilias.empresa = :codigo_empresa
	  AND venfamilias.tipo_materia = :produc
	USING SQLCA;
END IF
dw_1.TriggerEvent("Clicked")
end event

type gb_3 from groupbox within w_mant_venfamilias
integer x = 1819
integer y = 260
integer width = 421
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mant_venfamilias
integer x = 1390
integer y = 260
integer width = 416
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_mant_venfamilias
integer x = 955
integer y = 260
integer width = 421
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_2 from statictext within w_mant_venfamilias
integer x = 41
integer y = 180
integer width = 315
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Producto:"
boolean focusrectangle = false
end type

type em_producto from u_em_campo within w_mant_venfamilias
integer x = 352
integer y = 176
integer taborder = 10
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCIÓN DE PRODUCTOS"
ue_datawindow ="dw_ayuda_venmateria"
ue_filtro =""
isle_campo =this
valor_empresa = TRUE
end event

event modificado;call super::modificado;// Cada vez que cambiamos el producto, habrá que seleccionar de nuevo la
// familia. Para ello se inicializa.
dw_1.Reset()
cb_borrar.enabled = FALSE
sle_valor.text = ""

st_producto.text = f_nombre_materia(codigo_empresa,Trim(em_producto.text))
IF Trim(st_producto.text)="" THEN
	em_producto.text = ""
	st_producto.text = ""
	sle_valor.text = ""
	f_activar_campo(em_producto)
	Return
END IF
end event

type st_producto from statictext within w_mant_venfamilias
integer x = 631
integer y = 176
integer width = 1184
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

