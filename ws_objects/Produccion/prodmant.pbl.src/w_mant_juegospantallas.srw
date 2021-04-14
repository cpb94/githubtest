$PBExportHeader$w_mant_juegospantallas.srw
forward
global type w_mant_juegospantallas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_juegospantallas
end type
type pb_1 from upb_imprimir within w_mant_juegospantallas
end type
type dw_listado from datawindow within w_mant_juegospantallas
end type
type st_2 from statictext within w_mant_juegospantallas
end type
type dw_pantallas from u_datawindow within w_mant_juegospantallas
end type
type cb_insertar2 from commandbutton within w_mant_juegospantallas
end type
type cb_2 from commandbutton within w_mant_juegospantallas
end type
end forward

global type w_mant_juegospantallas from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2249
integer height = 2080
pb_calculadora pb_calculadora
pb_1 pb_1
dw_listado dw_listado
st_2 st_2
dw_pantallas dw_pantallas
cb_insertar2 cb_insertar2
cb_2 cb_2
end type
global w_mant_juegospantallas w_mant_juegospantallas

type variables
string modelo
end variables

forward prototypes
public function integer f_asignar_ubicacion_optima ()
public function boolean f_hay_espacio_en_ubicacion_actual ()
public function boolean f_hay_ubicacion_asignada ()
end prototypes

public function integer f_asignar_ubicacion_optima ();datastore ubicaciones
int exito
string consulta, tipo_pantalla
int total_ubicaciones, i, diferencia, diferencia_ant, ubicacion_optima, ocupacion, total_pantallas
int capacidad
boolean encontrado

encontrado = false
ubicacion_optima = 0
tipo_pantalla = dw_1.object.tipo[dw_1.Getrow()]
consulta = 	" select convert(integer, prodalmacenpantallas.codigo) as codigo, prodalmacenpantallas.capacidad, sum(juegospantallas.n_pantallas) as ocupacion"+&
				" from juegospantallas, prodalmacenpantallas "+&
				" where juegospantallas.empresa = '"+codigo_empresa+"' "+&
				" and prodalmacenpantallas.empresa = '"+codigo_empresa+"' "+&
				" and prodalmacenpantallas.codigo *= juegospantallas.ubicacion  "+&
				" and prodalmacenpantallas.tipo = '"+tipo_pantalla +"' "+&
				" group by convert(integer, prodalmacenpantallas.codigo), prodalmacenpantallas.capacidad "+&
				" order by convert(integer,prodalmacenpantallas.codigo) ASC "
				
f_cargar_cursor_nuevo (consulta, ubicaciones)
total_ubicaciones = ubicaciones.RowCount()
i = 1
if total_ubicaciones > 0 then
	// Inicicalizamos diferencia al valor de la capacidad de la primera ubicación
	if isnull(ubicaciones.object.prodalmacenpantallas_capacidad[i]) or ubicaciones.object.prodalmacenpantallas_capacidad[i] = 0 then
		messagebox("Aviso", "La ubicación "+string(ubicaciones.object.codigo[i])+" no tinene definida la capacidad")
		ubicacion_optima = 0
	else
		ubicacion_optima = ubicaciones.object.codigo[i]
		diferencia = ubicaciones.object.prodalmacenpantallas_capacidad[i]
		diferencia_ant = diferencia
		encontrado = false
		do while i <= total_ubicaciones and diferencia <> 0 and encontrado = false
			if isnull(ubicaciones.object.prodalmacenpantallas_capacidad[i]) then capacidad = 0 else capacidad = ubicaciones.object.prodalmacenpantallas_capacidad[i]
			if isnull(ubicaciones.object.ocupacion[i]) then ocupacion = 0 else ocupacion = ubicaciones.object.ocupacion[i]
			total_pantallas = ocupacion + dw_1.object.n_pantallas[dw_1.GetRow()]
			diferencia = capacidad - total_pantallas
			if diferencia >= 0 then
				ubicacion_optima = ubicaciones.object.codigo[i]
				encontrado = True
			end if
			i = i + 1
