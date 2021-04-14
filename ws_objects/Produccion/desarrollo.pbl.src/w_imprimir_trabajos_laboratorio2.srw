$PBExportHeader$w_imprimir_trabajos_laboratorio2.srw
forward
global type w_imprimir_trabajos_laboratorio2 from window
end type
type st_3 from statictext within w_imprimir_trabajos_laboratorio2
end type
type r_1 from rectangle within w_imprimir_trabajos_laboratorio2
end type
type cb_salir from commandbutton within w_imprimir_trabajos_laboratorio2
end type
type cb_continuar from commandbutton within w_imprimir_trabajos_laboratorio2
end type
type st_2 from statictext within w_imprimir_trabajos_laboratorio2
end type
type sle_pruebas from singlelineedit within w_imprimir_trabajos_laboratorio2
end type
type st_1 from statictext within w_imprimir_trabajos_laboratorio2
end type
end forward

global type w_imprimir_trabajos_laboratorio2 from window
integer x = 1056
integer y = 484
integer width = 1431
integer height = 500
boolean titlebar = true
string title = "Imprimir Trabajos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
st_3 st_3
r_1 r_1
cb_salir cb_salir
cb_continuar cb_continuar
st_2 st_2
sle_pruebas sle_pruebas
st_1 st_1
end type
global w_imprimir_trabajos_laboratorio2 w_imprimir_trabajos_laboratorio2

on w_imprimir_trabajos_laboratorio2.create
this.st_3=create st_3
this.r_1=create r_1
this.cb_salir=create cb_salir
this.cb_continuar=create cb_continuar
this.st_2=create st_2
this.sle_pruebas=create sle_pruebas
this.st_1=create st_1
this.Control[]={this.st_3,&
this.r_1,&
this.cb_salir,&
this.cb_continuar,&
this.st_2,&
this.sle_pruebas,&
this.st_1}
end on

on w_imprimir_trabajos_laboratorio2.destroy
destroy(this.st_3)
destroy(this.r_1)
destroy(this.cb_salir)
destroy(this.cb_continuar)
destroy(this.st_2)
destroy(this.sle_pruebas)
destroy(this.st_1)
end on

type st_3 from statictext within w_imprimir_trabajos_laboratorio2
integer x = 325
integer y = 72
integer width = 869
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
boolean enabled = false
string text = "Introducir Rango: 1-4"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_imprimir_trabajos_laboratorio2
long linecolor = 65280
integer linethickness = 12
long fillcolor = 15780518
integer x = 18
integer y = 12
integer width = 1376
integer height = 384
end type

type cb_salir from commandbutton within w_imprimir_trabajos_laboratorio2
integer x = 773
integer y = 256
integer width = 411
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;Close (parent)
end event

type cb_continuar from commandbutton within w_imprimir_trabajos_laboratorio2
integer x = 352
integer y = 256
integer width = 411
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;string datos, sel, caracter, datos_aux, cliente
long i, j, posicion, a, b, pruebas []
datastore total_pruebas
boolean cadena_correcta

w_mant_desmodelos_laboratorio.dw_ficha_laboratorio.SetTransObject(SQLCA)

datos_aux = sle_pruebas.text
cadena_correcta = True

for i= 1 to len (datos_aux)
	caracter = mid(datos_aux, i, 1)
	if isnumber(caracter) or caracter = ',' or caracter = '-' or caracter = ' ' then
		if caracter <> ' ' then
			datos = datos + caracter
		end if
	else
		cadena_correcta = false
	end if
next
if cadena_correcta then
	if isnull(datos) or datos = "" then
		sel = " select trabajo "+&
				" from destrabajo2 "+&
				" where empresa = '"+codigo_empresa+"'"+&
				" and modelo = '"+w_mant_desmodelos_laboratorio.sle_valor.text+"'"
		f_cargar_cursor_nuevo(sel, total_pruebas)
		
		for i = 1 to total_pruebas.rowcount() 
			pruebas[i] = total_pruebas.object.trabajo[i]
		next
	else
		posicion = pos (datos, '-')
		if posicion > 0 then
			a =  long(left(datos, posicion - 1 ))
			b =  long(right(datos, len(datos) - posicion))
			j = 1
			for i = a to b
				pruebas[j] = i
				j ++
			next
		else
			posicion = pos (datos, ',') 
			i= 1
			do while posicion >0
				posicion = pos (datos, ',')
				pruebas[i] = long(left(datos, posicion - 1 ))
				datos = right(datos, len(datos) - posicion)
			
				i ++
			loop
			if datos <> "" then
				pruebas[i] = long(datos)
			end if
		end if
	end if
	
	w_mant_desmodelos_laboratorio.dw_ficha_laboratorio.retrieve(codigo_empresa, w_mant_desmodelos_laboratorio.sle_valor.text, pruebas)
	f_imprimir_datawindow(w_mant_desmodelos_laboratorio.dw_ficha_laboratorio)
	close(parent)
else
	messagebox("Error", "Rango mal Introducido")
end if

end event

type st_2 from statictext within w_imprimir_trabajos_laboratorio2
integer x = 325
integer y = 24
integer width = 1042
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
boolean enabled = false
string text = "Introducir separados por comas: 1,2,4,6"
boolean focusrectangle = false
end type

type sle_pruebas from singlelineedit within w_imprimir_trabajos_laboratorio2
integer x = 343
integer y = 144
integer width = 855
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_imprimir_trabajos_laboratorio2
integer x = 73
integer y = 148
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Pruebas:"
boolean focusrectangle = false
end type

