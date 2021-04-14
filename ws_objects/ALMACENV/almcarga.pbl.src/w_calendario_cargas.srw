$PBExportHeader$w_calendario_cargas.srw
forward
global type w_calendario_cargas from window
end type
type em_eventos from editmask within w_calendario_cargas
end type
type st_3 from statictext within w_calendario_cargas
end type
type pb_imprimir from picturebutton within w_calendario_cargas
end type
type em_tamaño_horas from editmask within w_calendario_cargas
end type
type st_2 from statictext within w_calendario_cargas
end type
type em_hora_hasta from editmask within w_calendario_cargas
end type
type st_1 from statictext within w_calendario_cargas
end type
type em_hora_desde from editmask within w_calendario_cargas
end type
type dw_1 from u_datawindow within w_calendario_cargas
end type
type em_height from editmask within w_calendario_cargas
end type
type cb_1 from commandbutton within w_calendario_cargas
end type
end forward

global type w_calendario_cargas from window
integer width = 3671
integer height = 2604
boolean titlebar = true
string title = "Citas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
em_eventos em_eventos
st_3 st_3
pb_imprimir pb_imprimir
em_tamaño_horas em_tamaño_horas
st_2 st_2
em_hora_hasta em_hora_hasta
st_1 st_1
em_hora_desde em_hora_desde
dw_1 dw_1
em_height em_height
cb_1 cb_1
end type
global w_calendario_cargas w_calendario_cargas

type variables
date fecha_actual
end variables

forward prototypes
public subroutine f_cargar_calendario ()
end prototypes

public subroutine f_cargar_calendario ();int li_donde,li_hora_inicio,li_hora_fin,li_hora,li_anyo,li_mes,li_dia,li_height,li_evento,li_minutos_dura
int li_dia_semana,li_x,li_minuto_comienza,li_y
long ll_color_texto,ll_background_color
string lsModify,lsResultado,ls_nombre_texto,ls_texto
dw_1.reset()

li_hora_inicio = 0
li_hora_fin    = 23

li_anyo = 2016
li_mes  = 7
li_dia  = 1
li_height = 64

for li_hora = li_hora_inicio to li_hora_fin
	li_donde = dw_1.insertrow(0)
	
	dw_1.object.anyo[li_donde] = li_anyo
	dw_1.object.mes[li_donde] = li_mes
	dw_1.object.dia[li_donde] = li_dia
	dw_1.object.hora[li_donde] = li_hora
	dw_1.object.height[li_donde] = li_height
next