//			if isnull(ubicaciones.object.prodalmacenpantallas_capacidad[i]) then capacidad = 0 else capacidad = ubicaciones.object.prodalmacenpantallas_capacidad[i]
//			if isnull(ubicaciones.object.ocupacion[i]) then ocupacion = 0 else ocupacion = ubicaciones.object.ocupacion[i]
//			total_pantallas = ocupacion + dw_1.object.n_pantallas[dw_1.GetRow()]
//			diferencia = capacidad - total_pantallas
//			if total_pantallas <= capacidad and diferencia_ant > diferencia then
//				ubicacion_optima = ubicaciones.object.codigo[i]
//				diferencia_ant = diferencia
//				encontrado = True
//			end if
//			i = i + 1
		loop
	end if
else
	ubicacion_optima = 0
	messagebox("Aviso", "No hay ninguna ubicacion definida.")
end if

if i > total_ubicaciones and  not encontrado then
	messagebox("Aviso", "No hay espacio en ninguna ubicación.")
	ubicacion_optima = 0	
	dw_1.object.n_pantallas[dw_1.GetRow()] = 0
end if

destroy ubicaciones
return ubicacion_optima
end function

public function boolean f_hay_espacio_en_ubicacion_actual ();boolean hay_Espacio
int ocupacion, ubicacion_actual, capacidad_actual, n_pantallas
long v_juegopantallas

v_juegopantallas = long(dw_1.object.codigo[dw_1.GetRow()])

hay_espacio = true
if v_juegopantallas <> 0 and not isnull(v_juegopantallas) then
	if  isnull(dw_1.object.ubicacion[dw_1.GetRow()]) then 	
		ubicacion_actual = 0 
	else 
		ubicacion_actual = dw_1.object.ubicacion[dw_1.GetRow()]
	end if
	if isnull(dw_1.object.n_pantallas[dw_1.GetRow()] ) then 
		n_pantallas = 0 
	else 
	n_pantallas = dw_1.object.n_pantallas[dw_1.GetRow()]  
	end if

	// Stock actual de la ubicacion sin tener en cuenta el articulo actual
	select sum(juegospantallas.n_pantallas) 
	into :ocupacion
	from juegospantallas, prodalmacenpantallas 
	where juegospantallas.empresa = :codigo_empresa
	and prodalmacenpantallas.empresa = :codigo_empresa
	and prodalmacenpantallas.codigo *= juegospantallas.ubicacion  
	and prodalmacenpantallas.codigo = :ubicacion_actual
	and juegospantallas.codigo <> :v_juegopantallas;
	
	select capacidad 
	into :capacidad_actual
	from prodalmacenpantallas
	where empresa = :codigo_empresa
	and codigo = :ubicacion_actual;
	
	if ocupacion + n_pantallas > capacidad_actual or ubicacion_actual = 0 then
		hay_espacio = false
	end if
else
	hay_espacio = false
end if

if not hay_espacio  and ubicacion_actual <> 0 then
	messagebox("Aviso","No hay espacio en la ubicación actual. Se asignará una nueva")	
end if
return hay_espacio
end function

public function boolean f_hay_ubicacion_asignada ();boolean hay_ubicacion_asignada

if dw_1.object.ubicacion[dw_1.GetRow()] = 0 or isnull(dw_1.object.ubicacion[dw_1.GetRow()]) then
	hay_ubicacion_asignada = false
else
	hay_ubicacion_asignada = true
end if
return hay_ubicacion_asignada

end function

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Juegos de Pantallas"

This.title = istr_parametros.s_titulo_ventana

dw_pantallas.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos > 1 THEN
	modelo = istr_parametros.s_argumentos[3] // Cargamos la variable de instancia con el artículo para el que creamos el juego.
	sle_valor.text = istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_pantallas.Retrieve(codigo_empresa,sle_valor.Text)
		
	END IF
END IF



	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"descripcion",'JUEGO PANT.')

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "juegospantallas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_pantallas.Retrieve(codigo_empresa,sle_valor.Text)


CALL Super::ue_recuperar
end event

