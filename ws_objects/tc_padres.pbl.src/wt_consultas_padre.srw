$PBExportHeader$wt_consultas_padre.srw
forward
global type wt_consultas_padre from window
end type
type st_registros_padre from statictext within wt_consultas_padre
end type
type st_total_padre from statictext within wt_consultas_padre
end type
type pb_imprimir from picturebutton within wt_consultas_padre
end type
type pb_borrar from picturebutton within wt_consultas_padre
end type
type dw_montaje_filtro from datawindow within wt_consultas_padre
end type
type pb_1 from picturebutton within wt_consultas_padre
end type
type pb_reset from picturebutton within wt_consultas_padre
end type
type pb_anyadir1 from picturebutton within wt_consultas_padre
end type
type ddlb_operador from dropdownlistbox within wt_consultas_padre
end type
type ddlb_campo from dropdownlistbox within wt_consultas_padre
end type
type dw_datos from u_dw_consultas_padre within wt_consultas_padre
end type
type pb_salir from picturebutton within wt_consultas_padre
end type
type st_titulo from statictext within wt_consultas_padre
end type
type p_logo from picture within wt_consultas_padre
end type
type dw_filtro from u_dw_consultas_padre within wt_consultas_padre
end type
type pb_buscar from picturebutton within wt_consultas_padre
end type
type sle_valor1 from singlelineedit within wt_consultas_padre
end type
type em_fecha1 from editmask within wt_consultas_padre
end type
type sle_texto from singlelineedit within wt_consultas_padre
end type
type lb_lista from listbox within wt_consultas_padre
end type
end forward

global type wt_consultas_padre from window
integer width = 4398
integer height = 2828
boolean titlebar = true
string title = "Consulta de Diseño"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_cerrar_sin_abrir ( )
st_registros_padre st_registros_padre
st_total_padre st_total_padre
pb_imprimir pb_imprimir
pb_borrar pb_borrar
dw_montaje_filtro dw_montaje_filtro
pb_1 pb_1
pb_reset pb_reset
pb_anyadir1 pb_anyadir1
ddlb_operador ddlb_operador
ddlb_campo ddlb_campo
dw_datos dw_datos
pb_salir pb_salir
st_titulo st_titulo
p_logo p_logo
dw_filtro dw_filtro
pb_buscar pb_buscar
sle_valor1 sle_valor1
em_fecha1 em_fecha1
sle_texto sle_texto
lb_lista lb_lista
end type
global wt_consultas_padre wt_consultas_padre

type variables
int id_ventana_activa
long fila_inicial = 0

//Permisos
Boolean cerrar_sin_abrir
Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
boolean ib_control_acceso_pasado = false
end variables

forward prototypes
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
end prototypes

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);If arg_KeyFlags = 2 then
	choose case arg_key
		case KeyEnter!
		case KeyN!
		case KeyB!
			pb_borrar.triggerevent(clicked!)
		case KeyS!
		case KeyZ!
			pb_reset.triggerevent(clicked!)
	end choose		
else
	choose case arg_Key
		case KeyEnter!
		case KeyF2!
		case KeyF3!
		case KeyF4!
		case KeyF8!
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if


end subroutine

on wt_consultas_padre.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_registros_padre=create st_registros_padre
this.st_total_padre=create st_total_padre
this.pb_imprimir=create pb_imprimir
this.pb_borrar=create pb_borrar
this.dw_montaje_filtro=create dw_montaje_filtro
this.pb_1=create pb_1
this.pb_reset=create pb_reset
this.pb_anyadir1=create pb_anyadir1
this.ddlb_operador=create ddlb_operador
this.ddlb_campo=create ddlb_campo
this.dw_datos=create dw_datos
this.pb_salir=create pb_salir
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_filtro=create dw_filtro
this.pb_buscar=create pb_buscar
this.sle_valor1=create sle_valor1
this.em_fecha1=create em_fecha1
this.sle_texto=create sle_texto
this.lb_lista=create lb_lista
this.Control[]={this.st_registros_padre,&
this.st_total_padre,&
this.pb_imprimir,&
this.pb_borrar,&
this.dw_montaje_filtro,&
this.pb_1,&
this.pb_reset,&
this.pb_anyadir1,&
this.ddlb_operador,&
this.ddlb_campo,&
this.dw_datos,&
this.pb_salir,&
this.st_titulo,&
this.p_logo,&
this.dw_filtro,&
this.pb_buscar,&
this.sle_valor1,&
this.em_fecha1,&
this.sle_texto,&
this.lb_lista}
end on

