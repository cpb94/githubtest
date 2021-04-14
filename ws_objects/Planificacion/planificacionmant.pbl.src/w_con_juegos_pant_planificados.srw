$PBExportHeader$w_con_juegos_pant_planificados.srw
forward
global type w_con_juegos_pant_planificados from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_juegos_pant_planificados
end type
type pb_2 from upb_imprimir within w_con_juegos_pant_planificados
end type
type cb_1 from commandbutton within w_con_juegos_pant_planificados
end type
type gb_1 from groupbox within w_con_juegos_pant_planificados
end type
type gb_6 from groupbox within w_con_juegos_pant_planificados
end type
type dw_informe from datawindow within w_con_juegos_pant_planificados
end type
type em_fdesde from u_em_campo within w_con_juegos_pant_planificados
end type
type em_fhasta from u_em_campo within w_con_juegos_pant_planificados
end type
type uo_seccion from u_em_campo_2 within w_con_juegos_pant_planificados
end type
type uo_linea from u_em_campo_2 within w_con_juegos_pant_planificados
end type
type gb_3 from groupbox within w_con_juegos_pant_planificados
end type
type gb_2 from groupbox within w_con_juegos_pant_planificados
end type
end forward

global type w_con_juegos_pant_planificados from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3685
integer height = 2644
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
uo_seccion uo_seccion
uo_linea uo_linea
gb_3 gb_3
gb_2 gb_2
end type
global w_con_juegos_pant_planificados w_con_juegos_pant_planificados

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);/*
Date  fecha1,fecha2
string sel
long actual, i, total_registros
datastore ds_operaciones
string v_articulo, v_version, v_operacion, anyo_Ant, v_seccion, v_seccion_anterior, v_cod_seccion
dec v_piezas, v_coste_hora, v_correccion_velocidad, v_velocidad_Std, v_ancho, v_largo, v_precio_metro, v_velocidad
dec v_coste_fab, v_coste_mp, v_horas


st_contador.visible = true

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)		
fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)

anyo_ant = string(RelativeDate(fecha2, -365))

data.reset()
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text

sel = " select 	p.articulo, p.version, p.operacion, p.ordenoperacion, (p.buenas + p.malas) as piezas, p.seccion, "+&
		" t.coste, t.correccion_velocidad, t.velocidad_Std , t.descripcion_abr, "+&
		" f.ancho, f.largo ,  s.descripcion_abr, "+&
		" fa.precio_metro,  "+&
			"	( SELECT sum((prodpartes_ot.buenas +prodpartes_ot.malas)) / (sum( prodpartes_ot.segundos / 3600  )) "+&
			"	FROM prodpartes_ot "+&
			"	WHERE prodpartes_ot.empresa = '"+codigo_empresa+"' "+&
			"	and prodpartes_ot.fecha >= '"+anyo_ant+"' "+&
			"	and prodpartes_ot.fecha <= '"+em_fhasta.text+"' "+&
			"	and prodpartes_ot.articulo = p.articulo "+&
			"	and prodpartes_ot.version = p.version "+&
			"	and prodpartes_ot.ordenoperacion = p.ordenoperacion "+&
			"	and prodpartes_ot.segundos > 0 ) as velocidad "+&
		" from prodpartes_ot p, "+&
		" art_ver_tipooperacion t, "+&
		" factormp fa, "+&
		" formatos f, "+&
		" art_ver_operaciones o, "+&
		" prodsecciones s "+&
		" where p.empresa = '"+codigo_empresa+"'"+&
		" and t.empresa = '"+codigo_empresa+"'"+&
		" and fa.empresa = '"+codigo_empresa+"'"+&
		" and f.empresa = '"+codigo_empresa+"'"+&
		" and o.empresa = '"+codigo_empresa+"'"+&
		" and s.empresa = '"+codigo_empresa+"'"+&
		" and p.fecha >= '"+em_fdesde.text+"'"+&
		" and p.fecha <= '"+em_fhasta.text+"'"+&
		" and p.operacion = t.codigo "+&
		" and p.formato = f.codigo "+&
		" and p.articulo = o.articulo "+&
		" and p.version = o.version "+&
  		" and p.ordenoperacion = o.orden "+&
      " and o.tipo_operacion = fa.operacion "+&
		" and o.coste = fa.factor "+&
		" and p.seccion = s.codigo "+&
		" order by convert(integer, p.operacion) "

st_contador.text = " Cargando Registros. "
f_cargar_cursor_nuevo(sel, ds_operaciones)

total_registros = ds_operaciones.rowcount() 
v_seccion_anterior = ''
for i = 1 to total_registros 
	v_articulo = ds_operaciones.object.prodpartes_ot_articulo[i]
	v_version = ds_operaciones.object.prodpartes_ot_version[i]
	v_operacion = ds_operaciones.object.prodpartes_ot_operacion[i]
	v_piezas = ds_operaciones.object.piezas[i]
	v_coste_hora = ds_operaciones.object.art_ver_tipooperacion_coste[i]
	v_correccion_velocidad = ds_operaciones.object.art_ver_tipooperacion_correccion_velocidad[i]
	v_velocidad_std = ds_operaciones.object.art_ver_tipooperacion_velocidad_std[i]
	v_ancho = ds_operaciones.object.formatos_ancho[i]
	v_largo = ds_operaciones.object.formatos_largo[i]
	v_precio_metro = 	ds_operaciones.object.factormp_precio_metro[i]
	v_velocidad = ds_operaciones.object.velocidad[i]
	v_seccion = ds_operaciones.object.prodsecciones_descripcion_abr[i]
	v_cod_seccion = ds_operaciones.object.prodpartes_ot_seccion[i]
	
	if v_seccion <> v_seccion_anterior then
		select sum (horas) 
		into :v_horas
		from prodmeses, prodlineas
		where prodlineas.empresa = :codigo_empresa
		and prodmeses.empresa = :codigo_empresa
		and prodlineas.calendario = prodmeses.calendario
		and fecha >= :fecha1
		and fecha <= :fecha2
		and seccion = :v_cod_seccion;
	else
		
	end if
	v_seccion_anterior = v_seccion
	
	if v_operacion = '3' or v_operacion = '8' or v_operacion = '20'  then
		v_velocidad = v_velocidad_std / (v_largo * v_ancho / 10000 )
	end if

	v_coste_fab = v_piezas / ( v_velocidad * v_correccion_velocidad )* v_coste_hora 

	v_coste_mp = v_piezas * v_ancho * v_largo / 10000 * v_precio_metro

	actual = data.insertrow(0)

	data.object.operacion[actual] = ds_operaciones.object.art_ver_tipooperacion_descripcion_abr[i]
	data.object.coste_fab[actual] = v_coste_fab
	data.object.coste_mp[actual] = v_coste_mp
	data.object.coste_tot[actual] = v_coste_fab + v_coste_mp
	data.object.seccion[actual] = v_seccion
	data.object.horas[actual] = v_horas

	st_contador.text = "Registro: "+string(i, "###,###,###,###,##0")+" de "+string(total_registros, "###,###,###,###,##0")
next

destroy ds_operaciones

st_contador.visible = false
data.sort()
data.groupcalc()
data.setredraw(true)

*/
end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana = "Listado de Juegos de Pantallas Programados entre fechas."
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = string(today(),"dd-mm-yy")
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_juegos_pant_planificados.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.uo_seccion=create uo_seccion
this.uo_linea=create uo_linea
this.gb_3=create gb_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.uo_seccion
this.Control[iCurrent+10]=this.uo_linea
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
end on

