$PBExportHeader$w_con_resumen_produccion.srw
forward
global type w_con_resumen_produccion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_produccion
end type
type pb_2 from upb_imprimir within w_con_resumen_produccion
end type
type cb_1 from commandbutton within w_con_resumen_produccion
end type
type gb_1 from groupbox within w_con_resumen_produccion
end type
type gb_6 from groupbox within w_con_resumen_produccion
end type
type dw_informe from datawindow within w_con_resumen_produccion
end type
type em_fdesde from u_em_campo within w_con_resumen_produccion
end type
type em_fhasta from u_em_campo within w_con_resumen_produccion
end type
end forward

global type w_con_resumen_produccion from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3666
integer height = 3420
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
end type
global w_con_resumen_produccion w_con_resumen_produccion

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control_copia (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string sel, mes
dec{0} v_buenas_base, v_malas_base, v_total_base, v_metros_base
dec{0} v_buenas_biz, v_malas_biz, v_total_biz, v_metros_biz
dec{0} v_buenas_bico, v_malas_bico, v_total_bico, v_metros_bico
dec{0} v_buenas_3f, v_malas_3f, v_total_3f, v_metros_3f
dec{0} v_buenas_4f, v_malas_4f, v_total_4f, v_metros_4f
dec{0} v_buenas_mold3f, v_malas_mold3f, v_total_mold3f, v_metros_mold3f
dec{0} v_buenas_mold4f, v_malas_mold4f, v_total_mold4f, v_metros_mold4f
dec{0} v_buenas_hornos, v_malas_hornos, v_total_hornos, v_metros_hornos
dec{0} v_buenas_corte, v_malas_corte, v_total_corte, v_metros_corte
dec{2} v_porcent_base, v_porcent_biz, v_porcent_bico, v_porcent_3f, v_porcent_4f
dec{2} v_porcent_mold3f, v_porcent_mold4f, v_porcent_hornos, v_porcent_corte, v_porcen_buenash_efec, v_porcen_buenasc_efec
dec{2} v_acabado_hornos, v_efec_hornos, v_acabado_corte, v_efec_corte, v_piezash_acabado, v_piezasc_acabado, v_base_cliente
long fila_actual

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)		

fila_actual = data.insertrow(0)

fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)

data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text


// Bases
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_base, :v_malas_base, :v_total_base, :v_metros_base, :v_porcent_base
from prodpartes_ot, art_codestadistico, formatos
where prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '1'
and  	art_codestadistico.g2 = 'B'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;
data.object.buenas_base[fila_actual] = v_buenas_base
data.object.malas_base[fila_actual] = v_malas_base
data.object.total_base[fila_actual] = v_total_base
data.object.metros_base[fila_actual] = v_metros_base
data.object.porcent_base[fila_actual] = v_porcent_base

// Bizcochos
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_biz, :v_malas_biz, :v_total_biz, :v_metros_biz, :v_porcent_biz
from prodpartes_ot, art_codestadistico, formatos
where	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '1'
and  	art_codestadistico.g2 = 'Z'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;
data.object.buenas_biz[fila_actual] = v_buenas_biz
data.object.malas_biz[fila_actual] = v_malas_biz
data.object.total_biz[fila_actual] = v_total_biz
data.object.metros_biz[fila_actual] = v_metros_biz
data.object.porcent_biz[fila_actual] = v_porcent_biz

//Bicocción
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_bico, :v_malas_bico, :v_total_bico, :v_metros_bico, :v_porcent_bico
from prodpartes_ot, formatos, articulos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and 	articulos.empresa = :codigo_empresa
and 	prodpartes_ot.articulo = articulos.codigo
and   articulos.uso <> '1'
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '7'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_bico[fila_actual] = v_buenas_bico
data.object.malas_bico[fila_actual] = v_malas_bico
data.object.total_bico[fila_actual] = v_total_bico
data.object.metros_bico[fila_actual] = v_metros_bico
data.object.porcent_bico[fila_actual] = v_porcent_bico

