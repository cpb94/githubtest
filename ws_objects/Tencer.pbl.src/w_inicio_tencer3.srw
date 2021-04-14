$PBExportHeader$w_inicio_tencer3.srw
forward
global type w_inicio_tencer3 from w_ventana_padre_inicio
end type
type st_titulo from statictext within w_inicio_tencer3
end type
type dw_menu1 from datawindow within w_inicio_tencer3
end type
type dw_navegacion from datawindow within w_inicio_tencer3
end type
end forward

global type w_inicio_tencer3 from w_ventana_padre_inicio
integer width = 1477
integer height = 3196
string title = "Menu Principal"
string menuname = "mi_menu_generico"
boolean maxbox = false
windowstate windowstate = normal!
long backcolor = 32172778
st_titulo st_titulo
dw_menu1 dw_menu1
dw_navegacion dw_navegacion
end type
global w_inicio_tencer3 w_inicio_tencer3

type variables
String control_activo
Long alto_inicial_dw_menu1, ancho_inicial_dw_menu1, ancho_inicial_ventana, id_ventana_activa
end variables

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_tencer3.create
int iCurrent
call super::create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_titulo=create st_titulo
this.dw_menu1=create dw_menu1
this.dw_navegacion=create dw_navegacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_titulo
this.Control[iCurrent+2]=this.dw_menu1
this.Control[iCurrent+3]=this.dw_navegacion
end on

on w_inicio_tencer3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_titulo)
destroy(this.dw_menu1)
destroy(this.dw_navegacion)
end on

event open;call super::open;String errores, grupo
str_ventanas_activas actual
Long numero_elementos, elementos, nivel
Long color_fondo, color_resaltado, color_inicio, color_fin, alto_maximo

this.title = this.title + "   -   " + f_nombre_empresa(codigo_empresa)

//Color Rojo
//color_fondo = rgb(250,140,150)//rgb(255,76,82)//rgb(255,63,70)//rgb(243,71,84)250,140, 150
//color_resaltado = rgb(255,76,82)//rgb(242,21,21)//rgb(255,50,50)

//Color Gris
color_fondo = rgb(209,209,209)
color_resaltado = rgb(234,38,41)//rgb(242,21,21) //rgb(255,255,255)
color_inicio = color_fondo
color_fin = color_fondo//rgb(255,211,214)

dw_navegacion.SetTrans(sqlca)
dw_navegacion.retrieve()

dw_navegacion.InsertRow(0)
nivel = 1
dw_navegacion.object.descripcion[nivel] = "Menú Principal"
dw_navegacion.object.codigo[nivel] = 0
dw_navegacion.object.raiz[nivel] = 0
dw_navegacion.object.padre[nivel] = 0
dw_navegacion.object.color_fondo[nivel] = color_fondo
dw_navegacion.object.color_resaltado[nivel] = color_resaltado
dw_navegacion.object.color_inicio[nivel] = color_inicio
dw_navegacion.object.color_fin[nivel] = color_fin
dw_navegacion.object.separador[nivel] = ""
dw_navegacion.triggerevent("actualizado")

ancho_inicial_dw_menu1 = dw_menu1.width
alto_inicial_dw_menu1 = dw_menu1.height
ancho_inicial_ventana = this.width

