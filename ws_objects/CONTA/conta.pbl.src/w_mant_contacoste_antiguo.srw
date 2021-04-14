$PBExportHeader$w_mant_contacoste_antiguo.srw
forward
global type w_mant_contacoste_antiguo from wi_mvent_con_empresa
end type
type gb_1 from groupbox within w_mant_contacoste_antiguo
end type
type gb_2 from groupbox within w_mant_contacoste_antiguo
end type
type pb_calculadora from u_calculadora within w_mant_contacoste_antiguo
end type
type gb_3 from groupbox within w_mant_contacoste_antiguo
end type
type st_2 from statictext within w_mant_contacoste_antiguo
end type
type em_seccion from u_em_campo within w_mant_contacoste_antiguo
end type
type st_seccion from statictext within w_mant_contacoste_antiguo
end type
type dw_lista from u_datawindow within w_mant_contacoste_antiguo
end type
end forward

global type w_mant_contacoste_antiguo from wi_mvent_con_empresa
integer width = 2281
integer height = 1640
gb_1 gb_1
gb_2 gb_2
pb_calculadora pb_calculadora
gb_3 gb_3
st_2 st_2
em_seccion em_seccion
st_seccion st_seccion
dw_lista dw_lista
end type
global w_mant_contacoste_antiguo w_mant_contacoste_antiguo

on w_mant_contacoste_antiguo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.pb_calculadora=create pb_calculadora
this.gb_3=create gb_3
this.st_2=create st_2
this.em_seccion=create em_seccion
this.st_seccion=create st_seccion
this.dw_lista=create dw_lista
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_calculadora
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_seccion
this.Control[iCurrent+7]=this.st_seccion
this.Control[iCurrent+8]=this.dw_lista
end on

on w_mant_contacoste_antiguo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.pb_calculadora)
destroy(this.gb_3)
destroy(this.st_2)
destroy(this.em_seccion)
destroy(this.st_seccion)
destroy(this.dw_lista)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Centros de Coste"
istr_parametros.s_listado        = "report_contacentros"
This.title = istr_parametros.s_titulo_ventana
dw_lista.SetTransObject(SQLCA)
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_seccion.text = istr_parametros.s_argumentos[2]
	st_seccion.text = f_nombre_contaseccion(codigo_empresa,Trim(em_seccion.text))
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,em_seccion.text,sle_valor.Text)
	 dw_lista.Retrieve(codigo_empresa,em_seccion.text)
	END IF
ELSE
	f_activar_campo(em_seccion)
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"seccion",em_seccion.text)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(em_seccion.text)+ space(20-longitud)
longitud      =  len(trim(em_seccion.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contaseccion"

dw_1.Retrieve(codigo_empresa,em_seccion.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
em_seccion.enabled = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
em_seccion.enabled = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_contacoste_antiguo
integer x = 46
integer y = 444
integer width = 1563
integer height = 296
string dataobject = "dw_contacoste"
end type

event dw_1::key;call super::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
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

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_contacoste_antiguo
integer x = 18
integer y = 308
integer width = 366
string text = "Subsección:"
alignment alignment = left!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_contacoste_antiguo
integer x = 1742
integer y = 452
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

event cb_insertar::clicked;call super::clicked;dw_lista.Retrieve(codigo_empresa,em_seccion.text)
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_contacoste_antiguo
integer x = 1746
integer y = 592
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_contacoste_antiguo
integer x = 402
integer y = 308
integer width = 384
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;IF Trim(em_seccion.text)="" THEN
	f_activar_campo(em_seccion)
	Return
END IF

ue_titulo ="AYUDA SELECCIÓN DE CENTROS DE COSTE"
ue_datawindow ="dw_ayuda_contacoste"
ue_filtro ="seccion = " + "'" + Trim(em_seccion.text) + "'"
isle_campo =this
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_contacoste_antiguo
integer x = 1746
integer y = 728
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_contacoste_antiguo
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_contacoste_antiguo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_contacoste_antiguo
end type

type gb_1 from groupbox within w_mant_contacoste_antiguo
integer x = 1728
integer y = 408
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

type gb_2 from groupbox within w_mant_contacoste_antiguo
integer x = 1733
integer y = 548
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

type pb_calculadora from u_calculadora within w_mant_contacoste_antiguo
integer x = 809
integer y = 308
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN 
	Return
END IF

IF Trim(em_seccion.text)="" THEN
	f_activar_campo(em_seccion)
	Return
END IF

// Calculamos el siguiente nº de subseccion para la seccion dada
Integer registros
String  sec

sec = Trim(em_seccion.text)
SELECT count(*)
	INTO  :registros
	FROM  contacoste
	WHERE contacoste.empresa = :codigo_empresa
	  AND contacoste.seccion = :sec
	USING SQLCA;
	
IF (registros=0) OR (SQLCA.SQLCode<>0) OR IsNull(registros) Then
	sle_valor.text="1"
ELSE
	SELECT max(convert(int,contacoste.codigo)+1)
	INTO  :sle_valor.text
	FROM  contacoste
	WHERE contacoste.empresa = :codigo_empresa
	  AND contacoste.seccion = :sec
	USING SQLCA;
END IF
dw_1.TriggerEvent("Clicked")
end event

type gb_3 from groupbox within w_mant_contacoste_antiguo
integer x = 1733
integer y = 684
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

type st_2 from statictext within w_mant_contacoste_antiguo
integer x = 128
integer y = 180
integer width = 256
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
string text = "Sección:"
boolean focusrectangle = false
end type

type em_seccion from u_em_campo within w_mant_contacoste_antiguo
integer x = 402
integer y = 176
integer taborder = 10
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCIÓN DE SECCIONES"
ue_datawindow ="dw_ayuda_contaseccion"
ue_filtro =""
isle_campo =this
valor_empresa = TRUE
end event

event modificado;call super::modificado;// Cada vez que cambiamos la seccion, habrá que seleccionar de nuevo la
// subsección. Para ello se inicializa.
dw_1.Reset()
dw_lista.Reset()
cb_borrar.enabled = FALSE
sle_valor.text = ""

st_seccion.text = f_nombre_contaseccion(codigo_empresa,Trim(em_seccion.text))
IF Trim(st_seccion.text)="" THEN
	em_seccion.text = ""
	st_seccion.text = ""
	sle_valor.text = ""
	f_activar_campo(em_seccion)
	Return
END IF

dw_lista.Retrieve(codigo_empresa,em_seccion.text)
end event

type st_seccion from statictext within w_mant_contacoste_antiguo
integer x = 681
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

type dw_lista from u_datawindow within w_mant_contacoste_antiguo
integer x = 46
integer y = 764
integer width = 1568
integer height = 624
string dataobject = "dw_lista_subsecciones"
boolean border = false
end type

