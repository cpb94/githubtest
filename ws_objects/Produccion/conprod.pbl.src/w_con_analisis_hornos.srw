$PBExportHeader$w_con_analisis_hornos.srw
$PBExportComments$Informe de Objetivos de Facturación
forward
global type w_con_analisis_hornos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_analisis_hornos
end type
type pb_2 from upb_imprimir within w_con_analisis_hornos
end type
type cb_1 from commandbutton within w_con_analisis_hornos
end type
type gb_6 from groupbox within w_con_analisis_hornos
end type
type dw_informe from datawindow within w_con_analisis_hornos
end type
type em_fdesde from u_em_campo within w_con_analisis_hornos
end type
type em_fhasta from u_em_campo within w_con_analisis_hornos
end type
type sle_semanas from singlelineedit within w_con_analisis_hornos
end type
type st_1 from statictext within w_con_analisis_hornos
end type
type uo_linea from u_em_campo_2 within w_con_analisis_hornos
end type
type uo_1 from u_em_campo_2 within w_con_analisis_hornos
end type
type uo_lineas from u_em_campo_2 within w_con_analisis_hornos
end type
type gb_1 from groupbox within w_con_analisis_hornos
end type
type gb_3 from groupbox within w_con_analisis_hornos
end type
type gb_2 from groupbox within w_con_analisis_hornos
end type
type gb_4 from groupbox within w_con_analisis_hornos
end type
type gb_5 from groupbox within w_con_analisis_hornos
end type
end forward

global type w_con_analisis_hornos from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3689
integer height = 2604
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
sle_semanas sle_semanas
st_1 st_1
uo_linea uo_linea
uo_1 uo_1
uo_lineas uo_lineas
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
end type
global w_con_analisis_hornos w_con_analisis_hornos

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2, fecha_actual
string sel, lineaprod, seccion
long dias, fila_actual
dec metros, piezas

data.setredraw(true)
data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text

dias = 0
fecha_Actual = fecha1
do while fecha_actual <= fecha2 
	if dayname(fecha_actual) <> "sábado" and dayname(fecha_actual) <> "domingo" then
		dias = dias +1
	end if
	fecha_actual = RelativeDate(fecha_actual, 1)
loop

if uo_lineas.em_codigo.text = '' or isnull (uo_lineas.em_codigo.text) then
	lineaprod = '%'
	seccion = '3'
else
	lineaprod = uo_lineas.em_codigo.text
	seccion = '%'
end if

// PROMEDIO DE PIEZAS Y METROS DIARIO