dw_menu1.reset()
dw_menu1.Object.DataWindow.Color = rgb(234,234,234) //color_fondo
dw_menu1.SetTrans(sqlca)
//dw_menu1
elementos = dw_menu1.retrieve(nombre_usuario, 0, 0, 0, 1, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
alto_maximo = elementos * 164 + (dw_navegacion.height + 5)
if alto_maximo > alto_inicial_dw_menu1 then
	dw_menu1.VScrollBar = true
	dw_menu1.width = ancho_inicial_dw_menu1 + 80
	this.width = ancho_inicial_ventana + 80
else
	dw_menu1.VScrollBar = false
	dw_menu1.width = ancho_inicial_dw_menu1
	this.width = ancho_inicial_ventana
end if
end event

event close;call super::close;//f_menu_cerrar_aplicacion(true)
end event

event activate;call super::activate;id_ventana_activa = f_menu_insertar_ventana(this)
end event

event closequery;call super::closequery;if f_menu_cerrar_aplicacion(true) = -1 then
	//No cerramos - Error de validación en una ventana, que todabía permanecerá abierta
	return 1
end if
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_tencer3
boolean visible = false
integer x = 1641
integer y = 220
integer width = 174
integer height = 152
integer taborder = 10
boolean enabled = false
boolean originalsize = false
end type

type st_titulo from statictext within w_inicio_tencer3
boolean visible = false
integer x = 55
integer y = 4
integer width = 1998
integer height = 104
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_menu1 from datawindow within w_inicio_tencer3
event onmouseover pbm_dwnmousemove
integer x = 27
integer y = 60
integer width = 1417
integer height = 2940
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_usuario3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event onmouseover;Long i
if row <> 0 then
	if dwo.Type = "column" and dwo.Name = "uti_menu_descripcion" then
		this.object.resaltado[row] = 1
		for i = 1 to this.rowcount()
			if i = row then
				this.object.resaltado[i] = 1
			else 
				this.object.resaltado[i] = 0
			end if
		next
	else
		for i = 1 to this.rowcount()
			this.object.resaltado[i] = 0
		next
	end if
end if
end event

event clicked;Long raiz, padre, padre_anterior, nivel, nivel_sig, color_fondo, color_resaltado, color_inicio, color_fin, mas_menus, codigo_ventana
String ventana, descripcion, usuario, menu, menu_raiz
Long codigo_update, seleccion, i, res, esta_abierta, alto_maximo
Transaction trm
Window w
Window wprov
str_parametros lstr_param
Menu m
if row <> 0 then 
	if dwo.name = "seleccionado" then
		//Los menús solo permiten leer o no leer (1 o 0)
		CHOOSE CASE this.object.seleccionado[row]
			CASE 0
				this.object.seleccionado[row] = 1
				control_activo = "dw_menu1"
			CASE 1
				this.object.seleccionado[row] = 0
				control_activo = "dw_menu1"
		END CHOOSE
	else	
		//Obtención de los datos del elemento seleccionado y preparación para abrir ventana o submenú
		menu = this.object.uti_menu_menu[row]
		ventana = this.object.uti_ventana_nombre[row]
		codigo_ventana = this.object.uti_ventana_codigo[row]
		descripcion = this.object.uti_menu_descripcion[row]
		raiz = this.object.uti_menu_raiz[row]
		padre = this.object.uti_menu_codigo[row]
		padre_anterior = this.object.uti_menu_elemento_padre[row]
		nivel = this.object.uti_menu_nivel[row]
		nivel_sig = nivel + 1
		color_fondo = this.object.color_fondo[row]
		color_resaltado = this.object.color_resaltado[row]
		color_inicio = this.object.color_inicio[row]
		color_fin = this.object.color_fin[row]
		control_activo = "dw_menu1"
		if not isnull(ventana) and ventana <> "" then
			//Lanzar ventanas dinamicas
			
			//ventana_padre = Parent    //Por compatibilidad con el antiguo sistema MDI de ventanas padres
			esta_abierta = f_menu_ventana_esta_abierta(ventana)
			//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
			if esta_abierta = -1 then
				res = Openwithparm(w, lstr_param, ventana)
				//f_menu_insertar_ventana(w)
			else
				ventanas_activas[esta_abierta].ventana.WindowState = Normal!
				ventanas_activas[esta_abierta].ventana.bringtotop = true
			end if
		else
			
			//Actualización menú navegación
			if dw_navegacion.rowcount() < nivel_sig then
				dw_navegacion.InsertRow(0)
			end if
			dw_navegacion.object.descripcion[nivel_sig] = descripcion
			dw_navegacion.object.codigo[nivel_sig] = padre
			dw_navegacion.object.raiz[nivel_sig] = raiz
			dw_navegacion.object.padre[nivel_sig] = padre_anterior
			dw_navegacion.object.color_fondo[nivel_sig] = color_fondo
			dw_navegacion.object.color_resaltado[nivel_sig] = color_resaltado
			dw_navegacion.object.color_inicio[nivel_sig] = color_inicio
			dw_navegacion.object.color_fin[nivel_sig] = color_fin
			dw_navegacion.object.separador[nivel_sig] = ""
			if nivel_sig > 1 then
				dw_navegacion.object.separador[nivel_sig - 1] = ">"
			end if
			dw_navegacion.visible = true
			dw_navegacion.triggerevent("actualizado")
			
			//Apertura del submenú de nivel n + 1
			dw_menu1.reset()
			dw_menu1.SetTrans(sqlca)
			mas_menus = dw_menu1.retrieve(nombre_usuario, 0, padre, raiz, nivel_sig, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
			
			//Contro de elementos del menú por la barra de desplazamiento y ancho del menú
			//OJO: En función de la altura de los elementos (si se cambia cambiar programación de actualizar de dw_navegacion)
			alto_maximo = mas_menus * 164 + (dw_navegacion.height + 5)
			if alto_maximo > alto_inicial_dw_menu1 then
				dw_menu1.VScrollBar = true
				dw_menu1.width = ancho_inicial_dw_menu1 + 80
				parent.width = ancho_inicial_ventana + 80
			else
				dw_menu1.VScrollBar = false
				dw_menu1.width = ancho_inicial_dw_menu1
				parent.width = ancho_inicial_ventana
			end if
			if mas_menus < 1 then
				//No hay elementos de menú. No cargar...
				dw_navegacion.deleterow(nivel_sig)
				dw_navegacion.triggerevent("actualizado")
				
				dw_menu1.reset()
				dw_menu1.SetTrans(sqlca)
				mas_menus = dw_menu1.retrieve(nombre_usuario, 0, padre_anterior, raiz, nivel, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
				//Contro de elementos del menú por la barra de desplazamiento y ancho del menú
				alto_maximo = mas_menus * 164 + (dw_navegacion.height + 5)
				if alto_maximo > alto_inicial_dw_menu1 then
					dw_menu1.VScrollBar = true
					dw_menu1.width = ancho_inicial_dw_menu1 + 80
					parent.width = ancho_inicial_ventana + 80
				else
					dw_menu1.VScrollBar = false
					dw_menu1.width = ancho_inicial_dw_menu1
					parent.width = ancho_inicial_ventana
				end if
				return
			end if
		end if
	end if
end if
Destroy trm
setnull(wprov)
end event

event retrieveend;this.y = dw_navegacion.y + dw_navegacion.height + 5
this.height = alto_inicial_dw_menu1 - dw_navegacion.height - 5

end event

event retrieverow;/*
if row > 0 then
	//Menús especiales de cartera - código 
	if this.object.uti_menu_codigo[row] = 7 then
		tipo_vista="Nacional"
		mi_menu_generico.m_utilidades.m_cartera.visible = true
		mi_menu_generico.m_utilidades.m_2.visible = true
		mi_menu_generico.m_utilidades.m_cartera.m_nacional.checked=true
	end if
end if
*/
end event

type dw_navegacion from datawindow within w_inicio_tencer3
event actualizado ( )
event onmouseover pbm_dwnmousemove
integer x = 32
integer y = 60
integer width = 1413
integer height = 96
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_navegacion3"
borderstyle borderstyle = stylelowered!
end type

event actualizado();Long i 
i = this.rowcount()
if i > 1 then
	this.height = 87 * i
	if i >= 3 then
		this.height = this.height - (i - 2) * 5
	end if
else
	this.height = 87
end if

end event

event onmouseover;Long i
if row <> 0 then
	if dwo.Type = "column" and dwo.Name = "descripcion" then
		this.object.resaltado[row] = 1
		for i = 1 to this.rowcount()
			if i = row then
				this.object.resaltado[i] = 1
			else 
				this.object.resaltado[i] = 0
			end if
		next
	else
		for i = 1 to this.rowcount()
			this.object.resaltado[i] = 0
		next
	end if
end if
end event

event clicked;Long padre, raiz, nivel, color_fondo, color_resaltado, color_inicio, color_fin, i, alto_maximo, mas_menus
String tipo, nombre
if row > 0  then
	tipo = dwo.type
	nombre = lower(dwo.name)
	if tipo = "column" and pos(nombre,"descripcion") <> 0 then
		padre = this.object.codigo[row]
		raiz = this.object.raiz[row]
		nivel = row
		color_fondo = this.object.color_fondo[row]
		color_resaltado = this.object.color_resaltado[row]
		color_inicio = this.object.color_inicio[row]
		color_fin = this.object.color_fin[row]
		this.object.separador[row] = ""
		i = this.rowcount() 
		do while i >= row + 1
			this.deleterow(i)
			i --
		loop
		this.triggerevent("actualizado")
		dw_menu1.reset()
		dw_menu1.SetTrans(sqlca)
		mas_menus = dw_menu1.retrieve(nombre_usuario, 0, padre, raiz, nivel, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
		alto_maximo = mas_menus * 164 + (dw_navegacion.height + 5)
		if alto_maximo > alto_inicial_dw_menu1 then
			dw_menu1.VScrollBar = true
			dw_menu1.width = ancho_inicial_dw_menu1 + 80
			parent.width = ancho_inicial_ventana + 80
		else
			dw_menu1.VScrollBar = false
			dw_menu1.width = ancho_inicial_dw_menu1
			parent.width = ancho_inicial_ventana
		end if
	end if
end if
end event

event losefocus;Long i
For i = 1 To this.rowcount()
	this.object.resaltado[i] = 0
Next
end event

