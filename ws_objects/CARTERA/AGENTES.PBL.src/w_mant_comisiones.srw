$PBExportHeader$w_mant_comisiones.srw
$PBExportComments$€ Ventana para mantenimiento de comisiones.
forward
global type w_mant_comisiones from wi_mvent_con_empresa
end type
type gb_claves from groupbox within w_mant_comisiones
end type
type gb_1 from groupbox within w_mant_comisiones
end type
type st_anyo from statictext within w_mant_comisiones
end type
type em_anyo from u_em_campo within w_mant_comisiones
end type
type st_factura from statictext within w_mant_comisiones
end type
type em_factura from u_em_campo within w_mant_comisiones
end type
type dw_2 from u_datawindow within w_mant_comisiones
end type
end forward

global type w_mant_comisiones from wi_mvent_con_empresa
integer width = 2981
integer height = 1684
gb_claves gb_claves
gb_1 gb_1
st_anyo st_anyo
em_anyo em_anyo
st_factura st_factura
em_factura em_factura
dw_2 dw_2
end type
global w_mant_comisiones w_mant_comisiones

type variables

end variables

forward prototypes
public subroutine f_refrescar ()
end prototypes

public subroutine f_refrescar ();long linea
IF em_anyo.text <> "" THEN
	dw_2.Retrieve(codigo_empresa,Long(em_anyo.text),Dec(em_factura.text))
	dw_2.visible = TRUE
	if dw_2.Rowcount() <>0 then
		linea = dw_2.GetItemNumber(1,"carcomisiones_linea")
		dw_1.Retrieve(codigo_empresa,Long(em_anyo.text),Dec(em_factura.text),linea)
		sle_valor.text = string(linea)
		f_activar_campo(sle_valor)
		sle_valor.TriggerEvent("tecla_enter")
	  else
		dw_1.reset()
	End if
END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Comisiones"
istr_parametros.s_listado         = "report_comisiones"
This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
em_anyo.text = string(year(today()))
f_activar_campo(em_factura)

// Si recibo la clave como parámetro, lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text    = istr_parametros.s_argumentos[2]
	em_factura.text = istr_parametros.s_argumentos[3]
	sle_valor.text  = istr_parametros.s_argumentos[4]
	IF (Trim(em_anyo.text)<>"" AND NOT IsNull(em_anyo.text)) AND (Trim(em_factura.text)<>"" AND NOT IsNull(sle_valor.text)) AND (Trim(sle_valor.text)<>"" AND NOT IsNull(sle_valor.text)) THEN
		
			w_mant_comisiones.triggerevent("ue_recuperar")
			
	END IF 
END IF

f_mascara_columna(dw_1,"carcomisiones_basecomision","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_importeliquidar","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_basecomisionpts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_importeliquidarpts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_baseliqui","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_comisionliqui","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_baseliquipts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_comisionliquipts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_impfra","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_importeliquidado","###,###,###.00")
f_mascara_columna(dw_1,"carcomisiones_impfrapts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_importeliquidadopts","###,###,##0.00")
f_mascara_columna(dw_1,"carcomisiones_gastos_fletes","###,###,##0")
f_mascara_columna(dw_1,"carcomisiones_comision","#,##0.00")





end event

event ue_inserta_fila;call super::ue_inserta_fila;IF Trim(f_valor_columna(dw_1,1,"carcomisiones_empresa")) = "" Then
 dw_1.setitem(dw_1.getrow(),"carcomisiones_empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"carcomisiones_anyo",Long(em_anyo.text))
 dw_1.setitem(dw_1.getrow(),"carcomisiones_factura",Dec(em_factura.text))
 dw_1.setitem(dw_1.getrow(),"carcomisiones_linea",Long(sle_valor.text))
 dw_1.setitem(dw_1.getrow(),"carcomisiones_control_fletes","N")
 dw_1.setitem(dw_1.getrow(),"carcomisiones_cobrado","N")
 dw_1.setitem(dw_1.getrow(),"carcomisiones_liquidado","N")
 dw_1.setitem(dw_1.getrow(),"carcomisiones_fletes","N")
 dw_1.setitem(dw_1.getrow(),"carcomisiones_n_comision",Long(sle_valor.text))
End if
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(em_anyo.text))
criterio[2]   =  trim(em_anyo.text)+space(20-longitud)

longitud      =  len(trim(em_factura.text))
criterio[3]   =  trim(em_factura.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[4]   =  trim(sle_valor.text)+space(20-longitud)


seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
tabla         =  "carcomisiones"

dw_1.Retrieve(codigo_empresa,Long(em_anyo.text),Dec(em_factura.text),Long(sle_valor.Text))

CALL Super::ue_recuperar
end event

on w_mant_comisiones.create
int iCurrent
call super::create
this.gb_claves=create gb_claves
this.gb_1=create gb_1
this.st_anyo=create st_anyo
this.em_anyo=create em_anyo
this.st_factura=create st_factura
this.em_factura=create em_factura
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_claves
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_anyo
this.Control[iCurrent+4]=this.em_anyo
this.Control[iCurrent+5]=this.st_factura
this.Control[iCurrent+6]=this.em_factura
this.Control[iCurrent+7]=this.dw_2
end on

on w_mant_comisiones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_claves)
destroy(this.gb_1)
destroy(this.st_anyo)
destroy(this.em_anyo)
destroy(this.st_factura)
destroy(this.em_factura)
destroy(this.dw_2)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;em_factura.enabled = False
end event

event ue_activa_claves;call super::ue_activa_claves;em_factura.enabled = True
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_comisiones
integer x = 14
integer y = 304
integer width = 2848
integer height = 772
string dataobject = "dw_mant_comisiones"
end type