on w_mant_juegospantallas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.st_2=create st_2
this.dw_pantallas=create dw_pantallas
this.cb_insertar2=create cb_insertar2
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_pantallas
this.Control[iCurrent+6]=this.cb_insertar2
this.Control[iCurrent+7]=this.cb_2
end on

on w_mant_juegospantallas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.st_2)
destroy(this.dw_pantallas)
destroy(this.cb_insertar2)
destroy(this.cb_2)
end on

event activate;call super::activate;w_mant_juegospantallas = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_juegospantallas
integer x = 0
integer y = 280
integer width = 2194
integer height = 384
integer taborder = 20
string dataobject = "dw_mant_juegospantallas"
end type

event dw_1::key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT archivo_disenyo_sistema_archivos.tipomaquina_disenyo, archivo_disenyo_sistema_archivos.archivo, tipomaquina_disenyo.prefijo, archivo_disenyo_sistema_archivos.codigo, CONVERT(CHAR(20),archivo_disenyo_sistema_archivos.fichero), archivo_disenyo_sistema_archivos.observaciones "+&
							"FROM archivo_disenyo_sistema_archivos "+&
							"INNER JOIN tipomaquina_disenyo ON  archivo_disenyo_sistema_archivos.empresa = tipomaquina_disenyo.empresa and archivo_disenyo_sistema_archivos.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
							"WHERE archivo_disenyo_sistema_archivos.empresa = '"+codigo_empresa+"' AND archivo_disenyo_sistema_archivos.tipomaquina_disenyo = '3' "+&
							"ORDER BY archivo_disenyo_sistema_archivos.fichero"


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Cód. Máquina Diseño"
busqueda.titulos[3] = "Máquina Diseño"
busqueda.titulos[2] = "Cód. Archivo"
busqueda.titulos[4] = "Prueba"
busqueda.titulos[5] = "Fichero"
busqueda.titulos[6] = "Observaciones"


IF KeyDown(KeyEnter!) OR (not isnull(Message.LongParm) and Message.LongParm = 1001) THEN  
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado > 0 then
		dw_1.object.tipomaquina_disenyo[1] 								= resultado.valores[1]
		dw_1.object.archivo[1] 												= resultado.valores[2]
		dw_1.object.prueba[1] 												= resultado.valores[4]
		dw_1.object.archivo_disenyo_sistema_archivos_fichero[1] 	= resultado.valores[5]
	end if
END IF

end event

event dw_1::itemchanged;call super::itemchanged;if row > 0 then
	if dwo.name = "archivo_disenyo_sistema_archivos_fichero" then
		dwo.Primary[row] = ''
		dw_1.object.tipomaquina_disenyo[1] = ""
		dw_1.object.archivo[1] = ""
		dw_1.object.prueba[1] = ""
		return 2		
	end if
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_juegospantallas
integer x = 41
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_juegospantallas
integer x = 891
integer y = 160
integer height = 96
end type

event cb_insertar::clicked;int pantallas, i, fila_actual
datastore regs
string sel, cod_pantalla, des_pantalla, articulo, ver, operacion, contadoraplicacion, archivo
dec ancho, largo, hilos, paso, gramaje
long k, m


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//														CREAR PANTALLAS
//////////////////////////////////////////////////////////////////////////////////////////////////////////

if dw_pantallas.rowcount() < 1 then
	if dw_1.rowcount() > 0 then
		pantallas = dw_1.object.n_pantallas[dw_1.GetRow()]
		
		for i = 1 to pantallas
			cb_insertar2.TriggerEvent (clicked!)
			fila_actual = dw_pantallas.Getrow()
			dw_pantallas.object.descripcion[i] = sle_valor.text+"-"+string(i)
			dw_pantallas.object.numero_hilos[i] = 90
		next
	end if