on wt_consultas_padre.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_registros_padre)
destroy(this.st_total_padre)
destroy(this.pb_imprimir)
destroy(this.pb_borrar)
destroy(this.dw_montaje_filtro)
destroy(this.pb_1)
destroy(this.pb_reset)
destroy(this.pb_anyadir1)
destroy(this.ddlb_operador)
destroy(this.ddlb_campo)
destroy(this.dw_datos)
destroy(this.pb_salir)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_filtro)
destroy(this.pb_buscar)
destroy(this.sle_valor1)
destroy(this.em_fecha1)
destroy(this.sle_texto)
destroy(this.lb_lista)
end on

event open;
//cerrar_sin_abrir = false
//
////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	
//elseif permiso_ventana = 2 then
//	//OK acceso total
//	
//else
//	//Opción no contemplada -> Salir
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//end if
//
//if cerrar_sin_abrir = true then
//	this.Post Event ue_cerrar_sin_abrir()
//else
	
	//Codigo Ventana
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa;
	
//end if


end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

if not(ib_control_acceso_pasado) then
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
		//Compatibilidad permisos GNO con permisos Tencer		
		ib_control_acceso_pasado = true
	END IF
end if


end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event key;control_teclas (keyflags, key)

end event

type st_registros_padre from statictext within wt_consultas_padre
integer x = 3223
integer y = 12
integer width = 201
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 67108864
string text = "Regs."
boolean focusrectangle = false
end type

type st_total_padre from statictext within wt_consultas_padre
integer x = 3465
integer y = 12
integer width = 293
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_imprimir from picturebutton within wt_consultas_padre
integer x = 3589
integer y = 116
integer width = 146
integer height = 128
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir"
end type

event clicked;if dw_datos.rowcount() > 0 then
		f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from picturebutton within wt_consultas_padre
integer x = 3735
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Delete_24x24Gris.png"
boolean map3dcolors = true
string powertiptext = "Resetear Filtros"
end type

event clicked;dw_montaje_filtro.reset()
pb_anyadir1.TriggerEvent(Clicked!)




end event

type dw_montaje_filtro from datawindow within wt_consultas_padre
integer x = 46
integer y = 268
integer width = 4270
integer height = 252
integer taborder = 50
string title = "none"
string dataobject = "dwt_construccion_filtro"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type pb_1 from picturebutton within wt_consultas_padre
integer x = 3333
integer y = 116
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "Quitar Filtro"
end type

type pb_reset from picturebutton within wt_consultas_padre
integer x = 3881
integer y = 116
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Undo_24x24gris.png"
alignment htextalign = left!
string powertiptext = "Limpiar Filtro Actual"
end type

event clicked;
dw_filtro.reset()
dw_filtro.visible = false
sle_texto.text = ''
sle_texto.visible = false
pb_buscar.visible = false

lb_lista.Reset()
lb_lista.visible = false

em_fecha1.visible = false

sle_valor1.text = ''
sle_valor1.visible = false

ddlb_campo.SelectItem (0)
ddlb_operador.reset()
end event

type pb_anyadir1 from picturebutton within wt_consultas_padre
integer x = 3182
integer y = 116
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Filtro"
end type

