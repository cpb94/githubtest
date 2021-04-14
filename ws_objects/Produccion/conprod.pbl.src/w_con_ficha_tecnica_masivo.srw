$PBExportHeader$w_con_ficha_tecnica_masivo.srw
forward
global type w_con_ficha_tecnica_masivo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ficha_tecnica_masivo
end type
type pb_imprimir_etiquetas from upb_imprimir within w_con_ficha_tecnica_masivo
end type
type uo_articulo from u_em_campo_2 within w_con_ficha_tecnica_masivo
end type
type cb_1 from u_boton within w_con_ficha_tecnica_masivo
end type
type pb_2 from upb_papelera within w_con_ficha_tecnica_masivo
end type
type st_5 from statictext within w_con_ficha_tecnica_masivo
end type
type em_desde from u_em_campo within w_con_ficha_tecnica_masivo
end type
type dw_1 from datawindow within w_con_ficha_tecnica_masivo
end type
type st_455 from statictext within w_con_ficha_tecnica_masivo
end type
type st_333 from statictext within w_con_ficha_tecnica_masivo
end type
type em_hasta from u_em_campo within w_con_ficha_tecnica_masivo
end type
type dw_listado from datawindow within w_con_ficha_tecnica_masivo
end type
type st_1 from statictext within w_con_ficha_tecnica_masivo
end type
type r_1 from rectangle within w_con_ficha_tecnica_masivo
end type
type st_2 from statictext within w_con_ficha_tecnica_masivo
end type
type r_2 from rectangle within w_con_ficha_tecnica_masivo
end type
type estructura_articulo from structure within w_con_ficha_tecnica_masivo
end type
type estructura_version from structure within w_con_ficha_tecnica_masivo
end type
end forward

type estructura_articulo from structure
	string		escandallo[]
end type

type estructura_version from structure
	string		version_esc[]
end type

global type w_con_ficha_tecnica_masivo from w_int_con_empresa
integer width = 3154
integer height = 1444
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
uo_articulo uo_articulo
cb_1 cb_1
pb_2 pb_2
st_5 st_5
em_desde em_desde
dw_1 dw_1
st_455 st_455
st_333 st_333
em_hasta em_hasta
dw_listado dw_listado
st_1 st_1
r_1 r_1
st_2 st_2
r_2 r_2
end type
global w_con_ficha_tecnica_masivo w_con_ficha_tecnica_masivo

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
public subroutine f_imprimir_ficha_tecnica (datawindow data, string ar_articulo, string ar_version, string ar_version2)
end prototypes

public subroutine f_desactivar (boolean bool);cb_1.enabled = bool
uo_articulo.enabled = bool
dw_1.enabled = bool

end subroutine

public subroutine f_imprimir_ficha_tecnica (datawindow data, string ar_articulo, string ar_version, string ar_version2);datastore aplicaciones, caracteristicas, alternativos

string   sel0, sel1, sel2
long     indice0, total0, indice1, total1, indice2, total2, indice_data, indice_data2, total_data
string   v_molde, v_valor_caracteristica, v_unidad, v_unidad_caracteristica, v_imagen
string   v_aplicacion, v_comentarios, v_origen, v_formula, v_nombre_formula, v_caracteristica
string   v_referencia_lab, v_ver_lab, v_tipo_pasta, v_cod_pant, v_nombre_aplicacion
long     v_contador, v_orden, v_orden_caracteristica, donde, reg_data, reg_data2
dec      v_gramaje_formula, v_grupo_aplicacion, v_espesor
string   v_nombre_formato, v_nombre_molde, v_nombre_articulo, v_formato, v_nombre_pasta, v_nombre_alt, v_cliente, v_nombre_cliente,v_tipo
string   cadena, cadena1
datetime v_falta
long     indicex
string   arg_version,arg_version_x,nombre_coccion_x,ante_coccion

data.setredraw(false)
data.retrieve(codigo_empresa, ar_articulo, ar_version)

