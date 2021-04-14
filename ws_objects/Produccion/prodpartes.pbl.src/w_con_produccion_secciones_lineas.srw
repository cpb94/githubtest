$PBExportHeader$w_con_produccion_secciones_lineas.srw
forward
global type w_con_produccion_secciones_lineas from w_int_con_empresa
end type
type gb_g from groupbox within w_con_produccion_secciones_lineas
end type
type pb_imprimir from upb_imprimir within w_con_produccion_secciones_lineas
end type
type gb_1 from groupbox within w_con_produccion_secciones_lineas
end type
type em_fdesde from u_em_campo within w_con_produccion_secciones_lineas
end type
type em_fhasta from u_em_campo within w_con_produccion_secciones_lineas
end type
type dw_1 from datawindow within w_con_produccion_secciones_lineas
end type
type cb_1 from u_boton within w_con_produccion_secciones_lineas
end type
type pb_1 from upb_salir within w_con_produccion_secciones_lineas
end type
type uo_seccion from u_em_campo_2 within w_con_produccion_secciones_lineas
end type
type em_fdesde_ant from u_em_campo within w_con_produccion_secciones_lineas
end type
type em_fhasta_ant from u_em_campo within w_con_produccion_secciones_lineas
end type
type rb_total from radiobutton within w_con_produccion_secciones_lineas
end type
type rb_media from radiobutton within w_con_produccion_secciones_lineas
end type
type cbx_efectiva from checkbox within w_con_produccion_secciones_lineas
end type
type cbx_malas from checkbox within w_con_produccion_secciones_lineas
end type
type gb_2 from groupbox within w_con_produccion_secciones_lineas
end type
type gb_3 from groupbox within w_con_produccion_secciones_lineas
end type
end forward

global type w_con_produccion_secciones_lineas from w_int_con_empresa
integer width = 3831
integer height = 2716
gb_g gb_g
pb_imprimir pb_imprimir
gb_1 gb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
uo_seccion uo_seccion
em_fdesde_ant em_fdesde_ant
em_fhasta_ant em_fhasta_ant
rb_total rb_total
rb_media rb_media
cbx_efectiva cbx_efectiva
cbx_malas cbx_malas
gb_2 gb_2
gb_3 gb_3
end type
global w_con_produccion_secciones_lineas w_con_produccion_secciones_lineas

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_media_linea (string linea, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas)
public subroutine f_media_seccion (string seccion, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas)
public subroutine f_total_linea (string linea, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas)
public subroutine f_total_seccion (string seccion, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas)
end prototypes

public subroutine f_control (datawindow data);string seccion, linea, turno, articulo, sel, efectiva
datetime fecha1, fecha2
datastore regs
long i, fila
dec piezas1, metros1, piezas2, metros2
dec horas
Boolean sumar_malas, sumar_pruebas

//No tenemos en cuenta nunca el artículo de pruebas de laboratorio
sumar_pruebas = false

if isnull(uo_seccion.em_codigo.text) then
	seccion = ""
else
	seccion = uo_seccion.em_codigo.text
end if

if cbx_efectiva.checked then
	efectiva = 'S'
else
	efectiva = '%'
end if

if cbx_malas.checked then
	sumar_malas = true
else
	sumar_malas = false
end if

