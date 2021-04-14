$PBExportHeader$w_con_capacidades_produccion.srw
forward
global type w_con_capacidades_produccion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_capacidades_produccion
end type
type pb_2 from upb_imprimir within w_con_capacidades_produccion
end type
type cb_1 from commandbutton within w_con_capacidades_produccion
end type
type gb_1 from groupbox within w_con_capacidades_produccion
end type
type gb_6 from groupbox within w_con_capacidades_produccion
end type
type dw_informe from datawindow within w_con_capacidades_produccion
end type
type em_fdesde from u_em_campo within w_con_capacidades_produccion
end type
type em_fhasta from u_em_campo within w_con_capacidades_produccion
end type
type sle_semanas from singlelineedit within w_con_capacidades_produccion
end type
type st_1 from statictext within w_con_capacidades_produccion
end type
end forward

global type w_con_capacidades_produccion from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3721
integer height = 3216
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
sle_semanas sle_semanas
st_1 st_1
end type
global w_con_capacidades_produccion w_con_capacidades_produccion

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2, fecha_actual
string sel, mes
dec{2} v_prod_hornos_total, v_efec_hornos, v_Acabado_hornos, v_prod_alta, v_metros_4f, v_porcentaje_4fue
dec{2} v_metros_base_reales, v_metros_seccion_3f, v_base_cliente, v_metros_corte
dec{2} v_prod_hornos_total_buenas, consumo_base, base_vendida, material_tirado
long fila_actual, dias, i

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()
data.setredraw(false)		

fila_actual = data.insertrow(0)

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

// PRODUCCIÓN TOTAL DE HORNOS
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_prod_hornos_total
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '14') or 
		(prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.prod_hornos_total_fechas[fila_actual] = v_prod_hornos_total 

if dias > 0 then
	data.object.prod_hornos_total[fila_actual] = v_prod_hornos_total / dias
else
	data.object.prod_hornos_total[fila_actual] = 0
end if


// TOTAL HORNOS EFECTIVA
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_acabado_hornos
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.prod_hornos_efectiva_fechas[fila_actual] = v_acabado_hornos 
data.object.porcentaje_efectiva_fechas[fila_actual] = ( v_acabado_hornos / v_prod_hornos_total)  * 100
data.object.base_necesaria_fechas[fila_actual] = data.object.prod_hornos_efectiva_fechas[fila_actual]

if dias > 0 then
	data.object.prod_hornos_efectiva[fila_actual] = v_acabado_hornos / dias
else
	data.object.prod_hornos_efectiva[fila_actual] = 0
end if
if v_prod_hornos_total > 0 then
	data.object.porcentaje_efectiva[fila_actual] = ( v_acabado_hornos / v_prod_hornos_total)  * 100
else 
	data.object.porcentaje_efectiva[fila_actual] = 0
end if
data.object.base_necesaria[fila_actual] = data.object.prod_hornos_efectiva[fila_actual]

// PRODUCCION DE A+B
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_prod_alta
from prodpartes_ot, art_codestadistico, formatos
where prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.seccion = '3'
and ( art_codestadistico.g2 = 'B' or art_codestadistico.g2 = 'Z')// or art_codestadistico.g2 = 'N')
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.prod_alta_fechas[fila_actual] = v_prod_hornos_total - v_prod_alta

if dias > 0 then
	data.object.prod_alta[fila_actual] = (v_prod_hornos_total - v_prod_alta) / dias
else
	data.object.prod_alta[fila_actual] = 0
end if

//PORCENTAJE DE 4FUE RESPECTO A LA PRODUCCIÓN TOTAL DE LA SECCIÓN DE TERCER FUEGO
//Cuarto Fuego
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_metros_4f
from  prodpartes_ot, art_codestadistico, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '15'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

//Sección completa deTercer Fuego
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into :v_metros_seccion_3f
from prodpartes_ot, art_codestadistico, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.seccion = '1'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;


if v_metros_seccion_3f > 0 then
	data.object.porcentaje_4fue[fila_actual] = (v_metros_4f / v_metros_seccion_3f) * 100
	data.object.porcentaje_4fue_fechas[fila_actual] = (v_metros_4f / v_metros_seccion_3f) * 100
else
	data.object.porcentaje_4fue[fila_actual] = 0
end if

//BASE POSIBLE (BUENAS)
// PRODUCCIÓN TOTAL DE HORNOS
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * prodpartes_ot.buenas ) metros
into  :v_prod_hornos_total_buenas
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.prod_hornos_total_fechas[fila_actual] = v_prod_hornos_total_buenas 