for li_evento = 1 to 15
	li_hora = rand(24) -1
	li_minutos_dura = 10 + (rand(5) * 10)
	li_height = (li_minutos_dura / 10) * 64
	li_dia_semana = rand(7)
	choose case li_dia_semana
		case 1
			li_x = 87
		case 2
			li_x = 558
		case 3
			li_x = 1029
		case 4
			li_x = 1499
		case 5
			li_x = 1970
		case 6
			li_x = 2441
		case 7
			li_x = 2912
	end choose	
	
	li_minuto_comienza = (rand(6) -1) * 10
	li_y = (64 * (li_minuto_comienza/10)) + 4
	
	ls_nombre_texto = "texto_"+string(li_evento,"###0")
	ls_texto = string(li_hora,"00")+":"+string(li_minuto_comienza,"00")
	
	choose case rand(4)
		case 1
			ll_color_texto = rgb(255,128,0)
			ll_background_color = rgb(128,128,128)
		case 2
			ll_color_texto = rgb(0,128,255)
			ll_background_color = rgb(0,0,255)
		case 3
			ll_color_texto = rgb(255,0,0)
			ll_background_color = rgb(128,128,128)
		case 4
			ll_color_texto = rgb(0,255,0)
			ll_background_color = rgb(0,0,255)
		case else
			ll_color_texto = 33554432
			ll_background_color = 536870912
	end choose
	
	lsModify = "create text(band=detail alignment=~"2~" text=~""+ls_texto+"~" border=~"2~" color=~""+string(ll_color_texto,"#########0")+"~" x=~""+string(li_x,"####0")+"~" y=~""+string(li_y,"##0")+"~" height=~""+string(li_height,"##0")+"~" width=~"142~" html.valueishtml=~"0~"  name="+ls_nombre_texto+" visible=~"1~tif( anyo = 2016 and  mes = 7 and  dia = 1 and  hora = "+string(li_hora,"#0")+" , 1 , 0 )~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~"font.escapement=~"0~"  background.mode=~"2~" background.color=~""+string(ll_background_color,"#######0")+"~" )"
	lsResultado=dw_1.modify(lsModify)
	
	//
	choose case li_dia_semana
		case 1
			li_x = 87 + 142 + 4
		case 2
			li_x = 558 + 142 + 4
		case 3
			li_x = 1029 + 142 + 4
		case 4
			li_x = 1499 + 142 + 4
		case 5
			li_x = 1970 + 142 + 4
		case 6
			li_x = 2441 + 142 + 4
		case 7
			li_x = 2912 + 142 + 4
	end choose		
	
	li_minuto_comienza = (rand(6) -1) * 10
	li_y = (64 * (li_minuto_comienza/10)) + 4
	
	ls_nombre_texto = "texto2_"+string(li_evento,"###0")
	ls_texto = string(li_hora,"00")+":"+string(li_minuto_comienza,"00")
	
	choose case rand(4)
		case 1
			ll_color_texto = rgb(255,128,0)
			ll_background_color = rgb(128,128,128)
		case 2
			ll_color_texto = rgb(0,128,255)
			ll_background_color = rgb(0,0,255)
		case 3
			ll_color_texto = rgb(255,0,0)
			ll_background_color = rgb(128,128,128)
		case 4
			ll_color_texto = rgb(0,255,0)
			ll_background_color = rgb(0,0,255)
		case else
			ll_color_texto = 33554432
			ll_background_color = 536870912
	end choose
	//                   text(band=detail alignment="2" text="text" border="0" color="0" x="187" y="4" height="56" width="128" html.valueishtml="0"  name=t_1 visible="1"  font.face="Arial" font.height="-8" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="8421504" )
	lsModify = "create text(band=detail alignment=~"2~" text=~""+ls_texto+"~" border=~"2~" color=~""+string(ll_color_texto,"#########0")+"~" x=~""+string(li_x,"####0")+"~" y=~""+string(li_y,"##0")+"~" height=~""+string(li_height,"##0")+"~" width=~"142~" html.valueishtml=~"0~"  name="+ls_nombre_texto+" visible=~"1~tif( anyo = 2016 and  mes = 7 and  dia = 1 and  hora = "+string(li_hora,"#0")+" , 1 , 0 )~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~"font.escapement=~"0~"  background.mode=~"2~" background.color=~""+string(ll_background_color,"#######0")+"~" )"
	lsResultado=dw_1.modify(lsModify)	
next

dw_1.sort()
dw_1.groupcalc()



//	lsModify = "create text(band=header alignment=~"2~" text=~""+isTitulo+"~" border=~"2~" color=~"0~" x=~"20~" y=~"368~" height=~"80~" width=~"3346~" html.valueishtml=~"0~"  name=t_titulo visible=~"1~"  font.face=~"Arial~" font.height=~"-12~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
//	lsResultado=report.modify(lsModify)	
end subroutine

on w_calendario_cargas.create
this.em_eventos=create em_eventos
this.st_3=create st_3
this.pb_imprimir=create pb_imprimir
this.em_tamaño_horas=create em_tamaño_horas
this.st_2=create st_2
this.em_hora_hasta=create em_hora_hasta
this.st_1=create st_1
this.em_hora_desde=create em_hora_desde
this.dw_1=create dw_1
this.em_height=create em_height
this.cb_1=create cb_1
this.Control[]={this.em_eventos,&
this.st_3,&
this.pb_imprimir,&
this.em_tamaño_horas,&
this.st_2,&
this.em_hora_hasta,&
this.st_1,&
this.em_hora_desde,&
this.dw_1,&
this.em_height,&
this.cb_1}
end on