if seccion = "" then  //Cálculo de todas las secciones
	dw_1.object.t_titulo.text = "Sección"
	sel = " Select codigo, descripcion_abr "+&
			" from prodsecciones "+&
			" where empresa = '"+codigo_empresa+"'"+&
			" order by descripcion_abr"
			
	f_cargar_cursor_nuevo (sel, regs)
	dw_1.reset()
	for i = 1 to regs.rowcount()
		fila = dw_1.insertrow(0)		
		dw_1.object.seccion[fila] = regs.object.descripcion_abr[i]
		
		if rb_media.checked then
			f_media_seccion (regs.object.codigo[i], date(em_fdesde.text), date (em_fhasta.text), piezas1, metros1, efectiva, sumar_malas, sumar_pruebas)
		else
			f_total_seccion (regs.object.codigo[i], date(em_fdesde.text), date (em_fhasta.text), piezas1, metros1, efectiva, sumar_malas, sumar_pruebas)
		end if
		
		dw_1.object.piezas1[fila] = piezas1
		dw_1.object.metros1[fila] = metros1
		seccion = regs.object.codigo[fila] 
		
		if rb_total.checked then
			select sum (horas)
			into :horas
			from prodmeses, prodlineas, prodsecciones
			where prodlineas.empresa = :codigo_empresa
			and prodlineas.calendario = prodmeses.calendario
			and prodlineas.empresa = prodsecciones.empresa
			and prodlineas.seccion = prodsecciones.codigo
			and prodsecciones.codigo = :seccion
			and fecha >= :em_fdesde.text
			and fecha <= :em_fhasta.text;
			
			if isnull(horas) or horas = 0 then
				dw_1.object.piezas1h[fila] = 0
				dw_1.object.metros1h[fila] = 0
			else
				dw_1.object.piezas1h[fila] = piezas1 / horas
				dw_1.object.metros1h[fila] = metros1 / horas
			end if
		end if
		
		if rb_media.checked then
			f_media_seccion (regs.object.codigo[i], date(em_fdesde_ant.text), date (em_fhasta_ant.text), piezas2, metros2, efectiva, sumar_malas, sumar_pruebas)
		else
			f_total_seccion (regs.object.codigo[i], date(em_fdesde_ant.text), date (em_fhasta_ant.text), piezas2, metros2, efectiva, sumar_malas, sumar_pruebas)
		end if
		
		dw_1.object.piezas2[fila] = piezas2
		dw_1.object.metros2[fila] = metros2
		
		if rb_total.checked then
			select sum (horas)
			into :horas
			from prodmeses, prodlineas, prodsecciones
			where prodlineas.empresa = :codigo_empresa
			and prodlineas.calendario = prodmeses.calendario
			and prodlineas.empresa = prodsecciones.empresa
			and prodlineas.seccion = prodsecciones.codigo
			and prodsecciones.codigo = :seccion
			and fecha >= :em_fdesde_ant.text
			and fecha <= :em_fhasta_ant.text;
			
			if isnull(horas) or horas = 0 then
				dw_1.object.piezas2h[fila] = 0
				dw_1.object.metros2h[fila] = 0
			else
				dw_1.object.piezas2h[fila] = piezas2 / horas
				dw_1.object.metros2h[fila] = metros2 / horas
			end if
		end if
		if piezas1 > 0 and piezas2 > 0 then
			dw_1.object.var_piezas[fila] = (piezas2 - piezas1) * 100 / piezas1
		else
			dw_1.object.var_piezas[fila] = 0
		end if
		if metros1 > 0 and metros2 > 0 then
			dw_1.object.var_metros[fila] = (metros2 - metros1) * 100 / metros1
		else
			dw_1.object.var_metros[fila] = 0		
		end if
		
		if rb_total.checked then
			if dw_1.object.piezas1h[fila] > 0 and dw_1.object.piezas2h[fila] > 0 then
				dw_1.object.var_piezash[fila] = (dw_1.object.piezas2h[fila] - dw_1.object.piezas1h[fila]) * 100 / dw_1.object.piezas1h[fila]
			else
				dw_1.object.var_piezash[fila] = 0
			end if
			if dw_1.object.metros1h[fila] > 0 and dw_1.object.metros2h[fila] > 0 then
				dw_1.object.var_metrosh[fila] = (dw_1.object.metros2h[fila] - dw_1.object.metros1h[fila]) * 100 / dw_1.object.metros1h[fila]
			else
				dw_1.object.var_metrosh[fila] = 0		
			end if
		end if
		
	next