end if
//////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_pantallas.update()

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//														ASIGNAR UBICACIÓN
//////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.accepttext()
if dw_1.rowcount() > 0 then
	
	archivo = dw_1.object.archivo_disenyo_sistema_archivos_fichero[dw_1.GetRow()]
	if not isnull(archivo) and archivo <> "" then
		dw_1.object.descripcion[dw_1.GetRow()] = mid(archivo,1,pos(archivo,"-") - 1)
	end if
	
	if isnull(dw_1.object.n_pantallas[dw_1.GetRow()]) then 
		pantallas = 0 
	else 
		pantallas = dw_1.object.n_pantallas[dw_1.GetRow()]
	end if

	connect using SQLCA;
	if not f_bloquear("Gestión Almacén Pantallas Producción","Almacen_pantallas_prod",titulo) then
		commit;
		dw_1.accepttext()
		if dw_1.Rowcount() > 0 then
			if (not f_hay_ubicacion_asignada() or not f_hay_espacio_en_ubicacion_actual()) and pantallas <> 0 then
				dw_1.object.ubicacion[dw_1.GetRow()] = f_asignar_ubicacion_optima()	 
			end if
		end if
	else
		messagebox("Bloqueo", "Hay un usuario bloqueando la tabla")
	end if
end if
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//											CÁLCULO DEL GRAMAJE DE CADA PANTALLA
//////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_pantallas.accepttext()
for k = 1 to dw_pantallas.rowcount()
	cod_pantalla = dw_pantallas.object.codigo [k]
	
	sel = " select art_ver_op_aplicaciones.articulo, art_ver_op_aplicaciones.version, art_ver_op_aplicaciones.operacion, "+& 
			" art_ver_op_aplicaciones.contadoraplicacion, formatos.ancho, formatos.largo "+&
			" from art_ver_op_aplicaciones, art_ver_operaciones, formatos "+&
			" where art_ver_op_aplicaciones.empresa = '"+codigo_empresa+"' "+&
			" and art_ver_op_aplicaciones.empresa = art_Ver_operaciones.empresa "+&
			" and art_ver_op_aplicaciones.articulo = art_Ver_operaciones.articulo "+&
			" and art_ver_op_aplicaciones.version = art_Ver_operaciones.version "+&
			" and art_ver_op_aplicaciones.operacion = art_Ver_operaciones.operacion "+&
			" and art_ver_op_aplicaciones.pantalla = '"+cod_pantalla+"' "+&
			" and art_ver_operaciones.empresa = formatos.empresa "+&
			" and art_ver_operaciones.formato = formatos.codigo "

	f_cargar_cursor_nuevo (sel, regs)
	for m = 1 to regs.rowcount()
		articulo = regs.object.art_ver_op_aplicaciones_articulo[m]
		ver = regs.object.art_ver_op_aplicaciones_version[m]
		operacion = regs.object.art_ver_op_aplicaciones_operacion[m]
		contadoraplicacion = regs.object.art_ver_op_aplicaciones_contadoraplicacion[m]
		ancho = regs.object.formatos_ancho[m]
		largo = regs.object.formatos_largo[m]
		

		f_calculo_peso_mp ( cod_pantalla, ancho, largo, hilos, paso, gramaje, des_pantalla)

		if not isnull(paso) and paso <> 0 then
	
			update art_ver_op_aplicaciones
			set gramaje = :gramaje
			where articulo = :articulo
			and version = :ver
			and operacion = :operacion
			and contadoraplicacion = :contadoraplicacion;
		end if		

	next
	
next

destroy regs
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//		CÁLCULO DEL COSTE DE MATERIA PRIMA DE CADA OPERACIÓN QUE UTILICE ESTE JUEGO DE PANTALLAS													
//////////////////////////////////////////////////////////////////////////////////////////////////////////
sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "+&
		" where juegopantallas = '"+sle_valor.text+"' "

	f_cargar_cursor_nuevo (sel, regs)
	
	for m = 1 to regs.rowcount()
		articulo = regs.object.articulo[m]
		ver = regs.object.version[m]
		operacion = regs.object.operacion[m]

		f_calculo_mp_operacion ( codigo_empresa, articulo, operacion, ver)
		
		
	next			
destroy regs

Call super::clicked



connect using SQLCA;
f_desbloquear("Gestión Almacén Pantallas Producción","Almacen_pantallas_prod",titulo)
commit;




end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_juegospantallas
integer x = 1294
integer y = 160
integer height = 96
end type