on w_calendario_cargas.destroy
destroy(this.em_eventos)
destroy(this.st_3)
destroy(this.pb_imprimir)
destroy(this.em_tamaño_horas)
destroy(this.st_2)
destroy(this.em_hora_hasta)
destroy(this.st_1)
destroy(this.em_hora_desde)
destroy(this.dw_1)
destroy(this.em_height)
destroy(this.cb_1)
end on

event open;//string lsFecha
//
//lsFecha = Message.StringParm
//if lsFecha <> "" and not isnull(lsFecha) then
//	fecha_actual = date(lsFecha)
//	st_fecha.text = f_nombre_fecha(datetime(fecha_actual))
//	if isvalid(w_calendario_notas) then
//		this.x = w_calendario_notas.width + 100
//		this.y = w_calendario_notas.y
//	else
//		f_centrar_ventana(this)
//	end if
//	f_cargar_dia()
//end if
//f_cargar_calendario()

dw_1.setfocus()
//em_height.text = string(this.height,em_height.mask)
//dw_1.setcolumn("texto8")

end event

event resize;//em_height.text = string(this.height,em_height.mask)
end event

type em_eventos from editmask within w_calendario_cargas
integer x = 1897
integer y = 20
integer width = 224
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "25"
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "64~~9999"
end type

type st_3 from statictext within w_calendario_cargas
integer x = 1641
integer y = 24
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "EVENTOS:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir from picturebutton within w_calendario_cargas
integer x = 3470
integer width = 165
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\BMP\IMP32.BMP"
end type

event clicked;dw_1.print(true)
end event

type em_tamaño_horas from editmask within w_calendario_cargas
integer x = 1161
integer y = 20
integer width = 224
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "120"
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "64~~9999"
end type

type st_2 from statictext within w_calendario_cargas
integer x = 731
integer y = 24
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TAMAÑO HORAS:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hora_hasta from editmask within w_calendario_cargas
integer x = 448
integer y = 20
integer width = 187
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "22"
alignment alignment = center!
string mask = "#0"
boolean spin = true
double increment = 1
string minmax = "0~~24"
end type

type st_1 from statictext within w_calendario_cargas
integer x = 23
integer y = 24
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "HORAS:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_hora_desde from editmask within w_calendario_cargas
integer x = 233
integer y = 20
integer width = 187
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "6"
alignment alignment = center!
string mask = "#0"
boolean spin = true
double increment = 1
string minmax = "0~~24"
end type

type dw_1 from u_datawindow within w_calendario_cargas
integer x = 5
integer y = 112
integer width = 3461
integer height = 2380
integer taborder = 10
string dataobject = "prueba_calendario_tareas"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type em_height from editmask within w_calendario_cargas
boolean visible = false
integer x = 2629
integer y = 20
integer width = 343
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
string mask = "#######0"
end type

type cb_1 from commandbutton within w_calendario_cargas
integer x = 2994
integer y = 4
integer width = 471
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear Calendario"
end type