if dias > 0 then
	data.object.prod_hornos_total[fila_actual] = v_prod_hornos_total_buenas / dias
else
	data.object.prod_hornos_total[fila_actual] = 0
end if




data.object.base_posible_fechas[fila_actual] = data.object.prod_hornos_total_fechas[fila_actual] - data.object.prod_alta_fechas[fila_actual] 
data.object.base_posible[fila_actual] = data.object.prod_hornos_total[fila_actual] - data.object.prod_alta[fila_actual] 

// RATIO
// Artículos sobre base del cliente
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_base_cliente
from prodpartes_ot, formatos, art_codestadistico
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and	art_codestadistico.N = 'S'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.base_cliente_fechas[fila_actual] = v_base_cliente 
if (data.object.base_necesaria_fechas[fila_actual] - data.object.base_cliente_fechas[fila_actual]) <> 0 then
	data.object.ratio_fechas[fila_actual] = &
        data.object.base_posible_fechas[fila_actual] / (data.object.base_necesaria_fechas[fila_actual] - data.object.base_cliente_fechas[fila_actual])
else
	data.object.ratio_fechas[fila_actual]  = 0
end if

if dias > 0 then
	data.object.base_cliente[fila_actual] = v_base_cliente / dias
else
	data.object.base_cliente[fila_actual] = 0
end if
if (data.object.base_necesaria[fila_actual] - data.object.base_cliente[fila_actual]) <> 0 then
	data.object.ratio[fila_actual] = data.object.base_posible[fila_actual] / (data.object.base_necesaria[fila_actual] - data.object.base_cliente[fila_actual])
else
	data.object.ratio[fila_actual]  = 0
end if
if v_acabado_hornos > 0 then
	data.object.porcentaje_base_cliente[fila_actual] =  (v_base_cliente / v_acabado_hornos) * 100 
	data.object.porcentaje_base_cliente_fechas[fila_actual] =  (v_base_cliente / v_acabado_hornos) * 100 
else
	data.object.porcentaje_base_cliente[fila_actual] = 0
end if


// TOTAL DE PRODUCCIÓN DEL CORTE
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_metros_corte
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and 	prodpartes_ot.seccion = '4'
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and	datename(dw,prodpartes_ot.fecha) <> 'Domingo'
and 	datename(dw,prodpartes_ot.fecha) <> 'Sábado';

data.object.prod_total_corte_fechas[fila_actual] = v_metros_corte

if dias > 0 then
	data.object.prod_total_corte[fila_actual] = v_metros_corte / dias
else
	data.object.prod_total_corte[fila_actual] = 0
end if

// TOTAL EFECTIVA DE ARTICULOS QUE LLEVAN CORTE
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros
into  :v_metros_corte
from prodpartes_ot, formatos, art_codestadistico, art_ver_operaciones
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   art_ver_operaciones.formato *= formatos.codigo 
and 	art_ver_operaciones.empresa = :codigo_empresa
and   art_ver_operaciones.articulo = prodpartes_ot.articulo
and 	art_ver_operaciones.version = prodpartes_ot.version
and	((art_ver_operaciones.tipo_operacion = '5') or (art_ver_operaciones.tipo_operacion = '10'))
and	art_codestadistico.empresa = :codigo_empresa
and   art_codestadistico.codigo = prodpartes_ot.articulo
and 	art_codestadistico.ct <> "00"
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S'
and   prodpartes_ot.seccion = '3';