//Tercer Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_3f, :v_malas_3f, :v_total_3f, :v_metros_3f, :v_porcent_3f
from prodpartes_ot, art_codestadistico, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '2'
and  	((art_codestadistico.g3 = 'R') or (art_codestadistico.g3 = 'L'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_3f[fila_actual] = v_buenas_3f
data.object.malas_3f[fila_actual] = v_malas_3f
data.object.total_3f[fila_actual] = v_total_3f
data.object.metros_3f[fila_actual] = v_metros_3f
data.object.porcent_3f[fila_actual] = v_porcent_3f

//Cuarto Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_4f, :v_malas_4f, :v_total_4f, :v_metros_4f, :v_porcent_4f
from  prodpartes_ot, art_codestadistico, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '15'
and  	((art_codestadistico.g3 = 'R') or (art_codestadistico.g3 = 'L'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_4f[fila_actual] = v_buenas_4f
data.object.malas_4f[fila_actual] = v_malas_4f
data.object.total_4f[fila_actual] = v_total_4f
data.object.metros_4f[fila_actual] = v_metros_4f
data.object.porcent_4f[fila_actual] = v_porcent_4f

// Molduras Tercer Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_mold3f, :v_malas_mold3f, :v_total_mold3f, :v_metros_mold3f, :v_porcent_mold3f
from prodpartes_ot, art_codestadistico, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '2'
and  	art_codestadistico.g3 = 'C'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_mold3f[fila_actual] = v_buenas_mold3f
data.object.malas_mold3f[fila_actual] = v_malas_mold3f
data.object.total_mold3f[fila_actual] = v_total_mold3f
data.object.metros_mold3f[fila_actual] = v_metros_mold3f
data.object.porcent_mold3f[fila_actual] = v_porcent_mold3f

// Molduras Cuarto Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_mold4f, :v_malas_mold4f, :v_total_mold4f, :v_metros_mold4f, :v_porcent_mold4f
from prodpartes_ot, art_codestadistico, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '15'
and  	art_codestadistico.g3 = 'C'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_mold4f[fila_actual] = v_buenas_mold4f
data.object.malas_mold4f[fila_actual] = v_malas_mold4f
data.object.total_mold4f[fila_actual] = v_total_mold4f
data.object.metros_mold4f[fila_actual] = v_metros_mold4f
data.object.porcent_mold4f[fila_actual] = v_porcent_mold4f

// Hornos
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_hornos, :v_malas_hornos, :v_total_hornos, :v_metros_hornos, :v_porcent_hornos
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_hornos[fila_actual] = v_buenas_hornos
data.object.malas_hornos[fila_actual] = v_malas_hornos
data.object.total_hornos[fila_actual] = v_total_hornos
data.object.metros_hornos[fila_actual] = v_metros_hornos
data.object.porcent_hornos[fila_actual] = v_porcent_hornos

// Hornos porcentaje buenas efectiva
select (sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_porcen_buenash_efec
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.porcen_buenash_efec[fila_actual] = v_porcen_buenash_efec

// Total Hornos efectiva 
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			sum(prodpartes_ot.buenas + prodpartes_ot.malas) piezas_efec
into  :v_acabado_hornos, :v_piezash_acabado
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

v_efec_hornos = ( v_acabado_hornos / v_metros_hornos )  * 100

data.object.buenas_hornos[fila_actual] = v_buenas_hornos
data.object.malas_hornos[fila_actual] = v_malas_hornos
data.object.total_hornos[fila_actual] = v_total_hornos
data.object.metros_hornos[fila_actual] = v_metros_hornos
data.object.porcent_hornos[fila_actual] = v_porcent_hornos
data.object.efec_hornos[fila_actual] = v_efec_hornos
data.object.piezash_efec[fila_actual] = v_piezash_acabado
data.object.metrosh_efec[fila_actual] = v_acabado_hornos

// Corte
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_corte, :v_malas_corte, :v_total_corte, :v_metros_corte, :v_porcent_corte
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_corte[fila_actual] = v_buenas_corte
data.object.malas_corte[fila_actual] = v_malas_corte
data.object.total_corte[fila_actual] = v_total_corte
data.object.metros_corte[fila_actual] = v_metros_corte
data.object.porcent_corte[fila_actual] = v_porcent_corte

// Corte efectiva
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			sum(prodpartes_ot.buenas + prodpartes_ot.malas) piezas_efec
into  :v_acabado_corte, :v_piezasc_acabado
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

v_efec_corte = ( v_acabado_corte / v_metros_corte )  * 100

data.object.buenas_corte[fila_actual] = v_buenas_corte
data.object.malas_corte[fila_actual] = v_malas_corte
data.object.total_corte[fila_actual] = v_total_corte
data.object.metros_corte[fila_actual] = v_metros_corte
data.object.porcent_corte[fila_actual] = v_porcent_corte
data.object.efec_corte[fila_actual] = v_efec_corte
data.object.piezasc_efec[fila_actual] = v_piezasc_acabado
data.object.metrosc_efec[fila_actual] = v_acabado_corte

// Corte porcentaje buenas efectiva 
select	(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_porcen_buenasc_efec
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.porcen_buenasc_efec[fila_actual] = v_porcen_buenasc_efec

// Porcentaje de metros de 4f respecto al total de serigrafía
data.object.porcen_total_4f[fila_actual] = ((data.object.metros_4f[fila_actual] + data.object.metros_mold4f[fila_actual]) / data.object.total_metros_serigrafia[fila_actual] ) * 100

// Porcentaje de metros de ser. curva respecto al total de serigrafía
data.object.porcen_total_ser[fila_actual] = ((data.object.metros_mold3f[fila_actual] + data.object.metros_mold4f[fila_actual]) / data.object.total_metros_serigrafia[fila_actual] ) * 100

// PORCENTAJE DE ARTICULOS QUE SE HACEN SOBRE BASE DEL CLIENTE

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


if v_metros_hornos <> 0 then
	data.object.porcen_base_cli[fila_actual] = (v_base_cliente / v_acabado_hornos ) * 100
else
	data.object.porcen_base_cli[fila_actual] = 0
end if


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

public subroutine f_control_copia (datawindow data);// Copia
Date  fecha1,fecha2
string sel, mes
dec{0} v_buenas_base, v_malas_base, v_total_base, v_metros_base
dec{0} v_buenas_biz, v_malas_biz, v_total_biz, v_metros_biz
dec{0} v_buenas_bico, v_malas_bico, v_total_bico, v_metros_bico
dec{0} v_buenas_3f, v_malas_3f, v_total_3f, v_metros_3f
dec{0} v_buenas_4f, v_malas_4f, v_total_4f, v_metros_4f
dec{0} v_buenas_mold3f, v_malas_mold3f, v_total_mold3f, v_metros_mold3f
dec{0} v_buenas_mold4f, v_malas_mold4f, v_total_mold4f, v_metros_mold4f
dec{0} v_buenas_hornos, v_malas_hornos, v_total_hornos, v_metros_hornos
dec{0} v_buenas_corte, v_malas_corte, v_total_corte, v_metros_corte
dec{2} v_porcent_base, v_porcent_biz, v_porcent_bico, v_porcent_3f, v_porcent_4f
dec{2} v_porcent_mold3f, v_porcent_mold4f, v_porcent_hornos, v_porcent_corte, v_porcen_buenash_efec, v_porcen_buenasc_efec
dec{2} v_acabado_hornos, v_efec_hornos, v_acabado_corte, v_efec_corte, v_piezash_acabado, v_piezasc_acabado, v_base_cliente
long fila_actual

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)		

fila_actual = data.insertrow(0)

fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)

data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text


// Bases
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_base, :v_malas_base, :v_total_base, :v_metros_base, :v_porcent_base
from prodpartes_ot, art_codestadistico, formatos
where prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '1'
and  	art_codestadistico.g2 = 'B'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;
data.object.buenas_base[fila_actual] = v_buenas_base
data.object.malas_base[fila_actual] = v_malas_base
data.object.total_base[fila_actual] = v_total_base
data.object.metros_base[fila_actual] = v_metros_base
data.object.porcent_base[fila_actual] = v_porcent_base

// Bizcochos
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_biz, :v_malas_biz, :v_total_biz, :v_metros_biz, :v_porcent_biz
from prodpartes_ot, art_codestadistico, formatos
where	prodpartes_ot.empresa = :codigo_empresa
and 	art_codestadistico.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.articulo = art_codestadistico.codigo
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '1'
and  	art_codestadistico.g2 = 'Z'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;
data.object.buenas_biz[fila_actual] = v_buenas_biz
data.object.malas_biz[fila_actual] = v_malas_biz
data.object.total_biz[fila_actual] = v_total_biz
data.object.metros_biz[fila_actual] = v_metros_biz
data.object.porcent_biz[fila_actual] = v_porcent_biz

//Bicocción
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_bico, :v_malas_bico, :v_total_bico, :v_metros_bico, :v_porcent_bico
from prodpartes_ot, formatos, articulos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and 	articulos.empresa = :codigo_empresa
and 	prodpartes_ot.articulo = articulos.codigo
and   articulos.uso <> '1'
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '7'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_bico[fila_actual] = v_buenas_bico
data.object.malas_bico[fila_actual] = v_malas_bico
data.object.total_bico[fila_actual] = v_total_bico
data.object.metros_bico[fila_actual] = v_metros_bico
data.object.porcent_bico[fila_actual] = v_porcent_bico

//Tercer Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_3f, :v_malas_3f, :v_total_3f, :v_metros_3f, :v_porcent_3f
from prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '2'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_3f[fila_actual] = v_buenas_3f
data.object.malas_3f[fila_actual] = v_malas_3f
data.object.total_3f[fila_actual] = v_total_3f
data.object.metros_3f[fila_actual] = v_metros_3f
data.object.porcent_3f[fila_actual] = v_porcent_3f

//Cuarto Fuego
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_4f, :v_malas_4f, :v_total_4f, :v_metros_4f, :v_porcent_4f
from  prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	prodpartes_ot.operacion = '15'
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_4f[fila_actual] = v_buenas_4f
data.object.malas_4f[fila_actual] = v_malas_4f
data.object.total_4f[fila_actual] = v_total_4f
data.object.metros_4f[fila_actual] = v_metros_4f
data.object.porcent_4f[fila_actual] = v_porcent_4f


// Hornos
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_hornos, :v_malas_hornos, :v_total_hornos, :v_metros_hornos, :v_porcent_hornos
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_hornos[fila_actual] = v_buenas_hornos
data.object.malas_hornos[fila_actual] = v_malas_hornos
data.object.total_hornos[fila_actual] = v_total_hornos
data.object.metros_hornos[fila_actual] = v_metros_hornos
data.object.porcent_hornos[fila_actual] = v_porcent_hornos

// Hornos porcentaje buenas efectiva
select (sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_porcen_buenash_efec
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.porcen_buenash_efec[fila_actual] = v_porcen_buenash_efec

// Total Hornos efectiva 
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			sum(prodpartes_ot.buenas + prodpartes_ot.malas) piezas_efec
into  :v_acabado_hornos, :v_piezash_acabado
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '3') or (prodpartes_ot.operacion = '4') or
		(prodpartes_ot.operacion = '8') or (prodpartes_ot.operacion = '20'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

if v_metros_hornos <> 0 then
	v_efec_hornos = ( v_acabado_hornos / v_metros_hornos )  * 100
else
	v_efec_hornos =  0
end if

data.object.buenas_hornos[fila_actual] = v_buenas_hornos
data.object.malas_hornos[fila_actual] = v_malas_hornos
data.object.total_hornos[fila_actual] = v_total_hornos
data.object.metros_hornos[fila_actual] = v_metros_hornos
data.object.porcent_hornos[fila_actual] = v_porcent_hornos
data.object.efec_hornos[fila_actual] = v_efec_hornos
data.object.piezash_efec[fila_actual] = v_piezash_acabado
data.object.metrosh_efec[fila_actual] = v_acabado_hornos

// Corte
select	sum(prodpartes_ot.buenas) buenas, 
			sum(prodpartes_ot.malas) malas, 
			sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas) total,			
			sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_buenas_corte, :v_malas_corte, :v_total_corte, :v_metros_corte, :v_porcent_corte
from  prodpartes_ot, formatos
where 	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2;

data.object.buenas_corte[fila_actual] = v_buenas_corte
data.object.malas_corte[fila_actual] = v_malas_corte
data.object.total_corte[fila_actual] = v_total_corte
data.object.metros_corte[fila_actual] = v_metros_corte
data.object.porcent_corte[fila_actual] = v_porcent_corte

// Corte efectiva
select	sum((formatos.largo/100) * (formatos.ancho/100 ) * (prodpartes_ot.buenas + prodpartes_ot.malas)) metros,
			sum(prodpartes_ot.buenas + prodpartes_ot.malas) piezas_efec
into  :v_acabado_corte, :v_piezasc_acabado
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

if v_metros_corte <> 0 then
	v_efec_corte = ( v_acabado_corte / v_metros_corte )  * 100
else
	v_efec_corte = 0
end if

data.object.buenas_corte[fila_actual] = v_buenas_corte
data.object.malas_corte[fila_actual] = v_malas_corte
data.object.total_corte[fila_actual] = v_total_corte
data.object.metros_corte[fila_actual] = v_metros_corte
data.object.porcent_corte[fila_actual] = v_porcent_corte
data.object.efec_corte[fila_actual] = v_efec_corte
data.object.piezasc_efec[fila_actual] = v_piezasc_acabado
data.object.metrosc_efec[fila_actual] = v_acabado_corte

// Corte porcentaje buenas efectiva 
select	(sum(prodpartes_ot.buenas)*100)/(sum(prodpartes_ot.buenas) + sum(prodpartes_ot.malas)) Porcentaje
into  :v_porcen_buenasc_efec
from prodpartes_ot, formatos
where  	prodpartes_ot.empresa = :codigo_empresa
and 	formatos.empresa = :codigo_empresa
and   prodpartes_ot.formato *= formatos.codigo 
and	((prodpartes_ot.operacion = '5') or (prodpartes_ot.operacion = '10'))
and 	prodpartes_ot.fecha >= :fecha1
and 	prodpartes_ot.fecha <= :fecha2
and 	prodpartes_ot.art_terminado = 'S';

data.object.porcen_buenasc_efec[fila_actual] = v_porcen_buenasc_efec

// Porcentaje de metros de 4f respecto al total de serigrafía

if  data.object.total_metros_serigrafia[fila_actual] <> 0 then
	data.object.porcen_total_4f[fila_actual] = (data.object.metros_4f[fila_actual]  / data.object.total_metros_serigrafia[fila_actual] ) * 100
else
	data.object.porcen_total_4f[fila_actual]  = 0
end if


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Resumen de Producción"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-09-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_resumen_produccion.create
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
end on

on w_con_resumen_produccion.destroy
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
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_produccion
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_produccion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_produccion
integer x = 9
integer y = 8
integer width = 3566
integer height = 88
end type

type pb_1 from upb_salir within w_con_resumen_produccion
integer x = 3419
integer y = 140
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_resumen_produccion
integer x = 3259
integer y = 140
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control_copia(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_resumen_produccion
integer x = 2962
integer y = 140
integer width = 288
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;// f_control(dw_informe)
 f_control_copia(dw_informe)
end event

type gb_1 from groupbox within w_con_resumen_produccion
integer x = 9
integer y = 100
integer width = 827
integer height = 160
integer taborder = 20
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

type gb_6 from groupbox within w_con_resumen_produccion
integer x = 2944
integer y = 92
integer width = 631
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_resumen_produccion
integer x = 9
integer y = 268
integer width = 3584
integer height = 2912
boolean bringtotop = true
string dataobject = "dw_con_resumen_produccion"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_resumen_produccion
integer x = 41
integer y = 156
integer width = 352
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_resumen_produccion
integer x = 443
integer y = 156
integer width = 352
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