event cb_borrar::clicked;string valor

valor = sle_valor.text
//if MessageBox("Aviso", "¿Se Borraran todas las Pantallas Asociadas?", Exclamation!, YesNo!, 2) = 1 then

CALL Super::clicked

if not cb_borrar.enabled then
	delete from prodpantallas 
	where empresa = :codigo_empresa 
	and juegopantallas = :valor;
	
	if SQLCA.SQLCode <> 0 then
		rollback;
	else
		commit;
	end if
end if
//end if



end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_juegospantallas
integer x = 315
integer y = 172
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_juegospantallas"
ue_titulo      = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
ue_filtro      = ""
end event

event sle_valor::losefocus;call super::losefocus;//if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
//end if
//
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_juegospantallas
integer x = 1696
integer y = 160
integer height = 96
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_juegospantallas
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_juegospantallas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_juegospantallas
integer y = 20
integer width = 2245
integer textsize = -12
end type

type pb_calculadora from u_calculadora within w_mant_juegospantallas
integer x = 581
integer y = 164
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   juegospantallas	
	Where  empresa = :codigo_empresa;
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   juegospantallas
		Where  empresa = :codigo_empresa;
	END IF
	dw_1.triggerEvent("clicked")
end if


dw_1.object.descripcion[dw_1.getrow()] = modelo
end event

type pb_1 from upb_imprimir within w_mant_juegospantallas
integer x = 2112
integer y = 160
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;long   indice,total,i
tipo_array val, ent

openWithParm(w_pedir_version,ent)
val =  message.powerObjectparm
IF val.valor[1] = "RETURN" Then 
	Return
end if

dw_listado.SetTransObject(SQLCA)
dw_listado.retrieve(codigo_empresa, val.valor[1],val.valor[2])

//		f_imprimir_ficha_tecnica_op(dw_listado,sle_valor.text,val.valor[1],val.valor[2])
f_imprimir_datawindow(dw_listado)


end event

type dw_listado from datawindow within w_mant_juegospantallas
boolean visible = false
integer x = 1984
integer y = 1124
integer width = 315
integer height = 164
boolean bringtotop = true
string dataobject = "dw_etiqueta_pantalla"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mant_juegospantallas
integer x = 55
integer y = 644
integer width = 2144
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 23016974
boolean enabled = false
string text = "Pantallas"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_pantallas from u_datawindow within w_mant_juegospantallas
integer x = 50
integer y = 720
integer width = 2149
integer height = 1156
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_pantallas_juegos_pantallas"
boolean vscrollbar = true
boolean border = false
end type

event clicked;str_parametros lstr_param

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "linea"
		bus_titulo     = "AYUDA LINEAS DE PRODUCCION"
		bus_datawindow = "dw_ayuda_prodlineas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "linea"
		bus_titulo     = "AYUDA LINEAS DE PRODUCCION"
		bus_datawindow = "dw_ayuda_prodlineas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type cb_insertar2 from commandbutton within w_mant_juegospantallas
integer x = 78
integer y = 1772
integer width = 1033
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;dec fila_actual, total_filas, pantalla, i

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

fila_actual = dw_pantallas.InsertRow(0)
dw_pantallas.scrolltorow(fila_actual)
dw_pantallas.SetColumn(1)
dw_pantallas.object.empresa[fila_actual] = codigo_empresa
dw_pantallas.object.juegopantallas[fila_actual] = sle_valor.text

total_filas = dw_pantallas.RowCount()

select max(convert(integer,codigo))
into :pantalla
from prodpantallas
where empresa = :codigo_empresa;

pantalla = pantalla + 1
for i = 1 to total_filas
	if dec(dw_pantallas.object.codigo[i]) >= pantalla then
		pantalla = dec(dw_pantallas.object.codigo[i]) + 1
	end if
next

dw_pantallas.object.codigo[fila_actual] = string(truncate(pantalla,0))


end event

type cb_2 from commandbutton within w_mant_juegospantallas
integer x = 1129
integer y = 1772
integer width = 1033
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

dw_pantallas.deleterow(dw_pantallas.GetRow())

end event