select sum((buenas + malas) * formatos.ancho * formatos.largo) / 10000 , sum (buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and  prodpartes_ot.linea like :lineaprod
and  prodpartes_ot.seccion like :seccion
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2;

fila_actual = data.insertrow(0)
data.object.m2_promedio_diario [fila_actual] = metros / dias
data.object.pzs_promedio_diario [fila_actual] = piezas / dias


//	 ARTICULOS CON CORTE FINAL Y BASE TENCER
select sum((buenas + malas) * formatos.ancho * formatos.largo)/ 10000 , sum(buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos, art_codestadistico
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and art_codestadistico.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and articulos.codigo = art_codestadistico.codigo
and prodpartes_ot.linea like :lineaprod
and  prodpartes_ot.seccion like :seccion
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2
and art_codestadistico.N = 'N'
and prodpartes_ot.art_terminado = 'S'
and ( '10' in ( select tipo_operacion 
		from art_ver_operaciones 
		where art_ver_operaciones.empresa = 1 
		and  prodpartes_ot.version = art_ver_operaciones.version 
		and  prodpartes_ot.articulo = art_ver_operaciones.articulo)  or
	'8' <> all (select tipo_operacion 
		from art_ver_operaciones 
		where art_ver_operaciones.empresa = 1 
		and  prodpartes_ot.version = art_ver_operaciones.version 
		and  prodpartes_ot.articulo = art_ver_operaciones.articulo) );

data.object.m2_corte_final_base_tencer [fila_actual] = metros / dias
data.object.pzs_corte_final_base_tencer [fila_actual] = piezas / dias

data.object.p_m2_corte_final_base_tencer [fila_actual] = &
			(data.object.m2_corte_final_base_tencer [fila_actual] * 100) / data.object.m2_promedio_diario [fila_actual]
data.object.p_pzs_corte_final_base_tencer [fila_actual] = &
			(data.object.pzs_corte_final_base_tencer [fila_actual] * 100) / data.object.pzs_promedio_diario [fila_actual]

//	 ARTICULOS CON CORTE FINAL Y BASE CLIENTE
select sum((buenas + malas) * formatos.ancho * formatos.largo)/ 10000 , sum(buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos, art_codestadistico
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and art_codestadistico.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and articulos.codigo = art_codestadistico.codigo
and prodpartes_ot.linea like :lineaprod
and  prodpartes_ot.seccion like :seccion
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2
and art_codestadistico.N = 'S'
and prodpartes_ot.art_terminado = 'S'
and ( '10' in ( select tipo_operacion 
		from art_ver_operaciones 
		where art_ver_operaciones.empresa = 1 
		and  prodpartes_ot.version = art_ver_operaciones.version 
		and  prodpartes_ot.articulo = art_ver_operaciones.articulo)  or
	'8' <> all (select tipo_operacion 
		from art_ver_operaciones 
		where art_ver_operaciones.empresa = 1 
		and  prodpartes_ot.version = art_ver_operaciones.version 
		and  prodpartes_ot.articulo = art_ver_operaciones.articulo) );

data.object.m2_corte_final_base_cliente [fila_actual] = metros / dias
data.object.pzs_corte_final_base_cliente [fila_actual] = piezas / dias

data.object.p_m2_corte_final_base_cliente [fila_actual] = &
			(data.object.m2_corte_final_base_cliente [fila_actual] * 100) / data.object.m2_promedio_diario [fila_actual]
data.object.p_pzs_corte_final_base_cliente [fila_actual] = &
			(data.object.pzs_corte_final_base_cliente [fila_actual] * 100) / data.object.pzs_promedio_diario [fila_actual]

// ARTÍCULOS QUE SE ENCAJAN EN EL HORNO
select sum((buenas + malas) * formatos.ancho * formatos.largo)/ 10000 , sum(buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and prodpartes_ot.operacion = '8'
and prodpartes_ot.linea like :lineaprod 
and  prodpartes_ot.seccion like :seccion
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2;

data.object.m2_encajados_en_horno [fila_actual] = metros / dias
data.object.pzs_encajados_en_horno [fila_actual] = piezas / dias

data.object.p_m2_encajados_en_horno [fila_actual] = &
			( data.object.m2_encajados_en_horno [fila_actual]  * 100 ) / data.object.m2_promedio_diario [fila_actual]
data.object.p_pzs_encajados_en_horno [fila_actual] = &
			( data.object.pzs_encajados_en_horno [fila_actual]  * 100 ) / data.object.pzs_promedio_diario [fila_actual]


// ARTÍCULOS QUE VAN A CUARTO FUEGO
select sum((buenas + malas) * formatos.ancho * formatos.largo)/ 10000 , sum(buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos, art_codestadistico
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and art_codestadistico.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and articulos.codigo = art_codestadistico.codigo
and prodpartes_ot.operacion = '3'
and prodpartes_ot.art_terminado = 'N'
and  prodpartes_ot.linea like :lineaprod
and  prodpartes_ot.seccion like :seccion
and art_codestadistico.G4 = '4F'
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2;

data.object.m2_que_van_a_4f [fila_actual] = metros / dias
data.object.pzs_que_van_a_4f [fila_actual] = piezas / dias

data.object.p_m2_que_van_a_4f [fila_actual] = &
			( data.object.m2_que_van_a_4f [fila_actual] * 100 ) / data.object.m2_promedio_diario [fila_actual]
data.object.p_pzs_que_van_a_4f [fila_actual] = &
			( data.object.pzs_que_van_a_4f [fila_actual] * 100 ) / data.object.pzs_promedio_diario [fila_actual]


// BASES Y BIZCOCHOS
select sum((buenas + malas) * formatos.ancho * formatos.largo)/ 10000 , sum(buenas + malas)
into :metros, :piezas
from prodpartes_ot, articulos, formatos, art_codestadistico
where articulos.empresa = 1 
and prodpartes_ot.empresa = 1
and formatos.empresa = 1
and art_codestadistico.empresa = 1
and prodpartes_ot.articulo = articulos.codigo
and prodpartes_ot.formato = formatos.codigo
and articulos.codigo = art_codestadistico.codigo
and articulos.uso = '1'
and prodpartes_ot.operacion = '3'
and prodpartes_ot.linea like :lineaprod
and  prodpartes_ot.seccion like :seccion
and prodpartes_ot.fecha >=:fecha1 
and prodpartes_ot.fecha <=:fecha2;

data.object.m2_bases_bizcochos [fila_actual] = metros / dias
data.object.pzs_bases_bizcochos [fila_actual] = piezas / dias

data.object.p_m2_bases_bizcochos [fila_actual] = &
					( data.object.m2_bases_bizcochos [fila_actual] * 100 ) / data.object.m2_promedio_diario [fila_actual]
data.object.p_pzs_bases_bizcochos [fila_actual] = &
					( data.object.pzs_bases_bizcochos [fila_actual] * 100 ) / data.object.pzs_promedio_diario [fila_actual]

data.object.descarga_automatica [fila_actual] = ( ( 	data.object.m2_que_van_a_4f [fila_actual] + &
																		data.object.m2_corte_final_base_tencer [fila_actual] ) * 100 ) / &
																		data.object.m2_promedio_diario [fila_actual]
data.object.recoger_horno [fila_actual] = 100 - data.object.descarga_automatica [fila_actual]


data.sort()
data.groupcalc()
data.setredraw(true)



end subroutine

event close;call super::close;dw_informe.reset()

end event

on w_con_analisis_hornos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.sle_semanas=create sle_semanas
this.st_1=create st_1
this.uo_linea=create uo_linea
this.uo_1=create uo_1
this.uo_lineas=create uo_lineas
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_informe
this.Control[iCurrent+6]=this.em_fdesde
this.Control[iCurrent+7]=this.em_fhasta
this.Control[iCurrent+8]=this.sle_semanas
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_linea
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.uo_lineas
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_5
end on

on w_con_analisis_hornos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.sle_semanas)
destroy(this.st_1)
destroy(this.uo_linea)
destroy(this.uo_1)
destroy(this.uo_lineas)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event ue_f5;f_control(dw_informe)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Análisis de la Producción en los Hornos"
This.title=istr_parametros.s_titulo_ventana

em_fhasta.text = string(RelativeDate(today(), -1),"dd-mm-yy")
sle_semanas.text = '1'
em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_analisis_hornos
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_analisis_hornos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_analisis_hornos
integer x = 9
integer y = 8
integer width = 3575
integer height = 88
end type

type pb_1 from upb_salir within w_con_analisis_hornos
integer x = 3442
integer y = 136
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_analisis_hornos
integer x = 3314
integer y = 136
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_analisis_hornos
integer x = 3017
integer y = 136
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_6 from groupbox within w_con_analisis_hornos
integer x = 2999
integer y = 92
integer width = 581
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_con_analisis_hornos
integer x = 5
integer y = 252
integer width = 3589
integer height = 2108
boolean bringtotop = true
string dataobject = "dw_con_analisis_hornos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_analisis_hornos
integer x = 27
integer y = 148
integer width = 357
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_analisis_hornos
integer x = 407
integer y = 148
integer width = 357
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type sle_semanas from singlelineedit within w_con_analisis_hornos
integer x = 1138
integer y = 148
integer width = 201
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;if long(sle_semanas.text) = 1 then
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
else
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), ( -7 * ( long( sle_semanas.text ) -1 ) ) - 6 ),"dd-mm-yy")
end if

end event

type st_1 from statictext within w_con_analisis_hornos
integer x = 832
integer y = 156
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Semanas:"
boolean focusrectangle = false
end type

type uo_linea from u_em_campo_2 within w_con_analisis_hornos
event destroy ( )
integer x = 1440
integer y = 152
integer width = 1083
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_linea.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_linea.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_linea.em_codigo.text)
IF Trim(uo_linea.em_campo.text)="" THEN 
 IF Trim(uo_linea.em_codigo.text)<>"" Then uo_linea.em_campo.SetFocus()
 uo_linea.em_campo.text=""
 uo_linea.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type uo_1 from u_em_campo_2 within w_con_analisis_hornos