else   // Cálculo de todas las líneas de una sección.
	dw_1.object.t_titulo.text = "Línea"
	sel = " Select codigo, resumido "+&
			" from prodlineas "+&
			" where empresa = '"+codigo_empresa+"'"+&
			" and seccion = '"+seccion+"'"+&
			" order by resumido"
			
	f_cargar_cursor_nuevo (sel, regs)
	dw_1.reset()
	for i = 1 to regs.rowcount()
		fila = dw_1.insertrow(0)		
		dw_1.object.seccion[fila] = regs.object.resumido[i]
		linea = regs.object.codigo[fila]
		
		

		if rb_media.checked then
			f_media_linea (regs.object.codigo[i], date(em_fdesde.text), date (em_fhasta.text), piezas1, metros1, efectiva, sumar_malas, sumar_pruebas)
		else
			f_total_linea (regs.object.codigo[i], date(em_fdesde.text), date (em_fhasta.text), piezas1, metros1, efectiva, sumar_malas, sumar_pruebas)
		end if
		
		
		dw_1.object.piezas1[fila] = piezas1
		dw_1.object.metros1[fila] = metros1

		if rb_total.checked then
			select sum (horas)
			into :horas
			from prodmeses, prodlineas
			where prodlineas.empresa = :codigo_empresa
			and prodlineas.calendario = prodmeses.calendario
			and prodlineas.codigo = :linea
			and fecha >= :em_fdesde.text
			and fecha <= :em_fhasta.text;
			
			if isnull(horas) or horas = 0 then
				dw_1.object.piezas1h[fila] = 0
				dw_1.object.metros1h[fila] = 0
			else
				dw_1.object.piezas1h[fila] = piezas1 / horas
				dw_1.object.metros1h[fila] = metros1 / horas
			end if
		end if
		
		if rb_media.checked then
			f_media_linea (regs.object.codigo[i], date(em_fdesde_ant.text), date (em_fhasta_ant.text), piezas2, metros2, efectiva, sumar_malas, sumar_pruebas)
		else
			f_total_linea (regs.object.codigo[i], date(em_fdesde_ant.text), date (em_fhasta_ant.text), piezas2, metros2, efectiva, sumar_malas, sumar_pruebas)
		end if

		dw_1.object.piezas2[fila] = piezas2
		dw_1.object.metros2[fila] = metros2
		
		if rb_total.checked then
			select sum (horas)
			into :horas
			from prodmeses, prodlineas
			where prodlineas.empresa = :codigo_empresa
			and prodlineas.calendario = prodmeses.calendario
			and prodlineas.codigo = :linea
			and fecha >= :em_fdesde_ant.text
			and fecha <= :em_fhasta_ant.text;
	
			if isnull(horas) or horas = 0 then
				dw_1.object.piezas2h[fila] = 0
				dw_1.object.metros2h[fila] = 0
			else
				dw_1.object.piezas2h[fila] = piezas2 / horas
				dw_1.object.metros2h[fila] = metros2 / horas
			end if
		end if
		
		if piezas1 > 0 and piezas2 > 0 then
			dw_1.object.var_piezas[fila] = (piezas2 - piezas1) * 100 / piezas1
		else
			dw_1.object.var_piezas[fila] = 0
		end if
		if metros1 > 0 and metros2 > 0 then
			dw_1.object.var_metros[fila] = (metros2 - metros1) * 100 / metros1
		else
			dw_1.object.var_metros[fila] = 0		
		end if
		
		if rb_total.checked then
			if dw_1.object.piezas1h[fila] > 0 and dw_1.object.piezas2h[fila] > 0 then
				dw_1.object.var_piezash[fila] = (dw_1.object.piezas2h[fila] - dw_1.object.piezas1h[fila]) * 100 / dw_1.object.piezas1h[fila]
			else
				dw_1.object.var_piezash[fila] = 0
			end if
			if dw_1.object.metros1h[fila] > 0 and dw_1.object.metros2h[fila] > 0 then
				dw_1.object.var_metrosh[fila] = (dw_1.object.metros2h[fila] - dw_1.object.metros1h[fila]) * 100 / dw_1.object.metros1h[fila]
			else
				dw_1.object.var_metrosh[fila] = 0		
			end if
		end if
	next
	
end if
dw_1.object.t_1.text = em_fdesde.text+" / "+em_fhasta.text
dw_1.object.t_2.text = em_fdesde_ant.text+" / "+em_fhasta_ant.text
	
destroy regs

end subroutine

public subroutine f_media_linea (string linea, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas);string sel, fechad, fechah, pruebas
datastore regs
long i, fila, total_Regs, total_dias