event clicked;int li_hora,li_hora_inicio,li_hora_fin,li_tamano_horas,li_posicion_x,li_posicion_y,li_height,li_posicion_y_anterior
int li_posicion_y_linea,li_evento,li_dia_semana,li_hora_dia,li_minuto_hora,li_duracion_evento_minutos
int li_horas_visibles,li_inicio_y_hora[],li_posicion_x_dia[]
int li_ancho_dia,li_ancho_rectangulo_tarea_con_respecto_a_dia
int li_posicion_x_rectangulo_con_respecto_a_dia,li_width,li_donde
int li_posicion_x_texto_con_respecto_a_rectangulo,li_posicion_y_texto_con_respecto_a_rectangulo
int li_ancho_texto_con_respecto_a_rectangulo,li_alto_texto_con_respecto_a_rectangulo,li_eventos
long ll_color_fondo_par,ll_color_fondo_impar,ll_color_texto_par,ll_color_texto_impar
string ls_Modify,ls_Resultado,ls_nombre_objeto,ls_texto,ls_orden_visible
string ls_posicion_x,ls_posicion_y,ls_height,ls_width
string ls_color_fondo_par,ls_color_fondo_impar,ls_color_texto_par,ls_color_texto_impar
string ls_color_fondo,ls_color_texto
string ls_posicion_x1_linea,ls_posicion_x2_linea
string ls_colores_tareas[],ls_color_tarea,ls_texto_tarea,ls_fontheight,ls_descripcion_evento

string ls_sel
datastore ds_datos

dw_1.reset()
dw_1.dataobject = "prueba_calendario_tareas_vacio"
dw_1.setredraw(false)

li_ancho_dia                                        = 457
li_ancho_rectangulo_tarea_con_respecto_a_dia        = -9
li_posicion_x_rectangulo_con_respecto_a_dia         = +4

li_posicion_x_texto_con_respecto_a_rectangulo       = +14
li_posicion_y_texto_con_respecto_a_rectangulo       = +7
li_ancho_texto_con_respecto_a_rectangulo            = -28
li_alto_texto_con_respecto_a_rectangulo             = -14

li_hora_inicio  = integer(em_hora_desde.text)
li_hora_fin     = integer(em_hora_hasta.text)
li_horas_visibles = li_hora_fin - li_hora_inicio
li_tamano_horas = integer(em_tamaño_horas.text)

ll_color_fondo_par   = rgb(128,128,128) //Gris Oscuro
ll_color_fondo_impar = rgb(255,128,0) //Naranja Gno
ll_color_texto_par   = rgb(255,255,255) //Blanco
ll_color_texto_impar = rgb(0,0,0) //Negro

ls_colores_tareas[1] = string(rgb(128,0,0),"#########0")
ls_colores_tareas[2] = string(rgb(255,128,0),"#########0")
ls_colores_tareas[3] = string(rgb(0,128,0),"#########0")
ls_colores_tareas[4] = string(rgb(0,128,64),"#########0")
ls_colores_tareas[5] = string(rgb(0,0,255),"#########0")
ls_colores_tareas[6] = string(rgb(0,0,160),"#########0")
ls_colores_tareas[7] = string(rgb(128,0,128),"#########0")
ls_colores_tareas[8] = string(rgb(128,0,255),"#########0")

ls_color_fondo_par   = string(ll_color_fondo_par,"#########0")
ls_color_fondo_impar = string(ll_color_fondo_impar,"#########0")
ls_color_texto_par   = string(ll_color_texto_par,"#########0")
ls_color_texto_impar = string(ll_color_texto_impar,"#########0")

li_posicion_x_dia[1] = 87
li_posicion_x_dia[2] = 558
li_posicion_x_dia[3] = 1029
li_posicion_x_dia[4] = 1499
li_posicion_x_dia[5] = 1970
li_posicion_x_dia[6] = 2441
li_posicion_x_dia[7] = 2912

