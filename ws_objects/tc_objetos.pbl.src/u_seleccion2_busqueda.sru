$PBExportHeader$u_seleccion2_busqueda.sru
forward
global type u_seleccion2_busqueda from userobject
end type
type p_activar_busqueda from picture within u_seleccion2_busqueda
end type
type u_pb_buscar from picturebutton within u_seleccion2_busqueda
end type
type u_sle_texto from singlelineedit within u_seleccion2_busqueda
end type
type dw_1 from u_seleccion2 within u_seleccion2_busqueda
end type
end forward

global type u_seleccion2_busqueda from userobject
integer width = 2217
integer height = 1080
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event keydown pbm_keydown
p_activar_busqueda p_activar_busqueda
u_pb_buscar u_pb_buscar
u_sle_texto u_sle_texto
dw_1 dw_1
end type
global u_seleccion2_busqueda u_seleccion2_busqueda

type variables
Int busqueda_siguiente
String texto_anterior
end variables

forward prototypes
public function integer setsqlselect (string consulta)
public function integer settransobject (transaction tr1)
public function integer retrieve ()
public function integer devolver_seleccionados ()
public function string devolver_resultado ()
public function string devolver_resultado (integer v1, integer v2)
end prototypes

event keydown;if key = KeyF8! then
	p_activar_busqueda.triggerevent(clicked!)
elseif key = KeyEnter! or key = KeyTab! then 
	u_pb_buscar.triggerevent(clicked!)
end if
end event

public function integer setsqlselect (string consulta);return dw_1.SetSQLSelect(consulta)
end function

public function integer settransobject (transaction tr1);return dw_1.SetTransObject(tr1)
end function

public function integer retrieve ();return dw_1.retrieve()
end function

public function integer devolver_seleccionados ();return dw_1.devolver_seleccionados()
end function

public function string devolver_resultado ();return dw_1.devolver_resultado()
end function

public function string devolver_resultado (integer v1, integer v2);return dw_1.devolver_resultado(v1,v2)
end function

on u_seleccion2_busqueda.create
this.p_activar_busqueda=create p_activar_busqueda
this.u_pb_buscar=create u_pb_buscar
this.u_sle_texto=create u_sle_texto
this.dw_1=create dw_1
this.Control[]={this.p_activar_busqueda,&
this.u_pb_buscar,&
this.u_sle_texto,&
this.dw_1}
end on

on u_seleccion2_busqueda.destroy
destroy(this.p_activar_busqueda)
destroy(this.u_pb_buscar)
destroy(this.u_sle_texto)
destroy(this.dw_1)
end on

event constructor;busqueda_siguiente = 0
texto_anterior = ""
end event

type p_activar_busqueda from picture within u_seleccion2_busqueda
integer x = 2021
integer y = 16
integer width = 87
integer height = 72
string picturename = "C:\Tencer_PB12\Preview_32x32.png"
boolean focusrectangle = false
end type

event clicked;u_pb_buscar.visible = not(u_pb_buscar.visible)
u_sle_texto.visible = not(u_sle_texto.visible)
u_sle_texto.setfocus()
end event

type u_pb_buscar from picturebutton within u_seleccion2_busqueda
boolean visible = false
integer x = 1998
integer y = 952
integer width = 105
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Search_24x24.png"
alignment htextalign = left!
end type

event clicked;String busqueda, banda
Int resultado, posicion, fila_temporal

busqueda = u_sle_texto.text
if busqueda <> "" then
	if busqueda <> texto_anterior then
		busqueda_siguiente = 0
		texto_anterior = busqueda
	end if
	busqueda = "#4 LIKE '%"+busqueda+"%'"
	posicion = 0
	resultado = 1000
	fila_temporal = 1
	do while posicion <= busqueda_siguiente and resultado > 0
		resultado = dw_1.find(busqueda,fila_temporal,dw_1.RowCount())
		fila_temporal = resultado + 1
		posicion++
	loop
	if resultado > 0 then
		dw_1.collapseAll()
		dw_1.ScrollToRow(resultado)
		dw_1.SelectTreeNode(resultado, 2, true)
		dw_1.Expand(resultado, 1)
		busqueda_siguiente ++
	else	
		busqueda_siguiente = 0
	end if
	
end if
end event

type u_sle_texto from singlelineedit within u_seleccion2_busqueda
boolean visible = false
integer x = 69
integer y = 952
integer width = 1883
integer height = 92
integer taborder = 20
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

type dw_1 from u_seleccion2 within u_seleccion2_busqueda
integer taborder = 10
string dataobject = "dw_padre_seleccion_2tablas"
end type

