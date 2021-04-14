$PBExportHeader$wtc_consulta_productividad_disenyo.srw
forward
global type wtc_consulta_productividad_disenyo from w_int_con_empresa
end type
type pb_2 from upb_salir within wtc_consulta_productividad_disenyo
end type
type cb_consulta from commandbutton within wtc_consulta_productividad_disenyo
end type
type pb_imprimir_preli from upb_imprimir within wtc_consulta_productividad_disenyo
end type
type gb_2 from groupbox within wtc_consulta_productividad_disenyo
end type
type st_titulo from statictext within wtc_consulta_productividad_disenyo
end type
type p_logo from picture within wtc_consulta_productividad_disenyo
end type
type dw_1 from datawindow within wtc_consulta_productividad_disenyo
end type
type uo_disenyador from u_em_campo_2 within wtc_consulta_productividad_disenyo
end type
type ddlb_grafica from dropdownlistbox within wtc_consulta_productividad_disenyo
end type
type em_fhasta from u_em_campo within wtc_consulta_productividad_disenyo
end type
type em_fdesde from u_em_campo within wtc_consulta_productividad_disenyo
end type
type gb_1 from groupbox within wtc_consulta_productividad_disenyo
end type
type gb_3 from groupbox within wtc_consulta_productividad_disenyo
end type
end forward

global type wtc_consulta_productividad_disenyo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4910
integer height = 3756
string title = "Informe de Productividad de Diseño"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
gb_2 gb_2
st_titulo st_titulo
p_logo p_logo
dw_1 dw_1
uo_disenyador uo_disenyador
ddlb_grafica ddlb_grafica
em_fhasta em_fhasta
em_fdesde em_fdesde
gb_1 gb_1
gb_3 gb_3
end type
global wtc_consulta_productividad_disenyo wtc_consulta_productividad_disenyo

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia

This.title = "Informe de Productividad de Diseño"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)

ddlb_grafica.text = '%'

em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy") 
em_fhasta.text = string(today(), "dd-mm-yy")






end event

on wtc_consulta_productividad_disenyo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.gb_2=create gb_2
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.uo_disenyador=create uo_disenyador
this.ddlb_grafica=create ddlb_grafica
this.em_fhasta=create em_fhasta
this.em_fdesde=create em_fdesde
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.st_titulo
this.Control[iCurrent+6]=this.p_logo
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.uo_disenyador
this.Control[iCurrent+9]=this.ddlb_grafica
this.Control[iCurrent+10]=this.em_fhasta
this.Control[iCurrent+11]=this.em_fdesde
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_3
end on