event destroy ( )
integer x = 1440
integer y = 152
integer width = 1083
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_linea.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_linea.em_codigo.text)
IF Trim(uo_linea.em_campo.text)="" THEN 
 IF Trim(uo_linea.em_codigo.text)<>"" Then uo_linea.em_campo.SetFocus()
 uo_linea.em_campo.text=""
 uo_linea.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type uo_lineas from u_em_campo_2 within w_con_analisis_hornos
event destroy ( )
integer x = 1440
integer y = 148
integer width = 1083
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_lineas.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_lineas.em_campo.text = f_nombre_linea_abr(codigo_empresa,uo_lineas.em_codigo.text)
IF Trim(uo_lineas.em_campo.text)="" THEN 
 IF Trim(uo_lineas.em_codigo.text)<>"" Then uo_lineas.em_campo.SetFocus()
 uo_lineas.em_campo.text=""
 uo_lineas.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = ""

end event

type gb_1 from groupbox within w_con_analisis_hornos
integer x = 795
integer y = 92
integer width = 617
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_con_analisis_hornos
integer x = 1422
integer y = 92
integer width = 1120
integer height = 160
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

type gb_2 from groupbox within w_con_analisis_hornos
integer x = 1422
integer y = 92
integer width = 1120
integer height = 160
integer taborder = 70
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

type gb_4 from groupbox within w_con_analisis_hornos
integer x = 1422
integer y = 92
integer width = 1120
integer height = 160
integer taborder = 80
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

type gb_5 from groupbox within w_con_analisis_hornos
integer x = 9
integer y = 92
integer width = 773
integer height = 160
integer taborder = 80
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

