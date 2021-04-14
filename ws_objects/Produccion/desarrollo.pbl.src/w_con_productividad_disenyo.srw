$PBExportHeader$w_con_productividad_disenyo.srw
forward
global type w_con_productividad_disenyo from w_int_con_empresa
end type
type gb_7 from groupbox within w_con_productividad_disenyo
end type
type pb_imprimir from upb_imprimir within w_con_productividad_disenyo
end type
type dw_1 from datawindow within w_con_productividad_disenyo
end type
type cb_1 from u_boton within w_con_productividad_disenyo
end type
type pb_1 from upb_salir within w_con_productividad_disenyo
end type
type uo_disenyador from u_em_campo_2 within w_con_productividad_disenyo
end type
type em_fdesde from u_em_campo within w_con_productividad_disenyo
end type
type em_fhasta from u_em_campo within w_con_productividad_disenyo
end type
type ddlb_grafica from dropdownlistbox within w_con_productividad_disenyo
end type
type gb_2 from groupbox within w_con_productividad_disenyo
end type
type gb_3 from groupbox within w_con_productividad_disenyo
end type
type gb_1 from groupbox within w_con_productividad_disenyo
end type
end forward

global type w_con_productividad_disenyo from w_int_con_empresa
integer width = 4914
integer height = 3180
string title = "Consulta de artículos (cod. estadístico)"
gb_7 gb_7
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
uo_disenyador uo_disenyador
em_fdesde em_fdesde
em_fhasta em_fhasta
ddlb_grafica ddlb_grafica
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
end type
global w_con_productividad_disenyo w_con_productividad_disenyo

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);datetime desde, hasta
datastore datos, datos2
long i, fila_actual
decimal v_colecciones, v_piezas, ventas, trab_periodo, pzas_periodo, altas_periodo
decimal total, total_trabajos, 	colecciones_en_produccion, piezas_en_produccion
string disenyador, filtro, consulta, consulta2, des_disenyador

dw_1.reset()
if uo_disenyador.em_codigo.text = "" or isnull(uo_disenyador.em_codigo.text) then
	disenyador = '%'
else
	disenyador = uo_disenyador.em_codigo.text
end if

filtro = ""
			
dw_1.SetFilter(filtro)
dw_1.Filter()

desde = datetime(date(em_fdesde.text))
hasta = datetime(date(em_fhasta.text))

consulta =  " select codigo, descripcion "+&
				" from tecnico_dis "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and activo = 'S' "+&
				" and codigo like '"+disenyador+"' "+&
				" order by descripcion "

f_cargar_cursor_nuevo (consulta, datos)