if dias > 0 then
	data.object.mat_a_cortar[fila_actual] = v_metros_corte / dias
else
	data.object.mat_a_cortar[fila_actual] = 0
end if
if data.object.prod_hornos_efectiva[fila_actual] <>0 then
	data.object.porcentaje_cortado[fila_actual] = (data.object.mat_a_cortar[fila_actual] / data.object.prod_hornos_efectiva[fila_actual]) *100
else
	data.object.porcentaje_cortado[fila_actual] = 0
end if
if data.object.mat_a_cortar[fila_actual]  <> 0 then
	data.object.ratio_corte[fila_actual] = data.object.prod_total_corte[fila_actual] / data.object.mat_a_cortar[fila_actual] 
else
	data.object.ratio_corte[fila_actual] = 0
end if

data.object.mat_a_cortar_fechas[fila_actual] = v_metros_corte 
if data.object.prod_hornos_efectiva_Fechas[fila_actual] <>0 then
	data.object.porcentaje_cortado_fechas[fila_actual] = (data.object.mat_a_cortar_fechas[fila_actual] / data.object.prod_hornos_efectiva_fechas[fila_actual]) *100
else
	data.object.porcentaje_cortado_fechas[fila_actual] = 0
end if
if data.object.mat_a_cortar_Fechas[fila_actual]  <> 0 then
	data.object.ratio_corte_fechas[fila_actual] = data.object.prod_total_corte_fechas[fila_actual] / data.object.mat_a_cortar_fechas[fila_actual] 
else
	data.object.ratio_corte_fechas[fila_actual] = 0
end if


data.object.incremento_base_fechas[fila_actual]  = &
	data.object.base_posible_fechas[fila_actual] + data.object.base_cliente_fechas[fila_actual] - data.object.prod_hornos_efectiva_fechas[fila_actual]
data.object.incremento_base[fila_actual]  = &
	data.object.base_posible[fila_actual] + data.object.base_cliente[fila_actual] - data.object.prod_hornos_efectiva[fila_actual]

data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Resumen de Producción"
This.title=istr_parametros.s_titulo_ventana

em_fhasta.text = string(RelativeDate(today(), -1),"dd-mm-yy")
sle_semanas.text = '1'
em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")


end event

on w_con_capacidades_produccion.create
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
this.sle_semanas=create sle_semanas
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.sle_semanas
this.Control[iCurrent+10]=this.st_1
end on

on w_con_capacidades_produccion.destroy
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
destroy(this.sle_semanas)
destroy(this.st_1)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_capacidades_produccion
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_capacidades_produccion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_capacidades_produccion
integer x = 9
integer y = 8
integer width = 3237
integer height = 112
end type

type pb_1 from upb_salir within w_con_capacidades_produccion
integer x = 3269
integer y = 16
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_capacidades_produccion
integer x = 3109
integer y = 160
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_capacidades_produccion
integer x = 2811
integer y = 160
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

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_capacidades_produccion
integer x = 82
integer y = 128
integer width = 617
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

type gb_6 from groupbox within w_con_capacidades_produccion
integer x = 2793
integer y = 120
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

type dw_informe from datawindow within w_con_capacidades_produccion
integer x = 9
integer y = 288
integer width = 3584
integer height = 2676
boolean bringtotop = true
string dataobject = "dw_con_capacidades_produccion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_capacidades_produccion
integer x = 96
integer y = 188
integer width = 288
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_capacidades_produccion
integer x = 393
integer y = 188
integer width = 288
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type sle_semanas from singlelineedit within w_con_capacidades_produccion
integer x = 1083
integer y = 176
integer width = 201
integer height = 84
integer taborder = 50
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

type st_1 from statictext within w_con_capacidades_produccion
integer x = 777
integer y = 184
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

