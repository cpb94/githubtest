$PBExportHeader$u_seleccion2.sru
$PBExportComments$Objeto para seleccionar parametros en una consulta (Sirve para parametros agrupados en grupo/subgrupo - join de una tabla)
forward
global type u_seleccion2 from datawindow
end type
end forward

global type u_seleccion2 from datawindow
integer width = 2217
integer height = 1080
string title = "none"
string dataobject = "dw_padre_seleccion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type
global u_seleccion2 u_seleccion2

forward prototypes
public function string devolver_resultado ()
public function integer devolver_seleccionados ()
public function string devolver_resultado (integer tipo_variable, integer parametros)
end prototypes

public function string devolver_resultado ();String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

//Obtención de los campos de la clave primaria
	
//Obtención de la consulta. Quitamos el select
consulta = this.GetSQLSelect()
consulta = trim(mid(consulta,7))

//Código del padre (Entidad con clave primaria fuerte)
p1 = pos (consulta, ",")
nombre_padre = trim(mid(consulta,1,p1 - 1))

//Saltamos la descrición
consulta = trim(mid(consulta,p1+1))
p1 = pos (consulta, ",")
consulta = trim(mid(consulta,p1+1))

//Código del elemento seleccionado (Entidad con clave primaria débil)
p1 = pos (consulta, ",")
nombre_seleccionado = trim(mid(consulta,1,p1 - 1))

numero_seleccionados = 0
resultado = "("
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		if numero_seleccionados = 0 then
			resultado = resultado + "(" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
		else
			resultado = resultado + " OR (" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
		end if
		numero_seleccionados ++
	end if
Next
resultado = resultado + ")"

return resultado
end function

public function integer devolver_seleccionados ();Long i, seleccionado, numero_seleccionados

numero_seleccionados = 0
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		numero_seleccionados ++
	end if
Next

return numero_seleccionados
end function

public function string devolver_resultado (integer tipo_variable, integer parametros);String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

//TIPOS DE VARIABLES
//tipo_variable = 1 
//Hay que devolver el primer código (padre) como int y el segundo (seleccionado) como string
//tipo_variable = 2 
//Hay que devolver el primer código (padre) como string y el segundo (seleccionado) como int
//tipo_variable = 3 
//Hay que devolver los dos códigos como int

//PARAMETROS
//Si parametros = 1 a uno solo se solicita el codigo del elemento hijo. De lo contrario se devuelven los 2 codigos 

//Obtención de los campos de la clave primaria
	
//Obtención de la consulta. Quitamos el select
consulta = this.GetSQLSelect()
consulta = trim(mid(consulta,7))

//Código del padre (Entidad con clave primaria fuerte)
p1 = pos (consulta, ",")
nombre_padre = trim(mid(consulta,1,p1 - 1))

//Saltamos la descrición
consulta = trim(mid(consulta,p1+1))
p1 = pos (consulta, ",")
consulta = trim(mid(consulta,p1+1))

//Código del elemento seleccionado (Entidad con clave primaria débil)
p1 = pos (consulta, ",")
nombre_seleccionado = trim(mid(consulta,1,p1 - 1))

numero_seleccionados = 0
resultado = "("
For i = 1 To this.rowcount()
	seleccionado = this.object.seleccionado[i]
	if seleccionado = 1 then
		if numero_seleccionados = 0 then
			if parametros = 1 then
				if tipo_variable = 2 or tipo_variable = 3 then
					resultado = resultado + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i]
				else
					resultado = resultado + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "'"
				end if
			else
				if tipo_variable = 1 then
					resultado = resultado + "(" + nombre_padre + " = " + this.object.codigo_padre[i] + " AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
				elseif tipo_variable = 2 then
					resultado = resultado + "(" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i] + ")"
				elseif tipo_variable = 3 then
					resultado = resultado + "(" + nombre_padre + " = " + this.object.codigo_padre[i] + " AND " + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i] + ")"
				else
					resultado = resultado + "(" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
				end if
			end if
		else
			if parametros = 1 then
				if tipo_variable = 2 or tipo_variable = 3 then
					resultado = resultado + " OR " + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i]
				else
					resultado = resultado + " OR " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "'"
				end if
			else
				if tipo_variable = 1 then
					resultado = resultado + " OR (" + nombre_padre + " = " + this.object.codigo_padre[i] + " AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
				elseif tipo_variable = 2 then
					resultado = resultado + " OR (" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i] + ")"
				elseif tipo_variable = 3 then
					resultado = resultado + " OR (" + nombre_padre + " = " + this.object.codigo_padre[i] + " AND " + nombre_seleccionado + " = " + this.object.codigo_seleccionado[i] + ")"
				else
					resultado = resultado + " OR (" + nombre_padre + " = '" + this.object.codigo_padre[i] + "' AND " + nombre_seleccionado + " = '" + this.object.codigo_seleccionado[i] + "')"
				end if
			end if
		end if
		numero_seleccionados ++
	end if
Next
resultado = resultado + ")"

return resultado
end function

event clicked;String codigo_padre, resultado, consulta, nombre_padre, nombre_seleccionado
Long seleccionado, i, accion, posicion, numero_seleccionados
Long p1, p2

this.AcceptText()

//Obtención de los campos de la clave primaria
	
//Obtención de la consulta. Quitamos el select
consulta = this.GetSQLSelect()
consulta = trim(mid(consulta,7))

//Código del padre (Entidad con clave primaria fuerte)
p1 = pos (consulta, ",")
nombre_padre = trim(mid(consulta,1,p1 - 1))

//Saltamos la descrición
consulta = trim(mid(consulta,p1+1))
p1 = pos (consulta, ",")
consulta = trim(mid(consulta,p1+1))

//Código del elemento seleccionado (Entidad con clave primaria débil)
p1 = pos (consulta, ",")
nombre_seleccionado = trim(mid(consulta,1,p1 - 1))

if row = 0 then
	//Los grupos de un Tree View están en la cabecera, por lo que row es igual a 0
	if not isnull(dwo.name) and dwo.name = "marcar" or dwo.name = "desmarcar" then	
		//Para obtener el valor del código padre (valor por el que se agrupa) hay que obtener la primera fila del data window cuyo código padre es el seleccionado.
		//Utilizamos GetBandAtPointer(), que nos muestra la banda seleccionada y la primera fila del grupo seleccionado en un string separado por un tabulador.
		codigo_padre = this.GetBandAtPointer()
		//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
		posicion = Long(Mid(codigo_padre, LastPos(codigo_padre, "~t") + 1))
		codigo_padre = this.object.codigo_padre[posicion] 
		//Obtenenos la acción seleccionada por el usuario (marcar todos o desmarcar todos)
		if dwo.name = "desmarcar" then
			accion = 0
		else
			accion = 1
		end if
		//Aplicamos a todos los miembros del grupo la acción
		//Tener en cuenta que el data window está ordenado por el grupo, empezando las filas del grupo por la fila obtenida previamanete y terminando en cuanto cambia el código del padre
		i = posicion
		Do While i <= this.rowcount() and accion <> -1 
			if this.object.codigo_padre[i] = codigo_padre then
				this.object.seleccionado[i] =  accion
			else
				accion = -1
			end if
			i++
		Loop		
	end if
end if
end event

on u_seleccion2.create
end on

on u_seleccion2.destroy
end on