for i = 1 to datos.rowcount()
	fila_actual = dw_1.insertrow(0)
	disenyador = datos.object.codigo[fila_actual]
	des_disenyador = datos.object.descripcion[fila_actual]

	dw_1.object.disenyador[i] = des_disenyador
	
	// Colecciones por diseñador 
	select count(*)
	into :total
	from descoleccionsol
	where empresa = :codigo_empresa
	and disenyador = :disenyador
	and grafica like :ddlb_grafica.text
	and fecha_coleccion >= :desde 
	and fecha_coleccion <= :hasta;
	
	if isnull(total) then total = 0
	dw_1.object.colecciones[fila_actual] = total
	
	// Trabajos por diseñador
	select  count(*)
	into :total_trabajos
	from  destrabajo2 T1, desmodelo M1, descoleccionsol C1
	where T1.empresa = M1.empresa  
	and  T1.modelo = M1.modelo   
	and T1.empresa = :codigo_empresa
	and M1.empresa = C1.empresa 
	and M1.coleccion = C1.codigo 
	and C1.disenyador = :disenyador
	and C1.grafica like :ddlb_grafica.text
	and T1.laboratorio = 'N'
	and C1.fecha_coleccion >= :desde 
	and C1.fecha_coleccion <= :hasta; 
	
	if isnull(total_trabajos) then total_trabajos = 0	
	dw_1.object.trabajos[fila_actual] = total_trabajos

	
	// Colecciones que pasan a producción por diseñador.
	consulta2 = 	"	select  distinct M1.coleccion "+&
						"	from  destrabajo2 T1, desmodelo M1, descoleccionsol C1, articulos A1 "+&
						"	where T1.empresa = M1.empresa  "+&
						"	and  T1.modelo = M1.modelo   "+&
						"  and T1.empresa = A1.empresa  "+&
						"  and T1.modelo = A1.referencia_laboratorio  "+&
						"	and T1.empresa = '"+codigo_empresa+"' "+&
						"	and M1.empresa = C1.empresa  "+&
						"	and M1.coleccion = C1.codigo  "+&
						"	and C1.disenyador = '"+disenyador+"' "+&
						"  and C1.grafica like '"+ddlb_grafica.text+"' "+&
						"	and C1.fecha_coleccion >= '"+em_fdesde.text+"' "+&
						"	and C1.fecha_coleccion <= '"+em_fhasta.text+"' "

	f_cargar_cursor_nuevo ( consulta2, datos2)
	
	colecciones_en_produccion = datos2.rowcount()
	if isnull(colecciones_en_produccion) then colecciones_en_produccion = 0	
	dw_1.object.colecciones_prod[fila_actual] = 	colecciones_en_produccion
	
	destroy datos2

	// Piezas que pasan a producción por diseñador.
	consulta2 = 	"	select  distinct M1.coleccion, A1.codigo "+&
						"	from  destrabajo2 T1, desmodelo M1, descoleccionsol C1, articulos A1 "+&
						"	where T1.empresa = M1.empresa  "+&
						"	and  T1.modelo = M1.modelo   "+&
						"  and T1.empresa = A1.empresa  "+&
						"  and T1.modelo = A1.referencia_laboratorio  "+&
						"  and T1.trabajo = A1.version_laboratorio  "+&
						"  and A1.uso = '3' "+&
						"	and M1.empresa = C1.empresa  "+&
						"	and M1.coleccion = C1.codigo  "+&
						"	and T1.empresa = '"+codigo_empresa+"' "+&
						"	and C1.disenyador = '"+disenyador+"' "+&
						"  and C1.grafica like '"+ddlb_grafica.text+"' "+&
						"	and C1.fecha_coleccion >= '"+em_fdesde.text+"' "+&
						"	and C1.fecha_coleccion <= '"+em_fhasta.text+"' "
						
	f_cargar_cursor_nuevo ( consulta2, datos2)
	
	piezas_en_produccion = datos2.rowcount()
	if isnull(piezas_en_produccion) then piezas_en_produccion = 0	
	dw_1.object.piezas_prod[fila_actual] = piezas_en_produccion
	
	destroy datos2
	
	
	// Piezas por diseñador
	select  count (*) 
	into :v_piezas
	from  desmodelo, descoleccionsol C1
	where C1.empresa = :codigo_empresa
	and desmodelo.empresa = C1.empresa
	and desmodelo.coleccion = C1.codigo
	and C1.disenyador = :disenyador
	and C1.grafica like :ddlb_grafica.text
	and C1.fecha_coleccion >= :desde 
	and C1.fecha_coleccion <= :hasta;
	
	dw_1.object.disenyador[fila_actual] = des_disenyador
	dw_1.object.piezas[fila_actual] = v_piezas
	
	if v_piezas <> 0 and not isnull(v_piezas) then
		dw_1.object.trabajos_por_pieza[fila_actual] = total_trabajos / v_piezas
	else
		dw_1.object.trabajos_por_pieza[fila_actual] = 0
	end if

	
	// Ventas por diseñador según fecha fin de colección
	select  sum( venlifac.neto / venlifac.cambio)
	into :ventas
	from  destrabajo2 T1, desmodelo, descoleccionsol C1, articulos, venlifac, art_codestadistico
	where venlifac.empresa = :codigo_empresa
	and venlifac.empresa = articulos.empresa
	and venlifac.articulo = articulos.codigo 
	and articulos.empresa = T1.empresa
	and articulos.referencia_laboratorio = T1.modelo
	and articulos.version_laboratorio = T1.trabajo
	and articulos.empresa = art_codestadistico.empresa
	and articulos.codigo = art_codestadistico.codigo
	and T1.empresa = desmodelo.empresa 
	and T1.modelo = desmodelo.modelo  
	and desmodelo.empresa = C1.empresa 
	and desmodelo.coleccion = C1.codigo 
	and C1.disenyador = :disenyador
	and C1.grafica like :ddlb_grafica.text
	and C1.fecha_coleccion >= :desde 
	and C1.fecha_coleccion <= :hasta;

	if isnull (ventas) then ventas = 0
	dw_1.object.ventas[fila_actual] = ventas
	
	// Trabajos realizados en el período filtrado	
	select count(*)
	into :trab_periodo
	from destrabajo2
	where empresa = :codigo_empresa
	and tecnico_dis = :disenyador
	and fecha_fin >= :desde 
	and fecha_fin <= :hasta;
	
	if isnull (trab_periodo) then trab_periodo = 0
	dw_1.object.trab_periodo[fila_actual] = trab_periodo
	
	// Piezas realizadas durante el período filtrado. Nos basaremos en la fecha fin del primer trabajo.
	select count(*)
	into :pzas_periodo
	from desmodelo, destrabajo2 A
	where desmodelo.empresa = :codigo_empresa
	and desmodelo.empresa = A.empresa
	and desmodelo.modelo = A.modelo
	and A.trabajo = ( 	select min(B.trabajo)
								from destrabajo2 B
								where B.empresa = :codigo_empresa
								and B.modelo = A.modelo 
								and B.fecha_fin >= :desde 
								and B.fecha_fin <= :hasta )
	and desmodelo.tecnico_dis = :disenyador
	and A.fecha_fin >= :desde 
	and A.fecha_fin <= :hasta;
	
	if isnull (pzas_periodo) then pzas_periodo = 0
	dw_1.object.pzas_periodo[fila_actual] = pzas_periodo
	
