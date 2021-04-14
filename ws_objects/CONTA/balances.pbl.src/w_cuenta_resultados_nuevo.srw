$PBExportHeader$w_cuenta_resultados_nuevo.srw
$PBExportComments$Informe de Objetivos de Facturación
forward
global type w_cuenta_resultados_nuevo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cuenta_resultados_nuevo
end type
type pb_2 from upb_imprimir within w_cuenta_resultados_nuevo
end type
type cb_1 from commandbutton within w_cuenta_resultados_nuevo
end type
type gb_6 from groupbox within w_cuenta_resultados_nuevo
end type
type dw_informe from datawindow within w_cuenta_resultados_nuevo
end type
type ddlb_anyo from dropdownlistbox within w_cuenta_resultados_nuevo
end type
type st_2 from statictext within w_cuenta_resultados_nuevo
end type
type ddlb_mes from dropdownlistbox within w_cuenta_resultados_nuevo
end type
type st_1 from statictext within w_cuenta_resultados_nuevo
end type
end forward

global type w_cuenta_resultados_nuevo from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 5047
integer height = 3348
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_informe dw_informe
ddlb_anyo ddlb_anyo
st_2 st_2
ddlb_mes ddlb_mes
st_1 st_1
end type
global w_cuenta_resultados_nuevo w_cuenta_resultados_nuevo

type variables

end variables

forward prototypes
public subroutine f_ventas_brutas_de_pt (datawindow data, integer fila)
public subroutine f_devoluciones (datawindow data, integer fila)
public subroutine f_rappel_sobre_ventas (integer fila)
public subroutine f_ventas_mercaderias_y_otros (integer fila)
public subroutine f_compras_de_materias_primas (integer fila)
public subroutine f_compras_de_envases_y_embalajes (integer fila)
public subroutine f_variacion_existencias_materias_primas (integer fila)
public subroutine f_variacion_exist_embases_embalajes (integer fila)
public subroutine f_trabajos_realizados_otras_empresas (integer fila)
public subroutine f_consumibles_pantallas (integer fila)
public subroutine f_higiene_y_medio_ambiente (integer fila)
public subroutine f_gas_natural (integer fila)
public subroutine f_electricidad (integer fila)
public subroutine f_gasoleo (integer fila)
public subroutine f_agua (integer fila)
public subroutine f_transportes (integer fila)
public subroutine f_variacion_existencias_pt (integer fila)
public subroutine f_variacion_existencias_st (integer fila)
public subroutine f_sueldos_y_salarios (integer fila)
public subroutine f_seguridad_social (integer fila)
public subroutine f_otros_gastos_de_personal (integer fila)
public subroutine f_amortizaciones (integer fila)
public subroutine f_reparaciones_y_mmto (integer fila)
public subroutine f_publicidad (integer fila)
public subroutine f_gastos_de_viaje (integer fila)
public subroutine f_renting_vehiculos (integer fila)
public subroutine f_servicios_prof_indpdtes (integer fila)
public subroutine f_tributos (integer fila)
public subroutine f_telefono_fax (integer fila)
public subroutine f_primas_de_seguros (integer fila)
public subroutine f_otros_gastos_corrientes (integer fila)
public subroutine f_intereses_prestamos_y_creditos_disp (integer fila)
public subroutine f_intereses_descuento_de_efectos (integer fila)
public subroutine f_comisiones_y_otros_servicios_bancarios (integer fila)
public subroutine f_dtos_ventas_y_otros_gastos_financieros (integer fila)
public subroutine f_ingresos_financieros (integer fila)
public subroutine f_otros_ingresos_y_gastos (integer fila)
public subroutine f_prevision (integer fila, string ejercicio)
public subroutine f_dotacion_provisiones_insolv_y_obsol (integer fila)
public subroutine f_descuentos_sobre_ventas_pp (integer fila)
public subroutine f_renting_v_almacen (integer fila)
end prototypes