SELECT molde, descripcion, formato, referencia_laboratorio, version_laboratorio, tipo_pasta, codigo_pantallas, espesor, fecha_alta, imagen, tipo
INTO  :v_molde, :v_nombre_articulo, :v_formato, :v_referencia_lab, :v_ver_lab, :v_tipo_pasta, :v_cod_pant, :v_espesor, :v_falta, :v_imagen, :v_tipo
FROM  articulos
WHERE empresa = :codigo_empresa
AND   codigo = :ar_articulo;

v_nombre_formato = f_nombre_formato(codigo_empresa, v_formato)
v_nombre_molde   = v_molde+"-"+f_nombre_molde(codigo_empresa, v_molde)
if isnull(v_tipo_pasta) or v_tipo_pasta = "B" or v_tipo_pasta = "" then
	v_nombre_pasta = "BLANCA"
else
	v_nombre_pasta = "ROJA"
end if

sel0 = "SELECT descripcion, cliente "+&
		 "FROM  almcliartdesc "+&
		 "WHERE empresa  = '" + codigo_empresa + "' "+&
		 "AND articulo = '" + ar_articulo + "' "+&
		 "AND (cliente = '24' OR cliente = '79')"

//alternativos = f_cargar_cursor(sel0)
f_cargar_cursor_nuevo(sel0, alternativos)
total0 = alternativos.rowcount()
cadena  = ""
cadena1 = ""
for indice0 = 1 to total0
	 v_nombre_alt = alternativos.object.descripcion[indice0]
	 v_cliente    = alternativos.object.cliente[indice0]
	 if v_cliente = "24" or v_cliente = "79" then
	 		cadena = v_cliente + " " + v_nombre_alt
	 else
			cadena1 = v_cliente + " " + v_nombre_alt
	 end if
next

