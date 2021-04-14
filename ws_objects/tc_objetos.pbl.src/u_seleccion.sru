$PBExportHeader$u_seleccion.sru
$PBExportComments$Objeto para seleccionar parametros en una consulta (Sirve para parametros de una sola tabla)
forward
global type u_seleccion from datawindow
end type
end forward

global type u_seleccion from datawindow
integer width = 2217
integer height = 1080
string title = "none"
string dataobject = "dw_padre_seleccion_1tabla"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type
global u_seleccion u_seleccion

forward prototypes
public function string devolver_resultado ()
public function string devolver_resultado (integer tipo_variable)
public function integer devolver_selecionados ()
end prototypes

public function string devolver_resultado ();String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

this.AcceptText()

//Obtención de los campos de la clave primaria
	
//Obtención de la consulta. Quitamos el select
consulta = this.GetSQLSelect()
consulta = trim(mid(consulta,7))

//Código (Entidad con clave primaria fuerte)
p1 = pos (consulta, ",")
nombre_padre = trim(mid(consulta,1,p1 - 1))

//Preparación del resultado (elementos seleccionados listos para realizar consulta con ellos)
numero_seleccionados = 0
resultado = "("
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		if numero_seleccionados = 0 then
			resultado = resultado + nombre_padre + " = '" + this.object.codigo[i] + "'"
		else
			resultado = resultado + " OR " + nombre_padre + " = '" + this.object.codigo[i] + "'"
		end if
		numero_seleccionados ++
	end if
Next
resultado = resultado + ")"

return resultado

end function

public function string devolver_resultado (integer tipo_variable);String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

//TIPO VARIABLE
//Si tipo variable es 1 es tipo int, en cualquier otro caso se trata como string

this.AcceptText()

//Obtención de los campos de la clave primaria
	
//Obtención de la consulta. Quitamos el select
consulta = this.GetSQLSelect()
consulta = trim(mid(consulta,7))

//Código (Entidad con clave primaria fuerte)
p1 = pos (consulta, ",")
nombre_padre = trim(mid(consulta,1,p1 - 1))

//Preparación del resultado (elementos seleccionados listos para realizar consulta con ellos)
numero_seleccionados = 0
resultado = "("
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		if numero_seleccionados = 0 then
			if tipo_variable = 1 then
				resultado = resultado + nombre_padre + " = " + this.object.codigo[i]
			else
				resultado = resultado + nombre_padre + " = '" + this.object.codigo[i] + "'"
			end if
		else
			if tipo_variable = 1 then
				resultado = resultado + " OR " + nombre_padre + " = " + this.object.codigo[i]
			else
				resultado = resultado + " OR " + nombre_padre + " = '" + this.object.codigo[i] + "'"
			end if
		end if
		numero_seleccionados ++
	end if
Next
resultado = resultado + ")"

return resultado
end function

public function integer devolver_selecionados ();Long seleccionado, i, numero_seleccionados

numero_seleccionados = 0
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		numero_seleccionados ++
	end if
Next

return numero_seleccionados
end function

event clicked;String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

this.AcceptText()

if row = 0 then
	//Los grupos de un Tree View están en la cabecera, por lo que row es igual a 0
	if not isnull(dwo.name) and dwo.name = "marcar" or dwo.name = "desmarcar" then	
		//Obtenenos la acción seleccionada por el usuario (marcar todos o desmarcar todos)
		if dwo.name = "desmarcar" then
			accion = 0
		else
			accion = 1
		end if
		i = 1
		Do While i <= this.rowcount()
			this.object.seleccionado[i] = accion
			i++
		Loop		
	end if
end if
end event

on u_seleccion.create
end on

on u_seleccion.destroy
end on