for li_hora = li_hora_inicio to li_hora_fin
	//Texto Hora:
	if li_hora = li_hora_inicio then
		li_posicion_x = 9
		li_posicion_y = 4
	else
		li_posicion_x = 9
		li_posicion_y = li_posicion_y_anterior + li_tamano_horas + 12	
	end if
	
	li_inicio_y_hora[li_hora] = li_posicion_y
	
	li_posicion_y_anterior = li_posicion_y
	
	li_height = li_tamano_horas
	
	ls_posicion_x = string(li_posicion_x,"#####0")
	ls_posicion_y = string(li_posicion_y,"#####0")
	ls_height     = string(li_height,"#####0")
	
	if mod(li_hora,2) = 1 then
		ls_color_fondo = ls_color_fondo_impar
		ls_color_texto = ls_color_texto_impar
	else
		ls_color_fondo = ls_color_fondo_par
		ls_color_texto = ls_color_texto_par
	end if
	
	ls_nombre_objeto = "t_hora_"+string(li_hora,"00")
	ls_texto         = string(li_hora,"00")
	
	ls_Modify = "create text(band=detail alignment=~"2~" text=~""+ls_texto+"~" border=~"2~" color=~""+ls_color_texto+"~" x=~""+ls_posicion_x+"~" y=~""+ls_posicion_y+"~" height=~""+ls_height+"~" width=~"64~" html.valueishtml=~"0~"  name="+ls_nombre_objeto+" visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~""+ls_color_fondo+"~" )"
	ls_Resultado = dw_1.modify(ls_Modify)	

	//Linea Media Hora:
	ls_posicion_x1_linea = ls_posicion_x
	ls_posicion_x2_linea = "3369"
	li_posicion_y_linea = li_posicion_y + (li_height / 2)
	ls_posicion_y       = string(li_posicion_y_linea,"#####0")
	
	ls_nombre_objeto = "l_hora_"+string(li_hora,"00")+"_30_minutos"
	ls_texto         = string(li_hora,"00")	
	
	ls_Modify = "create line(band=detail x1=~""+ls_posicion_x1_linea+"~" y1=~""+ls_posicion_y+"~" x2=~""+ls_posicion_x2_linea+"~" y2=~""+ls_posicion_y+"~"  name="+ls_nombre_objeto+" visible=~"1~" pen.style=~"2~" pen.width=~"5~" pen.color=~"0~"  background.mode=~"2~" background.color=~"1073741824~" )"
	ls_Resultado = dw_1.modify(ls_Modify)
	
	//Linea Final Hora:
	ls_posicion_x1_linea = ls_posicion_x
	ls_posicion_x2_linea = "3369"
	li_posicion_y_linea = li_posicion_y + li_height
	ls_posicion_y       = string(li_posicion_y_linea,"#####0")
	
	ls_nombre_objeto = "l_hora_"+string(li_hora,"00")+"_60_minutos"
	ls_texto         = string(li_hora,"00")	
	
	ls_Modify = "create line(band=detail x1=~""+ls_posicion_x1_linea+"~" y1=~""+ls_posicion_y+"~" x2=~""+ls_posicion_x2_linea+"~" y2=~""+ls_posicion_y+"~"  name="+ls_nombre_objeto+" visible=~"1~" pen.style=~"0~" pen.width=~"5~" pen.color=~"0~"  background.mode=~"2~" background.color=~"1073741824~" )"
	ls_Resultado = dw_1.modify(ls_Modify)	
next

dw_1.insertrow(1)
dw_1.object.orden[1] = 1
dw_1.object.periodo[1] = "SEMANA DEL 11 AL 17 DE JULIO"
dw_1.insertrow(2)
dw_1.object.orden[2] = 2
dw_1.object.periodo[2] = "SEMANA DEL 18 AL 24 DE JULIO"
dw_1.sort()
dw_1.groupcalc()

//Vamos a simular eventos
ls_sel = "select 0 as evento,"+&
		 "       0 as dia_semana,"+&
		 "       0 as hora,"+&
		 "       0 as minuto,"+&
		 "       0 as duracion,"+&
		 "       '' as descripcion_evento,"+&
		 "       convert(datetime,'00/00/0000 00:00') as hora_inicio_evento,"+&
		 "       convert(datetime,'00/00/0000 00:00') as hora_final_evento,"+&
		 "       0 as orden_evento_dia,"+&
		 "       0 as columna_evento_dia,"+&
		 "       0 as ancho_columna_dia "+&
		 "from empresas where 0 = 1"

f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

li_eventos = integer(em_eventos.text)

