$PBExportHeader$w_inicio_tencer2.srw
forward
global type w_inicio_tencer2 from w_ventana_padre_inicio
end type
type mdi_1 from mdiclient within w_inicio_tencer2
end type
type st_titulo from statictext within w_inicio_tencer2
end type
type dw_menu_completo from datawindow within w_inicio_tencer2
end type
type dw_menu1 from datawindow within w_inicio_tencer2
end type
type dw_navegacion from datawindow within w_inicio_tencer2
end type
end forward

global type w_inicio_tencer2 from w_ventana_padre_inicio
integer width = 3767
integer height = 3248
string title = "Menu Principal"
string menuname = "mi_menu_generico"
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = normal!
mdi_1 mdi_1
st_titulo st_titulo
dw_menu_completo dw_menu_completo
dw_menu1 dw_menu1
dw_navegacion dw_navegacion
end type
global w_inicio_tencer2 w_inicio_tencer2

type variables
String control_activo
Long alto_inicial_dw_menu1, ancho_inicial_dw_menu1
end variables

forward prototypes
public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso)
end prototypes

public subroutine f_abrir_ventana (string arg_programa, integer arg_permiso);
end subroutine

on w_inicio_tencer2.create
int iCurrent
call super::create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.mdi_1=create mdi_1
this.st_titulo=create st_titulo
this.dw_menu_completo=create dw_menu_completo
this.dw_menu1=create dw_menu1
this.dw_navegacion=create dw_navegacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
this.Control[iCurrent+2]=this.st_titulo
this.Control[iCurrent+3]=this.dw_menu_completo
this.Control[iCurrent+4]=this.dw_menu1
this.Control[iCurrent+5]=this.dw_navegacion
end on

on w_inicio_tencer2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_titulo)
destroy(this.dw_menu_completo)
destroy(this.dw_menu1)
destroy(this.dw_navegacion)
end on

event open;call super::open;String errores
str_ventanas_activas actual
Long numero_elementos, elementos
Long color_fondo, color_resaltado, color_inicio, color_fin

this.title = this.title + "   -   " + f_nombre_empresa(codigo_empresa)

control_activo = ""

f_menu_insertar_ventana(this)

dw_menu_completo.reset()
dw_menu_completo.SetTrans(sqlca)
numero_elementos = dw_menu_completo.retrieve(nombre_usuario, 0, codigo_empresa)

dw_navegacion.SetTrans(sqlca)
dw_navegacion.retrieve()
dw_navegacion.visible = false

dw_menu1.reset()
dw_menu1.SetTrans(sqlca)

//Tamaños
alto_inicial_dw_menu1 = 180 + numero_elementos * 164
if alto_inicial_dw_menu1 < (180 + 5 * 164) then
	alto_inicial_dw_menu1 = 180 + 5 * 164 + 100
end if

dw_menu_completo.height = alto_inicial_dw_menu1
ancho_inicial_dw_menu1 = dw_menu1.width

dw_menu1.height = alto_inicial_dw_menu1
this.height = dw_menu_completo.y + alto_inicial_dw_menu1 + 300





end event

event close;call super::close;f_menu_cerrar_aplicacion(true)
end event