on wtc_consulta_productividad_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.gb_2)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.uo_disenyador)
destroy(this.ddlb_grafica)
destroy(this.em_fhasta)
destroy(this.em_fdesde)
destroy(this.gb_1)
destroy(this.gb_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wtc_consulta_productividad_disenyo
integer x = 558
integer y = 24
integer width = 2107
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wtc_consulta_productividad_disenyo
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within wtc_consulta_productividad_disenyo
boolean visible = false
integer width = 2670
integer height = 84
end type

type pb_2 from upb_salir within wtc_consulta_productividad_disenyo
integer x = 4713
integer y = 152
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_consulta from commandbutton within wtc_consulta_productividad_disenyo
event clicked pbm_bnclicked
integer x = 4160
integer y = 152
integer width = 361
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;Datetime desde, hasta
String consulta, disenyador, disenyador_nombre
Long i, fila_actual, colecciones, colecciones_produccion, modelos, modelos_produccion, piezas, piezas_produccion, trabajos_periodo, modelos_periodo, piezas_periodo, altas_periodo
Dec ventas
Datastore disenyadores, datos

dw_1.object.t_desde.text = String(em_fdesde.text)
dw_1.object.t_hasta.text = String(em_fhasta.text)

desde = datetime(date(em_fdesde.text))
hasta = datetime(date(em_fhasta.text))

dw_1.reset()

if uo_disenyador.em_codigo.text = "" or isnull(uo_disenyador.em_codigo.text) then
	disenyador = '%'
else
	disenyador = uo_disenyador.em_codigo.text
end if

//Diseñadores seleccionados / Todos
consulta =  " select codigo, descripcion "+&
				" from tecnico_dis "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and activo = 'S' "+&
				" and codigo like '"+disenyador+"' "+&
				" order by descripcion "

f_cargar_cursor_nuevo (consulta, disenyadores)

for i = 1 to disenyadores.rowcount()
	
	disenyador = disenyadores.object.codigo[i]
	disenyador_nombre = disenyadores.object.descripcion[i]
	
	//Colecciones 
	select count(*)
	into :colecciones
	from descoleccionsol
	where empresa = :codigo_empresa
	and disenyador = :disenyador
	and grafica like :ddlb_grafica.text
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta
	and exists(SELECT modelo.coleccion FROM modelo WHERE modelo.coleccion = descoleccionsol.codigo);
	
	if isnull(colecciones) then colecciones = 0
	
	//Colecciones en producción
	
	select count(*)
	into :colecciones_produccion
	from descoleccionsol
	where empresa = :codigo_empresa
	and disenyador = :disenyador
	and grafica like :ddlb_grafica.text
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta
	and codigo IN(SELECT modelo.coleccion FROM modelo WHERE modelo.modelo IN(SELECT articulos.modelo_origen FROM articulos));
	
	if isnull(colecciones_produccion) then colecciones_produccion = 0
	
	//Modelos
	select count(*)
	into :modelos
	from modelo 
	where empresa = :codigo_empresa
	and modelo.coleccion IN 
	(SELECT codigo FROM descoleccionsol 
	WHERE grafica like :ddlb_grafica.text 
	and disenyador = :disenyador 
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta);
	
	if isnull (modelos) then modelos = 0
	
	//Modelos en producción
	
	select COUNT(DISTINCT modelo.modelo)
	into :modelos_produccion
	from modelo 
	where empresa = :codigo_empresa
	and modelo.modelo IN(SELECT articulos.modelo_origen FROM articulos) 
	and modelo.coleccion IN 
	(SELECT codigo FROM descoleccionsol 
	WHERE grafica like :ddlb_grafica.text 
	and disenyador = :disenyador 
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta);
	
	if isnull (modelos_produccion) then modelos_produccion = 0
	
	//Piezas
	select count(modelo_pieza.codigo)
	into :piezas 
	from modelo_pieza 
	where modelo_pieza.empresa = :codigo_empresa 
	and modelo_pieza.modelo IN 
	(SELECT modelo.modelo FROM modelo 
	WHERE modelo.coleccion IN 
	(SELECT descoleccionsol.codigo FROM descoleccionsol 
	WHERE descoleccionsol.grafica like :ddlb_grafica.text 
	and disenyador = :disenyador 
	and descoleccionsol.fecha_coleccion >= :desde 
	and descoleccionsol.fecha_coleccion <= :hasta));
	
	if isnull (piezas) then piezas = 0
	
	//Piezas en producción
	select count(DISTINCT modelo_pieza.codigo_lab)
	into :piezas_produccion
	from modelo_pieza
	where modelo_pieza.empresa = :codigo_empresa 
	and modelo_pieza.codigo_lab IN(SELECT articulos.pieza_origen FROM articulos) 
	and modelo_pieza.modelo IN 
	(SELECT modelo.modelo FROM modelo
	WHERE modelo.coleccion IN 
	(SELECT codigo FROM descoleccionsol 
	WHERE grafica like :ddlb_grafica.text 
	and disenyador = :disenyador 
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta));
	
	if isnull (piezas_produccion) then piezas_produccion = 0
	
	//VENTAS
	select  sum( venlifac.neto / venlifac.cambio)
	into :ventas
	from  modelo, descoleccionsol, articulos, venlifac
	where venlifac.empresa = :codigo_empresa
	and venlifac.empresa = articulos.empresa
	and venlifac.articulo = articulos.codigo 
	and articulos.empresa = modelo.empresa
	and articulos.modelo_origen = modelo.modelo
	and modelo.empresa = descoleccionsol.empresa 
	and modelo.coleccion = descoleccionsol.codigo 
	and descoleccionsol.disenyador = :disenyador
	and descoleccionsol.grafica like :ddlb_grafica.text
	and descoleccionsol.fecha_coleccion >= :desde 
	and descoleccionsol.fecha_coleccion <= :hasta;
	
	if isnull (ventas) then ventas = 0
	
	//Cantidad de trabajo realizado
	
	//Trabajos
	select count(*)
	into :trabajos_periodo
	from modelo_trabajo
	where empresa = :codigo_empresa
	and tecnico_dis = :disenyador
	and fecha_fin >= :desde 
	and fecha_fin <= :hasta;

	if isnull (trabajos_periodo) then trabajos_periodo = 0
	
	//Modelos
	select count(DISTINCT modelo.modelo)
	into :modelos_periodo 
	from modelo 
	where modelo.empresa = :codigo_empresa
	and modelo.tecnico_dis = :disenyador 
	and exists (SELECT * FROM modelo_trabajo T1 
					WHERE T1.empresa = modelo.empresa 
					AND T1.modelo = modelo.modelo 
					AND T1.tecnico_dis = :disenyador 
					AND T1.fecha_fin >= :desde 
					AND T1.fecha_fin <= :hasta 
					AND T1.fecha_fin = (SELECT MIN(T2.fecha_fin) FROM modelo_trabajo T2 
												WHERE T2.empresa = modelo.empresa 
												AND T2.modelo = modelo.modelo));
	
	if isnull (modelos_periodo) then modelos_periodo = 0
	
	//Piezas
	select count(modelo_pieza.codigo_lab)
	into :piezas_periodo 
	from modelo_pieza 
	INNER JOIN modelo_trabajo ON modelo_pieza.empresa = modelo_trabajo.empresa 
			AND modelo_pieza.modelo = modelo_trabajo.modelo 
			AND modelo_pieza.cliente = modelo_trabajo.cliente 
			AND modelo_pieza.propuesta = modelo_trabajo.propuesta 
			AND modelo_pieza.modelo_trabajo = modelo_trabajo.codigo 
	where modelo_pieza.empresa = :codigo_empresa
	and modelo_trabajo.tecnico_dis = :disenyador 
	and modelo_pieza.fecha_lab >= :desde 
	AND modelo_pieza.fecha_lab <= :hasta;
	
	if isnull (piezas_periodo) then piezas_periodo = 0
	
	//Altas
	/*
	select count(*)
	into :altas_periodo
	from articulos, modelo
	where articulos.empresa = :codigo_empresa
	and articulos.empresa = modelo.empresa
	and articulos.modelo_origen = modelo.modelo
	and modelo.tecnico_dis = :disenyador
	and articulos.uso = '3'
	and articulos.fecha_alta >= :desde 
	and articulos.fecha_alta <= :hasta;
	*/
	select count(DISTINCT modelo.modelo)
	into :altas_periodo
	from articulos, modelo
	where articulos.empresa = :codigo_empresa 
	and articulos.empresa = modelo.empresa 
	and articulos.modelo_origen = modelo.modelo 
	and modelo.tecnico_dis = :disenyador 
	and articulos.fecha_alta >= :desde 
	and articulos.fecha_alta <= :hasta;
	
	if isnull (altas_periodo) then altas_periodo = 0
	
	//Datos al DW
	fila_actual = dw_1.insertrow(0)
	
	dw_1.object.disenyador[fila_actual] = disenyador_nombre
	dw_1.object.colecciones[fila_actual] = colecciones
	dw_1.object.colecciones_produccion[fila_actual] = colecciones_produccion
	dw_1.object.modelos[fila_actual] = modelos
	dw_1.object.modelos_produccion[fila_actual] = modelos_produccion
	dw_1.object.piezas[fila_actual] = piezas
	dw_1.object.piezas_produccion[fila_actual] = piezas_produccion
	dw_1.object.ventas[fila_actual] = ventas
	dw_1.object.trabajos_periodo[fila_actual] = trabajos_periodo
	dw_1.object.modelos_periodo[fila_actual] = modelos_periodo
	dw_1.object.piezas_periodo[fila_actual] = piezas_periodo
	dw_1.object.altas_periodo[fila_actual] = altas_periodo
	
next

Destroy disenyadores
end event

type pb_imprimir_preli from upb_imprimir within wtc_consulta_productividad_disenyo
event clicked pbm_bnclicked
integer x = 4539
integer y = 152
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;f_imprimir_datawindow(dw_1)


end event

type gb_2 from groupbox within wtc_consulta_productividad_disenyo
integer x = 873
integer y = 104
integer width = 1408
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Diseñador"
end type

type st_titulo from statictext within wtc_consulta_productividad_disenyo
integer x = 23
integer y = 20
integer width = 1710
integer height = 68
boolean bringtotop = true
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

type p_logo from picture within wtc_consulta_productividad_disenyo
integer x = 4338
integer y = 16
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within wtc_consulta_productividad_disenyo
integer x = 27
integer y = 316
integer width = 4832
integer height = 3252
integer taborder = 60
string title = "none"
string dataobject = "dwtc_productividad_disenyo"
boolean border = false
boolean livescroll = true
end type

event clicked;Choose Case dwo.name
	Case "t_disenyador"
		dw_1.setsort("disenyador ASC")
	Case "t_colecciones"
		dw_1.setsort("colecciones DESC")
	Case "t_colecciones_produccion"
		dw_1.setsort("colecciones_produccion DESC")
	Case "t_colecciones_porcentaje"
		dw_1.setsort("colecciones_porcentaje DESC")
	Case "t_colecciones_porcentaje_total"
		dw_1.setsort("colecciones_porcentaje_total DESC")
	Case "t_modelos"
		dw_1.setsort("modelos DESC")
	Case "t_modelos_produccion"
		dw_1.setsort("modelos_produccion DESC")
	Case "t_modelos_porcentaje"
		dw_1.setsort("modelos_porcentaje DESC")	
	Case "t_piezas"
		dw_1.setsort("piezas DESC")
	Case "t_piezas_produccion"
		dw_1.setsort("piezas_produccion DESC")
	Case "t_piezas_porcentaje"
		dw_1.setsort("piezas_porcentaje DESC")	
	Case "t_ventas"
		dw_1.setsort("ventas DESC")
	Case "t_ventas_porcentaje_total"
		dw_1.setsort("ventas_porcentaje_total DESC")	
	Case "t_trabajos_periodo"
		dw_1.setsort("trabajos_periodo DESC")
	Case "t_modelos_periodo"
		dw_1.setsort("modelos_periodo DESC")
	Case "t_piezas_periodo"
		dw_1.setsort("piezas_periodo DESC")	
	Case "t_altas_periodo"
		dw_1.setsort("altas_periodo DESC")	
End Choose
dw_1.sort()
end event

type uo_disenyador from u_em_campo_2 within wtc_consulta_productividad_disenyo
event destroy ( )
integer x = 914
integer y = 176
integer width = 1321
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_disenyador.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_disenyador

select descripcion
into :des_disenyador
from tecnico_dis
where empresa = :codigo_empresa
and codigo = :uo_disenyador.em_codigo.text;

uo_disenyador.em_campo.text = des_disenyador
IF Trim(uo_disenyador.em_campo.text)="" THEN 
 IF Trim(uo_disenyador.em_codigo.text)<>"" Then uo_disenyador.em_campo.SetFocus()
 uo_disenyador.em_campo.text=""
 uo_disenyador.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Diseñadores"
ue_datawindow = "dw_ayuda_tecnicos_dis"
ue_filtro     = ""

end event

event busqueda;	
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

busqueda.titulo_ventana = "Búsqueda de Diseñador"
busqueda.consulta  =  	" select codigo, descripcion "+&
								" from tecnico_dis "+&
								" where empresa = '"+codigo_empresa+"' "+&
								" and activo = 'S' "+&
								" order by descripcion "
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Razón"
busqueda.filtro = trim(ue_valor)

OpenWithParm(wt_busquedas, busqueda)
resultado = Message.PowerObjectParm
if resultado.resultado > 0 then
	This.em_codigo.text 		= resultado.valores[1]		
	//This.em_campo.text		= resultado.valores[2]		
end if
   
   This.TriggerEvent("modificado")
	ue_valor_anterior = Trim(em_campo.text)
//	ue_campo.SetFocus()
	ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type ddlb_grafica from dropdownlistbox within wtc_consulta_productividad_disenyo
integer x = 2327
integer y = 180
integer width = 283
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"S","N","%"}
borderstyle borderstyle = stylelowered!
end type

type em_fhasta from u_em_campo within wtc_consulta_productividad_disenyo
integer x = 462
integer y = 176
integer width = 352
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fdesde from u_em_campo within wtc_consulta_productividad_disenyo
integer x = 78
integer y = 176
integer width = 352
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_1 from groupbox within wtc_consulta_productividad_disenyo
integer x = 2286
integer y = 104
integer width = 370
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gráfica"
end type

type gb_3 from groupbox within wtc_consulta_productividad_disenyo
integer x = 32
integer y = 104
integer width = 837
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Período"
end type