on w_con_juegos_pant_planificados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.uo_seccion)
destroy(this.uo_linea)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event ue_f5;f_control(dw_informe)
end event

event activate;call super::activate;w_con_juegos_pant_planificados = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_juegos_pant_planificados
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_juegos_pant_planificados
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_juegos_pant_planificados
integer x = 9
integer y = 12
integer width = 3419
integer height = 92
end type

type pb_1 from upb_salir within w_con_juegos_pant_planificados
integer x = 3438
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_juegos_pant_planificados
integer x = 3406
integer y = 156
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_juegos_pant_planificados
integer x = 3109
integer y = 156
integer width = 288
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;string seccion, linea
// f_control(dw_informe)
dw_informe.SetTransObject(SQLCA)


if uo_seccion.em_codigo.text <> '' and not isnull(uo_seccion.em_codigo.text) then
	seccion = uo_seccion.em_codigo.text
else 
	seccion = '%'
end if
if uo_linea.em_codigo.text <> '' and not isnull(uo_linea.em_codigo.text) then
	linea = uo_linea.em_codigo.text
else 
	linea = '%'
end if
dw_informe.retrieve(codigo_empresa, seccion, date(em_fdesde.text), date(em_fhasta.text), linea)

end event

type gb_1 from groupbox within w_con_juegos_pant_planificados
integer x = 59
integer y = 128
integer width = 786
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_juegos_pant_planificados
integer x = 3090
integer y = 116
integer width = 462
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_con_juegos_pant_planificados
integer y = 304
integer width = 3584
integer height = 2096
boolean bringtotop = true
string dataobject = "dw_con_juegos_pant_planificados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_juegos_pant_planificados
integer x = 73
integer y = 188
integer width = 361
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_juegos_pant_planificados
integer x = 462
integer y = 188
integer width = 361
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type uo_seccion from u_em_campo_2 within w_con_juegos_pant_planificados
event destroy ( )
integer x = 1033
integer y = 188
integer width = 873
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_seccion.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_seccion.em_campo.text = f_nombre_seccion_abr(codigo_empresa,uo_seccion.em_codigo.text)
IF Trim(uo_seccion.em_campo.text)="" THEN 
 IF Trim(uo_seccion.em_codigo.text)<>"" Then uo_seccion.em_campo.SetFocus()
 uo_seccion.em_campo.text=""
 uo_seccion.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Secciones"
ue_datawindow = "dw_ayuda_secciones"
ue_filtro     = ""

end event

type uo_linea from u_em_campo_2 within w_con_juegos_pant_planificados
event destroy ( )
integer x = 1957
integer y = 188
integer width = 873
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_linea.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_linea.em_campo.text = f_nombre_linea_abr(codigo_empresa,uo_linea.em_codigo.text)
IF Trim(uo_linea.em_campo.text)="" THEN 
 IF Trim(uo_linea.em_codigo.text)<>"" Then uo_linea.em_campo.SetFocus()
 uo_linea.em_campo.text=""
 uo_linea.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Líneas de Producción"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type gb_3 from groupbox within w_con_juegos_pant_planificados
integer x = 1015
integer y = 128
integer width = 910
integer height = 160
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sección"
end type

type gb_2 from groupbox within w_con_juegos_pant_planificados
integer x = 1938
integer y = 128
integer width = 910
integer height = 160
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Línea"
end type