type ddlb_operador from dropdownlistbox within wt_consultas_padre
integer x = 809
integer y = 136
integer width = 325
integer height = 752
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type ddlb_campo from dropdownlistbox within wt_consultas_padre
integer x = 50
integer y = 136
integer width = 731
integer height = 752
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_datos from u_dw_consultas_padre within wt_consultas_padre
event usr_dwnkey pbm_dwnkey
integer x = 46
integer y = 536
integer width = 4270
integer height = 2092
integer taborder = 20
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged; this.SelectRow ( 0, false)
 this.SelectRow ( currentrow, true)
end event

event retrieveend;call super::retrieveend;st_total_padre.text = string(dw_datos.rowcount(), "###,###,###")
end event

type pb_salir from picturebutton within wt_consultas_padre
integer x = 4160
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Log Out_24x24gris.png"
boolean map3dcolors = true
string powertiptext = "Salir (Esc)"
end type

event clicked;close(parent)


end event

type st_titulo from statictext within wt_consultas_padre
integer x = 41
integer y = 20
integer width = 3118
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within wt_consultas_padre
integer x = 3803
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_filtro from u_dw_consultas_padre within wt_consultas_padre
boolean visible = false
integer x = 1166
integer y = 236
integer width = 1682
integer height = 136
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;this.selectrow(row, not this.isselected(row))
end event

event retrieveend;call super::retrieveend;
this.Object.DataWindow.Detail.height = 70
this.Object.DataWindow.Header.Color = rgb(81, 98, 111) //rgb(243, 71, 84) //rgb(252, 141, 156)
this.Object.DataWindow.Detail.Color = rgb(209,209,209) //rgb(239, 239, 239)
//this.Object.DataWindow.Header.Color = rgb(81, 98, 111) //rgb(243, 71, 84) //rgb(252, 141, 156)
this.Object.#1.Color = rgb (221,69,66)

this.BringToTop = TRUE
if rowcount > 10 then
	this.height = 136 * 10
else 
	if	rowcount > 0 then
		this.height = 136 * rowcount 
	
	else 
		this.height = 136 
		
	end if
end if

end event

event doubleclicked;call super::doubleclicked;this.selectrow(row, true)
pb_anyadir1.triggerevent(clicked!)
end event

type pb_buscar from picturebutton within wt_consultas_padre
boolean visible = false
integer x = 2743
integer y = 136
integer width = 105
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Search_24x24.png"
alignment htextalign = left!
end type

event clicked;String busqueda
//Int fila_encontrada

busqueda = "#2 like '%"+sle_texto.text+"%'"
if sle_texto.text <> "" then
	dw_filtro.setfilter(busqueda)
	dw_filtro.filter()
else
	dw_filtro.setfilter("")
	dw_filtro.filter()	
end if


/*
busqueda = "#2 like '%"+sle_texto.text+"%'"
if busqueda <> "" then
	fila_encontrada = dw_filtro.find(busqueda, fila_inicial, dw_filtro.RowCount())
	dw_filtro.ScrollToRow(fila_encontrada)

	if fila_inicial <  dw_filtro.RowCount() then
		fila_inicial = fila_encontrada + 1
	else
		fila_inicial = 0
	end if
end if
*/


end event

type sle_valor1 from singlelineedit within wt_consultas_padre
boolean visible = false
integer x = 1175
integer y = 136
integer width = 389
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
borderstyle borderstyle = stylelowered!
end type

event modified;pb_buscar.triggerevent("clicked")
pb_anyadir1.triggerevent("clicked")

end event

type em_fecha1 from editmask within wt_consultas_padre
boolean visible = false
integer x = 1175
integer y = 136
integer width = 425
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type sle_texto from singlelineedit within wt_consultas_padre
boolean visible = false
integer x = 1175
integer y = 136
integer width = 1559
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;fila_inicial = 0
end event

event losefocus;pb_buscar.triggerevent("clicked")
end event

type lb_lista from listbox within wt_consultas_padre
boolean visible = false
integer x = 1179
integer y = 140
integer width = 1536
integer height = 344
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = styleraised!
end type