fechad = string(desde, "dd-mm-yyyy")
fechah = string(hasta, "dd-mm-yyyy")

if sumar_pruebas then
	pruebas = ""
else
	pruebas = " and prodpartes_ot.articulo <> '44906' "
end if

if sumar_malas then
	sel = " 	SELECT  sum (prodpartes_ot.buenas + prodpartes_ot.malas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas + prodpartes_ot.malas ) * formatos.ancho * formatos.largo)  / 10000) as metros, "+&
			"	prodpartes_ot.fecha "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.linea = '"+linea+"' ) AND"+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas+&
			"  group by  prodpartes_ot.fecha "
else
	sel = " 	SELECT  sum (prodpartes_ot.buenas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas) * formatos.ancho * formatos.largo)  / 10000) as metros, "+&
			"	prodpartes_ot.fecha "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.linea = '"+linea+"' ) AND"+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas+&
			"  group by  prodpartes_ot.fecha "
end if
f_cargar_cursor_nuevo (sel, regs)

total_regs = regs.rowcount()
total_dias = total_regs
piezas = 0
metros = 0
for i = 1 to total_regs
	if dayname(date(regs.object.prodpartes_ot_fecha[i])) <> "sábado" and dayname(date(regs.object.prodpartes_ot_fecha[i])) <> "domingo" then
		piezas = piezas + regs.object.piezas[i]
		metros = metros + regs.object.metros[i]
	else
		total_dias = total_dias - 1
	end if
next

if total_dias <> 0 then
	piezas = piezas / total_dias
	metros = metros / total_dias
else
	piezas = 0
	metros = 0
end if

destroy regs

end subroutine

public subroutine f_media_seccion (string seccion, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas);string sel, fechad, fechah, pruebas
datastore regs
long i, fila, total_Regs, total_dias

fechad = string(desde, "dd-mm-yyyy")
fechah = string(hasta, "dd-mm-yyyy")

if sumar_pruebas then
	pruebas = ""
else
	pruebas = " and prodpartes_ot.articulo <> '44906' "
end if

if sumar_malas then
	sel = " 	SELECT  sum (prodpartes_ot.buenas + prodpartes_ot.malas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas + prodpartes_ot.malas ) * formatos.ancho * formatos.largo)  / 10000) as metros, "+&
			"	prodpartes_ot.fecha "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN prodsecciones ON prodpartes_ot.empresa = prodsecciones.empresa AND "+&
			" 	prodpartes_ot.seccion = prodsecciones.codigo LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.seccion = '"+seccion+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas+&
			"  group by  prodpartes_ot.fecha "
else
	sel = " 	SELECT  sum (prodpartes_ot.buenas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas ) * formatos.ancho * formatos.largo)  / 10000) as metros, "+&
			"	prodpartes_ot.fecha "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN prodsecciones ON prodpartes_ot.empresa = prodsecciones.empresa AND "+&
			" 	prodpartes_ot.seccion = prodsecciones.codigo LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.seccion = '"+seccion+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas+&
			"  group by  prodpartes_ot.fecha "
end if

f_cargar_cursor_nuevo (sel, regs)

total_regs = regs.rowcount()
total_dias = total_regs

piezas = 0
metros = 0
for i = 1 to total_regs
	if dayname(date(regs.object.prodpartes_ot_fecha[i])) <> "sábado" and dayname(date(regs.object.prodpartes_ot_fecha[i])) <> "domingo" then
		piezas = piezas + regs.object.piezas[i]
		metros = metros + regs.object.metros[i]
	else
		total_dias = total_dias - 1
	end if
next

if total_regs <> 0 then
	piezas = piezas / total_dias
	metros = metros / total_dias
else
	piezas = 0
	metros = 0
end if

destroy regs
end subroutine

public subroutine f_total_linea (string linea, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas);
string sel, fechad, fechah, pruebas
datastore regs
long i, fila, total_Regs, total_dias

fechad = string(desde, "dd-mm-yyyy")
fechah = string(hasta, "dd-mm-yyyy")

if sumar_pruebas then
	pruebas = ""
else
	pruebas = " and prodpartes_ot.articulo <> '44906' "
end if