for li_evento = 1 to li_eventos
	li_dia_semana  = rand(7)
	li_hora_dia    = (rand(li_horas_visibles) - 1) + li_hora_inicio
	li_minuto_hora = (rand(6) - 1) * 10
	li_duracion_evento_minutos = rand(18) * 10
	
	choose case rand(4)
		case 1
			ls_descripcion_evento = "PREPARAR CAMIÓN"
		case 2
			ls_descripcion_evento = "PREPARAR CONTENEDOR"
		case 3
			ls_descripcion_evento = "CARGAR CAMIÓN"
		case 4
			ls_descripcion_evento = "CARGAR CONTENEDOR"
	end choose
	
	li_donde = ds_datos.insertrow(0)
	
	ds_datos.object.evento[li_donde]             = li_evento
	ds_datos.object.dia_semana[li_donde]         = li_dia_semana
	ds_datos.object.hora[li_donde]               = li_hora_dia
	ds_datos.object.minuto[li_donde]             = li_minuto_hora
	ds_datos.object.duracion[li_donde]           = li_duracion_evento_minutos
	ds_datos.object.descripcion_evento[li_donde] = ls_descripcion_evento
//	ds_datos.object.hora_inicio_evento[li_donde] = datetime(mdy(7,),time())
//	ds_datos.object.hora_final_evento[li_donde]  = datetime()
	ds_datos.object.orden_evento_dia[li_donde]   = 0
	ds_datos.object.columna_evento_dia[li_donde] = 0
	ds_datos.object.ancho_columna_dia[li_donde]  = 0
next

for li_evento = 1 to li_eventos
	ls_orden_visible = string(rand(2),"0")
	
	li_dia_semana  = rand(7)
	li_hora_dia    = (rand(li_horas_visibles) - 1) + li_hora_inicio
	li_minuto_hora = (rand(6) - 1) * 10
	li_duracion_evento_minutos = rand(18) * 10
	
	li_posicion_y = (li_inicio_y_hora[li_hora_dia] + ((li_tamano_horas / 60) * li_minuto_hora)) - 4
	
	ls_posicion_x = string(li_posicion_x_dia[li_dia_semana] + li_posicion_x_rectangulo_con_respecto_a_dia,"#####0")
	ls_posicion_y = string(li_posicion_y,"#####0")
	
	li_width = li_ancho_dia + li_ancho_rectangulo_tarea_con_respecto_a_dia
	ls_width = string(li_width,"#####0")
	
	li_height = (li_tamano_horas / 60) * li_duracion_evento_minutos
	
	ls_height     = string(li_height,"#####0") 
	
	ls_color_tarea = ls_colores_tareas[rand(8)] //16711680
	
	//Rectangulo Evento
	ls_nombre_objeto = "rr_evento_"+string(li_evento,"000")

	ls_Modify    = "create roundrectangle(band=detail ellipseheight=~"36~" ellipsewidth=~"41~"x=~""+ls_posicion_x+"~" y=~""+ls_posicion_y+"~" height=~"140~" width=~"457~"  name="+ls_nombre_objeto+" visible=~"1~" brush.hatch=~"6~" brush.color=~"16777215~" pen.style=~"0~" pen.width=~"5~" pen.color=~"16711680~"  background.mode=~"1~" background.color=~"553648127~" )	"	
	