for indicex = dec(ar_version) to dec(ar_version2)
	arg_version = string(indicex)

	sel1 = "SELECT aplicacion, contador, orden, comentarios "+&
			 "FROM prodaplicaciones_articulo "+&
			 "WHERE empresa = '" + codigo_empresa + "' "+&
			 "AND articulo = '" + ar_articulo + "' "+&
			 "AND version = '" + arg_version + "' "
	
	//aplicaciones = f_cargar_cursor(sel1)
	f_cargar_cursor_nuevo(sel1, aplicaciones)
	total1 = aplicaciones.rowcount()
	for indice1=1 to total1
		v_aplicacion  = aplicaciones.object.aplicacion[indice1]
		v_contador    = aplicaciones.object.contador[indice1]
		v_orden       = aplicaciones.object.orden[indice1]
		v_comentarios = aplicaciones.object.comentarios[indice1]
			
		SELECT formula, gramaje
		INTO   :v_formula, :v_gramaje_formula
		FROM   prodformulacionesapli_articulo
		WHERE  empresa  = :codigo_empresa
		AND    articulo = :ar_articulo
		AND    version  = :arg_version
		AND    aplicacion = :v_aplicacion
		AND    contador = :v_contador;
		if isnull(v_formula) then v_formula = ""
		if trim(v_formula) = "" then
			v_nombre_formula = ""
		else
			if (v_aplicacion = "11") or (v_aplicacion = "12") or (v_aplicacion = "13") or (v_aplicacion = "14") then
				v_nombre_formula = ""
			else
				if (v_aplicacion = "16") then
					v_nombre_formula = trim(f_nombre_aplicacion(codigo_empresa, v_aplicacion))+" "+trim(f_nombre_formulacion_produccion(codigo_empresa, v_formula))
				else
					v_nombre_formula = f_nombre_formulacion_produccion(codigo_empresa, v_formula)
				end if
			end if
		end if
		sel2 = "SELECT caracteristica, orden, valor_numerico, valor_alfanumerico "+&
				 "FROM prodcaracteristapli_articulo "+&
				 "WHERE empresa = '" + codigo_empresa + "' "+&
				 "AND articulo = '" + ar_articulo + "' "+&
				 "AND version = '" + arg_version + "' "+&
				 "AND aplicacion = '" + v_aplicacion + "' "+&
				 "AND contador = '" + string(v_contador, "#####") + "' " +&
				 "AND (valor_numerico <> 0 OR valor_alfanumerico <> '')"
		
		//caracteristicas = f_cargar_cursor(sel2)
		f_cargar_cursor_nuevo(sel2, caracteristicas)
		total2 = caracteristicas.rowcount()
		if total2=0 then
				donde = data.insertrow(0)
				data.object.articulo[donde]  = ar_articulo
				data.object.articulo_final[donde] = ar_articulo
				data.object.version[donde]   = arg_version
				data.object.nombre_articulo[donde]   = v_nombre_articulo
				data.object.nombre_formato[donde]    = v_nombre_formato
				data.object.codigo_aplicacion[donde] = v_aplicacion
				data.object.nombre_aplicacion[donde] = f_nombre_aplicacion(codigo_empresa, v_aplicacion)
				data.object.nombre_formula[donde]    = v_nombre_formula
				data.object.gramaje_formula[donde]   = v_gramaje_formula
				data.object.nombre_molde[donde]      = v_nombre_molde
				data.object.num_aplicacion[donde]    = string(v_orden)
				data.object.modelo[donde]            = f_nombre_modelos(codigo_empresa, v_tipo)
				data.object.orden_caracteristica1[donde]  = 1
				data.object.nombre_caracteristica1[donde] = ""
				data.object.valor_caracteristica1[donde]  = ""
				data.object.unidad_caracteristica1[donde] = ""
				data.object.orden_caracteristica1[donde]  = 2
				data.object.nombre_caracteristica1[donde] = ""
				data.object.valor_caracteristica1[donde]  = ""
				data.object.unidad_caracteristica1[donde] = ""
				data.object.orden_caracteristica1[donde]  = 3
				data.object.nombre_caracteristica1[donde] = ""
				data.object.valor_caracteristica1[donde]  = ""
				data.object.unidad_caracteristica1[donde] = ""
				data.object.orden_caracteristica1[donde]  = 4
				data.object.nombre_caracteristica1[donde] = ""
				data.object.valor_caracteristica1[donde]  = ""
				data.object.unidad_caracteristica1[donde] = ""
				data.object.orden_caracteristica1[donde]  = 5
				data.object.nombre_caracteristica1[donde] = ""
				data.object.valor_caracteristica1[donde]  = ""
				data.object.unidad_caracteristica1[donde] = ""
				data.object.observaciones[donde]  = v_comentarios
				data.object.reflab[donde]  = v_referencia_lab
				data.object.verlab[donde]  = v_ver_lab
				data.object.pasta[donde]   = v_nombre_pasta
				data.object.codpan[donde]  = v_cod_pant
				data.object.espesor[donde] = v_espesor
				data.object.falta[donde]   = v_falta
				data.object.cad[donde]     = cadena
				data.object.cad1[donde]    = cadena1
	//			data.object.imagen[donde]  = v_imagen
	//			data.modify("imagen_f.picturename = '"+v_imagen+"'")
	//			messagebox("",v_imagen)
		else
			for indice2=1 to total2
				v_caracteristica = caracteristicas.object.caracteristica[indice2]
				v_orden_caracteristica = caracteristicas.object.orden[indice2]
				if f_tipo_valor_prodcaracteristica(codigo_empresa, v_caracteristica)='A' then
					v_valor_caracteristica = caracteristicas.object.valor_alfanumerico[indice2]
					v_unidad_caracteristica = ""
				else
					v_unidad = f_unidad_prodcaracteristica(codigo_empresa, v_caracteristica)
					v_valor_caracteristica = string(caracteristicas.object.valor_numerico[indice2], f_mascara_unidad_compras(v_unidad))			
					v_unidad_caracteristica = f_nombre_unimedida(v_unidad)
				end if
				donde   = data.find("articulo = '"+ar_articulo+"'"+" and version = '"+arg_version+"'"+" and num_aplicacion = '"+string(v_orden)+"'",1,data.rowcount())
				if donde > 0 then
					choose case v_caracteristica
										
						case "1"	// Densidad
							data.object.nombre_caracteristica1[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica1[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica1[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica1[donde]  = v_orden_caracteristica
							
						case "2"  // Viscosidad
							data.object.nombre_caracteristica2[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica2[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica2[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica2[donde]  = v_orden_caracteristica
							
						case "3" // Hilos
							data.object.nombre_caracteristica3[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica3[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica3[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica3[donde]  = v_orden_caracteristica
						
						case "4"  // Orden
							data.object.nombre_caracteristica4[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica4[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica4[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica4[donde]  = v_orden_caracteristica
							
						case "5"  // Boquilla
							data.object.nombre_caracteristica5[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica5[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica5[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica5[donde]  = v_orden_caracteristica
							
						case "6"  // Ciclo
							data.object.nombre_caracteristica6[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica6[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica6[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica6[donde]  = v_orden_caracteristica
						
					end choose
				else
					donde = data.insertrow(0)
					data.object.articulo[donde]          = ar_articulo
					data.object.articulo_final[donde]    = ar_articulo
					data.object.version[donde]           = arg_version
					data.object.nombre_articulo[donde]   = v_nombre_articulo
					data.object.nombre_formato[donde]    = v_nombre_formato
					data.object.codigo_aplicacion[donde] = v_aplicacion
					data.object.nombre_aplicacion[donde] = f_nombre_aplicacion(codigo_empresa, v_aplicacion)
					data.object.modelo[donde]            = f_nombre_modelos(codigo_empresa, v_tipo)
					data.object.nombre_formula[donde]    = v_nombre_formula
					data.object.gramaje_formula[donde]   = v_gramaje_formula
					data.object.nombre_molde[donde]      = v_nombre_molde
					data.object.num_aplicacion[donde]    = string(v_orden)
					choose case v_caracteristica
										
						case "1"	// Densidad
							data.object.nombre_caracteristica1[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica1[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica1[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica1[donde]  = v_orden_caracteristica
							
						case "2"  // Viscosidad
							data.object.nombre_caracteristica2[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica2[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica2[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica2[donde]  = v_orden_caracteristica
							
						case "3" // Hilos
							data.object.nombre_caracteristica3[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica3[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica3[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica3[donde]  = v_orden_caracteristica
						
						case "4"  // Orden
							data.object.nombre_caracteristica4[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica4[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica4[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica4[donde]  = v_orden_caracteristica
							
						case "5"  // Boquilla
							data.object.nombre_caracteristica5[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica5[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica5[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica5[donde]  = v_orden_caracteristica
							
						case "6"  // Ciclo
							data.object.nombre_caracteristica6[donde] = left(f_nombre_caracteristica(codigo_empresa, v_caracteristica),5)
							data.object.valor_caracteristica6[donde]  = v_valor_caracteristica
							data.object.unidad_caracteristica6[donde] = v_unidad_caracteristica
							data.object.orden_caracteristica6[donde]  = v_orden_caracteristica
						
					end choose
					data.object.observaciones[donde] = v_comentarios
					data.object.reflab[donde]  = v_referencia_lab
					data.object.verlab[donde]  = v_ver_lab
					data.object.pasta[donde]   = v_nombre_pasta
					data.object.codpan[donde]  = v_cod_pant
					data.object.espesor[donde] = v_espesor
					data.object.falta[donde]   = v_falta
					data.object.cad[donde]     = cadena
					data.object.cad1[donde]    = cadena1
	//				data.object.imagen[donde]  = v_imagen
				end if
			next
		end if
		destroy caracteristicas
		
	next
	
	destroy aplicaciones
	destroy alternativos
	data.SetFilter("version = '"+arg_version+"'")
	data.Filter()
	data.SetSort("articulo_final a,version a,dec(num_aplicacion) a")
	data.Sort()
	total_data = data.RowCount()
	if total_data <> 0 then
		reg_data = 1
		for indice_data = reg_data to total_data
			v_aplicacion     = data.object.codigo_aplicacion[indice_data]
			if (v_aplicacion = "11") or (v_aplicacion = "12") or (v_aplicacion = "13") or (v_aplicacion = "14") or (v_aplicacion = "15") then			
				reg_data2 = dec(data.object.num_aplicacion[indice_data])
				for indice_data2 = reg_data to reg_data2
					data.object.coccion[indice_data2]        = v_aplicacion
					data.object.nombre_coccion[indice_data2] = f_nombre_aplicacion(codigo_empresa, v_aplicacion)
				next
				reg_data = reg_data2 + 1
			end if			
		next
	else
		messagebox("Atención","No hay datos a imprimir")
		return
	end if
	data.SetFilter("")
	data.Filter()
	
next
data.sort()
data.groupcalc()
data.setredraw(true)

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas articulos"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(hand!)
f_activar_campo(uo_articulo.em_campo)



end event

on w_con_ficha_tecnica_masivo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.uo_articulo=create uo_articulo
this.cb_1=create cb_1
this.pb_2=create pb_2
this.st_5=create st_5
this.em_desde=create em_desde
this.dw_1=create dw_1
this.st_455=create st_455
this.st_333=create st_333
this.em_hasta=create em_hasta
this.dw_listado=create dw_listado
this.st_1=create st_1
this.r_1=create r_1
this.st_2=create st_2
this.r_2=create r_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.st_455
this.Control[iCurrent+10]=this.st_333
this.Control[iCurrent+11]=this.em_hasta
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.r_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.r_2
end on

on w_con_ficha_tecnica_masivo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.uo_articulo)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.st_5)
destroy(this.em_desde)
destroy(this.dw_1)
destroy(this.st_455)
destroy(this.st_333)
destroy(this.em_hasta)
destroy(this.dw_listado)
destroy(this.st_1)
destroy(this.r_1)
destroy(this.st_2)
destroy(this.r_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ficha_tecnica_masivo
integer y = 1104
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ficha_tecnica_masivo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ficha_tecnica_masivo
integer y = 24
integer width = 2638
integer height = 108
end type

type pb_1 from upb_salir within w_con_ficha_tecnica_masivo
integer x = 2697
integer y = 24
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir_etiquetas from upb_imprimir within w_con_ficha_tecnica_masivo
integer x = 2784
integer y = 872
integer width = 174
integer height = 152
integer taborder = 0
boolean originalsize = false
end type

event clicked;string version_esc[],camino,ar_articulo
long   indice,total,i,j,z,ar_desde,ar_hasta,articulos,veces
estructura_articulo estructura_art[100,100]
estructura_version  version_art[100,100]

articulos = dw_1.RowCount()
if articulos = 0 then
	messagebox("Atención","No hay artículos a imprimir")
	f_activar_campo(uo_articulo.em_campo)
	return
end if
if articulos > 100 then
	messagebox("Atención","Sólo se permiten imprimir hasta 100 artículos")
	f_activar_campo(uo_articulo.em_campo)
	return
end if
veces = 1
for i = 1 to articulos
	ar_articulo = dw_1.GetItemString(i,"articulo")
	ar_desde    = dec(dw_1.GetItemString(i,"desde"))
	ar_hasta    = dec(dw_1.GetItemString(i,"hasta"))
	if ar_hasta = 100 then
		select count(version)
		into :ar_hasta
		from prodobsversionart
		where empresa  = :codigo_empresa and
				articulo = :ar_articulo;
	end if
	f_imprimir_ficha_tecnica(dw_listado,ar_articulo,string(ar_desde),string(ar_hasta))
	if veces = 1 then
		f_imprimir_datawindow(dw_listado)
		veces = 2
	else
		f_imprimir_datawindow_v2(dw_listado)
	end if
next
end event

type uo_articulo from u_em_campo_2 within w_con_ficha_tecnica_masivo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 27
integer y = 236
integer width = 1422
integer height = 92
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""


end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_ficha_tecnica_masivo
integer x = 2395
integer y = 216
integer width = 462
integer height = 112
integer taborder = 40
string text = "Añadir a la lista"
end type

event clicked;Integer registro

If Trim(uo_articulo.em_campo.text) = "" then
	f_mensaje("Campo obligatorio","Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
End If

If Trim(em_desde.text) = "" then
	f_mensaje("Campo obligatorio","Introduzca el rango inferior")
	f_activar_campo(em_desde)
	Return
End If

If Trim(em_hasta.text) = "" then
	f_mensaje("Campo obligatorio","Introduzca el rango superior")
	f_activar_campo(em_hasta)
	Return
End If

If dec(em_hasta.text) > 100 then
	f_mensaje("Atención","Sólo se permiten 100 versiones máx. por artículo")
	f_activar_campo(em_hasta)
	Return
End If

registro = dw_1.RowCount()
registro = registro + 1
dw_1.InsertRow(registro)
dw_1.SetItem(registro,"articulo",uo_articulo.em_codigo.text)
dw_1.SetItem(registro,"desde",em_desde.text)
dw_1.SetItem(registro,"hasta",em_hasta.text)
dw_1.setitem(registro,"empresa",codigo_empresa)

uo_articulo.em_campo.text  = "" 
uo_articulo.em_codigo.text = "" 
em_desde.text					= "1"
em_hasta.text					= "100"

f_activar_campo(uo_articulo.em_campo)
end event

type pb_2 from upb_papelera within w_con_ficha_tecnica_masivo
integer x = 2784
integer y = 444
integer width = 183
integer height = 160
integer taborder = 0
end type

event clicked;call super::clicked;IF dw_1.GetRow() = 0 Then Return
dw_1.DeleteRow(dw_1.GetRow())
end event

type st_5 from statictext within w_con_ficha_tecnica_masivo
integer x = 1454
integer y = 160
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde Versión"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_con_ficha_tecnica_masivo
integer x = 1454
integer y = 236
integer width = 457
integer height = 92
integer taborder = 20
string text = "1"
alignment alignment = right!
end type

type dw_1 from datawindow within w_con_ficha_tecnica_masivo
integer x = 32
integer y = 412
integer width = 2624
integer height = 812
string dataobject = "dw_con_ficha_tecnica_masivo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_455 from statictext within w_con_ficha_tecnica_masivo
integer x = 27
integer y = 160
integer width = 1422
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_333 from statictext within w_con_ficha_tecnica_masivo
integer x = 1920
integer y = 160
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta Versión"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_con_ficha_tecnica_masivo
integer x = 1920
integer y = 236
integer width = 457
integer height = 92
integer taborder = 30
string text = "100"
alignment alignment = right!
end type

type dw_listado from datawindow within w_con_ficha_tecnica_masivo
boolean visible = false
integer x = 2688
integer y = 748
integer width = 155
integer height = 68
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_ficha_tecnica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_ficha_tecnica_masivo
integer x = 2688
integer y = 1064
integer width = 366
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Imprime toda la lista"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_con_ficha_tecnica_masivo
integer linethickness = 4
long fillcolor = 79741120
integer x = 2674
integer y = 848
integer width = 398
integer height = 372
end type

type st_2 from statictext within w_con_ficha_tecnica_masivo
integer x = 2697
integer y = 608
integer width = 352
integer height = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Borra el artículo seleccionado"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_2 from rectangle within w_con_ficha_tecnica_masivo
integer linethickness = 4
long fillcolor = 79741120
integer x = 2674
integer y = 416
integer width = 402
integer height = 424
end type

