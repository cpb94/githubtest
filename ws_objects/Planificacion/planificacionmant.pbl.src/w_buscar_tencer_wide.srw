$PBExportHeader$w_buscar_tencer_wide.srw
forward
global type w_buscar_tencer_wide from window
end type
type cb_salir from commandbutton within w_buscar_tencer_wide
end type
type cb_1 from commandbutton within w_buscar_tencer_wide
end type
type sle_cadena from singlelineedit within w_buscar_tencer_wide
end type
type ddlb_campo from dropdownlistbox within w_buscar_tencer_wide
end type
type dw_1 from datawindow within w_buscar_tencer_wide
end type
end forward

global type w_buscar_tencer_wide from window
integer x = 1056
integer y = 484
integer width = 3378
integer height = 1580
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 80269524
event ue_cerrar_sin_abrir ( )
cb_salir cb_salir
cb_1 cb_1
sle_cadena sle_cadena
ddlb_campo ddlb_campo
dw_1 dw_1
end type
global w_buscar_tencer_wide w_buscar_tencer_wide

type variables
datawindow DW
Boolean cerrar_sin_abrir
boolean ib_control_acceso_pasado = FALSE
string is_permiso_altas = 'N', is_permiso_bajas = 'N', is_permiso_cambios = 'N', is_permiso_consultas = 'N'
int    permiso_ventana
end variables

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

on w_buscar_tencer_wide.create
this.cb_salir=create cb_salir
this.cb_1=create cb_1
this.sle_cadena=create sle_cadena
this.ddlb_campo=create ddlb_campo
this.dw_1=create dw_1
this.Control[]={this.cb_salir,&
this.cb_1,&
this.sle_cadena,&
this.ddlb_campo,&
this.dw_1}
end on

on w_buscar_tencer_wide.destroy
destroy(this.cb_salir)
destroy(this.cb_1)
destroy(this.sle_cadena)
destroy(this.ddlb_campo)
destroy(this.dw_1)
end on

event open;string articulo

// DW está declarada como variable de
DW = Message.PowerObjectParm
cerrar_sin_abrir = false

if DW.Getrow() > 0 then
	articulo = DW.object.cod_articulo[DW.Getrow()]
else
	MESSAGEBOX("Atención",nombre_usuario+", No hay filas que buscar en la planificación")
	cerrar_sin_abrir = true
end if


Dw_1.SetTransObject(SQLCA)
ddlb_campo.text = "Código Artículo"

//nombre_ventana = "w_planificacion_tencer_wide" //Los permisos de usuario los hereda de esta ventana
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;


//this.Post Event ue_cerrar_sin_abrir()

end event

event activate;if not(ib_control_acceso_pasado) then
	IF guo_menu_utigrupos.of_menu_leer_permiso (gs_usuarios_v_grupo, codigo_empresa, This.ClassName (), 'activo') = '0' THEN
		MessageBox ("Permisos", "NO tiene permisos para acceder a esta ventana¡", StopSign!)
		Close (this)
	ELSE
		//Compatibilidad permisos GNO con permisos Tencer
		guo_menu_utigrupos.of_menu_leer_permiso_total(gs_usuarios_v_grupo,codigo_empresa,This.ClassName(),is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas)
		
		if is_permiso_altas = 'S' or is_permiso_bajas = 'S' or is_permiso_cambios = 'S' then
			permiso_ventana = 2 //Permisos escritura
		else
			if is_permiso_consultas = 'S' then
				permiso_ventana = 1 //Permisos lectura
			else
				permiso_ventana = 0 //Sin permisos
			end if
		end if
		
		If permiso_ventana = 0 then
			MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
			cb_1.visible = false
//			cb_2.visible = false
			cb_salir.visible = true
			cerrar_sin_abrir = true
		elseif permiso_ventana = 1 then
			//Solo lectura
//			cb_2.visible = false
		elseif permiso_ventana = 2 then
			//OK acceso total
			
		else
			//Opción no contemplada -> Salir
			MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
			cb_1.visible = false
//			cb_2.visible = false
			cb_salir.visible = true
			cerrar_sin_abrir = true
		end if		
		
		//Compatibilidad permisos GNO con permisos Tencer		
		ib_control_acceso_pasado = true
	END IF
end if
end event

type cb_salir from commandbutton within w_buscar_tencer_wide
boolean visible = false
integer x = 2546
integer y = 40
integer width = 489
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(Parent)
end event

type cb_1 from commandbutton within w_buscar_tencer_wide
integer x = 2734
integer y = 40
integer width = 494
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;string codigo, descripcion


dw_1.SetFilter("")
dw_1.Filter()

if sle_cadena.text <> "" and not isnull(sle_cadena.text) then
	choose case ddlb_campo.text 
		case "Descripción Artículo"
			descripcion = "%"+sle_cadena.text+"%"
			dw_1.SetFilter("articulos_descripcion like '"+descripcion+"'")
			dw_1.Filter()
			dw_1.retrieve(codigo_empresa)
		case "Código Artículo"
			dw_1.SetFilter("planificacion_cod_articulo = '"+sle_cadena.text+"'")
			dw_1.Filter()
			dw_1.retrieve(codigo_empresa)
		case "Lote"
			dw_1.SetFilter("planificacion_lote = '"+sle_cadena.text+"'")
			dw_1.Filter()
			dw_1.retrieve(codigo_empresa)			
	end choose
end if


end event

type sle_cadena from singlelineedit within w_buscar_tencer_wide
integer x = 1047
integer y = 48
integer width = 1646
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type ddlb_campo from dropdownlistbox within w_buscar_tencer_wide
integer x = 87
integer y = 44
integer width = 878
integer height = 316
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 2
string item[] = {"Código Artículo","Descripción Artículo","Lote"}
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_buscar_tencer_wide
integer x = 27
integer y = 196
integer width = 3319
integer height = 1288
integer taborder = 30
string dataobject = "dw_buscar_wide"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;long v_ot, fila_seleccionada
string cod_linea, linea

if dw_1.RowCount() > 0 then
	v_ot = dw_1.object.planificacion_ot[row]
	linea = dw_1.object.prodlineas_resumido[row]
	
	select codigo 
	into :cod_linea
	from prodlineas
	where resumido = :linea
	and empresa = :codigo_empresa;
	
	DW.retrieve(codigo_empresa,cod_linea)
	fila_seleccionada = DW.Find ("ot = "+string(v_ot), 1, DW.RowCount() )
	DW.SelectRow ( fila_seleccionada, true )
	DW.ScrollToRow ( fila_seleccionada)
	
	w_planificacion_tencer_wide.uo_1.em_codigo.text = cod_linea
	w_planificacion_tencer_wide.uo_1.em_campo.text = linea

	close(parent)
end if
end event