//								  roundrectangle(band=detail ellipseheight="36" ellipsewidth="41"x="1029" y="408" height="292" width="229"  name=rr_3 visible="1" brush.hatch="7" brush.color="553648127" pen.style="0" pen.width="5" pen.color="16711680"  background.mode="1" background.color="553648127" )
//								  roundrectangle(band=detail ellipseheight="36" ellipsewidth="41"x="1257" y="152" height="292" width="229"  name=rr_4 visible="1" brush.hatch="5" brush.color="255" pen.style="0" pen.width="5" pen.color="16711680"  background.mode="2" background.color="16777215" )		

	ls_Modify    = "create roundrectangle(band=detail ellipseheight=~"36~" ellipsewidth=~"41~"x=~""+ls_posicion_x+"~" y=~""+ls_posicion_y+"~" height=~""+ls_height+"~" width=~""+ls_width+"~"  name="+ls_nombre_objeto+" visible=~"1~tif( orden = "+ls_orden_visible+" , 1 , 0 )~" brush.hatch=~"7~" brush.color=~"553648127~" pen.style=~"0~" pen.width=~"23~" pen.color=~""+ls_color_tarea+"~"  background.mode=~"1~" background.color=~"553648127~" )	"		
	ls_Resultado = dw_1.modify(ls_Modify)
	
	//Texto Evento
	ls_posicion_x = string((integer(ls_posicion_x) + li_posicion_x_texto_con_respecto_a_rectangulo),"#####0")
	ls_posicion_y = string((integer(ls_posicion_y) + li_posicion_y_texto_con_respecto_a_rectangulo),"#####0")
	ls_width = string((integer(ls_width) + li_ancho_texto_con_respecto_a_rectangulo),"#####0")
	ls_height = string((integer(ls_height) + li_alto_texto_con_respecto_a_rectangulo),"#####0")	
	
	if li_duracion_evento_minutos <= 10 then
		ls_fontheight = "6"
	else
		ls_fontheight = "8"
	end if	
	
	ls_nombre_objeto = "t_evento_"+string(li_evento,"000")
	ls_texto_tarea = string(li_hora_dia,"00")+":"+string(li_minuto_hora,"00")+" Tarea "+string(li_evento,"000")
	ls_Modify    = "create text(band=detail alignment=~"3~" text=~""+ls_texto_tarea+"~" border=~"0~" color=~"0~" x=~""+ls_posicion_x+"~" y=~""+ls_posicion_y+"~" height=~""+ls_height+"~" width=~""+ls_width+"~" html.valueishtml=~"0~"  name="+ls_nombre_objeto+" visible=~"1~tif( orden = "+ls_orden_visible+" , 1 , 0 )~"  font.face=~"Arial~" font.height=~"-"+ls_fontheight+"~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~""+ls_color_tarea+"~" )"
	
	ls_Resultado = dw_1.modify(ls_Modify)
	//w_1.BringToTop = TRUE
next

dw_1.sort()
dw_1.groupcalc()
dw_1.setredraw(true)

destroy ds_datos


//Texto Hora:
//text(band=detail alignment=~"2~" text=~"00~" border=~"2~" color=~"0~" x=~"9~" y=~"4~" height=~"140~" width=~"64~" html.valueishtml=~"0~"  name=t_hora_0 visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"12632256~" )
//Linea Media Hora:
//line(band=detail x1=~"9~" y1=~"76~" x2=~"3369~" y2=~"76~"  name=l_hora_0_1 visible=~"1~" pen.style=~"2~" pen.width=~"5~" pen.color=~"0~"  background.mode=~"2~" background.color=~"1073741824~" )
//Linea Final Hora:
//line(band=detail x1=~"9~" y1=~"144~" x2=~"3369~" y2=~"144~"  name=l_hora_0_2 visible=~"1~" pen.style=~"0~" pen.width=~"5~" pen.color=~"0~"  background.mode=~"2~" background.color=~"1073741824~" )


//Rectangulo Evento
//roundrectangle(band=detail ellipseheight=~"36~" ellipsewidth=~"41~"x=~"87~" y=~"0~" height=~"140~" width=~"457~"  name=rr_hora_0_1_1 visible=~"1~" brush.hatch=~"6~" brush.color=~"16777215~" pen.style=~"0~" pen.width=~"5~" pen.color=~"16711680~"  background.mode=~"1~" background.color=~"553648127~" )

//Texto Evento
//text(band=detail alignment=~"3~" text=~"00:15 Camión2500Kg~" border=~"0~" color=~"0~" x=~"101~" y=~"8~" height=~"124~" width=~"430~" html.valueishtml=~"0~"  name=t_5 visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"12639424~" )

end event