event dw_1::key;str_wt_busquedas_salida resultado

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "carcomisiones_agente"
	bus_titulo     = "AYUDA SELECCION AGENTES"
	bus_datawindow = "dw_ayuda_venagentes"
	bus_filtro     = "" 

CASE "carcomisiones_cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_1::rbuttondown;str_wt_busquedas_salida resultado

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "carcomisiones_agente"
	bus_titulo     = "AYUDA SELECCION AGENTES"
	bus_datawindow = "dw_ayuda_venagentes"
	bus_filtro     = "" 

CASE "carcomisiones_cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;// calcula los campos de las comisiones
dec porc,base1,base2,base3,base4,comi1,comi2,comi3,comi4
String moneda,cliente
porc  = This.GetitemNumber(this.Getrow(),"carcomisiones_comision")

cliente = This.GetitemString(this.Getrow(),"carcomisiones_cliente")
moneda = f_moneda_genter(codigo_empresa,"C",cliente)
base1 = This.GetitemNumber(this.Getrow(),"carcomisiones_basecomision")
base2 = This.GetitemNumber(this.Getrow(),"carcomisiones_basecomisionpts")
base3 = This.GetitemNumber(this.Getrow(),"carcomisiones_baseliqui")
base4 = This.GetitemNumber(this.Getrow(),"carcomisiones_baseliquipts")

comi1 = Dec(String(((base1*porc)/100),f_mascara_moneda(moneda)))
comi2 = Dec(String(((base2*porc)/100),"###,###,##0.00"))
comi3 = Dec(String(((base3*porc)/100),f_mascara_moneda(moneda)))
comi4 = Dec(String(((base4*porc)/100),"###,###,##0.00"))

This.Setitem(This.GetRow(),"carcomisiones_importeliquidar",comi1)
This.Setitem(This.GetRow(),"carcomisiones_importeliquidarpts",comi2)
This.Setitem(This.GetRow(),"carcomisiones_comisionliqui",comi3)
This.Setitem(This.GetRow(),"carcomisiones_comisionliquipts",comi4)


end event

event dw_1::getfocus;call super::getfocus;dw_2.enabled = False
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_comisiones
integer x = 983
integer y = 184
integer width = 219
integer height = 84
string text = "Línea:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_comisiones
integer x = 1861
integer y = 200
integer width = 329
integer height = 76
end type

event cb_insertar::clicked;IF cb_Insertar.enabled=TRUE THEN

		String var_nacional,var_cliente,var_pais,var_serie,var_moneda
		
		dw_1.acceptText()
		var_cliente = dw_1.GetItemString(1,"carcomisiones_cliente")
		var_pais    = f_pais_genter(codigo_empresa,"C",var_cliente)
		var_serie   = f_serie_venclientes(codigo_empresa,var_cliente)
		var_moneda  = f_moneda_genter(codigo_empresa,"C",var_cliente)
		
		iF f_tipo_pais(dw_1.GetItemString(1,"carcomisiones_pais")) = "N" Then
	        var_nacional = "S"
        ELSE
	        var_nacional = "N"
      END IF

		dw_1.SetItem(1,"carcomisiones_nacional",var_nacional)
		dw_1.SetItem(1,"carcomisiones_pais",var_pais)
		dw_1.SetItem(1,"carcomisiones_serie",var_serie)
		dw_1.SetItem(1,"carcomisiones_moneda",var_moneda)
      dw_2.enabled = true		
End if
call super::clicked


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_comisiones
integer x = 2194
integer y = 200
integer width = 325
integer height = 76
end type

event cb_borrar::clicked;dw_2.enabled = True
call super::clicked
f_refrescar()
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_comisiones
integer x = 1198
integer y = 184
integer taborder = 20
alignment alignment = right!
string mask = "#######"
string displaydata = "ˆ"
end type

event sle_valor::modificado;call super::modificado;this.TriggerEvent("tecla_enter")
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_comisiones
integer x = 2519
integer y = 200
integer width = 320
integer height = 76
end type

event cb_salir::clicked;dw_2.enabled = True
call super::clicked
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_comisiones
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_comisiones
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_comisiones
integer width = 2834
end type

type gb_claves from groupbox within w_mant_comisiones
integer x = 32
integer y = 132
integer width = 1449
integer height = 164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_mant_comisiones
integer x = 1847
integer y = 156
integer width = 1001
integer height = 132
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_anyo from statictext within w_mant_comisiones
integer x = 41
integer y = 184
integer width = 160
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_mant_comisiones
integer x = 187
integer y = 184
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "<"
end type

type st_factura from statictext within w_mant_comisiones
integer x = 480
integer y = 184
integer width = 238
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Factura: "
alignment alignment = center!
boolean focusrectangle = false
end type

type em_factura from u_em_campo within w_mant_comisiones
event modified pbm_enmodified
integer x = 699
integer y = 184
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,#####,###"
string displaydata = "Ì"
end type

event modified;call super::modified;f_refrescar()
end event

type dw_2 from u_datawindow within w_mant_comisiones
boolean visible = false
integer x = 9
integer y = 1080
integer width = 2848
integer height = 372
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_lista_lineas_comi"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;Long	fila_ant

IF row = 0 OR isNull(row) THEN
	Return
ELSE
	// Iluminamos solo la línea seleccionada
	fila_ant = dw_2.GetSelectedRow(0)
	IF fila_ant <> 0 THEN
		dw_2.SelectRow(fila_ant, FALSE)
	END IF
	dw_2.SelectRow(row, TRUE)
	dw_2.SetRow(row)
	// Recupera la línea seleccionada para la clave
	sle_valor.text = string(dw_2.GetItemNumber(row,"carcomisiones_linea"))
	sle_valor.TriggerEvent("modificado")

END IF
end event