type pb_salir from w_ventana_padre_inicio`pb_salir within w_inicio_tencer2
boolean visible = false
integer x = 2112
integer y = 108
integer width = 174
integer height = 152
integer taborder = 10
boolean enabled = false
boolean originalsize = false
end type

type mdi_1 from mdiclient within w_inicio_tencer2
long BackColor=268435456
end type

type st_titulo from statictext within w_inicio_tencer2
boolean visible = false
integer x = 82
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

type dw_menu_completo from datawindow within w_inicio_tencer2
event onmouseover pbm_dwnmousemove
integer x = 73
integer y = 60
integer width = 1147
integer height = 2940
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_raiz_usuario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event onmouseover;Long i, marcados
if row <> 0 then
	//marcados = Long(this.Describe('Evaluate(~'Sum(resaltado)~',0)'))
	if dwo.Type = "column" and dwo.Name = "uti_menu_descripcion" then
		//this.object.resaltado[row] = 1
		for i = 1 to this.rowcount()
			if this.object.resaltado[i] <> 2 then
				if i = row then				
					this.object.resaltado[i] = 1
				else 
					this.object.resaltado[i] = 0
				end if
			end if
		next
	else
		for i = 1 to this.rowcount()
			if this.object.resaltado[i] <> 2 then
				this.object.resaltado[i] = 0
			end if
		next
	end if
end if
end event

event clicked;Long color_fondo, color_resaltado, color_inicio, color_fin, i, ventana
Long padre, raiz, nivel, elementos, codigo_update, seleccion, alto_maximo
String descripcion, usuario, menu, menu_raiz
Transaction trm
if row <> 0 then 
	if dwo.name = "seleccionado" then
		CHOOSE CASE this.object.seleccionado[row]
			CASE 0
				this.object.seleccionado[row] = 1
				control_activo = "dw_menu_completo"
			CASE 1
				this.object.seleccionado[row] = 0
				control_activo = "dw_menu_completo"
		END CHOOSE
	else
		//Obtención de los datos del elemento seleccionado y preparación para abrir ventana o submenú
		descripcion = this.object.uti_menu_descripcion[row]
		padre = this.object.uti_menu_codigo[row]
		raiz = this.object.uti_menu_codigo[row]
		menu_raiz = this.object.uti_menu_menu[row]
		nivel = 2
		color_fondo = rgb(52,175,250)
		color_resaltado = rgb(50,222,252)
		color_inicio = color_fondo
		color_fin = rgb(69,188,233)
		
		//Actualización menú navegación
		dw_navegacion.reset()
		dw_navegacion.InsertRow(0)
		dw_navegacion.object.descripcion[nivel - 1] = descripcion
		dw_navegacion.object.codigo[nivel - 1] = padre
		dw_navegacion.object.raiz[nivel - 1] = raiz
		dw_navegacion.object.padre[nivel - 1] = 0
		dw_navegacion.object.color_fondo[nivel - 1] = color_fondo
		dw_navegacion.object.color_resaltado[nivel - 1] = color_resaltado
		dw_navegacion.object.color_inicio[nivel - 1] = color_inicio
		dw_navegacion.object.color_fin[nivel - 1] = color_fin
		dw_navegacion.object.separador[nivel - 1] = ""
		
		dw_navegacion.triggerevent("actualizado")
		
		dw_menu1.Object.DataWindow.Color = color_fondo
		dw_menu1.reset()
		dw_menu1.SetTrans(sqlca)
		elementos = dw_menu1.retrieve(nombre_usuario, 0, padre, raiz, nivel, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
		//Contro de elementos del menú por la barra de desplazamiento y ancho del menú
		alto_maximo = elementos * 164 + (dw_navegacion.height + 5)
		if alto_maximo > alto_inicial_dw_menu1 then
			dw_menu1.VScrollBar = true
			dw_menu1.width = ancho_inicial_dw_menu1 + 80
		else
			dw_menu1.VScrollBar = false
			dw_menu1.width = ancho_inicial_dw_menu1
		end if
		dw_navegacion.visible = true
		this.object.seleccionado[row] = 1
		control_activo = "dw_menu_completo"
	end if
end if
Destroy trm
end event

event retrieverow;if row <> 0 then
	//Menús especiales de cartera - código 
	if this.object.uti_menu_codigo[row] = 7 then
		tipo_vista="Nacional"
		mi_menu_generico.m_utilidades.m_cartera.visible = true
		mi_menu_generico.m_utilidades.m_2.visible = true
		mi_menu_generico.m_utilidades.m_cartera.m_nacional.checked=true
	end if
end if
end event

type dw_menu1 from datawindow within w_inicio_tencer2
event onmouseover pbm_dwnmousemove
integer x = 1230
integer y = 60
integer width = 2441
integer height = 2940
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_usuario"
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
Window w, wprov
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
		//menu_raiz = dw_navegacion.object.menu[1]
		if not isnull(ventana) and ventana <> "" then
			//Lanzar ventana
			//Obtenemos los datos de la ventana creando una del mismo tipo que la que vamos a abrir
			wprov = CREATE using ventana
			str_parametros lstr_param
			//ventana_padre = Parent    //Por compatibilidad con el antiguo sistema MDI de ventanas padres
			esta_abierta = f_menu_ventana_esta_abierta(ventana)
			//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
			if esta_abierta = -1 then
				//Por si queremos distinguir y realizar acciones distintas
				if wprov.WindowType <> main! and wprov.WindowType <> mdi! and wprov.WindowType <> mdihelp! then
					res = Openwithparm(w, lstr_param, ventana)
				else
					res = Openwithparm(w, lstr_param, ventana)
				end if
				//res = Openwithparm(w, lstr_param,ventana)
			else
				ventanas_activas[esta_abierta].ventana.bringtotop = true
			end if
		else
			if pos(menu,"m_salir") <> 0 then
				close(Parent)
				return
			end if
			
			//Actualización menú navegación
			if dw_navegacion.rowcount() < nivel then
				dw_navegacion.InsertRow(0)
			end if
			dw_navegacion.object.descripcion[nivel] = descripcion
			dw_navegacion.object.codigo[nivel] = padre
			dw_navegacion.object.raiz[nivel] = raiz
			dw_navegacion.object.padre[nivel] = padre_anterior
			dw_navegacion.object.color_fondo[nivel] = color_fondo
			dw_navegacion.object.color_resaltado[nivel] = color_resaltado
			dw_navegacion.object.color_inicio[nivel] = color_inicio
			dw_navegacion.object.color_fin[nivel] = color_fin
			dw_navegacion.object.separador[nivel] = ""
			if nivel > 1 then
				dw_navegacion.object.separador[nivel - 1] = ">"
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
			else
				dw_menu1.VScrollBar = false
				dw_menu1.width = ancho_inicial_dw_menu1
			end if
			if mas_menus < 1 then
				//No hay elementos de menú. No cargar...
				dw_navegacion.deleterow(nivel)
				dw_navegacion.triggerevent("actualizado")
				
				dw_menu1.reset()
				dw_menu1.SetTrans(sqlca)
				mas_menus = dw_menu1.retrieve(nombre_usuario, 0, padre_anterior, raiz, nivel, color_fondo, color_resaltado, color_inicio, color_fin, codigo_empresa)
				//Contro de elementos del menú por la barra de desplazamiento y ancho del menú
				alto_maximo = mas_menus * 164 + (dw_navegacion.height + 5)
				if alto_maximo > alto_inicial_dw_menu1 then
					dw_menu1.VScrollBar = true
					dw_menu1.width = ancho_inicial_dw_menu1 + 80
				else
					dw_menu1.VScrollBar = false
					dw_menu1.width = ancho_inicial_dw_menu1
				end if
				return
			end if
		end if
	end if
end if
Destroy trm
Destroy wprov
end event

event retrieveend;this.y = dw_navegacion.y + dw_navegacion.height + 5
this.height = alto_inicial_dw_menu1 - dw_navegacion.height - 5
end event

type dw_navegacion from datawindow within w_inicio_tencer2
event actualizado ( )
event onmouseover pbm_dwnmousemove
integer x = 1234
integer y = 60
integer width = 2437
integer height = 96
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_menu_navegacion"
boolean livescroll = true
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
		nivel = row + 1
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
		else
			dw_menu1.VScrollBar = false
			dw_menu1.width = ancho_inicial_dw_menu1
		end if
	end if
end if
end event

event losefocus;Long i
For i = 1 To this.rowcount()
	this.object.resaltado[i] = 0
Next
end event