public subroutine f_ventas_brutas_de_pt (datawindow data, integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '701%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_1[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_1[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_1[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_1[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_1[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_1[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_1[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_1[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_1[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_1[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_1[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_1[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_1[fila]) then dw_informe.object.ene_1[fila] = 0 
if isnull(dw_informe.object.feb_1[fila]) then dw_informe.object.feb_1[fila] = 0 
if isnull(dw_informe.object.mar_1[fila]) then dw_informe.object.mar_1[fila] = 0 
if isnull(dw_informe.object.abr_1[fila]) then dw_informe.object.abr_1[fila] = 0 
if isnull(dw_informe.object.may_1[fila]) then dw_informe.object.may_1[fila] = 0 
if isnull(dw_informe.object.jun_1[fila]) then dw_informe.object.jun_1[fila] = 0 
if isnull(dw_informe.object.jul_1[fila]) then dw_informe.object.jul_1[fila] = 0 
if isnull(dw_informe.object.ago_1[fila]) then dw_informe.object.ago_1[fila] = 0 
if isnull(dw_informe.object.sep_1[fila]) then dw_informe.object.sep_1[fila] = 0 
if isnull(dw_informe.object.oct_1[fila]) then dw_informe.object.oct_1[fila] = 0 
if isnull(dw_informe.object.nov_1[fila]) then dw_informe.object.nov_1[fila] = 0
if isnull(dw_informe.object.dic_1[fila]) then dw_informe.object.dic_1[fila] = 0 


destroy datos

end subroutine

public subroutine f_devoluciones (datawindow data, integer fila);datastore registros
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '708%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, registros )
		
		
for i = 1 to registros.rowcount()
	mes = registros.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			data.object.ene_2[fila] = registros.object.importe[i]
		CASE 2
			data.object.feb_2[fila] = registros.object.importe[i]
		CASE 3
			data.object.mar_2[fila] = registros.object.importe[i]
		CASE 4
			data.object.abr_2[fila] = registros.object.importe[i]
		CASE 5
			data.object.may_2[fila] = registros.object.importe[i]
		CASE 6
			data.object.jun_2[fila] = registros.object.importe[i]
		CASE 7
			data.object.jul_2[fila] = registros.object.importe[i]
		CASE 8
			data.object.ago_2[fila] = registros.object.importe[i]
		CASE 9
			data.object.sep_2[fila] = registros.object.importe[i]
		CASE 10
			data.object.oct_2[fila] = registros.object.importe[i]
		CASE 11
			 data.object.nov_2[fila] = registros.object.importe[i]
		CASE 12
			 data.object.dic_2[fila] = registros.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(data.object.ene_2[fila]) then data.object.ene_2[fila] = 0 
if isnull(data.object.feb_2[fila]) then data.object.feb_2[fila] = 0 
if isnull(data.object.mar_2[fila]) then data.object.mar_2[fila] = 0 
if isnull(data.object.abr_2[fila]) then data.object.abr_2[fila] = 0 
if isnull(data.object.may_2[fila]) then data.object.may_2[fila] = 0 
if isnull(data.object.jun_2[fila]) then data.object.jun_2[fila] = 0 
if isnull(data.object.jul_2[fila]) then data.object.jul_2[fila] = 0 
if isnull(data.object.ago_2[fila]) then data.object.ago_2[fila] = 0 
if isnull(data.object.sep_2[fila]) then data.object.sep_2[fila] = 0 
if isnull(data.object.oct_2[fila]) then data.object.oct_2[fila] = 0 
if isnull(data.object.nov_2[fila]) then data.object.nov_2[fila] = 0
if isnull(data.object.dic_2[fila]) then data.object.dic_2[fila] = 0 

destroy registros
end subroutine

public subroutine f_rappel_sobre_ventas (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '709%' "+&
		" and mes <= "+ddlb_mes.text+&	
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_3[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_3[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_3[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_3[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_3[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_3[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_3[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_3[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_3[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_3[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_3[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_3[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_3[fila]) then dw_informe.object.ene_3[fila] = 0 
if isnull(dw_informe.object.feb_3[fila]) then dw_informe.object.feb_3[fila] = 0 
if isnull(dw_informe.object.mar_3[fila]) then dw_informe.object.mar_3[fila] = 0 
if isnull(dw_informe.object.abr_3[fila]) then dw_informe.object.abr_3[fila] = 0 
if isnull(dw_informe.object.may_3[fila]) then dw_informe.object.may_3[fila] = 0 
if isnull(dw_informe.object.jun_3[fila]) then dw_informe.object.jun_3[fila] = 0 
if isnull(dw_informe.object.jul_3[fila]) then dw_informe.object.jul_3[fila] = 0 
if isnull(dw_informe.object.ago_3[fila]) then dw_informe.object.ago_3[fila] = 0 
if isnull(dw_informe.object.sep_3[fila]) then dw_informe.object.sep_3[fila] = 0 
if isnull(dw_informe.object.oct_3[fila]) then dw_informe.object.oct_3[fila] = 0 
if isnull(dw_informe.object.nov_3[fila]) then dw_informe.object.nov_3[fila] = 0
if isnull(dw_informe.object.dic_3[fila]) then dw_informe.object.dic_3[fila] = 0 



end subroutine

public subroutine f_ventas_mercaderias_y_otros (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '7000%' or cuenta like '7020%' or cuenta like '7030%' or cuenta like '7040%' or cuenta like '7050%') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_4[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_4[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_4[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_4[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_4[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_4[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_4[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_4[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_4[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_4[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_4[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_4[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_4[fila]) then dw_informe.object.ene_4[fila] = 0 
if isnull(dw_informe.object.feb_4[fila]) then dw_informe.object.feb_4[fila] = 0 
if isnull(dw_informe.object.mar_4[fila]) then dw_informe.object.mar_4[fila] = 0 
if isnull(dw_informe.object.abr_4[fila]) then dw_informe.object.abr_4[fila] = 0 
if isnull(dw_informe.object.may_4[fila]) then dw_informe.object.may_4[fila] = 0 
if isnull(dw_informe.object.jun_4[fila]) then dw_informe.object.jun_4[fila] = 0 
if isnull(dw_informe.object.jul_4[fila]) then dw_informe.object.jul_4[fila] = 0 
if isnull(dw_informe.object.ago_4[fila]) then dw_informe.object.ago_4[fila] = 0 
if isnull(dw_informe.object.sep_4[fila]) then dw_informe.object.sep_4[fila] = 0 
if isnull(dw_informe.object.oct_4[fila]) then dw_informe.object.oct_4[fila] = 0 
if isnull(dw_informe.object.nov_4[fila]) then dw_informe.object.nov_4[fila] = 0
if isnull(dw_informe.object.dic_4[fila]) then dw_informe.object.dic_4[fila] = 0 



destroy datos

end subroutine

public subroutine f_compras_de_materias_primas (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '601%' or cuenta like '6091%' or cuenta like '6090%' ) "+&
		" and mes <= "+ddlb_mes.text+&		
		" and cuenta not like '601004%' "+&
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_5[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_5[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_5[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_5[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_5[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_5[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_5[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_5[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_5[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_5[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_5[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_5[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_5[fila]) then dw_informe.object.ene_5[fila] = 0 
if isnull(dw_informe.object.feb_5[fila]) then dw_informe.object.feb_5[fila] = 0 
if isnull(dw_informe.object.mar_5[fila]) then dw_informe.object.mar_5[fila] = 0 
if isnull(dw_informe.object.abr_5[fila]) then dw_informe.object.abr_5[fila] = 0 
if isnull(dw_informe.object.may_5[fila]) then dw_informe.object.may_5[fila] = 0 
if isnull(dw_informe.object.jun_5[fila]) then dw_informe.object.jun_5[fila] = 0 
if isnull(dw_informe.object.jul_5[fila]) then dw_informe.object.jul_5[fila] = 0 
if isnull(dw_informe.object.ago_5[fila]) then dw_informe.object.ago_5[fila] = 0 
if isnull(dw_informe.object.sep_5[fila]) then dw_informe.object.sep_5[fila] = 0 
if isnull(dw_informe.object.oct_5[fila]) then dw_informe.object.oct_5[fila] = 0 
if isnull(dw_informe.object.nov_5[fila]) then dw_informe.object.nov_5[fila] = 0
if isnull(dw_informe.object.dic_5[fila]) then dw_informe.object.dic_5[fila] = 0 



destroy datos

end subroutine

public subroutine f_compras_de_envases_y_embalajes (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and (cuenta LIKE '601004%' or cuenta LIKE '6093%' ) "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "

		
// Pedro 23/12/2014	" and ( cuenta = '6010040000' or cuenta = '6090000001' )"+&
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_6[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_6[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_6[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_6[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_6[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_6[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_6[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_6[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_6[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_6[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_6[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_6[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_6[fila]) then dw_informe.object.ene_6[fila] = 0 
if isnull(dw_informe.object.feb_6[fila]) then dw_informe.object.feb_6[fila] = 0 
if isnull(dw_informe.object.mar_6[fila]) then dw_informe.object.mar_6[fila] = 0 
if isnull(dw_informe.object.abr_6[fila]) then dw_informe.object.abr_6[fila] = 0 
if isnull(dw_informe.object.may_6[fila]) then dw_informe.object.may_6[fila] = 0 
if isnull(dw_informe.object.jun_6[fila]) then dw_informe.object.jun_6[fila] = 0 
if isnull(dw_informe.object.jul_6[fila]) then dw_informe.object.jul_6[fila] = 0 
if isnull(dw_informe.object.ago_6[fila]) then dw_informe.object.ago_6[fila] = 0 
if isnull(dw_informe.object.sep_6[fila]) then dw_informe.object.sep_6[fila] = 0 
if isnull(dw_informe.object.oct_6[fila]) then dw_informe.object.oct_6[fila] = 0 
if isnull(dw_informe.object.nov_6[fila]) then dw_informe.object.nov_6[fila] = 0
if isnull(dw_informe.object.dic_6[fila]) then dw_informe.object.dic_6[fila] = 0 



destroy datos

end subroutine

public subroutine f_variacion_existencias_materias_primas (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '611%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_7[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_7[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_7[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_7[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_7[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_7[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_7[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_7[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_7[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_7[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_7[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_7[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_7[fila]) then dw_informe.object.ene_7[fila] = 0 
if isnull(dw_informe.object.feb_7[fila]) then dw_informe.object.feb_7[fila] = 0 
if isnull(dw_informe.object.mar_7[fila]) then dw_informe.object.mar_7[fila] = 0 
if isnull(dw_informe.object.abr_7[fila]) then dw_informe.object.abr_7[fila] = 0 
if isnull(dw_informe.object.may_7[fila]) then dw_informe.object.may_7[fila] = 0 
if isnull(dw_informe.object.jun_7[fila]) then dw_informe.object.jun_7[fila] = 0 
if isnull(dw_informe.object.jul_7[fila]) then dw_informe.object.jul_7[fila] = 0 
if isnull(dw_informe.object.ago_7[fila]) then dw_informe.object.ago_7[fila] = 0 
if isnull(dw_informe.object.sep_7[fila]) then dw_informe.object.sep_7[fila] = 0 
if isnull(dw_informe.object.oct_7[fila]) then dw_informe.object.oct_7[fila] = 0 
if isnull(dw_informe.object.nov_7[fila]) then dw_informe.object.nov_7[fila] = 0
if isnull(dw_informe.object.dic_7[fila]) then dw_informe.object.dic_7[fila] = 0 


destroy datos

end subroutine

public subroutine f_variacion_exist_embases_embalajes (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '612%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_8[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_8[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_8[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_8[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_8[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_8[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_8[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_8[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_8[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_8[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_8[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_8[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_8[fila]) then dw_informe.object.ene_8[fila] = 0 
if isnull(dw_informe.object.feb_8[fila]) then dw_informe.object.feb_8[fila] = 0 
if isnull(dw_informe.object.mar_8[fila]) then dw_informe.object.mar_8[fila] = 0 
if isnull(dw_informe.object.abr_8[fila]) then dw_informe.object.abr_8[fila] = 0 
if isnull(dw_informe.object.may_8[fila]) then dw_informe.object.may_8[fila] = 0 
if isnull(dw_informe.object.jun_8[fila]) then dw_informe.object.jun_8[fila] = 0 
if isnull(dw_informe.object.jul_8[fila]) then dw_informe.object.jul_8[fila] = 0 
if isnull(dw_informe.object.ago_8[fila]) then dw_informe.object.ago_8[fila] = 0 
if isnull(dw_informe.object.sep_8[fila]) then dw_informe.object.sep_8[fila] = 0 
if isnull(dw_informe.object.oct_8[fila]) then dw_informe.object.oct_8[fila] = 0 
if isnull(dw_informe.object.nov_8[fila]) then dw_informe.object.nov_8[fila] = 0
if isnull(dw_informe.object.dic_8[fila]) then dw_informe.object.dic_8[fila] = 0 


destroy datos

end subroutine

public subroutine f_trabajos_realizados_otras_empresas (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '607%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_9[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_9[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_9[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_9[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_9[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_9[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_9[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_9[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_9[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_9[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_9[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_9[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_9[fila]) then dw_informe.object.ene_9[fila] = 0 
if isnull(dw_informe.object.feb_9[fila]) then dw_informe.object.feb_9[fila] = 0 
if isnull(dw_informe.object.mar_9[fila]) then dw_informe.object.mar_9[fila] = 0 
if isnull(dw_informe.object.abr_9[fila]) then dw_informe.object.abr_9[fila] = 0 
if isnull(dw_informe.object.may_9[fila]) then dw_informe.object.may_9[fila] = 0 
if isnull(dw_informe.object.jun_9[fila]) then dw_informe.object.jun_9[fila] = 0 
if isnull(dw_informe.object.jul_9[fila]) then dw_informe.object.jul_9[fila] = 0 
if isnull(dw_informe.object.ago_9[fila]) then dw_informe.object.ago_9[fila] = 0 
if isnull(dw_informe.object.sep_9[fila]) then dw_informe.object.sep_9[fila] = 0 
if isnull(dw_informe.object.oct_9[fila]) then dw_informe.object.oct_9[fila] = 0 
if isnull(dw_informe.object.nov_9[fila]) then dw_informe.object.nov_9[fila] = 0
if isnull(dw_informe.object.dic_9[fila]) then dw_informe.object.dic_9[fila] = 0 



destroy datos

end subroutine

public subroutine f_consumibles_pantallas (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta = '6020000004' or cuenta like '6092%') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_10[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_10[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_10[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_10[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_10[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_10[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_10[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_10[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_10[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_10[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_10[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_10[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_10[fila]) then dw_informe.object.ene_10[fila] = 0 
if isnull(dw_informe.object.feb_10[fila]) then dw_informe.object.feb_10[fila] = 0 
if isnull(dw_informe.object.mar_10[fila]) then dw_informe.object.mar_10[fila] = 0 
if isnull(dw_informe.object.abr_10[fila]) then dw_informe.object.abr_10[fila] = 0 
if isnull(dw_informe.object.may_10[fila]) then dw_informe.object.may_10[fila] = 0 
if isnull(dw_informe.object.jun_10[fila]) then dw_informe.object.jun_10[fila] = 0 
if isnull(dw_informe.object.jul_10[fila]) then dw_informe.object.jul_10[fila] = 0 
if isnull(dw_informe.object.ago_10[fila]) then dw_informe.object.ago_10[fila] = 0 
if isnull(dw_informe.object.sep_10[fila]) then dw_informe.object.sep_10[fila] = 0 
if isnull(dw_informe.object.oct_10[fila]) then dw_informe.object.oct_10[fila] = 0 
if isnull(dw_informe.object.nov_10[fila]) then dw_informe.object.nov_10[fila] = 0
if isnull(dw_informe.object.dic_10[fila]) then dw_informe.object.dic_10[fila] = 0 


destroy datos

end subroutine

public subroutine f_higiene_y_medio_ambiente (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta in ('6290000002', '6580000000') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_11[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_11[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_11[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_11[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_11[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_11[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_11[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_11[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_11[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_11[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_11[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_11[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_11[fila]) then dw_informe.object.ene_11[fila] = 0 
if isnull(dw_informe.object.feb_11[fila]) then dw_informe.object.feb_11[fila] = 0 
if isnull(dw_informe.object.mar_11[fila]) then dw_informe.object.mar_11[fila] = 0 
if isnull(dw_informe.object.abr_11[fila]) then dw_informe.object.abr_11[fila] = 0 
if isnull(dw_informe.object.may_11[fila]) then dw_informe.object.may_11[fila] = 0 
if isnull(dw_informe.object.jun_11[fila]) then dw_informe.object.jun_11[fila] = 0 
if isnull(dw_informe.object.jul_11[fila]) then dw_informe.object.jul_11[fila] = 0 
if isnull(dw_informe.object.ago_11[fila]) then dw_informe.object.ago_11[fila] = 0 
if isnull(dw_informe.object.sep_11[fila]) then dw_informe.object.sep_11[fila] = 0 
if isnull(dw_informe.object.oct_11[fila]) then dw_informe.object.oct_11[fila] = 0 
if isnull(dw_informe.object.nov_11[fila]) then dw_informe.object.nov_11[fila] = 0
if isnull(dw_informe.object.dic_11[fila]) then dw_informe.object.dic_11[fila] = 0 


destroy datos

end subroutine

public subroutine f_gas_natural (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta = '6280000003' or cuenta = '6280000005' or cuenta = '6280000007') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_12[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_12[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_12[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_12[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_12[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_12[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_12[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_12[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_12[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_12[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_12[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_12[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_12[fila]) then dw_informe.object.ene_12[fila] = 0 
if isnull(dw_informe.object.feb_12[fila]) then dw_informe.object.feb_12[fila] = 0 
if isnull(dw_informe.object.mar_12[fila]) then dw_informe.object.mar_12[fila] = 0 
if isnull(dw_informe.object.abr_12[fila]) then dw_informe.object.abr_12[fila] = 0 
if isnull(dw_informe.object.may_12[fila]) then dw_informe.object.may_12[fila] = 0 
if isnull(dw_informe.object.jun_12[fila]) then dw_informe.object.jun_12[fila] = 0 
if isnull(dw_informe.object.jul_12[fila]) then dw_informe.object.jul_12[fila] = 0 
if isnull(dw_informe.object.ago_12[fila]) then dw_informe.object.ago_12[fila] = 0 
if isnull(dw_informe.object.sep_12[fila]) then dw_informe.object.sep_12[fila] = 0 
if isnull(dw_informe.object.oct_12[fila]) then dw_informe.object.oct_12[fila] = 0 
if isnull(dw_informe.object.nov_12[fila]) then dw_informe.object.nov_12[fila] = 0
if isnull(dw_informe.object.dic_12[fila]) then dw_informe.object.dic_12[fila] = 0 


destroy datos

end subroutine

public subroutine f_electricidad (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and  cuenta = '6280000006' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_13[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_13[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_13[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_13[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_13[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_13[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_13[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_13[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_13[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_13[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_13[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_13[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_13[fila]) then dw_informe.object.ene_13[fila] = 0 
if isnull(dw_informe.object.feb_13[fila]) then dw_informe.object.feb_13[fila] = 0 
if isnull(dw_informe.object.mar_13[fila]) then dw_informe.object.mar_13[fila] = 0 
if isnull(dw_informe.object.abr_13[fila]) then dw_informe.object.abr_13[fila] = 0 
if isnull(dw_informe.object.may_13[fila]) then dw_informe.object.may_13[fila] = 0 
if isnull(dw_informe.object.jun_13[fila]) then dw_informe.object.jun_13[fila] = 0 
if isnull(dw_informe.object.jul_13[fila]) then dw_informe.object.jul_13[fila] = 0 
if isnull(dw_informe.object.ago_13[fila]) then dw_informe.object.ago_13[fila] = 0 
if isnull(dw_informe.object.sep_13[fila]) then dw_informe.object.sep_13[fila] = 0 
if isnull(dw_informe.object.oct_13[fila]) then dw_informe.object.oct_13[fila] = 0 
if isnull(dw_informe.object.nov_13[fila]) then dw_informe.object.nov_13[fila] = 0
if isnull(dw_informe.object.dic_13[fila]) then dw_informe.object.dic_13[fila] = 0 


destroy datos

end subroutine

public subroutine f_gasoleo (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta = '6280000002' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_14[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_14[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_14[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_14[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_14[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_14[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_14[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_14[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_14[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_14[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_14[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_14[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_14[fila]) then dw_informe.object.ene_14[fila] = 0 
if isnull(dw_informe.object.feb_14[fila]) then dw_informe.object.feb_14[fila] = 0 
if isnull(dw_informe.object.mar_14[fila]) then dw_informe.object.mar_14[fila] = 0 
if isnull(dw_informe.object.abr_14[fila]) then dw_informe.object.abr_14[fila] = 0 
if isnull(dw_informe.object.may_14[fila]) then dw_informe.object.may_14[fila] = 0 
if isnull(dw_informe.object.jun_14[fila]) then dw_informe.object.jun_14[fila] = 0 
if isnull(dw_informe.object.jul_14[fila]) then dw_informe.object.jul_14[fila] = 0 
if isnull(dw_informe.object.ago_14[fila]) then dw_informe.object.ago_14[fila] = 0 
if isnull(dw_informe.object.sep_14[fila]) then dw_informe.object.sep_14[fila] = 0 
if isnull(dw_informe.object.oct_14[fila]) then dw_informe.object.oct_14[fila] = 0 
if isnull(dw_informe.object.nov_14[fila]) then dw_informe.object.nov_14[fila] = 0
if isnull(dw_informe.object.dic_14[fila]) then dw_informe.object.dic_14[fila] = 0 


destroy datos

end subroutine

public subroutine f_agua (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta = '6280000004' "+&
		" and mes <= "+ddlb_mes.text+&
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_15[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_15[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_15[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_15[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_15[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_15[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_15[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_15[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_15[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_15[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_15[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_15[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_15[fila]) then dw_informe.object.ene_15[fila] = 0 
if isnull(dw_informe.object.feb_15[fila]) then dw_informe.object.feb_15[fila] = 0 
if isnull(dw_informe.object.mar_15[fila]) then dw_informe.object.mar_15[fila] = 0 
if isnull(dw_informe.object.abr_15[fila]) then dw_informe.object.abr_15[fila] = 0 
if isnull(dw_informe.object.may_15[fila]) then dw_informe.object.may_15[fila] = 0 
if isnull(dw_informe.object.jun_15[fila]) then dw_informe.object.jun_15[fila] = 0 
if isnull(dw_informe.object.jul_15[fila]) then dw_informe.object.jul_15[fila] = 0 
if isnull(dw_informe.object.ago_15[fila]) then dw_informe.object.ago_15[fila] = 0 
if isnull(dw_informe.object.sep_15[fila]) then dw_informe.object.sep_15[fila] = 0 
if isnull(dw_informe.object.oct_15[fila]) then dw_informe.object.oct_15[fila] = 0 
if isnull(dw_informe.object.nov_15[fila]) then dw_informe.object.nov_15[fila] = 0
if isnull(dw_informe.object.dic_15[fila]) then dw_informe.object.dic_15[fila] = 0 


destroy datos

end subroutine

public subroutine f_transportes (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6240%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_16[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_16[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_16[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_16[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_16[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_16[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_16[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_16[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_16[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_16[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_16[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_16[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_16[fila]) then dw_informe.object.ene_16[fila] = 0 
if isnull(dw_informe.object.feb_16[fila]) then dw_informe.object.feb_16[fila] = 0 
if isnull(dw_informe.object.mar_16[fila]) then dw_informe.object.mar_16[fila] = 0 
if isnull(dw_informe.object.abr_16[fila]) then dw_informe.object.abr_16[fila] = 0 
if isnull(dw_informe.object.may_16[fila]) then dw_informe.object.may_16[fila] = 0 
if isnull(dw_informe.object.jun_16[fila]) then dw_informe.object.jun_16[fila] = 0 
if isnull(dw_informe.object.jul_16[fila]) then dw_informe.object.jul_16[fila] = 0 
if isnull(dw_informe.object.ago_16[fila]) then dw_informe.object.ago_16[fila] = 0 
if isnull(dw_informe.object.sep_16[fila]) then dw_informe.object.sep_16[fila] = 0 
if isnull(dw_informe.object.oct_16[fila]) then dw_informe.object.oct_16[fila] = 0 
if isnull(dw_informe.object.nov_16[fila]) then dw_informe.object.nov_16[fila] = 0
if isnull(dw_informe.object.dic_16[fila]) then dw_informe.object.dic_16[fila] = 0 


destroy datos

end subroutine

public subroutine f_variacion_existencias_pt (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '7120%' or cuenta = '7930000000' ) "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_17[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_17[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_17[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_17[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_17[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_17[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_17[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_17[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_17[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_17[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_17[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_17[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_17[fila]) then dw_informe.object.ene_17[fila] = 0 
if isnull(dw_informe.object.feb_17[fila]) then dw_informe.object.feb_17[fila] = 0 
if isnull(dw_informe.object.mar_17[fila]) then dw_informe.object.mar_17[fila] = 0 
if isnull(dw_informe.object.abr_17[fila]) then dw_informe.object.abr_17[fila] = 0 
if isnull(dw_informe.object.may_17[fila]) then dw_informe.object.may_17[fila] = 0 
if isnull(dw_informe.object.jun_17[fila]) then dw_informe.object.jun_17[fila] = 0 
if isnull(dw_informe.object.jul_17[fila]) then dw_informe.object.jul_17[fila] = 0 
if isnull(dw_informe.object.ago_17[fila]) then dw_informe.object.ago_17[fila] = 0 
if isnull(dw_informe.object.sep_17[fila]) then dw_informe.object.sep_17[fila] = 0 
if isnull(dw_informe.object.oct_17[fila]) then dw_informe.object.oct_17[fila] = 0 
if isnull(dw_informe.object.nov_17[fila]) then dw_informe.object.nov_17[fila] = 0
if isnull(dw_informe.object.dic_17[fila]) then dw_informe.object.dic_17[fila] = 0 


destroy datos

end subroutine

public subroutine f_variacion_existencias_st (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

//////////////////////////////
//	(1) VENTAS BRUTAS DE P.T.
//////////////////////////////

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '7110%'  or cuenta = '7930000001') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_18[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_18[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_18[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_18[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_18[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_18[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_18[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_18[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_18[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_18[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_18[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_18[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_18[fila]) then dw_informe.object.ene_18[fila] = 0 
if isnull(dw_informe.object.feb_18[fila]) then dw_informe.object.feb_18[fila] = 0 
if isnull(dw_informe.object.mar_18[fila]) then dw_informe.object.mar_18[fila] = 0 
if isnull(dw_informe.object.abr_18[fila]) then dw_informe.object.abr_18[fila] = 0 
if isnull(dw_informe.object.may_18[fila]) then dw_informe.object.may_18[fila] = 0 
if isnull(dw_informe.object.jun_18[fila]) then dw_informe.object.jun_18[fila] = 0 
if isnull(dw_informe.object.jul_18[fila]) then dw_informe.object.jul_18[fila] = 0 
if isnull(dw_informe.object.ago_18[fila]) then dw_informe.object.ago_18[fila] = 0 
if isnull(dw_informe.object.sep_18[fila]) then dw_informe.object.sep_18[fila] = 0 
if isnull(dw_informe.object.oct_18[fila]) then dw_informe.object.oct_18[fila] = 0 
if isnull(dw_informe.object.nov_18[fila]) then dw_informe.object.nov_18[fila] = 0
if isnull(dw_informe.object.dic_18[fila]) then dw_informe.object.dic_18[fila] = 0 


destroy datos

end subroutine

public subroutine f_sueldos_y_salarios (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6400%'  or cuenta like '6410%') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_19[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_19[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_19[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_19[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_19[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_19[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_19[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_19[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_19[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_19[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_19[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_19[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_19[fila]) then dw_informe.object.ene_19[fila] = 0 
if isnull(dw_informe.object.feb_19[fila]) then dw_informe.object.feb_19[fila] = 0 
if isnull(dw_informe.object.mar_19[fila]) then dw_informe.object.mar_19[fila] = 0 
if isnull(dw_informe.object.abr_19[fila]) then dw_informe.object.abr_19[fila] = 0 
if isnull(dw_informe.object.may_19[fila]) then dw_informe.object.may_19[fila] = 0 
if isnull(dw_informe.object.jun_19[fila]) then dw_informe.object.jun_19[fila] = 0 
if isnull(dw_informe.object.jul_19[fila]) then dw_informe.object.jul_19[fila] = 0 
if isnull(dw_informe.object.ago_19[fila]) then dw_informe.object.ago_19[fila] = 0 
if isnull(dw_informe.object.sep_19[fila]) then dw_informe.object.sep_19[fila] = 0 
if isnull(dw_informe.object.oct_19[fila]) then dw_informe.object.oct_19[fila] = 0 
if isnull(dw_informe.object.nov_19[fila]) then dw_informe.object.nov_19[fila] = 0
if isnull(dw_informe.object.dic_19[fila]) then dw_informe.object.dic_19[fila] = 0 



destroy datos

end subroutine

public subroutine f_seguridad_social (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6420%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_20[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_20[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_20[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_20[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_20[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_20[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_20[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_20[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_20[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_20[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_20[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_20[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_20[fila]) then dw_informe.object.ene_20[fila] = 0 
if isnull(dw_informe.object.feb_20[fila]) then dw_informe.object.feb_20[fila] = 0 
if isnull(dw_informe.object.mar_20[fila]) then dw_informe.object.mar_20[fila] = 0 
if isnull(dw_informe.object.abr_20[fila]) then dw_informe.object.abr_20[fila] = 0 
if isnull(dw_informe.object.may_20[fila]) then dw_informe.object.may_20[fila] = 0 
if isnull(dw_informe.object.jun_20[fila]) then dw_informe.object.jun_20[fila] = 0 
if isnull(dw_informe.object.jul_20[fila]) then dw_informe.object.jul_20[fila] = 0 
if isnull(dw_informe.object.ago_20[fila]) then dw_informe.object.ago_20[fila] = 0 
if isnull(dw_informe.object.sep_20[fila]) then dw_informe.object.sep_20[fila] = 0 
if isnull(dw_informe.object.oct_20[fila]) then dw_informe.object.oct_20[fila] = 0 
if isnull(dw_informe.object.nov_20[fila]) then dw_informe.object.nov_20[fila] = 0
if isnull(dw_informe.object.dic_20[fila]) then dw_informe.object.dic_20[fila] = 0 



destroy datos

end subroutine

public subroutine f_otros_gastos_de_personal (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6490%' or cuenta = '6021150001') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_21[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_21[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_21[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_21[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_21[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_21[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_21[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_21[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_21[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_21[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_21[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_21[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_21[fila]) then dw_informe.object.ene_21[fila] = 0 
if isnull(dw_informe.object.feb_21[fila]) then dw_informe.object.feb_21[fila] = 0 
if isnull(dw_informe.object.mar_21[fila]) then dw_informe.object.mar_21[fila] = 0 
if isnull(dw_informe.object.abr_21[fila]) then dw_informe.object.abr_21[fila] = 0 
if isnull(dw_informe.object.may_21[fila]) then dw_informe.object.may_21[fila] = 0 
if isnull(dw_informe.object.jun_21[fila]) then dw_informe.object.jun_21[fila] = 0 
if isnull(dw_informe.object.jul_21[fila]) then dw_informe.object.jul_21[fila] = 0 
if isnull(dw_informe.object.ago_21[fila]) then dw_informe.object.ago_21[fila] = 0 
if isnull(dw_informe.object.sep_21[fila]) then dw_informe.object.sep_21[fila] = 0 
if isnull(dw_informe.object.oct_21[fila]) then dw_informe.object.oct_21[fila] = 0 
if isnull(dw_informe.object.nov_21[fila]) then dw_informe.object.nov_21[fila] = 0
if isnull(dw_informe.object.dic_21[fila]) then dw_informe.object.dic_21[fila] = 0 



destroy datos

end subroutine

public subroutine f_amortizaciones (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6800%' or cuenta like '6810%' or cuenta like '6820%' or cuenta like '6811%')"+&
		" and mes <= "+ddlb_mes.text+&
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_22[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_22[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_22[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_22[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_22[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_22[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_22[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_22[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_22[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_22[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_22[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_22[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_22[fila]) then dw_informe.object.ene_22[fila] = 0 
if isnull(dw_informe.object.feb_22[fila]) then dw_informe.object.feb_22[fila] = 0 
if isnull(dw_informe.object.mar_22[fila]) then dw_informe.object.mar_22[fila] = 0 
if isnull(dw_informe.object.abr_22[fila]) then dw_informe.object.abr_22[fila] = 0 
if isnull(dw_informe.object.may_22[fila]) then dw_informe.object.may_22[fila] = 0 
if isnull(dw_informe.object.jun_22[fila]) then dw_informe.object.jun_22[fila] = 0 
if isnull(dw_informe.object.jul_22[fila]) then dw_informe.object.jul_22[fila] = 0 
if isnull(dw_informe.object.ago_22[fila]) then dw_informe.object.ago_22[fila] = 0 
if isnull(dw_informe.object.sep_22[fila]) then dw_informe.object.sep_22[fila] = 0 
if isnull(dw_informe.object.oct_22[fila]) then dw_informe.object.oct_22[fila] = 0 
if isnull(dw_informe.object.nov_22[fila]) then dw_informe.object.nov_22[fila] = 0
if isnull(dw_informe.object.dic_22[fila]) then dw_informe.object.dic_22[fila] = 0 


destroy datos

end subroutine

public subroutine f_reparaciones_y_mmto (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6020%' or cuenta like '6021%' or cuenta like '6022%' or cuenta like '6220%' or cuenta like '6223%'  "+&
		" or cuenta like '6221%' or cuenta like '6222%' or cuenta = '6290000006') "+&
		" and cuenta <> '6020000004' "+&
		" and cuenta <> '6021150001' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_23[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_23[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_23[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_23[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_23[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_23[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_23[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_23[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_23[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_23[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_23[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_23[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_23[fila]) then dw_informe.object.ene_23[fila] = 0 
if isnull(dw_informe.object.feb_23[fila]) then dw_informe.object.feb_23[fila] = 0 
if isnull(dw_informe.object.mar_23[fila]) then dw_informe.object.mar_23[fila] = 0 
if isnull(dw_informe.object.abr_23[fila]) then dw_informe.object.abr_23[fila] = 0 
if isnull(dw_informe.object.may_23[fila]) then dw_informe.object.may_23[fila] = 0 
if isnull(dw_informe.object.jun_23[fila]) then dw_informe.object.jun_23[fila] = 0 
if isnull(dw_informe.object.jul_23[fila]) then dw_informe.object.jul_23[fila] = 0 
if isnull(dw_informe.object.ago_23[fila]) then dw_informe.object.ago_23[fila] = 0 
if isnull(dw_informe.object.sep_23[fila]) then dw_informe.object.sep_23[fila] = 0 
if isnull(dw_informe.object.oct_23[fila]) then dw_informe.object.oct_23[fila] = 0 
if isnull(dw_informe.object.nov_23[fila]) then dw_informe.object.nov_23[fila] = 0
if isnull(dw_informe.object.dic_23[fila]) then dw_informe.object.dic_23[fila] = 0 


destroy datos

end subroutine

public subroutine f_publicidad (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6270%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_24[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_24[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_24[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_24[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_24[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_24[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_24[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_24[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_24[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_24[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_24[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_24[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_24[fila]) then dw_informe.object.ene_24[fila] = 0 
if isnull(dw_informe.object.feb_24[fila]) then dw_informe.object.feb_24[fila] = 0 
if isnull(dw_informe.object.mar_24[fila]) then dw_informe.object.mar_24[fila] = 0 
if isnull(dw_informe.object.abr_24[fila]) then dw_informe.object.abr_24[fila] = 0 
if isnull(dw_informe.object.may_24[fila]) then dw_informe.object.may_24[fila] = 0 
if isnull(dw_informe.object.jun_24[fila]) then dw_informe.object.jun_24[fila] = 0 
if isnull(dw_informe.object.jul_24[fila]) then dw_informe.object.jul_24[fila] = 0 
if isnull(dw_informe.object.ago_24[fila]) then dw_informe.object.ago_24[fila] = 0 
if isnull(dw_informe.object.sep_24[fila]) then dw_informe.object.sep_24[fila] = 0 
if isnull(dw_informe.object.oct_24[fila]) then dw_informe.object.oct_24[fila] = 0 
if isnull(dw_informe.object.nov_24[fila]) then dw_informe.object.nov_24[fila] = 0
if isnull(dw_informe.object.dic_24[fila]) then dw_informe.object.dic_24[fila] = 0 



destroy datos

end subroutine

public subroutine f_gastos_de_viaje (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

// or cuenta like '629001%' Pedro Artuñedo 18/09/20

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6290001%') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_25[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_25[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_25[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_25[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_25[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_25[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_25[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_25[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_25[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_25[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_25[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_25[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_25[fila]) then dw_informe.object.ene_25[fila] = 0 
if isnull(dw_informe.object.feb_25[fila]) then dw_informe.object.feb_25[fila] = 0 
if isnull(dw_informe.object.mar_25[fila]) then dw_informe.object.mar_25[fila] = 0 
if isnull(dw_informe.object.abr_25[fila]) then dw_informe.object.abr_25[fila] = 0 
if isnull(dw_informe.object.may_25[fila]) then dw_informe.object.may_25[fila] = 0 
if isnull(dw_informe.object.jun_25[fila]) then dw_informe.object.jun_25[fila] = 0 
if isnull(dw_informe.object.jul_25[fila]) then dw_informe.object.jul_25[fila] = 0 
if isnull(dw_informe.object.ago_25[fila]) then dw_informe.object.ago_25[fila] = 0 
if isnull(dw_informe.object.sep_25[fila]) then dw_informe.object.sep_25[fila] = 0 
if isnull(dw_informe.object.oct_25[fila]) then dw_informe.object.oct_25[fila] = 0 
if isnull(dw_informe.object.nov_25[fila]) then dw_informe.object.nov_25[fila] = 0
if isnull(dw_informe.object.dic_25[fila]) then dw_informe.object.dic_25[fila] = 0 



destroy datos

end subroutine

public subroutine f_renting_vehiculos (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta = '6210000005'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_27[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_27[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_27[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_27[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_27[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_27[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_27[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_27[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_27[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_27[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_27[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_27[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_27[fila]) then dw_informe.object.ene_27[fila] = 0 
if isnull(dw_informe.object.feb_27[fila]) then dw_informe.object.feb_27[fila] = 0 
if isnull(dw_informe.object.mar_27[fila]) then dw_informe.object.mar_27[fila] = 0 
if isnull(dw_informe.object.abr_27[fila]) then dw_informe.object.abr_27[fila] = 0 
if isnull(dw_informe.object.may_27[fila]) then dw_informe.object.may_27[fila] = 0 
if isnull(dw_informe.object.jun_27[fila]) then dw_informe.object.jun_27[fila] = 0 
if isnull(dw_informe.object.jul_27[fila]) then dw_informe.object.jul_27[fila] = 0 
if isnull(dw_informe.object.ago_27[fila]) then dw_informe.object.ago_27[fila] = 0 
if isnull(dw_informe.object.sep_27[fila]) then dw_informe.object.sep_27[fila] = 0 
if isnull(dw_informe.object.oct_27[fila]) then dw_informe.object.oct_27[fila] = 0 
if isnull(dw_informe.object.nov_27[fila]) then dw_informe.object.nov_27[fila] = 0
if isnull(dw_informe.object.dic_27[fila]) then dw_informe.object.dic_27[fila] = 0 



destroy datos

end subroutine

public subroutine f_servicios_prof_indpdtes (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6230%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_28[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_28[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_28[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_28[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_28[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_28[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_28[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_28[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_28[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_28[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_28[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_28[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_28[fila]) then dw_informe.object.ene_28[fila] = 0 
if isnull(dw_informe.object.feb_28[fila]) then dw_informe.object.feb_28[fila] = 0 
if isnull(dw_informe.object.mar_28[fila]) then dw_informe.object.mar_28[fila] = 0 
if isnull(dw_informe.object.abr_28[fila]) then dw_informe.object.abr_28[fila] = 0 
if isnull(dw_informe.object.may_28[fila]) then dw_informe.object.may_28[fila] = 0 
if isnull(dw_informe.object.jun_28[fila]) then dw_informe.object.jun_28[fila] = 0 
if isnull(dw_informe.object.jul_28[fila]) then dw_informe.object.jul_28[fila] = 0 
if isnull(dw_informe.object.ago_28[fila]) then dw_informe.object.ago_28[fila] = 0 
if isnull(dw_informe.object.sep_28[fila]) then dw_informe.object.sep_28[fila] = 0 
if isnull(dw_informe.object.oct_28[fila]) then dw_informe.object.oct_28[fila] = 0 
if isnull(dw_informe.object.nov_28[fila]) then dw_informe.object.nov_28[fila] = 0
if isnull(dw_informe.object.dic_28[fila]) then dw_informe.object.dic_28[fila] = 0 



destroy datos

end subroutine

public subroutine f_tributos (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6310%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_29[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_29[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_29[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_29[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_29[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_29[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_29[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_29[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_29[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_29[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_29[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_29[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_29[fila]) then dw_informe.object.ene_29[fila] = 0 
if isnull(dw_informe.object.feb_29[fila]) then dw_informe.object.feb_29[fila] = 0 
if isnull(dw_informe.object.mar_29[fila]) then dw_informe.object.mar_29[fila] = 0 
if isnull(dw_informe.object.abr_29[fila]) then dw_informe.object.abr_29[fila] = 0 
if isnull(dw_informe.object.may_29[fila]) then dw_informe.object.may_29[fila] = 0 
if isnull(dw_informe.object.jun_29[fila]) then dw_informe.object.jun_29[fila] = 0 
if isnull(dw_informe.object.jul_29[fila]) then dw_informe.object.jul_29[fila] = 0 
if isnull(dw_informe.object.ago_29[fila]) then dw_informe.object.ago_29[fila] = 0 
if isnull(dw_informe.object.sep_29[fila]) then dw_informe.object.sep_29[fila] = 0 
if isnull(dw_informe.object.oct_29[fila]) then dw_informe.object.oct_29[fila] = 0 
if isnull(dw_informe.object.nov_29[fila]) then dw_informe.object.nov_29[fila] = 0
if isnull(dw_informe.object.dic_29[fila]) then dw_informe.object.dic_29[fila] = 0 



destroy datos

end subroutine

public subroutine f_telefono_fax (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '629003%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_30[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_30[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_30[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_30[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_30[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_30[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_30[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_30[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_30[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_30[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_30[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_30[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_30[fila]) then dw_informe.object.ene_30[fila] = 0 
if isnull(dw_informe.object.feb_30[fila]) then dw_informe.object.feb_30[fila] = 0 
if isnull(dw_informe.object.mar_30[fila]) then dw_informe.object.mar_30[fila] = 0 
if isnull(dw_informe.object.abr_30[fila]) then dw_informe.object.abr_30[fila] = 0 
if isnull(dw_informe.object.may_30[fila]) then dw_informe.object.may_30[fila] = 0 
if isnull(dw_informe.object.jun_30[fila]) then dw_informe.object.jun_30[fila] = 0 
if isnull(dw_informe.object.jul_30[fila]) then dw_informe.object.jul_30[fila] = 0 
if isnull(dw_informe.object.ago_30[fila]) then dw_informe.object.ago_30[fila] = 0 
if isnull(dw_informe.object.sep_30[fila]) then dw_informe.object.sep_30[fila] = 0 
if isnull(dw_informe.object.oct_30[fila]) then dw_informe.object.oct_30[fila] = 0 
if isnull(dw_informe.object.nov_30[fila]) then dw_informe.object.nov_30[fila] = 0
if isnull(dw_informe.object.dic_30[fila]) then dw_informe.object.dic_30[fila] = 0 



destroy datos

end subroutine

public subroutine f_primas_de_seguros (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '6250%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_31[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_31[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_31[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_31[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_31[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_31[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_31[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_31[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_31[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_31[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_31[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_31[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_31[fila]) then dw_informe.object.ene_31[fila] = 0 
if isnull(dw_informe.object.feb_31[fila]) then dw_informe.object.feb_31[fila] = 0 
if isnull(dw_informe.object.mar_31[fila]) then dw_informe.object.mar_31[fila] = 0 
if isnull(dw_informe.object.abr_31[fila]) then dw_informe.object.abr_31[fila] = 0 
if isnull(dw_informe.object.may_31[fila]) then dw_informe.object.may_31[fila] = 0 
if isnull(dw_informe.object.jun_31[fila]) then dw_informe.object.jun_31[fila] = 0 
if isnull(dw_informe.object.jul_31[fila]) then dw_informe.object.jul_31[fila] = 0 
if isnull(dw_informe.object.ago_31[fila]) then dw_informe.object.ago_31[fila] = 0 
if isnull(dw_informe.object.sep_31[fila]) then dw_informe.object.sep_31[fila] = 0 
if isnull(dw_informe.object.oct_31[fila]) then dw_informe.object.oct_31[fila] = 0 
if isnull(dw_informe.object.nov_31[fila]) then dw_informe.object.nov_31[fila] = 0
if isnull(dw_informe.object.dic_31[fila]) then dw_informe.object.dic_31[fila] = 0 



destroy datos

end subroutine

public subroutine f_otros_gastos_corrientes (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '6290002%' or cuenta like '629005%' or cuenta like '621%' or cuenta like '659%' "+&
		" or  cuenta = '6290000001' "+&
		" or  cuenta = '6290000005' "+&
		" or  cuenta = '6290000007' "+&
		" or cuenta like '629001%' "+&
		" or  cuenta = '6290000000' ) "+&
		" and  cuenta <> '6210000005' "+&
		" and cuenta <> '6210000007' "+&
		" and cuenta <> '6210000008' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
	" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_32[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_32[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_32[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_32[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_32[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_32[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_32[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_32[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_32[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_32[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_32[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_32[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_32[fila]) then dw_informe.object.ene_32[fila] = 0 
if isnull(dw_informe.object.feb_32[fila]) then dw_informe.object.feb_32[fila] = 0 
if isnull(dw_informe.object.mar_32[fila]) then dw_informe.object.mar_32[fila] = 0 
if isnull(dw_informe.object.abr_32[fila]) then dw_informe.object.abr_32[fila] = 0 
if isnull(dw_informe.object.may_32[fila]) then dw_informe.object.may_32[fila] = 0 
if isnull(dw_informe.object.jun_32[fila]) then dw_informe.object.jun_32[fila] = 0 
if isnull(dw_informe.object.jul_32[fila]) then dw_informe.object.jul_32[fila] = 0 
if isnull(dw_informe.object.ago_32[fila]) then dw_informe.object.ago_32[fila] = 0 
if isnull(dw_informe.object.sep_32[fila]) then dw_informe.object.sep_32[fila] = 0 
if isnull(dw_informe.object.oct_32[fila]) then dw_informe.object.oct_32[fila] = 0 
if isnull(dw_informe.object.nov_32[fila]) then dw_informe.object.nov_32[fila] = 0
if isnull(dw_informe.object.dic_32[fila]) then dw_informe.object.dic_32[fila] = 0 



destroy datos

end subroutine

public subroutine f_intereses_prestamos_y_creditos_disp (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '662%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_33[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_33[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_33[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_33[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_33[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_33[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_33[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_33[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_33[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_33[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_33[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_33[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_33[fila]) then dw_informe.object.ene_33[fila] = 0 
if isnull(dw_informe.object.feb_33[fila]) then dw_informe.object.feb_33[fila] = 0 
if isnull(dw_informe.object.mar_33[fila]) then dw_informe.object.mar_33[fila] = 0 
if isnull(dw_informe.object.abr_33[fila]) then dw_informe.object.abr_33[fila] = 0 
if isnull(dw_informe.object.may_33[fila]) then dw_informe.object.may_33[fila] = 0 
if isnull(dw_informe.object.jun_33[fila]) then dw_informe.object.jun_33[fila] = 0 
if isnull(dw_informe.object.jul_33[fila]) then dw_informe.object.jul_33[fila] = 0 
if isnull(dw_informe.object.ago_33[fila]) then dw_informe.object.ago_33[fila] = 0 
if isnull(dw_informe.object.sep_33[fila]) then dw_informe.object.sep_33[fila] = 0 
if isnull(dw_informe.object.oct_33[fila]) then dw_informe.object.oct_33[fila] = 0 
if isnull(dw_informe.object.nov_33[fila]) then dw_informe.object.nov_33[fila] = 0
if isnull(dw_informe.object.dic_33[fila]) then dw_informe.object.dic_33[fila] = 0 



destroy datos

end subroutine

public subroutine f_intereses_descuento_de_efectos (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '665%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_34[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_34[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_34[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_34[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_34[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_34[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_34[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_34[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_34[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_34[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_34[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_34[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_34[fila]) then dw_informe.object.ene_34[fila] = 0 
if isnull(dw_informe.object.feb_34[fila]) then dw_informe.object.feb_34[fila] = 0 
if isnull(dw_informe.object.mar_34[fila]) then dw_informe.object.mar_34[fila] = 0 
if isnull(dw_informe.object.abr_34[fila]) then dw_informe.object.abr_34[fila] = 0 
if isnull(dw_informe.object.may_34[fila]) then dw_informe.object.may_34[fila] = 0 
if isnull(dw_informe.object.jun_34[fila]) then dw_informe.object.jun_34[fila] = 0 
if isnull(dw_informe.object.jul_34[fila]) then dw_informe.object.jul_34[fila] = 0 
if isnull(dw_informe.object.ago_34[fila]) then dw_informe.object.ago_34[fila] = 0 
if isnull(dw_informe.object.sep_34[fila]) then dw_informe.object.sep_34[fila] = 0 
if isnull(dw_informe.object.oct_34[fila]) then dw_informe.object.oct_34[fila] = 0 
if isnull(dw_informe.object.nov_34[fila]) then dw_informe.object.nov_34[fila] = 0
if isnull(dw_informe.object.dic_34[fila]) then dw_informe.object.dic_34[fila] = 0 



destroy datos

end subroutine

public subroutine f_comisiones_y_otros_servicios_bancarios (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '626%' or cuenta like '661%' or cuenta like '663%' or cuenta like '664%' "+& 
		" or cuenta like '666%' or cuenta like '667%' or cuenta like '668%' or cuenta like '669%') "+&		
		" and mes <= "+ddlb_mes.text+&
		" and origen <> '102' "+&
		" group by mes "
	
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_35[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_35[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_35[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_35[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_35[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_35[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_35[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_35[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_35[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_35[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_35[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_35[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_35[fila]) then dw_informe.object.ene_35[fila] = 0 
if isnull(dw_informe.object.feb_35[fila]) then dw_informe.object.feb_35[fila] = 0 
if isnull(dw_informe.object.mar_35[fila]) then dw_informe.object.mar_35[fila] = 0 
if isnull(dw_informe.object.abr_35[fila]) then dw_informe.object.abr_35[fila] = 0 
if isnull(dw_informe.object.may_35[fila]) then dw_informe.object.may_35[fila] = 0 
if isnull(dw_informe.object.jun_35[fila]) then dw_informe.object.jun_35[fila] = 0 
if isnull(dw_informe.object.jul_35[fila]) then dw_informe.object.jul_35[fila] = 0 
if isnull(dw_informe.object.ago_35[fila]) then dw_informe.object.ago_35[fila] = 0 
if isnull(dw_informe.object.sep_35[fila]) then dw_informe.object.sep_35[fila] = 0 
if isnull(dw_informe.object.oct_35[fila]) then dw_informe.object.oct_35[fila] = 0 
if isnull(dw_informe.object.nov_35[fila]) then dw_informe.object.nov_35[fila] = 0
if isnull(dw_informe.object.dic_35[fila]) then dw_informe.object.dic_35[fila] = 0 



destroy datos

end subroutine

public subroutine f_dtos_ventas_y_otros_gastos_financieros (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '661%' or cuenta like '663%' or cuenta like '664%' or cuenta like '666%' "+&
				" or cuenta like '667%' or cuenta like '668%' or cuenta like '669%' or cuenta like '706%'   ) "+&
		" and mes <= "+ddlb_mes.text+&				
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_36[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_36[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_36[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_36[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_36[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_36[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_36[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_36[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_36[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_36[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_36[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_36[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_36[fila]) then dw_informe.object.ene_36[fila] = 0 
if isnull(dw_informe.object.feb_36[fila]) then dw_informe.object.feb_36[fila] = 0 
if isnull(dw_informe.object.mar_36[fila]) then dw_informe.object.mar_36[fila] = 0 
if isnull(dw_informe.object.abr_36[fila]) then dw_informe.object.abr_36[fila] = 0 
if isnull(dw_informe.object.may_36[fila]) then dw_informe.object.may_36[fila] = 0 
if isnull(dw_informe.object.jun_36[fila]) then dw_informe.object.jun_36[fila] = 0 
if isnull(dw_informe.object.jul_36[fila]) then dw_informe.object.jul_36[fila] = 0 
if isnull(dw_informe.object.ago_36[fila]) then dw_informe.object.ago_36[fila] = 0 
if isnull(dw_informe.object.sep_36[fila]) then dw_informe.object.sep_36[fila] = 0 
if isnull(dw_informe.object.oct_36[fila]) then dw_informe.object.oct_36[fila] = 0 
if isnull(dw_informe.object.nov_36[fila]) then dw_informe.object.nov_36[fila] = 0
if isnull(dw_informe.object.dic_36[fila]) then dw_informe.object.dic_36[fila] = 0 



destroy datos

end subroutine

public subroutine f_ingresos_financieros (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '76%'  "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_37[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_37[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_37[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_37[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_37[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_37[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_37[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_37[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_37[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_37[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_37[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_37[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_37[fila]) then dw_informe.object.ene_37[fila] = 0 
if isnull(dw_informe.object.feb_37[fila]) then dw_informe.object.feb_37[fila] = 0 
if isnull(dw_informe.object.mar_37[fila]) then dw_informe.object.mar_37[fila] = 0 
if isnull(dw_informe.object.abr_37[fila]) then dw_informe.object.abr_37[fila] = 0 
if isnull(dw_informe.object.may_37[fila]) then dw_informe.object.may_37[fila] = 0 
if isnull(dw_informe.object.jun_37[fila]) then dw_informe.object.jun_37[fila] = 0 
if isnull(dw_informe.object.jul_37[fila]) then dw_informe.object.jul_37[fila] = 0 
if isnull(dw_informe.object.ago_37[fila]) then dw_informe.object.ago_37[fila] = 0 
if isnull(dw_informe.object.sep_37[fila]) then dw_informe.object.sep_37[fila] = 0 
if isnull(dw_informe.object.oct_37[fila]) then dw_informe.object.oct_37[fila] = 0 
if isnull(dw_informe.object.nov_37[fila]) then dw_informe.object.nov_37[fila] = 0
if isnull(dw_informe.object.dic_37[fila]) then dw_informe.object.dic_37[fila] = 0 



destroy datos

end subroutine

public subroutine f_otros_ingresos_y_gastos (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta like '67%' or cuenta like '74%' or cuenta like '77%' or cuenta like '795%' ) "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )
		
for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_38[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_38[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_38[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_38[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_38[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_38[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_38[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_38[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_38[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_38[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_38[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_38[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_38[fila]) then dw_informe.object.ene_38[fila] = 0 
if isnull(dw_informe.object.feb_38[fila]) then dw_informe.object.feb_38[fila] = 0 
if isnull(dw_informe.object.mar_38[fila]) then dw_informe.object.mar_38[fila] = 0 
if isnull(dw_informe.object.abr_38[fila]) then dw_informe.object.abr_38[fila] = 0 
if isnull(dw_informe.object.may_38[fila]) then dw_informe.object.may_38[fila] = 0 
if isnull(dw_informe.object.jun_38[fila]) then dw_informe.object.jun_38[fila] = 0 
if isnull(dw_informe.object.jul_38[fila]) then dw_informe.object.jul_38[fila] = 0 
if isnull(dw_informe.object.ago_38[fila]) then dw_informe.object.ago_38[fila] = 0 
if isnull(dw_informe.object.sep_38[fila]) then dw_informe.object.sep_38[fila] = 0 
if isnull(dw_informe.object.oct_38[fila]) then dw_informe.object.oct_38[fila] = 0 
if isnull(dw_informe.object.nov_38[fila]) then dw_informe.object.nov_38[fila] = 0
if isnull(dw_informe.object.dic_38[fila]) then dw_informe.object.dic_38[fila] = 0 


end subroutine

public subroutine f_prevision (integer fila, string ejercicio);decimal c1, c2, c2_1, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29
decimal c30, c31, c32, c32_1, c33, c34, c35, c36, c37, c38


select c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, 
		c30, c31, c32, c32_1, c33, c34, c35, c36, c37, c38, c2_1
into :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8, :c9, :c10, :c11, :c12, :c13, :c14, :c15, :c16, :c17, :c18, :c19, :c20, :c21, :c22, :c23, 
		:c24, :c25, :c26, :c27, :c28, :c29, :c30, :c31, :c32, :c32_1, :c33, :c34, :c35, :c36, :c37, :c38
from contaprevresultado
where empresa = :codigo_empresa
and ejercicio = :ejercicio;


dw_informe.object.prev_1[fila] = c1
dw_informe.object.prev_2[fila] = c2
dw_informe.object.prev_2_1[fila] = c2_1
dw_informe.object.prev_3[fila] = c3
dw_informe.object.prev_4[fila] = c4
dw_informe.object.prev_5[fila] = c5
dw_informe.object.prev_6[fila] = c6
dw_informe.object.prev_7[fila] = c7
dw_informe.object.prev_8[fila] = c8
dw_informe.object.prev_9[fila] = c9
dw_informe.object.prev_10[fila] = c10
dw_informe.object.prev_11[fila] = c11
dw_informe.object.prev_12[fila] = c12
dw_informe.object.prev_13[fila] = c13
dw_informe.object.prev_14[fila] = c14
dw_informe.object.prev_15[fila] = c15
dw_informe.object.prev_16[fila] = c16
dw_informe.object.prev_17[fila] = c17
dw_informe.object.prev_18[fila] = c18
dw_informe.object.prev_19[fila] = c19
dw_informe.object.prev_20[fila] = c20
dw_informe.object.prev_21[fila] = c21
dw_informe.object.prev_22[fila] = c22
dw_informe.object.prev_23[fila] = c23
dw_informe.object.prev_24[fila] = c24
dw_informe.object.prev_25[fila] = c25
dw_informe.object.prev_26[fila] = c26
dw_informe.object.prev_27[fila] = c27
dw_informe.object.prev_28[fila] = c28
dw_informe.object.prev_29[fila] = c29
dw_informe.object.prev_30[fila] = c30
dw_informe.object.prev_31[fila] = c31
dw_informe.object.prev_32[fila] = c32
dw_informe.object.prev_32_1[fila] = c32_1
dw_informe.object.prev_33[fila] = c33
dw_informe.object.prev_34[fila] = c34
dw_informe.object.prev_35[fila] = c35
dw_informe.object.prev_36[fila] = c36
dw_informe.object.prev_37[fila] = c37
dw_informe.object.prev_38[fila] = c38

end subroutine

public subroutine f_dotacion_provisiones_insolv_y_obsol (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

////////////////////////////////////////////////////////////
//	(32_1) DOTACION PROVISIONES INSOLVENCIAS Y OBSOLETOS
////////////////////////////////////////////////////////////

sel = " select mes, sum ( debe - haber ) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and  ( cuenta like '69%'  or cuenta like '794%' or cuenta like '650%') "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_32_1[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_32_1[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_32_1[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_32_1[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_32_1[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_32_1[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_32_1[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_32_1[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_32_1[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_32_1[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_32_1[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_32_1[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_32_1[fila]) then dw_informe.object.ene_32_1[fila] = 0 
if isnull(dw_informe.object.feb_32_1[fila]) then dw_informe.object.feb_32_1[fila] = 0 
if isnull(dw_informe.object.mar_32_1[fila]) then dw_informe.object.mar_32_1[fila] = 0 
if isnull(dw_informe.object.abr_32_1[fila]) then dw_informe.object.abr_32_1[fila] = 0 
if isnull(dw_informe.object.may_32_1[fila]) then dw_informe.object.may_32_1[fila] = 0 
if isnull(dw_informe.object.jun_32_1[fila]) then dw_informe.object.jun_32_1[fila] = 0 
if isnull(dw_informe.object.jul_32_1[fila]) then dw_informe.object.jul_32_1[fila] = 0 
if isnull(dw_informe.object.ago_32_1[fila]) then dw_informe.object.ago_32_1[fila] = 0 
if isnull(dw_informe.object.sep_32_1[fila]) then dw_informe.object.sep_32_1[fila] = 0 
if isnull(dw_informe.object.oct_32_1[fila]) then dw_informe.object.oct_32_1[fila] = 0 
if isnull(dw_informe.object.nov_32_1[fila]) then dw_informe.object.nov_32_1[fila] = 0
if isnull(dw_informe.object.dic_32_1[fila]) then dw_informe.object.dic_32_1[fila] = 0 

destroy datos

end subroutine

public subroutine f_descuentos_sobre_ventas_pp (integer fila);datastore regs
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic


sel = " select mes, sum (haber - debe) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and cuenta like '706%' "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
		
f_cargar_cursor_nuevo ( sel, regs )
		
for i = 1 to regs.rowcount()
	mes = regs.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_2_1[fila] = regs.object.importe[i]
		CASE 2
			dw_informe.object.feb_2_1[fila] = regs.object.importe[i]
		CASE 3
			dw_informe.object.mar_2_1[fila] = regs.object.importe[i]
		CASE 4
			dw_informe.object.abr_2_1[fila] = regs.object.importe[i]
		CASE 5
			dw_informe.object.may_2_1[fila] = regs.object.importe[i]
		CASE 6
			dw_informe.object.jun_2_1[fila] = regs.object.importe[i]
		CASE 7
			dw_informe.object.jul_2_1[fila] = regs.object.importe[i]
		CASE 8
			dw_informe.object.ago_2_1[fila] = regs.object.importe[i]
		CASE 9
			dw_informe.object.sep_2_1[fila] = regs.object.importe[i]
		CASE 10
			dw_informe.object.oct_2_1[fila] = regs.object.importe[i]
		CASE 11
			 dw_informe.object.nov_2_1[fila] = regs.object.importe[i]
		CASE 12
			 dw_informe.object.dic_2_1[fila] = regs.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_2_1[fila]) then dw_informe.object.ene_2_1[fila] = 0 
if isnull(dw_informe.object.feb_2_1[fila]) then dw_informe.object.feb_2_1[fila] = 0 
if isnull(dw_informe.object.mar_2_1[fila]) then dw_informe.object.mar_2_1[fila] = 0 
if isnull(dw_informe.object.abr_2_1[fila]) then dw_informe.object.abr_2_1[fila] = 0 
if isnull(dw_informe.object.may_2_1[fila]) then dw_informe.object.may_2_1[fila] = 0 
if isnull(dw_informe.object.jun_2_1[fila]) then dw_informe.object.jun_2_1[fila] = 0 
if isnull(dw_informe.object.jul_2_1[fila]) then dw_informe.object.jul_2_1[fila] = 0 
if isnull(dw_informe.object.ago_2_1[fila]) then dw_informe.object.ago_2_1[fila] = 0 
if isnull(dw_informe.object.sep_2_1[fila]) then dw_informe.object.sep_2_1[fila] = 0 
if isnull(dw_informe.object.oct_2_1[fila]) then dw_informe.object.oct_2_1[fila] = 0 
if isnull(dw_informe.object.nov_2_1[fila]) then dw_informe.object.nov_2_1[fila] = 0
if isnull(dw_informe.object.dic_2_1[fila]) then dw_informe.object.dic_2_1[fila] = 0 

destroy regs
end subroutine

public subroutine f_renting_v_almacen (integer fila);datastore datos
integer mes, i
string sel
decimal ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

sel = " select mes, sum (debe - haber) as importe "+&
		" from contaapun "+&
		" where empresa = '"+codigo_empresa+"' "+&
		" and ejercicio = "+ddlb_anyo.text+&
		" and ( cuenta = '6210000007'  "+&
		" or cuenta = '6210000008' ) "+&
		" and mes <= "+ddlb_mes.text+&		
		" and origen <> '102' "+&
		" group by mes "
		
f_cargar_cursor_nuevo ( sel, datos )


for i = 1 to datos.rowcount()
	mes = datos.object.mes[i]
	CHOOSE CASE mes
		CASE 1
			dw_informe.object.ene_26[fila] = datos.object.importe[i]
		CASE 2
			dw_informe.object.feb_26[fila] = datos.object.importe[i]
		CASE 3
			dw_informe.object.mar_26[fila] = datos.object.importe[i]
		CASE 4
			dw_informe.object.abr_26[fila] = datos.object.importe[i]
		CASE 5
			dw_informe.object.may_26[fila] = datos.object.importe[i]
		CASE 6
			dw_informe.object.jun_26[fila] = datos.object.importe[i]
		CASE 7
			dw_informe.object.jul_26[fila] = datos.object.importe[i]
		CASE 8
			dw_informe.object.ago_26[fila] = datos.object.importe[i]
		CASE 9
			dw_informe.object.sep_26[fila] = datos.object.importe[i]
		CASE 10
			dw_informe.object.oct_26[fila] = datos.object.importe[i]
		CASE 11
			 dw_informe.object.nov_26[fila] = datos.object.importe[i]
		CASE 12
			 dw_informe.object.dic_26[fila] = datos.object.importe[i]
		CASE ELSE
			messagebox("Error", "Hay un apunte sin ningún valor en el campo mes")
	END CHOOSE
next

if isnull(dw_informe.object.ene_26[fila]) then dw_informe.object.ene_26[fila] = 0 
if isnull(dw_informe.object.feb_26[fila]) then dw_informe.object.feb_26[fila] = 0 
if isnull(dw_informe.object.mar_26[fila]) then dw_informe.object.mar_26[fila] = 0 
if isnull(dw_informe.object.abr_26[fila]) then dw_informe.object.abr_26[fila] = 0 
if isnull(dw_informe.object.may_26[fila]) then dw_informe.object.may_26[fila] = 0 
if isnull(dw_informe.object.jun_26[fila]) then dw_informe.object.jun_26[fila] = 0 
if isnull(dw_informe.object.jul_26[fila]) then dw_informe.object.jul_26[fila] = 0 
if isnull(dw_informe.object.ago_26[fila]) then dw_informe.object.ago_26[fila] = 0 
if isnull(dw_informe.object.sep_26[fila]) then dw_informe.object.sep_26[fila] = 0 
if isnull(dw_informe.object.oct_26[fila]) then dw_informe.object.oct_26[fila] = 0 
if isnull(dw_informe.object.nov_26[fila]) then dw_informe.object.nov_26[fila] = 0
if isnull(dw_informe.object.dic_26[fila]) then dw_informe.object.dic_26[fila] = 0 



destroy datos

end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe de Objetivos de Facturación"
This.title=istr_parametros.s_titulo_ventana


ddlb_anyo.text = string(year(today()))
ddlb_mes.text = string(month(today()) - 1 )
end event

on w_cuenta_resultados_nuevo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.ddlb_anyo=create ddlb_anyo
this.st_2=create st_2
this.ddlb_mes=create ddlb_mes
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_informe
this.Control[iCurrent+6]=this.ddlb_anyo
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.ddlb_mes
this.Control[iCurrent+9]=this.st_1
end on

on w_cuenta_resultados_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.ddlb_anyo)
destroy(this.st_2)
destroy(this.ddlb_mes)
destroy(this.st_1)
end on

event ue_f5;//f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cuenta_resultados_nuevo
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cuenta_resultados_nuevo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cuenta_resultados_nuevo
integer y = 8
integer width = 4786
integer height = 92
end type

type pb_1 from upb_salir within w_cuenta_resultados_nuevo
integer x = 4832
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_cuenta_resultados_nuevo
integer x = 4800
integer y = 148
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_cuenta_resultados_nuevo
integer x = 4503
integer y = 148
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

event clicked;integer fila

dw_informe.reset()
fila = dw_informe.insertrow(0)

dw_informe.object.titulo2.text = ""
dw_informe.object.titulo2.text = "CUENTA DE RESULTADOS "+ddlb_anyo.text

////////////////// 1 //////////////////
f_ventas_brutas_de_pt (dw_informe, fila)
////////////////// 2 //////////////////
f_devoluciones(dw_informe, fila)
////////////////// 2_1 //////////////////
f_descuentos_sobre_ventas_pp(fila)
////////////////// 3 //////////////////
f_rappel_sobre_ventas( fila)
////////////////// 4 //////////////////
f_ventas_mercaderias_y_otros(fila)
////////////////// 5 //////////////////
f_compras_de_materias_primas(fila)
////////////////// 6 //////////////////
f_compras_de_envases_y_embalajes(fila)
////////////////// 7 //////////////////
f_variacion_existencias_materias_primas(fila)
////////////////// 8 //////////////////
f_variacion_exist_embases_embalajes(fila)
////////////////// 9 //////////////////
f_trabajos_realizados_otras_empresas(fila)
////////////////// 10 //////////////////
f_consumibles_pantallas(fila)
////////////////// 11 //////////////////
f_higiene_y_medio_ambiente(fila)
////////////////// 12 //////////////////
f_gas_natural(fila)
////////////////// 13 //////////////////
f_electricidad(fila)
////////////////// 14 //////////////////
f_gasoleo(fila)
////////////////// 15 //////////////////
f_agua(fila)
////////////////// 16 //////////////////
f_transportes(fila)
////////////////// 17 //////////////////
f_variacion_existencias_pt(fila)
////////////////// 18 //////////////////
f_variacion_existencias_st(fila)
////////////////// 19 //////////////////
f_sueldos_y_salarios(fila)
////////////////// 20 //////////////////
f_seguridad_social(fila)
////////////////// 21 //////////////////
f_otros_gastos_de_personal(fila)
////////////////// 22 //////////////////
f_amortizaciones(fila)
////////////////// 23 //////////////////
f_reparaciones_y_mmto(fila)
////////////////// 24 //////////////////
f_publicidad(fila)
////////////////// 25 //////////////////
f_gastos_de_viaje(fila)
////////////////// 26 //////////////////
f_renting_v_almacen(fila)
////////////////// 27 //////////////////
f_renting_vehiculos(fila)
////////////////// 28 //////////////////
f_servicios_prof_indpdtes(fila)
////////////////// 29 //////////////////
f_tributos(fila)
////////////////// 30 //////////////////
f_telefono_fax(fila)
////////////////// 31 //////////////////
f_primas_de_seguros(fila)
////////////////// 32 //////////////////
f_otros_gastos_corrientes(fila)
////////////////// 32_1 //////////////////
f_dotacion_provisiones_insolv_y_obsol(fila)
////////////////// 33 //////////////////
f_intereses_prestamos_y_creditos_disp(fila)
////////////////// 34 //////////////////
f_intereses_descuento_de_efectos(fila)
////////////////// 35 //////////////////
f_comisiones_y_otros_servicios_bancarios(fila)
////////////////// 36 //////////////////
f_dtos_ventas_y_otros_gastos_financieros(fila)
////////////////// 37 //////////////////
f_ingresos_financieros(fila)
////////////////// 38 //////////////////
f_otros_ingresos_y_gastos(fila)

/////////////// PREVISION //////////////
f_prevision (fila, ddlb_anyo.text)

dw_informe.sort()
dw_informe.groupcalc()



end event

type gb_6 from groupbox within w_cuenta_resultados_nuevo
integer x = 4485
integer y = 108
integer width = 462
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_cuenta_resultados_nuevo
integer x = 18
integer y = 284
integer width = 4965
integer height = 2844
boolean bringtotop = true
string dataobject = "dw_cuenta_resultados_nuevo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type ddlb_anyo from dropdownlistbox within w_cuenta_resultados_nuevo
integer x = 265
integer y = 148
integer width = 265
integer height = 476
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_cuenta_resultados_nuevo
integer x = 91
integer y = 168
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_mes from dropdownlistbox within w_cuenta_resultados_nuevo
integer x = 759
integer y = 148
integer width = 265
integer height = 476
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1","2","3","4","5","6","7","8","9","10","11","12","",""}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_cuenta_resultados_nuevo
integer x = 585
integer y = 168
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Mes:"
alignment alignment = center!
boolean focusrectangle = false
end type