if sumar_malas then
	sel = " 	SELECT  sum (prodpartes_ot.buenas + prodpartes_ot.malas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas + prodpartes_ot.malas ) * formatos.ancho * formatos.largo)  / 10000) as metros "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+& 
			" 	( prodpartes_ot.linea = '"+linea+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  " + pruebas
else
	sel = " 	SELECT  sum (prodpartes_ot.buenas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas) * formatos.ancho * formatos.largo)  / 10000) as metros "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+& 
			" 	( prodpartes_ot.linea = '"+linea+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+ pruebas
end if


f_cargar_cursor_nuevo (sel, regs)

piezas = regs.object.piezas[1]
metros = regs.object.metros[1]

destroy regs

end subroutine

public subroutine f_total_seccion (string seccion, date desde, date hasta, ref decimal piezas, ref decimal metros, string efectiva, boolean sumar_malas, boolean sumar_pruebas);string sel, fechad, fechah, pruebas
datastore regs
long i, fila, total_Regs, total_dias

fechad = string(desde, "dd-mm-yyyy")
fechah = string(hasta, "dd-mm-yyyy")

if sumar_pruebas then
	pruebas = ""
else
	pruebas = " and prodpartes_ot.articulo <> '44906' "
end if

if sumar_malas then
	sel = " 	SELECT  sum (prodpartes_ot.buenas + prodpartes_ot.malas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas + prodpartes_ot.malas ) * formatos.ancho * formatos.largo)  / 10000) as metros "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN prodsecciones ON prodpartes_ot.empresa = prodsecciones.empresa AND "+&
			" 	prodpartes_ot.seccion = prodsecciones.codigo LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.seccion = '"+seccion+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas
else
	sel = " 	SELECT  sum (prodpartes_ot.buenas) as piezas,  "+&
			"	sum (( ( prodpartes_ot.buenas) * formatos.ancho * formatos.largo)  / 10000) as metros "+&
			" 	FROM prodpartes_ot LEFT OUTER JOIN prodsecciones ON prodpartes_ot.empresa = prodsecciones.empresa AND "+&
			" 	prodpartes_ot.seccion = prodsecciones.codigo LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa "+&
			" 	AND prodpartes_ot.formato = formatos.codigo  "+&
			" 	WHERE ( prodpartes_ot.empresa = "+codigo_empresa+" ) AND  "+&
			" 	( prodpartes_ot.fecha >= '"+fechad+"' ) AND  "+&
			" 	( prodpartes_ot.fecha <= '"+fechah+"' ) AND  "+&
			" 	( prodpartes_ot.seccion = '"+seccion+"' ) AND "+&
			" 	prodpartes_ot.art_terminado like '"+efectiva+"'  "+pruebas
end if


f_cargar_cursor_nuevo (sel, regs)


piezas = regs.object.piezas[1]
metros = regs.object.metros[1]

destroy regs
end subroutine

on w_con_produccion_secciones_lineas.create
int iCurrent
call super::create
this.gb_g=create gb_g
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.uo_seccion=create uo_seccion
this.em_fdesde_ant=create em_fdesde_ant
this.em_fhasta_ant=create em_fhasta_ant
this.rb_total=create rb_total
this.rb_media=create rb_media
this.cbx_efectiva=create cbx_efectiva
this.cbx_malas=create cbx_malas
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_g
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.em_fdesde
this.Control[iCurrent+5]=this.em_fhasta
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.uo_seccion
this.Control[iCurrent+10]=this.em_fdesde_ant
this.Control[iCurrent+11]=this.em_fhasta_ant
this.Control[iCurrent+12]=this.rb_total
this.Control[iCurrent+13]=this.rb_media
this.Control[iCurrent+14]=this.cbx_efectiva
this.Control[iCurrent+15]=this.cbx_malas
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_3
end on

on w_con_produccion_secciones_lineas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_g)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.uo_seccion)
destroy(this.em_fdesde_ant)
destroy(this.em_fhasta_ant)
destroy(this.rb_total)
destroy(this.rb_media)
destroy(this.cbx_efectiva)
destroy(this.cbx_malas)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;integer permiso

