$PBExportHeader$wi_mant_prodperdidastipolinea.srw
forward
global type wi_mant_prodperdidastipolinea from wi_mvent_con_empresa
end type
type ddlb_tipo_linea from dropdownlistbox within wi_mant_prodperdidastipolinea
end type
end forward

global type wi_mant_prodperdidastipolinea from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2437
integer height = 2232
ddlb_tipo_linea ddlb_tipo_linea
end type
global wi_mant_prodperdidastipolinea wi_mant_prodperdidastipolinea

type variables

end variables

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Perdidas segun Tipo de Linea"

This.title = istr_parametros.s_titulo_ventana
tipo_mantenimiento = "C"
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

event ue_inserta_fila;datastore formatos
string sel
long   indice,total,donde
 
if dw_1.rowcount() = 0 then 	
	sel = "select codigo,descripcion from formatos where empresa = '"+codigo_empresa+"' "+&
			"order by descripcion "
	
	//formatos = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, formatos)
	total = formatos.rowcount()
	dw_1.setredraw(false)
	for indice = 1 to total
		donde = dw_1.insertrow(0)
		dw_1.object.empresa[donde]        = codigo_empresa
		dw_1.object.tipo_linea[donde]     = sle_valor.text	
		dw_1.object.formato[donde]        = formatos.object.codigo[indice]
		dw_1.object.nombre_formato[donde] = formatos.object.descripcion[indice]
		dw_1.object.perdidas[donde]       = 0
	next

	dw_1.setredraw(true)
	dw_1.sort()
	dw_1.groupcalc()
end if

destroy formatos
end event

event ue_recuperar;datastore formatos
string sel,formato
long   indice,total,donde

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodperdidastipolinea"

total = dw_1.Retrieve(codigo_empresa,sle_valor.Text)
if total > 0 then
	dw_1.setredraw(false)
	for indice = 1 to total
		formato = dw_1.object.formato[indice]	
		dw_1.object.nombre_formato[indice]= f_nombre_formato(codigo_empresa,formato)
	next
		 
	sel = "select codigo,descripcion from formatos where empresa = '"+codigo_empresa+"' "+&
			"and codigo not in (select formato from prodperdidastipolinea "+&
			"where empresa = '"+codigo_empresa+"' "+&
			"and   tipo_linea = '"+sle_valor.text+"') "+&
			"order by descripcion "	
	//formatos = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, formatos)
	total = formatos.rowcount()
	for indice = 1 to total
		donde = dw_1.insertrow(0)
		dw_1.object.empresa[donde]        = codigo_empresa
		dw_1.object.tipo_linea[donde]     = sle_valor.text	
		dw_1.object.formato[donde]        = formatos.object.codigo[indice]
		dw_1.object.nombre_formato[donde] = formatos.object.descripcion[indice]
		dw_1.object.perdidas[donde]       = 0
	next
	destroy formatos		
	dw_1.setredraw(true)
	dw_1.sort()
	dw_1.groupcalc()
end if
CALL Super::ue_recuperar
end event

on wi_mant_prodperdidastipolinea.create
int iCurrent
call super::create
this.ddlb_tipo_linea=create ddlb_tipo_linea
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_tipo_linea
end on

on wi_mant_prodperdidastipolinea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_tipo_linea)
end on

event ue_activa_claves;call super::ue_activa_claves;ddlb_tipo_linea.enabled = true
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;ddlb_tipo_linea.enabled = false
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodperdidastipolinea
integer x = 41
integer y = 288
integer width = 1257
integer height = 1628
string dataobject = "dw_mant_prodperdidastipolinea"
boolean vscrollbar = true
end type

event dw_1::rbuttondown;call super::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
END CHOOSE
end event

event dw_1::key;call super::key; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodperdidastipolinea
boolean visible = false
integer x = 59
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodperdidastipolinea
integer x = 576
integer y = 172
integer width = 361
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodperdidastipolinea
boolean visible = false
integer x = 1047
integer y = 172
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodperdidastipolinea
boolean visible = false
integer x = 549
integer y = 172
integer width = 87
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "!"
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = ""
ue_titulo      = ""
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodperdidastipolinea
integer x = 937
integer y = 172
integer width = 361
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodperdidastipolinea
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodperdidastipolinea
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodperdidastipolinea
integer width = 2437
end type

type ddlb_tipo_linea from dropdownlistbox within wi_mant_prodperdidastipolinea
integer x = 46
integer y = 172
integer width = 507
integer height = 356
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Prensa","Esmaltadora","Horno"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case this.text
	case "Prensa"
		sle_valor.text = "P"
	case "Esmaltadora"
		sle_valor.text = "E"
	case "Horno"
		sle_valor.text = "H"
end choose
dw_1.triggerevent("clicked")
end event