// Altas del período filtrado	
	select count(*)
	into :altas_periodo
	from articulos, desmodelo
	where articulos.empresa = :codigo_empresa
	and articulos.empresa = desmodelo.empresa
	and articulos.referencia_laboratorio = desmodelo.modelo
	and desmodelo.tecnico_dis = :disenyador
	and articulos.uso = '3'
	and articulos.fecha_alta >= :desde 
	and articulos.fecha_alta <= :hasta;
	
	if isnull (altas_periodo) then altas_periodo = 0
	dw_1.object.altas_periodo[fila_actual] = altas_periodo	

	f_mensaje_proceso ("Regs:", i, datos.rowcount())
	
next

dw_1.object.t_desde.text = em_fdesde.text
dw_1.object.t_hasta.text = em_fhasta.text

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

destroy datos


end subroutine

on w_con_productividad_disenyo.create
int iCurrent
call super::create
this.gb_7=create gb_7
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.uo_disenyador=create uo_disenyador
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.ddlb_grafica=create ddlb_grafica
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_7
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.uo_disenyador
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.ddlb_grafica
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_1
end on

on w_con_productividad_disenyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_7)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.uo_disenyador)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.ddlb_grafica)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;call super::open;
istr_parametros.s_titulo_ventana =   "Informe Diseño"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana


em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy") 
em_fhasta.text = string(today(), "dd-mm-yy")

em_fdesde.setfocus()

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(FocusRect!)

ddlb_grafica.text = '%'


end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_productividad_disenyo
integer x = 1083
integer y = 2048
integer width = 1083
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_productividad_disenyo
integer x = 3040
integer width = 178
integer height = 92
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_productividad_disenyo
integer x = 37
integer width = 4823
integer height = 76
end type

type gb_7 from groupbox within w_con_productividad_disenyo
integer x = 2263
integer y = 80
integer width = 334
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Gráfica"
end type

type pb_imprimir from upb_imprimir within w_con_productividad_disenyo
event clicked pbm_bnclicked
integer x = 4594
integer y = 124
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow (dw_1)

end event

type dw_1 from datawindow within w_con_productividad_disenyo
integer x = 32
integer y = 268
integer width = 4823
integer height = 2632
string dataobject = "dw_con_productividad_disenyo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event rowfocuschanged;//This.SelectRow(0, FALSE)	
//This.SelectRow ( currentrow, True )
//	
	
	

end event

event clicked;string orden

choose case dwo.name
	case "colecciones_t"
		orden = "colecciones d"
	case "piezas_t"
		orden = "piezas d"
	case "colecciones_prod_t"
		orden = "colecciones_prod d"
	case "piezas_prod_t"
		orden = "piezas_prod d"
	case "ventas_t"
		orden = "ventas d"
	case "ventas_prod_t"
		orden = "ventas_prod d"

	case "t_altas_periodo"
		orden = "altas_periodo d"
	case "t_pzas_periodo"
		orden = "pzas_periodo d"
	case "t_trab_periodo"
		orden = "trab_periodo d"
		
	case "t_porc_ventas"
		orden = "porc_ventas d"
	case "t_trabajos"
		orden = "trabajos d"
	case "t_trabajos_por_pieza"
		orden = "trabajos_por_pieza d"
	case "t_porc_pzas_prod"
		orden = "porc_pzas_prod d"
	case "t_porc_colecc_prod"
		orden = "porc_colecc_prod d"
	case "t_porc_colecc_prod_dis"
		orden = "porc_colecc_prod_dis d"
		
		
		
end choose

dw_1.setsort (orden)
dw_1.sort()
end event

type cb_1 from u_boton within w_con_productividad_disenyo
integer x = 4224
integer y = 124
integer width = 370
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_productividad_disenyo
integer x = 4718
integer y = 124
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type uo_disenyador from u_em_campo_2 within w_con_productividad_disenyo
event destroy ( )
integer x = 873
integer y = 140
integer width = 1330
integer taborder = 40
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

type em_fdesde from u_em_campo within w_con_productividad_disenyo
integer x = 73
integer y = 140
integer width = 352
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_productividad_disenyo
integer x = 462
integer y = 140
integer width = 352
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type ddlb_grafica from dropdownlistbox within w_con_productividad_disenyo
integer x = 2286
integer y = 140
integer width = 283
integer height = 400
integer taborder = 50
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

type gb_2 from groupbox within w_con_productividad_disenyo
integer x = 859
integer y = 80
integer width = 1376
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Diseñador"
end type

type gb_3 from groupbox within w_con_productividad_disenyo
integer x = 50
integer y = 80
integer width = 791
integer height = 160
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_1 from groupbox within w_con_productividad_disenyo
integer x = 4197
integer y = 80
integer width = 654
integer height = 160
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