istr_parametros.s_titulo_ventana =   "Informe Resumen de Producción por Secciones y Líneas"
istr_parametros.s_listado        =   "dw_con_porduccion_secciones_lineas"
This.title                       =   istr_parametros.s_titulo_ventana

uo_seccion.setfocus()

em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fdesde.text = em_fhasta.text 
em_fhasta_ant.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fdesde_ant.text = em_fhasta.text 

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
	case 1
//		menu_planificacion.m_archivo.m_grabar.disable()
//		menu_planificacion.m_herramientas.m_borrarseleccin.disable()
//		menu_planificacion.m_herramientas.m_moverantes.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_herramientas.m_borrarot.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_procesos.disable()
//		menu_planificacion.m_procesos.m_generar1.disable()
//		menu_planificacion.m_seleccionar.disable()
//		menu_planificacion.m_listados.disable()
end choose



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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_produccion_secciones_lineas
integer x = 718
integer y = 1096
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_produccion_secciones_lineas
boolean visible = false
integer x = 1253
integer y = 1752
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_produccion_secciones_lineas
integer x = 32
integer y = 8
integer width = 3557
integer height = 80
integer textsize = -9
end type

type gb_g from groupbox within w_con_produccion_secciones_lineas
integer x = 32
integer y = 84
integer width = 485
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sección"
end type

type pb_imprimir from upb_imprimir within w_con_produccion_secciones_lineas
event clicked pbm_bnclicked
integer x = 3616
integer y = 136
integer taborder = 0
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type gb_1 from groupbox within w_con_produccion_secciones_lineas
integer x = 571
integer y = 88
integer width = 622
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo 1"
end type

type em_fdesde from u_em_campo within w_con_produccion_secciones_lineas
integer x = 590
integer y = 148
integer width = 288
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_produccion_secciones_lineas
integer x = 887
integer y = 148
integer width = 288
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_1 from datawindow within w_con_produccion_secciones_lineas
integer x = 46
integer y = 272
integer width = 3703
integer height = 2224
string dataobject = "dw_con_produccion_secciones_lineas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_produccion_secciones_lineas
integer x = 3214
integer y = 136
integer width = 389
integer height = 96
integer taborder = 60
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_produccion_secciones_lineas
integer x = 3611
integer y = 8
integer width = 114
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

type uo_seccion from u_em_campo_2 within w_con_produccion_secciones_lineas
event destroy ( )
integer x = 50
integer y = 144
integer width = 448
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_seccion.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_seccion.em_campo.text=f_nombre_seccion_abr(codigo_empresa,uo_seccion.em_codigo.text)
IF Trim(uo_seccion.em_campo.text)="" THEN 
 IF Trim(uo_seccion.em_codigo.text)<>"" Then uo_seccion.em_campo.SetFocus()
 uo_seccion.em_campo.text=""
 uo_seccion.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de secciones"
ue_datawindow = "dw_ayuda_secciones"
ue_filtro     = ""

end event

type em_fdesde_ant from u_em_campo within w_con_produccion_secciones_lineas
integer x = 1225
integer y = 148
integer width = 288
integer height = 80
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta_ant from u_em_campo within w_con_produccion_secciones_lineas
integer x = 1527
integer y = 148
integer width = 288
integer height = 80
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type rb_total from radiobutton within w_con_produccion_secciones_lineas
integer x = 1911
integer y = 140
integer width = 320
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Total"
end type

type rb_media from radiobutton within w_con_produccion_secciones_lineas
integer x = 2144
integer y = 148
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Media"
boolean checked = true
end type

type cbx_efectiva from checkbox within w_con_produccion_secciones_lineas
integer x = 2478
integer y = 140
integer width = 302
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Efectiva"
end type

type cbx_malas from checkbox within w_con_produccion_secciones_lineas
integer x = 2775
integer y = 140
integer width = 421
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Sumar Malas"
boolean checked = true
end type

type gb_2 from groupbox within w_con_produccion_secciones_lineas
integer x = 1207
integer y = 88
integer width = 626
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo 2"
end type

type gb_3 from groupbox within w_con_produccion_secciones_lineas
integer x = 1861
integer y = 92
integer width = 585
integer height = 152
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

