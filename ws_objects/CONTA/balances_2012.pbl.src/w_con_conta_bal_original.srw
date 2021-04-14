$PBExportHeader$w_con_conta_bal_original.srw
forward
global type w_con_conta_bal_original from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_conta_bal_original
end type
type pb_2 from upb_imprimir within w_con_conta_bal_original
end type
type dw_detalle from datawindow within w_con_conta_bal_original
end type
type em_fechadesde from u_em_campo within w_con_conta_bal_original
end type
type em_fechahasta from u_em_campo within w_con_conta_bal_original
end type
type gb_1 from groupbox within w_con_conta_bal_original
end type
type cb_calcular from commandbutton within w_con_conta_bal_original
end type
type uo_balance from u_em_campo_2 within w_con_conta_bal_original
end type
type gb_2 from groupbox within w_con_conta_bal_original
end type
type gb_3 from groupbox within w_con_conta_bal_original
end type
type uo_manejo from u_manejo_datawindow within w_con_conta_bal_original
end type
type pb_excel from picturebutton within w_con_conta_bal_original
end type
type cbx_con_cuentas from checkbox within w_con_conta_bal_original
end type
type cbx_version_para_chequeo from checkbox within w_con_conta_bal_original
end type
type cbx_cuentas_importe_cero from checkbox within w_con_conta_bal_original
end type
type cbx_un_ejercicio from checkbox within w_con_conta_bal_original
end type
type gb_4 from groupbox within w_con_conta_bal_original
end type
type istr_saldos_grupo from structure within w_con_conta_bal_original
end type
end forward

type istr_saldos_grupo from structure

	decimal		valor_periodo

	decimal		presupuesto_periodo

	decimal		valor_periodo_ant

end type

global type w_con_conta_bal_original from w_int_con_empresa
integer width = 4649
integer height = 2604
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_1 gb_1
cb_calcular cb_calcular
uo_balance uo_balance
gb_2 gb_2
gb_3 gb_3
uo_manejo uo_manejo
pb_excel pb_excel
cbx_con_cuentas cbx_con_cuentas
cbx_version_para_chequeo cbx_version_para_chequeo
cbx_cuentas_importe_cero cbx_cuentas_importe_cero
cbx_un_ejercicio cbx_un_ejercicio
gb_4 gb_4
end type
global w_con_conta_bal_original w_con_conta_bal_original

type variables
string filtro,is_balance
string is_moneda,is_mascara_moneda,is_centros_a_calcular,is_calcular_porcentaje,is_calcular_porcentaje_sobre_grupo
boolean ib_ajustar_coste

datastore ids_Grupos,ids_grupos2,ids_cuentas,ids_gpos_totaliza,ids_presupuestos,ids_cuentas_ant

end variables

forward prototypes
public function long f_cargar_arbol ()
public subroutine f_calcular_totales ()
public function long f_rgb_grupo (integer arg_nivel)
public subroutine f_calcular_totales_old ()
public function istr_saldos_grupo f_calcular_importes_grupo (string arg_grupo)
public function istr_saldos_grupo f_importes_grupo (string arg_grupo)
public subroutine f_calcular_porcentajes ()
public subroutine f_calcular_variacion_sobre_presupuesto ()
public function istr_saldos_grupo f_saldos_grupo (string arg_grupo, integer arg_nivel, long arg_orden, string arg_saldos_en_valor_absoluto, string arg_visible, integer arg_nivel_indentacion)
public function long f_cargar_rama (string arg_grupo_nivel_superior, long arg_nivel_superior, string arg_visible, integer arg_nivel_indentacion)
public subroutine f_calcular_variacion_sobre_ant ()
end prototypes

public function long f_cargar_arbol ();int    li_nivel_indentacion
long   ll_indice,ll_total_grupos,ll_nivel = 1,ll_orden = 0,ll_donde,ll_total_gpos_totaliza,ll_ejercicio,ll_color_texto,ll_color_fondo
string ls_codigo_grupo,ls_codigo_grupo_nivel_superior,ls_nombre_grupo,ls_gpo_totalizador
string ls_sel,ls_gpo_de_ultimo_nivel,ls_linea,ls_saldos_en_valor_absoluto,ls_mostrar_subgrupos,ls_negrita
dec    ld_valor_periodo,ld_presupuesto_periodo

istr_saldos_grupo listr_saldos_grupo

dw_detalle.reset()
dw_detalle.setredraw(false)

ll_ejercicio = year(date(em_fechadesde.text))
dw_detalle.modify("t_importe.text='"+string(ll_ejercicio,"###0")+"'")
dw_detalle.modify("t_presupuesto.text='Pres."+string(ll_ejercicio,"###0")+"'")
dw_detalle.modify("t_importe_ant.text='"+string(ll_ejercicio -1,"###0")+"'")

ls_sel = "select codigo, "+&
			"       descripcion, "+&
			"       conta_bal_grup_codigo, "+&
			"       orden, "+&
			"       gpo_totalizador, "+&
			"       orden_absoluto, "+&
			"       gpo_de_ultimo_nivel, "+&
			"       'N' as con_formula, "+&
			"       saldos_en_valor_absoluto, "+& 
			"       calcular_porcentaje, "+&
			"       conta_bal_grup_codigo_calc_po, "+&
			"       mostrar_subgrupos, "+&
			"       negrita, "+&
			"       color_texto, "+&
			"       color_fondo, "+&
			"       nivel_indentacion "+&
			"FROM   conta_bal_grup "+&
			"WHERE  empresa = '"+codigo_empresa+"' "+&
			"AND    conta_bal_cab_codigo = '"+is_balance+"' "+&
			"AND    isnull(conta_bal_grup_codigo,'') = '' "+& 
			"order by orden asc"
			
ll_total_grupos = f_cargar_cursor_transaccion(sqlca,ids_grupos,ls_sel)

ls_sel = "select codigo, "+&
			"       descripcion, "+&
			"       conta_bal_grup_codigo, "+&
			"       orden, "+&
			"       gpo_totalizador, "+&
			"       orden_absoluto, "+&
			"       gpo_de_ultimo_nivel, "+&
			"       0 as nivel, "+&
			"       'N' as con_formula, "+&
			"       saldos_en_valor_absoluto, "+& 
			"       calcular_porcentaje, "+&
			"       conta_bal_grup_codigo_calc_po, "+&
			"       mostrar_subgrupos, "+&
			"       negrita, "+&
			"       color_texto, "+&
			"       color_fondo, "+&
			"       nivel_indentacion "+&
			"FROM  conta_bal_grup "+&
			"WHERE empresa = '"+codigo_empresa+"' "+&
			"AND    conta_bal_cab_codigo = '"+is_balance+"' "+&
			"and isnull(conta_bal_grup_codigo,'') <> '' "+&
			"order by orden asc"

f_cargar_cursor_transaccion(sqlca,ids_grupos2,ls_sel)

ls_sel = "select conta_bal_grup_codigo, "+&
			"       contaplan_cuenta, "+&
			"       ejercicio, "+&
			"       min(orden) as orden, "+&
			"       sum(porcentaje) as porcentaje "+&
			"FROM  conta_bal_grup_ctas "+&
			"WHERE empresa = '"+codigo_empresa+"' "+&
			"and   isnull(conta_bal_grup_codigo,'') <> '' "+&
			"and   ejercicio = "+string(ll_ejercicio,"###0")+" "+&
			"AND   conta_bal_cab_codigo = '"+is_balance+"' "+&
			"group by conta_bal_grup_codigo,contaplan_cuenta,ejercicio "+&
			"order by min(orden) asc"

f_cargar_cursor_transaccion(sqlca,ids_cuentas,ls_sel) //,cos_centros_codigo

ls_sel = "select conta_bal_grup_codigo, "+&
			"       contaplan_cuenta, "+&
			"       ejercicio, "+&
			"       min(orden) as orden, "+&
			"       sum(porcentaje) as porcentaje "+&
			"FROM  conta_bal_grup_ctas "+&
			"WHERE empresa = '"+codigo_empresa+"' "+&
			"and   isnull(conta_bal_grup_codigo,'') <> '' "+&
			"and   ejercicio = "+string(ll_ejercicio -1,"###0")+" "+&
			"AND   conta_bal_cab_codigo = '"+is_balance+"' "+&
			"group by conta_bal_grup_codigo,contaplan_cuenta,ejercicio "+&
			"order by min(orden) asc"

f_cargar_cursor_transaccion(sqlca,ids_cuentas_ant,ls_sel) //,cos_centros_codigo

ls_sel = "select conta_bal_grup_codigo, "+&
			"       conta_bal_grup_codigo_t, "+&
			"       signo "+&
			"from conta_bal_grup_gpos_tot "+&
			"WHERE empresa = '"+codigo_empresa+"' "+&
			"AND    conta_bal_cab_codigo = '"+is_balance+"' "

f_cargar_cursor_transaccion(sqlca,ids_gpos_totaliza,ls_sel)

ls_sel = "SELECT cos_cuentas_centros_presupuesto.contaplan_cuenta, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_1) as presupuesto_mes_1, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_2) as presupuesto_mes_2, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_3) as presupuesto_mes_3, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_4) as presupuesto_mes_4, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_5) as presupuesto_mes_5, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_6) as presupuesto_mes_6, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_7) as presupuesto_mes_7, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_8) as presupuesto_mes_8, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_9) as presupuesto_mes_9, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_10) as presupuesto_mes_10, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_11) as presupuesto_mes_11, "+&
			"       sum(cos_cuentas_centros_presupuesto.presupuesto_mes_12) as presupuesto_mes_12 "+&
			"FROM   cos_cuentas_centros_presupuesto "+&
			"WHERE  cos_cuentas_centros_presupuesto.empresa = '"+codigo_empresa+"' "+&
			"AND    cos_cuentas_centros_presupuesto.ejercicio = "+string(ll_ejercicio,"###0")+" "+&
			"AND    cos_cuentas_centros_presupuesto.cos_centros_codigo in ("+is_centros_a_calcular+") "+&
			"GROUP BY cos_cuentas_centros_presupuesto.contaplan_cuenta"
//Esto en cristal no esta activo
//f_cargar_cursor_transaccion(sqlca,ids_presupuestos,ls_sel)

for ll_indice = 1 to ll_total_grupos
	f_mensaje_proceso("Insertando grupos",ll_indice,ll_total_grupos)

	ls_codigo_grupo                    = ids_grupos.object.codigo[ll_indice]	
	ls_codigo_grupo_nivel_superior     = ids_grupos.object.conta_bal_grup_codigo[ll_indice]
	ls_nombre_grupo                    = ids_grupos.object.descripcion[ll_indice]
	ls_gpo_totalizador                 = ids_grupos.object.gpo_totalizador[ll_indice]
	ll_orden                           = ids_grupos.object.orden_absoluto[ll_indice]
	ls_gpo_de_ultimo_nivel             = ids_grupos.object.gpo_de_ultimo_nivel[ll_indice]	
	ls_saldos_en_valor_absoluto        = ids_grupos.object.saldos_en_valor_absoluto[ll_indice]	
	is_calcular_porcentaje             = ids_grupos.object.calcular_porcentaje[ll_indice]	
	is_calcular_porcentaje_sobre_grupo = ids_grupos.object.conta_bal_grup_codigo_calc_po[ll_indice]	
	ls_mostrar_subgrupos               = ids_grupos.object.mostrar_subgrupos[ll_indice]	
	ls_negrita                         = ids_grupos.object.negrita[ll_indice]	
	ll_color_texto                     = ids_grupos.object.color_texto[ll_indice]	
	ll_color_fondo                     = ids_grupos.object.color_fondo[ll_indice]	
	li_nivel_indentacion               = ids_grupos.object.nivel_indentacion[ll_indice]	

	if li_nivel_indentacion = 0 then li_nivel_indentacion = ll_nivel	

	//Esto lo hacemos para detectar los grupos con formula

	ids_gpos_totaliza.setfilter("conta_bal_grup_codigo = '"+ls_codigo_grupo+"'")
	ids_gpos_totaliza.filter()

	ll_total_gpos_totaliza = ids_gpos_totaliza.rowcount()

	if ll_total_gpos_totaliza > 0 then
		ids_grupos.object.con_formula[ll_indice] = "S"	
		ls_linea = ""
	else
		ls_linea = "" //' -----------------------------------------------------------------------------------------------------------------------------------------------------'
	end if

	ld_valor_periodo = 0
	
	ll_donde = dw_detalle.insertrow(0)

	dw_detalle.object.codigo_grupo[ll_donde]                = ls_codigo_grupo
	dw_detalle.object.codigo_grupo_nivel_superior[ll_donde] = ls_codigo_grupo_nivel_superior
	if cbx_version_para_chequeo.checked then
		dw_detalle.object.nombre_grupo[ll_donde] = string(ll_nivel,"###0")+"-"+string(ls_codigo_grupo)+" "+ls_nombre_grupo+ls_linea
	else
		dw_detalle.object.nombre_grupo[ll_donde] = space((li_nivel_indentacion -1) * 5)+ls_nombre_grupo
	end if
	dw_detalle.object.gpo_totalizador[ll_donde]             = ls_gpo_totalizador
	dw_detalle.object.orden[ll_donde]                       = ll_orden
	dw_detalle.object.nivel[ll_donde]                       = ll_nivel
	dw_detalle.object.valor_periodo[ll_donde]               = 0
	dw_detalle.object.moneda[ll_donde]                      = is_moneda
	dw_detalle.object.mascara_moneda[ll_donde]              = is_mascara_moneda
	dw_detalle.object.rgb_grupo[ll_donde]                   = f_rgb_grupo(ll_nivel)
	dw_detalle.object.muestra_oculta_grupo[ll_donde]        = ""
	dw_detalle.object.visible[ll_donde]                     = "S"
	dw_detalle.object.saldos_en_valor_absoluto[ll_donde]    = ls_saldos_en_valor_absoluto
	dw_detalle.object.presupuesto_periodo[ll_donde]         = 0
	dw_detalle.object.valor_periodo_ant[ll_donde]           = 0
	dw_detalle.object.calcular_porcentaje[ll_donde]         = is_calcular_porcentaje
	dw_detalle.object.calcular_porcentaje_sobre_grupo[ll_donde] = is_calcular_porcentaje_sobre_grupo
	dw_detalle.object.negrita[ll_donde]	                        = ls_negrita
	dw_detalle.object.color_texto[ll_donde]                     = ll_color_texto
	dw_detalle.object.color_fondo[ll_donde]                     = ll_color_fondo

	if ls_gpo_de_ultimo_nivel = "S" then
		listr_saldos_grupo = f_saldos_grupo(ls_codigo_grupo,ll_nivel,ll_orden,ls_saldos_en_valor_absoluto,ls_mostrar_subgrupos,li_nivel_indentacion)
		dw_detalle.object.valor_periodo[ll_donde]               = listr_saldos_grupo.valor_periodo		
		dw_detalle.object.presupuesto_periodo[ll_donde]         = listr_saldos_grupo.presupuesto_periodo		
		dw_detalle.object.valor_periodo_ant[ll_donde]           = listr_saldos_grupo.valor_periodo_ant
	end if

	if f_cargar_rama(ls_codigo_grupo,ll_nivel,ls_mostrar_subgrupos,li_nivel_indentacion) > 0 then
		dw_detalle.object.muestra_oculta_grupo[ll_donde] = "-"	
	end if	

next

f_calcular_totales()

destroy ids_grupos
destroy ids_grupos2
destroy ids_cuentas
destroy ids_cuentas_ant
destroy ids_gpos_totaliza
destroy ids_presupuestos

if cbx_un_ejercicio.checked then
	dw_detalle.modify("t_importe_ant.visible=0")
	dw_detalle.modify("valor_periodo_ant.visible=0")
	dw_detalle.modify("t_variacion_sobre_ant.visible=0")
	dw_detalle.modify("variacion_sobre_ant.visible=0")
	dw_detalle.modify("t_porc_variacion_sobre_ant.visible=0")
	dw_detalle.modify("porc_variacion_sobre_ant.visible=0")
else
	dw_detalle.modify("t_importe_ant.visible=1")
	dw_detalle.modify("valor_periodo_ant.visible=1")
	dw_detalle.modify("t_variacion_sobre_ant.visible=1")
	dw_detalle.modify("variacion_sobre_ant.visible=1")
	dw_detalle.modify("t_porc_variacion_sobre_ant.visible=1")
	dw_detalle.modify("porc_variacion_sobre_ant.visible=1")	
end if

dw_detalle.selectrow(0,false)
dw_detalle.groupcalc()
dw_detalle.setredraw(true)



return ll_donde

end function

public subroutine f_calcular_totales ();long   ll_indice,ll_total_grupos,ll_nivel,ll_orden,ll_donde,ll_max_nivel,ll_total_gpos_totaliza,ll_indice_gpos_totaliza
string ls_codigo_grupo,ls_codigo_grupo_nivel_superior,ls_nombre_grupo,ls_gpo_totalizador
string ls_gpo_de_ultimo_nivel,ls_max_nivel,ls_codigo_grupo_a_totalizar,ls_signo,ls_formula_totaliza
dec    ld_importe_total_grupo,ld_presupuesto_total_grupo,ld_importe_ant_total_grupo

istr_saldos_grupo listr_saldos_grupo

ids_Grupos2.SetFilter( "gpo_totalizador = 'S'" )
ids_Grupos2.Filter()

ll_total_grupos = ids_Grupos2.RowCount()

if ll_total_grupos > 0 then
	ls_max_nivel = ids_Grupos2.describe("evaluate('max(nivel for all)',1)")
	ll_max_nivel = dec(ls_max_nivel)
end if

//El calculo lo haremos desde el nivel superior al inferior

for ll_nivel = ll_max_nivel to 2 step -1
//	f_mensaje_proceso("Calculando Totales",ll_nivel,ll_max_nivel)
	//Empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula) de nivel superior al 1
	ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'N' and nivel = "+string(ll_nivel,"###0") )
	ids_Grupos2.Filter()
	ids_Grupos2.Setsort("orden asc")
	ids_Grupos2.Sort()

	ll_total_grupos = ids_Grupos2.RowCount()

	for ll_indice = 1 to ll_total_grupos
		ls_codigo_grupo = ids_grupos2.object.codigo[ll_indice]	
		listr_saldos_grupo = f_calcular_importes_grupo(ls_codigo_grupo)
		
		ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

		if ll_donde > 0 then
			dw_detalle.object.valor_periodo[ll_donde]       = listr_saldos_grupo.valor_periodo
			dw_detalle.object.presupuesto_periodo[ll_donde] = listr_saldos_grupo.presupuesto_periodo
			dw_detalle.object.valor_periodo_ant[ll_donde]   = listr_saldos_grupo.valor_periodo_ant
		end if
	next	

	//Fin de empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula) de nivel superior al 1

	//Empezaremos calculando los grupos que dependen de otros (Los que tienen formula) de nivel superior al 1
	ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'S' and nivel = "+string(ll_nivel,"###0") )
	ids_Grupos2.Filter()
	ids_Grupos2.Setsort("orden asc")
	ids_Grupos2.Sort()

	ll_total_grupos = ids_Grupos2.RowCount()

	for ll_indice = 1 to ll_total_grupos
		ls_codigo_grupo        = ids_grupos2.object.codigo[ll_indice]	
		ld_importe_total_grupo     = 0
		ld_presupuesto_total_grupo = 0
		ld_importe_ant_total_grupo = 0

		ids_gpos_totaliza.setfilter("conta_bal_grup_codigo = '"+ls_codigo_grupo+"'")
		ids_gpos_totaliza.filter()
		ids_gpos_totaliza.setsort("signo desc,conta_bal_grup_codigo_t")
		
		ll_total_gpos_totaliza = ids_gpos_totaliza.rowcount()

		ls_formula_totaliza = ""

		if ll_total_gpos_totaliza > 0 then
			for ll_indice_gpos_totaliza = 1 to ll_total_gpos_totaliza
				ls_codigo_grupo_a_totalizar = ids_gpos_totaliza.object.conta_bal_grup_codigo_t[ll_indice_gpos_totaliza]
				ls_signo                    = ids_gpos_totaliza.object.signo[ll_indice_gpos_totaliza]
				
				if ll_indice_gpos_totaliza = 1 and ls_signo = '+' then
					ls_formula_totaliza = " ( "+f_conta_bal_grup_descripcion(codigo_empresa,"",ls_codigo_grupo_a_totalizar)+" "
				else
					ls_formula_totaliza += ls_signo+" "+f_conta_bal_grup_descripcion(codigo_empresa,"",ls_codigo_grupo_a_totalizar)+" "
					if ll_indice_gpos_totaliza = ll_total_gpos_totaliza then
						ls_formula_totaliza += ")"
					end if
				end if			
				
				listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo_a_totalizar)

				if ls_signo = '-' then
					listr_saldos_grupo.valor_periodo       = listr_saldos_grupo.valor_periodo * -1
					listr_saldos_grupo.presupuesto_periodo = listr_saldos_grupo.presupuesto_periodo * -1
					listr_saldos_grupo.valor_periodo_ant   = listr_saldos_grupo.valor_periodo_ant * -1
				end if

				ld_importe_total_grupo     += listr_saldos_grupo.valor_periodo
				ld_presupuesto_total_grupo += listr_saldos_grupo.presupuesto_periodo
				ld_importe_ant_total_grupo += listr_saldos_grupo.valor_periodo_ant
			next
		else
			listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo)

			ld_importe_total_grupo     = listr_saldos_grupo.valor_periodo
			ld_presupuesto_total_grupo = listr_saldos_grupo.presupuesto_periodo
			ld_importe_ant_total_grupo = listr_saldos_grupo.valor_periodo_ant
		end if		

		ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

		if ll_donde > 0 then
			dw_detalle.object.valor_periodo[ll_donde]       = ld_importe_total_grupo
			dw_detalle.object.presupuesto_periodo[ll_donde] = ld_presupuesto_total_grupo
			dw_detalle.object.valor_periodo_ant[ll_donde]   = ld_importe_ant_total_grupo
			if cbx_version_para_chequeo.checked then
				dw_detalle.object.nombre_grupo[ll_donde] = dw_detalle.object.nombre_grupo[ll_donde] + ls_formula_totaliza
			end if
		end if
	next		

	//Fin de empezaremos calculando los grupos que dependen de otros (Los que tienen formula) de nivel superior al 1
next

//Empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula) de nivel 1
ids_Grupos.SetFilter( "gpo_totalizador = 'S' and con_formula = 'N' " )
ids_Grupos.Filter()
ids_Grupos.Setsort("orden asc")
ids_Grupos.Sort()

ll_total_grupos = ids_Grupos.RowCount()

for ll_indice = 1 to ll_total_grupos
	ls_codigo_grupo = ids_Grupos.object.codigo[ll_indice]	
	listr_saldos_grupo = f_calcular_importes_grupo(ls_codigo_grupo)

	ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

	if ll_donde > 0 then
		dw_detalle.object.valor_periodo[ll_donde]       = listr_saldos_grupo.valor_periodo
		dw_detalle.object.presupuesto_periodo[ll_donde] = listr_saldos_grupo.presupuesto_periodo
		dw_detalle.object.valor_periodo_ant[ll_donde]   = listr_saldos_grupo.valor_periodo_ant
	end if
next	

//Fin de empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula) de nivel 1

//Empezaremos calculando los grupos que dependen de otros (Los que tienen formula) de nivel 1
ids_Grupos.SetFilter( "gpo_totalizador = 'S' and con_formula = 'S' " )
ids_Grupos.Filter()
ids_Grupos.Setsort("orden asc")
ids_Grupos.Sort()

ll_total_grupos = ids_Grupos.RowCount()

for ll_indice = 1 to ll_total_grupos
	ls_codigo_grupo        = ids_Grupos.object.codigo[ll_indice]	
	ld_importe_total_grupo     = 0
	ld_presupuesto_total_grupo = 0
	ld_importe_ant_total_grupo = 0

	ids_gpos_totaliza.setfilter("conta_bal_grup_codigo = '"+ls_codigo_grupo+"'")
	ids_gpos_totaliza.filter()

	ll_total_gpos_totaliza = ids_gpos_totaliza.rowcount()

	ls_formula_totaliza = ""

	if ll_total_gpos_totaliza > 0 then
		for ll_indice_gpos_totaliza = 1 to ll_total_gpos_totaliza
			ls_codigo_grupo_a_totalizar = ids_gpos_totaliza.object.conta_bal_grup_codigo_t[ll_indice_gpos_totaliza]
			ls_signo                    = ids_gpos_totaliza.object.signo[ll_indice_gpos_totaliza]

			if ll_indice_gpos_totaliza = 1 and ls_signo = '+' then
				ls_formula_totaliza = " ( "+f_conta_bal_grup_descripcion(codigo_empresa,"",ls_codigo_grupo_a_totalizar)+" "
			else
				ls_formula_totaliza += ls_signo+" "+f_conta_bal_grup_descripcion(codigo_empresa,"",ls_codigo_grupo_a_totalizar)+" "
				if ll_indice_gpos_totaliza = ll_total_gpos_totaliza then
					ls_formula_totaliza += ")"
				end if
			end if			

			listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo_a_totalizar)

			if ls_signo = '-' then
				listr_saldos_grupo.valor_periodo       = listr_saldos_grupo.valor_periodo * -1
				listr_saldos_grupo.presupuesto_periodo = listr_saldos_grupo.presupuesto_periodo * -1
				listr_saldos_grupo.valor_periodo_ant   = listr_saldos_grupo.valor_periodo_ant * -1
			end if

			ld_importe_total_grupo     += listr_saldos_grupo.valor_periodo
			ld_presupuesto_total_grupo += listr_saldos_grupo.presupuesto_periodo
			ld_importe_ant_total_grupo += listr_saldos_grupo.valor_periodo_ant
		next
	else
		listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo)
		
		ld_importe_total_grupo     = listr_saldos_grupo.valor_periodo
		ld_presupuesto_total_grupo = listr_saldos_grupo.presupuesto_periodo		
		ld_importe_ant_total_grupo = listr_saldos_grupo.valor_periodo_ant

	end if		

	ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

	if ll_donde > 0 then
		dw_detalle.object.valor_periodo[ll_donde]       = ld_importe_total_grupo
		dw_detalle.object.presupuesto_periodo[ll_donde] = ld_presupuesto_total_grupo
		dw_detalle.object.valor_periodo_ant[ll_donde]   = ld_importe_ant_total_grupo
		if cbx_version_para_chequeo.checked then
			dw_detalle.object.nombre_grupo[ll_donde] = dw_detalle.object.nombre_grupo[ll_donde] + ls_formula_totaliza
		end if
	end if
next		

//Fin de empezaremos calculando los grupos que dependen de otros (Los que tienen formula) de nivel 1

f_calcular_porcentajes()

f_calcular_variacion_sobre_ant()
f_calcular_variacion_sobre_presupuesto()

end subroutine

public function long f_rgb_grupo (integer arg_nivel);int li_r,li_g,li_b
dec id_ratio_gb = 1.29,ratio_gr = 0.22

li_r = 0
li_g = 100
li_b = li_g * id_ratio_gb

if arg_nivel > 1 then
	li_g = li_g + ((arg_nivel -1) * 20)
	li_b = li_g * id_ratio_gb

	if li_b > 255 then
		li_b = 255
		li_r = li_g * ratio_gr
	end if
end if

return rgb(li_r,li_g,li_b)

end function

public subroutine f_calcular_totales_old ();//long   ll_indice,ll_total_grupos,ll_nivel,ll_orden,ll_donde,ll_max_nivel,ll_total_gpos_totaliza,ll_indice_gpos_totaliza

//string ls_codigo_grupo,ls_codigo_grupo_nivel_superior,ls_nombre_grupo,ls_gpo_totalizador

//string ls_gpo_de_ultimo_nivel,ls_max_nivel,ls_codigo_grupo_a_totalizar,ls_signo

//dec    ld_importe_grupo,ld_importe_total_grupo

//

////Empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula)

//

//ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'N'" )

//ids_Grupos2.Filter()

//

//ll_total_grupos = ids_Grupos2.RowCount()

//

//if ll_total_grupos > 0 then

//	ls_max_nivel = ids_Grupos2.describe("evaluate('max(nivel for all)',1)")

//	ll_max_nivel = dec(ls_max_nivel)

//end if

//

////El calculo lo haremos desde el nivel superior al inferior

//

//for ll_nivel = ll_max_nivel to 2 step -1

////	f_mensaje_proceso("Calculando Totales",ll_nivel,ll_max_nivel)

//	ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'N' and nivel = "+string(ll_nivel,"###0") )

//	ids_Grupos2.Filter()

//	

//	ll_total_grupos = ids_Grupos2.RowCount()

//	

//	for ll_indice = 1 to ll_total_grupos

//		ls_codigo_grupo = ids_grupos2.object.codigo[ll_indice]	

//		ld_importe_grupo = f_importe_grupo(ls_codigo_grupo)

//		

//		ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

//		

//		if ll_donde > 0 then

//			dw_detalle.object.valor_periodo[ll_donde] = ld_importe_grupo

//		end if

//	next	

//	

//next

//

////Fin de empezaremos calculando los grupos que dependen de si mismos (Los que no tienen formula)

//

////Empezaremos calculando los grupos que dependen de otros (Los que tienen formula)

//

//ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'S'" )

//ids_Grupos2.Filter()

//

//ll_total_grupos = ids_Grupos2.RowCount()

//

//if ll_total_grupos > 0 then

//	ls_max_nivel = ids_Grupos2.describe("evaluate('max(nivel for all)',1)")

//	ll_max_nivel = dec(ls_max_nivel)

//end if

//

////El calculo lo haremos desde el nivel superior al inferior

//

//for ll_nivel = ll_max_nivel to 2 step -1

////	f_mensaje_proceso("Calculando Totales",ll_nivel,ll_max_nivel)

//	ids_Grupos2.SetFilter( "gpo_totalizador = 'S' and con_formula = 'S' and nivel = "+string(ll_nivel,"###0") )

//	ids_Grupos2.Filter()

//	

//	ll_total_grupos = ids_Grupos2.RowCount()

//	

//	for ll_indice = 1 to ll_total_grupos

//		ls_codigo_grupo        = ids_grupos2.object.codigo[ll_indice]	

//		ld_importe_total_grupo = 0

//		

//		ids_gpos_totaliza.setfilter("conta_bal_grup_codigo = '"+ls_codigo_grupo+"'")

//		ids_gpos_totaliza.filter()

//		

//		ll_total_gpos_totaliza = ids_gpos_totaliza.rowcount()

//		

//		if ll_total_gpos_totaliza > 0 then

//			for ll_indice_gpos_totaliza = 1 to ll_total_gpos_totaliza

//				ls_codigo_grupo_a_totalizar = ids_gpos_totaliza.object.conta_bal_grup_codigo_t[ll_indice_gpos_totaliza]

//				ls_signo                    = ids_gpos_totaliza.object.signo[ll_indice_gpos_totaliza]

//				

//				ld_importe_grupo = f_importe_grupo(ls_codigo_grupo_a_totalizar)

//				

//				if ls_signo = '-' then

//					ld_importe_grupo = ld_importe_grupo * -1

//				end if

//				

//				ld_importe_total_grupo += ld_importe_grupo

//			next

//		else

//			ld_importe_grupo = f_importe_grupo(ls_codigo_grupo)

//			ld_importe_total_grupo = ld_importe_grupo

//		end if		

//		

//

//		

//		ll_donde = dw_detalle.find("codigo_grupo = '"+ls_codigo_grupo+"'",1,dw_detalle.rowcount())

//		

//		if ll_donde > 0 then

//			dw_detalle.object.valor_periodo[ll_donde] = ld_importe_total_grupo

//		end if

//	next	

//	

//next

//

////Fin de empezaremos calculando los grupos que dependen de otros (Los que tienen formula)

//

end subroutine

public function istr_saldos_grupo f_calcular_importes_grupo (string arg_grupo);string ls_valor_periodo,ls_presupuesto_periodo,ls_valor_periodo_ant
dec    ld_valor_periodo,ld_presupuesto_periodo,ld_valor_periodo_ant

istr_saldos_grupo listr_saldos_grupo

ls_valor_periodo = dw_detalle.describe('evaluate("sum(if (codigo_grupo_nivel_superior = ~''+arg_grupo+'~',valor_periodo,0) for all)",1)')
ld_valor_periodo = dec(ls_valor_periodo)
ls_presupuesto_periodo = dw_detalle.describe('evaluate("sum(if (codigo_grupo_nivel_superior = ~''+arg_grupo+'~',presupuesto_periodo,0) for all)",1)')
ld_presupuesto_periodo = dec(ls_presupuesto_periodo)

ls_valor_periodo_ant = dw_detalle.describe('evaluate("sum(if (codigo_grupo_nivel_superior = ~''+arg_grupo+'~',valor_periodo_ant,0) for all)",1)')
ld_valor_periodo_ant = dec(ls_valor_periodo_ant)

listr_saldos_grupo.valor_periodo       = ld_valor_periodo
listr_saldos_grupo.presupuesto_periodo = ld_presupuesto_periodo
listr_saldos_grupo.valor_periodo_ant   = ld_valor_periodo_ant

return listr_saldos_grupo

end function

public function istr_saldos_grupo f_importes_grupo (string arg_grupo);string ls_valor_periodo,ls_presupuesto_periodo,ls_valor_periodo_ant
dec    ld_valor_periodo,ld_presupuesto_periodo,ld_valor_periodo_ant

istr_saldos_grupo listr_saldos_grupo

ls_valor_periodo = dw_detalle.describe('evaluate("sum(if (codigo_grupo = ~''+arg_grupo+'~',valor_periodo,0) for all)",1)')
ld_valor_periodo = dec(ls_valor_periodo)

ls_presupuesto_periodo = dw_detalle.describe('evaluate("sum(if (codigo_grupo = ~''+arg_grupo+'~',presupuesto_periodo,0) for all)",1)')
ld_presupuesto_periodo = dec(ls_presupuesto_periodo)

ls_valor_periodo_ant = dw_detalle.describe('evaluate("sum(if (codigo_grupo = ~''+arg_grupo+'~',valor_periodo_ant,0) for all)",1)')
ld_valor_periodo_ant = dec(ls_valor_periodo_ant)

listr_saldos_grupo.valor_periodo       = ld_valor_periodo
listr_saldos_grupo.presupuesto_periodo = ld_presupuesto_periodo
listr_saldos_grupo.valor_periodo_ant   = ld_valor_periodo_ant

return listr_saldos_grupo

end function

public subroutine f_calcular_porcentajes ();long   ll_indice,ll_total
dec    ld_porcentaje,ld_porcentaje_presupuesto,ld_porcentaje_ant
string ls_codigo_grupo,ls_calcular_porcentaje,ls_calcular_porcentaje_sobre_grupo

istr_saldos_grupo listr_saldos_grupo,listr_saldos_grupo_calcular_porcentaje

ll_total = dw_detalle.rowcount()

for ll_indice = 1 to ll_total
	ls_codigo_grupo                    = dw_detalle.object.codigo_grupo[ll_indice]	
	ls_calcular_porcentaje             = dw_detalle.object.calcular_porcentaje[ll_indice]	
	ls_calcular_porcentaje_sobre_grupo = dw_detalle.object.calcular_porcentaje_sobre_grupo[ll_indice]	

	//listr_saldos_grupo = f_calcular_importes_grupo(ls_codigo_grupo)

	listr_saldos_grupo                     = f_importes_grupo(ls_codigo_grupo)
	listr_saldos_grupo_calcular_porcentaje = f_importes_grupo(ls_calcular_porcentaje_sobre_grupo)

	if listr_saldos_grupo_calcular_porcentaje.valor_periodo <> 0 then
		ld_porcentaje             = (listr_saldos_grupo.valor_periodo / listr_saldos_grupo_calcular_porcentaje.valor_periodo) * 100
	else
		ld_porcentaje             = 0
	end if

	if listr_saldos_grupo_calcular_porcentaje.presupuesto_periodo <> 0 then
		ld_porcentaje_presupuesto = (listr_saldos_grupo.presupuesto_periodo / listr_saldos_grupo_calcular_porcentaje.presupuesto_periodo) * 100
	else
		ld_porcentaje_presupuesto = 0
	end if

	if listr_saldos_grupo_calcular_porcentaje.valor_periodo_ant <> 0 then
		ld_porcentaje_ant         = (listr_saldos_grupo.valor_periodo_ant / listr_saldos_grupo_calcular_porcentaje.valor_periodo_ant) * 100
	else
		ld_porcentaje_ant         = 0
	end if

	dw_detalle.object.porcentaje[ll_indice]             = ld_porcentaje
	dw_detalle.object.porcentaje_presupuesto[ll_indice] = ld_porcentaje_presupuesto
	dw_detalle.object.porcentaje_ant[ll_indice]         = ld_porcentaje_ant

next

end subroutine

public subroutine f_calcular_variacion_sobre_presupuesto ();long   ll_indice,ll_total
dec    ld_variacion_sobre_presupuesto,ld_porc_variacion_sobre_presupuesto
string ls_codigo_grupo

istr_saldos_grupo listr_saldos_grupo

ll_total = dw_detalle.rowcount()

for ll_indice = 1 to ll_total
	ls_codigo_grupo    = dw_detalle.object.codigo_grupo[ll_indice]	

	listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo)

	ld_variacion_sobre_presupuesto = listr_saldos_grupo.valor_periodo - listr_saldos_grupo.presupuesto_periodo

	if listr_saldos_grupo.presupuesto_periodo <> 0 then
		ld_porc_variacion_sobre_presupuesto = (ld_variacion_sobre_presupuesto / listr_saldos_grupo.presupuesto_periodo ) * 100
	else
		if ld_variacion_sobre_presupuesto = 0 then
			ld_porc_variacion_sobre_presupuesto = 0
		else
			if ld_variacion_sobre_presupuesto > 0 then
				ld_porc_variacion_sobre_presupuesto = 100
			else
				ld_porc_variacion_sobre_presupuesto = -100
			end if			
		end if
	end if

	dw_detalle.object.variacion_sobre_presupuesto[ll_indice]      = ld_variacion_sobre_presupuesto
	dw_detalle.object.porc_variacion_sobre_presupuesto[ll_indice] = ld_porc_variacion_sobre_presupuesto

next

end subroutine

public function istr_saldos_grupo f_saldos_grupo (string arg_grupo, integer arg_nivel, long arg_orden, string arg_saldos_en_valor_absoluto, string arg_visible, integer arg_nivel_indentacion);dec    ld_saldo,ld_saldo_total,ld_porcentaje,ld_saldo_ant,ld_saldo_ant_total,ld_presupuesto,ld_presupuesto_total
dec    ld_porcentaje_ant
int    li_mes,li_mes_desde,li_mes_hasta,li_nivel_indentacion
long   ll_indice,ll_total_cuentas,ll_ejercicio_desde,ll_ejercicio_hasta,ll_nivel,ll_donde,ll_ejercicio_desde_ant,ll_ejercicio_hasta_ant
long   ll_donde_presupuesto,ll_donde_cuenta_ant,ll_color_texto,ll_color_fondo
string ls_cuenta,ls_linea = ' -----------------------------------------------------------------------------------------------------------------------------------------------------',ls_negrita
datetime ldt_f_desde,ldt_f_hasta,ldt_f_desde_ant,ldt_f_hasta_ant

istr_saldos_grupo listr_saldos_grupo

ls_negrita     = "N"
ll_color_texto = 0
ll_color_fondo = 16777215 //Blanco

ll_ejercicio_desde = year(date(em_fechadesde.text))
ll_ejercicio_hasta =  year(date(em_fechadesde.text))

ldt_f_desde  = datetime(date(em_fechadesde.text))
ldt_f_hasta  = datetime(date(em_fechahasta.text))

li_mes_desde = month(date(ldt_f_desde))
li_mes_hasta = month(date(ldt_f_hasta))

ldt_f_desde_ant = datetime(mdy(month(date(ldt_f_desde)),day(date(ldt_f_desde)),year(date(ldt_f_desde)) -1))
ldt_f_hasta_ant = datetime(mdy(month(date(ldt_f_hasta)),day(date(ldt_f_hasta)),year(date(ldt_f_hasta)) -1))

ll_ejercicio_desde_ant = year(date(ldt_f_desde_ant))
ll_ejercicio_hasta_ant = year(date(ldt_f_hasta_ant))

//ids_cuentas.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo + "' and (ejercicio >= "+string(ll_ejercicio_desde,"###0")+" and ejercicio <= "+string(ll_ejercicio_hasta,"###0")+" )" )
ids_cuentas.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo + "' " )
ids_cuentas.Filter()
ids_cuentas.SetSort("orden A")
ids_cuentas.Sort()

//ids_cuentas_ant.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo + "' and (ejercicio >= "+string(ll_ejercicio_desde -1,"###0")+" and ejercicio <= "+string(ll_ejercicio_hasta,"###0")+" )" )
ids_cuentas_ant.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo + "' " )
ids_cuentas_ant.Filter()
ids_cuentas_ant.SetSort("orden A")
ids_cuentas_ant.Sort()

ll_total_cuentas = ids_cuentas.RowCount()

ld_saldo_total       = 0
ld_presupuesto_total = 0
ld_saldo_ant_total   = 0

ll_nivel = arg_nivel
ll_nivel ++
li_nivel_indentacion = arg_nivel_indentacion
li_nivel_indentacion ++

for ll_indice = 1 to ll_total_cuentas
	ls_cuenta     = ids_cuentas.object.contaplan_cuenta[ll_indice]	
	ld_porcentaje = ids_cuentas.object.porcentaje[ll_indice]	
	
	ll_donde_cuenta_ant = ids_cuentas_ant.find("contaplan_cuenta = '"+ls_cuenta+"'",1,ids_cuentas_ant.rowcount())
	
	if ll_donde_cuenta_ant > 0 then
		ld_porcentaje_ant = ids_cuentas_ant.object.porcentaje[ll_donde_cuenta_ant]	
		ids_cuentas_ant.deleterow(ll_donde_cuenta_ant)
	else
		ld_porcentaje_ant = 0
	end if
	
	if ld_porcentaje > 100 then ld_porcentaje = 100	
	
	if ld_porcentaje > 0 or ld_porcentaje_ant > 0 then
		ld_saldo     = f_saldo_cuenta_balance_npgc(ll_ejercicio_desde,codigo_empresa,ls_cuenta,ldt_f_desde,ldt_f_hasta)	
		ld_saldo     = round((ld_saldo / 100) * ld_porcentaje,2)

		ld_saldo_ant = f_saldo_cuenta_balance_npgc(ll_ejercicio_desde_ant,codigo_empresa,ls_cuenta,ldt_f_desde_ant,ldt_f_hasta_ant)	
		ld_saldo_ant = round((ld_saldo_ant / 100) * ld_porcentaje_ant,2)
		
		ll_donde_presupuesto = 0 //Esto no vale ids_presupuestos.find("contaplan_cuenta = '"+ls_cuenta+"'",1,ids_presupuestos.rowcount())
		
		ld_presupuesto = 0
		
		if ll_donde_presupuesto > 0 then
			for li_mes = li_mes_desde to li_mes_hasta
				choose case li_mes
					case 1
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_1[ll_donde_presupuesto]
					case 2
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_2[ll_donde_presupuesto]
					case 3
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_3[ll_donde_presupuesto]
					case 4
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_4[ll_donde_presupuesto]
					case 5
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_5[ll_donde_presupuesto]
					case 6
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_6[ll_donde_presupuesto]
					case 7
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_7[ll_donde_presupuesto]
					case 8
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_8[ll_donde_presupuesto]
					case 9
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_9[ll_donde_presupuesto]
					case 10
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_10[ll_donde_presupuesto]
					case 11
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_11[ll_donde_presupuesto]
					case 12
						ld_presupuesto += ids_presupuestos.object.presupuesto_mes_12[ll_donde_presupuesto]
				end choose
			next		
		end if
		
		ld_presupuesto  = round((ld_presupuesto / 100) * ld_porcentaje,2)
	else
		ld_saldo       = 0
		ld_saldo_ant   = 0
		ld_presupuesto = 0
	end if
	
	//esta variable nos indicara si cambiamos el signo al saldo
	if arg_saldos_en_valor_absoluto = 'S' then
		ld_saldo       = ld_saldo * -1
		ld_saldo_ant   = ld_saldo_ant * -1
		ld_presupuesto = ld_presupuesto * -1
	end if

	if cbx_con_cuentas.checked then
		if cbx_cuentas_importe_cero.checked or (ld_saldo <> 0 or ld_saldo_ant <> 0) then
			ll_donde = dw_detalle.insertrow(0)
			dw_detalle.object.codigo_grupo[ll_donde]                = ls_cuenta
			dw_detalle.object.codigo_grupo_nivel_superior[ll_donde] = arg_grupo
			dw_detalle.object.nombre_grupo[ll_donde]                = ls_cuenta+" "+f_nombre_contaplan(ll_ejercicio_desde,codigo_empresa,ls_cuenta)+" "+string(ld_porcentaje,"##0.0")+"% "+string(ld_porcentaje_ant,"##0.0")+"% "+ls_linea
			if cbx_version_para_chequeo.checked then
				dw_detalle.object.nombre_grupo[ll_donde] = ls_cuenta+" "+f_nombre_contaplan(ll_ejercicio_desde,codigo_empresa,ls_cuenta)+" "+string(ld_porcentaje,"##0.0")+"% "+string(ld_porcentaje_ant,"##0.0")+"% "+ls_linea
			else
				dw_detalle.object.nombre_grupo[ll_donde] = space((li_nivel_indentacion -1) * 5)+ls_cuenta+" "+f_nombre_contaplan(ll_ejercicio_desde,codigo_empresa,ls_cuenta)+" "+ls_linea
			end if				
	
			dw_detalle.object.gpo_totalizador[ll_donde]             = 'N'
			dw_detalle.object.orden[ll_donde]                       = arg_orden
			dw_detalle.object.nivel[ll_donde]                       = ll_nivel
			dw_detalle.object.valor_periodo[ll_donde]               = ld_saldo
			dw_detalle.object.moneda[ll_donde]                      = is_moneda
			dw_detalle.object.mascara_moneda[ll_donde]              = is_mascara_moneda
			dw_detalle.object.rgb_grupo[ll_donde]                   = f_rgb_grupo(ll_nivel)	
			dw_detalle.object.muestra_oculta_grupo[ll_donde]        = ""
			dw_detalle.object.visible[ll_donde]                     = arg_visible		
			dw_detalle.object.presupuesto_periodo[ll_donde]         = ld_presupuesto
			dw_detalle.object.valor_periodo_ant[ll_donde]           = ld_saldo_ant
			dw_detalle.object.calcular_porcentaje[ll_donde]         = is_calcular_porcentaje
			dw_detalle.object.calcular_porcentaje_sobre_grupo[ll_donde] = is_calcular_porcentaje_sobre_grupo
			dw_detalle.object.negrita[ll_donde]	                        = ls_negrita
			dw_detalle.object.color_texto[ll_donde]                     = ll_color_texto
			dw_detalle.object.color_fondo[ll_donde]                     = ll_color_fondo	
		end if
	end if

	ld_saldo_total       += ld_saldo
	ld_presupuesto_total += ld_presupuesto
	ld_saldo_ant_total   += ld_saldo_ant

next

//Añadimos las cuentas del ejercicio anterior que no estan en el actual

ll_total_cuentas = ids_cuentas_ant.rowcount()

for ll_indice = 1 to ll_total_cuentas
	ls_cuenta         = ids_cuentas_ant.object.contaplan_cuenta[ll_indice]	
	ld_porcentaje     = 0
	ld_porcentaje_ant = ids_cuentas_ant.object.porcentaje[ll_indice]	
		
	if ld_porcentaje_ant > 100 then ld_porcentaje_ant = 100	
	
	if ld_porcentaje_ant > 0 then
		ld_saldo     = 0
		ld_saldo     = round((ld_saldo / 100) * ld_porcentaje,2)
		
		ld_saldo_ant = f_saldo_cuenta_balance_npgc(ll_ejercicio_desde_ant,codigo_empresa,ls_cuenta,ldt_f_desde_ant,ldt_f_hasta_ant)	
		ld_saldo_ant = round((ld_saldo_ant / 100) * ld_porcentaje_ant,2)
		
		ld_presupuesto = 0
	else
		ld_saldo       = 0
		ld_saldo_ant   = 0
		ld_presupuesto = 0		
	end if
	
	//esta variable nos indicara si cambiamos el signo al saldo
	if arg_saldos_en_valor_absoluto = 'S' then
		ld_saldo       = ld_saldo * -1
		ld_saldo_ant   = ld_saldo_ant * -1
		ld_presupuesto = ld_presupuesto * -1
	end if
	
	if cbx_con_cuentas.checked then
		if cbx_cuentas_importe_cero.checked or (ld_saldo <> 0 or ld_saldo_ant <> 0) then
			ll_donde = dw_detalle.insertrow(0)
			dw_detalle.object.codigo_grupo[ll_donde]                = ls_cuenta
			dw_detalle.object.codigo_grupo_nivel_superior[ll_donde] = arg_grupo		
			if cbx_version_para_chequeo.checked then
				dw_detalle.object.nombre_grupo[ll_donde] = ls_cuenta+" "+f_nombre_contaplan(ll_ejercicio_desde,codigo_empresa,ls_cuenta)+" "+string(ld_porcentaje,"##0.0")+"% "+string(ld_porcentaje_ant,"##0.0")+"% "+ls_linea
			else
				dw_detalle.object.nombre_grupo[ll_donde] = space((li_nivel_indentacion -1) * 5)+ls_cuenta+" "+f_nombre_contaplan(ll_ejercicio_desde,codigo_empresa,ls_cuenta)+" "+ls_linea
			end if						
	
			dw_detalle.object.gpo_totalizador[ll_donde]             = 'N'
			dw_detalle.object.orden[ll_donde]                       = arg_orden
			dw_detalle.object.nivel[ll_donde]                       = ll_nivel
			dw_detalle.object.valor_periodo[ll_donde]               = ld_saldo
			dw_detalle.object.moneda[ll_donde]                      = is_moneda
			dw_detalle.object.mascara_moneda[ll_donde]              = is_mascara_moneda
			dw_detalle.object.rgb_grupo[ll_donde]                   = f_rgb_grupo(ll_nivel)	
			dw_detalle.object.muestra_oculta_grupo[ll_donde]        = ""
			dw_detalle.object.visible[ll_donde]                     = arg_visible		
			dw_detalle.object.presupuesto_periodo[ll_donde]         = ld_presupuesto
			dw_detalle.object.valor_periodo_ant[ll_donde]           = ld_saldo_ant
			dw_detalle.object.calcular_porcentaje[ll_donde]         = is_calcular_porcentaje
			dw_detalle.object.calcular_porcentaje_sobre_grupo[ll_donde] = is_calcular_porcentaje_sobre_grupo	
			dw_detalle.object.negrita[ll_donde]	                        = ls_negrita
			dw_detalle.object.color_texto[ll_donde]                     = ll_color_texto
			dw_detalle.object.color_fondo[ll_donde]                     = ll_color_fondo		
		end if
	end if
	
	ld_saldo_total       += ld_saldo
	ld_presupuesto_total += ld_presupuesto
	ld_saldo_ant_total   += ld_saldo_ant
next

//Fin de añadimos las cuentas del ejercicio anterior que no estan en el actual

listr_saldos_grupo.valor_periodo       = ld_saldo_total
listr_saldos_grupo.presupuesto_periodo = ld_presupuesto_total
listr_saldos_grupo.valor_periodo_ant   = ld_saldo_ant_total

return listr_saldos_grupo
end function

public function long f_cargar_rama (string arg_grupo_nivel_superior, long arg_nivel_superior, string arg_visible, integer arg_nivel_indentacion);int    li_nivel_indentacion,li_nivel_indentacion_segun_anterior
long   ll_indice,ll_total_grupos,ll_nivel,ll_orden,ll_donde,ll_total_gpos_totaliza,ll_color_texto,ll_color_fondo
string ls_codigo_grupo,ls_codigo_grupo_nivel_superior,ls_nombre_grupo,ls_gpo_totalizador
string ls_gpo_de_ultimo_nivel,ls_linea,ls_saldos_en_valor_absoluto,ls_mostrar_subgrupos,ls_negrita
dec    ld_valor_periodo,ld_presupuesto_periodo

istr_saldos_grupo listr_saldos_grupo

ids_Grupos2.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo_nivel_superior + "'" )
ids_Grupos2.Filter()
ids_Grupos2.SetSort("orden A")
ids_Grupos2.Sort( )

ll_total_grupos = ids_Grupos2.RowCount()

ll_nivel = arg_nivel_superior
ll_nivel ++

li_nivel_indentacion_segun_anterior = arg_nivel_indentacion
li_nivel_indentacion_segun_anterior ++

for ll_indice = 1 to ll_total_grupos
	ls_codigo_grupo                    = ids_grupos2.object.codigo[ll_indice]	
	ls_codigo_grupo_nivel_superior     = ids_grupos2.object.conta_bal_grup_codigo[ll_indice]
	ls_nombre_grupo                    = ids_grupos2.object.descripcion[ll_indice]
	ls_gpo_totalizador                 = ids_grupos2.object.gpo_totalizador[ll_indice]
	ll_orden                           = ids_grupos2.object.orden_absoluto[ll_indice]
	ls_gpo_de_ultimo_nivel             = ids_grupos2.object.gpo_de_ultimo_nivel[ll_indice]
	ls_saldos_en_valor_absoluto        = ids_grupos2.object.saldos_en_valor_absoluto[ll_indice]
	is_calcular_porcentaje             = ids_grupos2.object.calcular_porcentaje[ll_indice]	
	is_calcular_porcentaje_sobre_grupo = ids_grupos2.object.conta_bal_grup_codigo_calc_po[ll_indice]	
	if arg_visible = "S" then
		ls_mostrar_subgrupos = ids_grupos2.object.mostrar_subgrupos[ll_indice]	
	else
		ls_mostrar_subgrupos = arg_visible
	end if
	ls_negrita                         = ids_grupos2.object.negrita[ll_indice]	
	ll_color_texto                     = ids_grupos2.object.color_texto[ll_indice]	
	ll_color_fondo                     = ids_grupos2.object.color_fondo[ll_indice]		
	li_nivel_indentacion               = ids_grupos2.object.nivel_indentacion[ll_indice]	
	
	if li_nivel_indentacion = 0 then li_nivel_indentacion = li_nivel_indentacion_segun_anterior
	
	ld_valor_periodo = 0

	ll_donde = dw_detalle.insertrow(0)
	dw_detalle.object.codigo_grupo[ll_donde]                = ls_codigo_grupo
	dw_detalle.object.codigo_grupo_nivel_superior[ll_donde] = ls_codigo_grupo_nivel_superior
	if cbx_version_para_chequeo.checked then
		dw_detalle.object.nombre_grupo[ll_donde] = string(ll_nivel,"###0")+"-"+string(ls_codigo_grupo)+" "+ls_nombre_grupo
	else
		dw_detalle.object.nombre_grupo[ll_donde] = space((li_nivel_indentacion -1) * 5)+ls_nombre_grupo
	end if		
	dw_detalle.object.gpo_totalizador[ll_donde]             = ls_gpo_totalizador
	dw_detalle.object.orden[ll_donde]                       = ll_orden
	dw_detalle.object.nivel[ll_donde]                       = ll_nivel
	dw_detalle.object.valor_periodo[ll_donde]               = 0
	dw_detalle.object.moneda[ll_donde]                      = is_moneda
	dw_detalle.object.mascara_moneda[ll_donde]              = is_mascara_moneda
	dw_detalle.object.rgb_grupo[ll_donde]                   = f_rgb_grupo(ll_nivel)
	dw_detalle.object.muestra_oculta_grupo[ll_donde]        = ""
	dw_detalle.object.visible[ll_donde]                     = arg_visible
	dw_detalle.object.saldos_en_valor_absoluto[ll_donde]    = ls_saldos_en_valor_absoluto
	dw_detalle.object.presupuesto_periodo[ll_donde]         = 0
	dw_detalle.object.valor_periodo_ant[ll_donde]           = 0
	dw_detalle.object.calcular_porcentaje[ll_donde]         = is_calcular_porcentaje
	dw_detalle.object.calcular_porcentaje_sobre_grupo[ll_donde] = is_calcular_porcentaje_sobre_grupo
	dw_detalle.object.negrita[ll_donde]	                        = ls_negrita
	dw_detalle.object.color_texto[ll_donde]                     = ll_color_texto
	dw_detalle.object.color_fondo[ll_donde]                     = ll_color_fondo

	//Esto lo hacemos para luego ir calculando los totales de los grupos totalizadores de mas a menos nivel
	ids_grupos2.object.nivel[ll_indice] = ll_nivel
	//

	if ls_gpo_de_ultimo_nivel = "S" then
		listr_saldos_grupo = f_saldos_grupo(ls_codigo_grupo,ll_nivel,ll_orden,ls_saldos_en_valor_absoluto,ls_mostrar_subgrupos,li_nivel_indentacion)
		dw_detalle.object.valor_periodo[ll_donde]               = listr_saldos_grupo.valor_periodo
		//ld_presupuesto_periodo= f_presupuesto_grupo(ls_codigo_grupo,ll_nivel,ll_orden,ls_saldos_en_valor_absoluto)
		dw_detalle.object.presupuesto_periodo[ll_donde]         = listr_saldos_grupo.presupuesto_periodo
		dw_detalle.object.valor_periodo_ant[ll_donde]           = listr_saldos_grupo.valor_periodo_ant
		ls_linea = ' -----------------------------------------------------------------------------------------------------------------------------------------------------'
	else
		ls_linea = ""
	end if

	if cbx_version_para_chequeo.checked then
		dw_detalle.object.nombre_grupo[ll_donde] = string(ll_nivel,"###0")+"-"+string(ls_codigo_grupo)+" "+ls_nombre_grupo+ls_linea
	else
		dw_detalle.object.nombre_grupo[ll_donde] = space((li_nivel_indentacion -1) * 5)+ls_nombre_grupo
	end if		

	//Esto lo hacemos para detectar los grupos con formula
	ids_gpos_totaliza.setfilter("conta_bal_grup_codigo = '"+ls_codigo_grupo+"'")
	ids_gpos_totaliza.filter()

	ll_total_gpos_totaliza = ids_gpos_totaliza.rowcount()
	
	if ll_total_gpos_totaliza > 0 then
		ids_grupos2.object.con_formula[ll_indice] = "S"	
	end if
	//

	if f_cargar_rama(ls_codigo_grupo,ll_nivel,ls_mostrar_subgrupos,li_nivel_indentacion) > 0 then
		dw_detalle.object.muestra_oculta_grupo[ll_donde] = "-"	
	end if

	ids_Grupos2.SetFilter( "conta_bal_grup_codigo = '" + arg_grupo_nivel_superior + "'" )
	ids_Grupos2.Filter()
	ids_Grupos2.SetSort("orden A")
	ids_Grupos2.Sort( )	

next

return ll_total_grupos

end function

public subroutine f_calcular_variacion_sobre_ant ();long   ll_indice,ll_total
dec    ld_variacion_sobre_ant,ld_porc_variacion_sobre_ant
string ls_codigo_grupo

istr_saldos_grupo listr_saldos_grupo

ll_total = dw_detalle.rowcount()

for ll_indice = 1 to ll_total
	ls_codigo_grupo    = dw_detalle.object.codigo_grupo[ll_indice]	

	listr_saldos_grupo = f_importes_grupo(ls_codigo_grupo)

	ld_variacion_sobre_ant = listr_saldos_grupo.valor_periodo - listr_saldos_grupo.valor_periodo_ant

	if listr_saldos_grupo.valor_periodo_ant <> 0 then
		ld_porc_variacion_sobre_ant = (ld_variacion_sobre_ant / listr_saldos_grupo.valor_periodo_ant ) * 100
	else
		if ld_variacion_sobre_ant = 0 then
			ld_porc_variacion_sobre_ant = 0
		else
			if ld_variacion_sobre_ant > 0 then
				ld_porc_variacion_sobre_ant = 100
			else
				ld_porc_variacion_sobre_ant = -100
			end if			
		end if
	end if

	dw_detalle.object.variacion_sobre_ant[ll_indice]      = ld_variacion_sobre_ant
	dw_detalle.object.porc_variacion_sobre_ant[ll_indice] = ld_porc_variacion_sobre_ant

next

end subroutine

event close;call super::close;dw_detalle.reset()

end event

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")

end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")

end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")

end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta Balances 2011"

This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)


is_moneda         = f_moneda_empresa(codigo_empresa)
is_mascara_moneda = f_mascara_moneda(is_moneda)
is_moneda         = f_nombre_moneda_abr(is_moneda)

//long ll_color
//ll_color = rgb(0,107,159)
//messagebox("rgb(0,107,159)",string(ll_color))
//ll_color = rgb(0,151,223)
//messagebox("rgb(0,151,223)",string(ll_color))
//ll_color = rgb(32,183,255)
//messagebox("rgb(32,183,255)",string(ll_color))



end event

on w_con_conta_bal_original.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_calcular=create cb_calcular
this.uo_balance=create uo_balance
this.gb_2=create gb_2
this.gb_3=create gb_3
this.uo_manejo=create uo_manejo
this.pb_excel=create pb_excel
this.cbx_con_cuentas=create cbx_con_cuentas
this.cbx_version_para_chequeo=create cbx_version_para_chequeo
this.cbx_cuentas_importe_cero=create cbx_cuentas_importe_cero
this.cbx_un_ejercicio=create cbx_un_ejercicio
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_calcular
this.Control[iCurrent+8]=this.uo_balance
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.uo_manejo
this.Control[iCurrent+12]=this.pb_excel
this.Control[iCurrent+13]=this.cbx_con_cuentas
this.Control[iCurrent+14]=this.cbx_version_para_chequeo
this.Control[iCurrent+15]=this.cbx_cuentas_importe_cero
this.Control[iCurrent+16]=this.cbx_un_ejercicio
this.Control[iCurrent+17]=this.gb_4
end on

on w_con_conta_bal_original.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_calcular)
destroy(this.uo_balance)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.uo_manejo)
destroy(this.pb_excel)
destroy(this.cbx_con_cuentas)
destroy(this.cbx_version_para_chequeo)
destroy(this.cbx_cuentas_importe_cero)
destroy(this.cbx_un_ejercicio)
destroy(this.gb_4)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")

end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_conta_bal_original
integer x = 2240
integer y = 28
integer taborder = 110
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_conta_bal_original
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_conta_bal_original
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_conta_bal_original
integer x = 4507
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_conta_bal_original
integer x = 4498
integer y = 148
integer taborder = 0
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = uo_balance.em_campo.text+" desde '"+em_fechadesde.text +"' hasta '"+em_fechahasta.text+"'"
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

dw_detalle.Object.DataWindow.Zoom = 93

u_imp.event ue_imprimir(dw_detalle)

destroy u_imp

dw_detalle.Object.DataWindow.Zoom = 100

end event

type dw_detalle from datawindow within w_con_conta_bal_original
integer x = 14
integer y = 260
integer width = 4613
integer height = 2176
string dataobject = "dw_con_conta_bal"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type em_fechadesde from u_em_campo within w_con_conta_bal_original
integer x = 14
integer y = 152
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_conta_bal_original
integer x = 366
integer y = 152
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33554431
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_conta_bal_original
integer y = 104
integer width = 704
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fechas calculo"
end type

type cb_calcular from commandbutton within w_con_conta_bal_original
integer x = 3269
integer y = 144
integer width = 635
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcular"
end type

event clicked;long ll_registros 


if cbx_version_para_chequeo.checked then
	dw_detalle.dataobject = "dw_con_cuenta_resultados_chequeo"
else	
	dw_detalle.dataobject = "dw_con_conta_bal"
end if

dw_detalle.settransobject(sqlca)

dw_detalle.reset()

ll_registros = f_cargar_arbol()//f_cargar(dw_detalle)



end event

type uo_balance from u_em_campo_2 within w_con_conta_bal_original
event destroy ( )
integer x = 727
integer y = 152
integer width = 1033
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_balance.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_balance.em_campo.text=f_conta_bal_cab_descripcion(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF

is_balance = uo_balance.em_codigo.text

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_conta_bal_cab"
ue_filtro     = ""

end event

type gb_2 from groupbox within w_con_conta_bal_original
integer x = 709
integer y = 104
integer width = 1070
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Balance"
end type

type gb_3 from groupbox within w_con_conta_bal_original
integer x = 3250
integer y = 104
integer width = 786
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_manejo from u_manejo_datawindow within w_con_conta_bal_original
integer x = 4023
integer y = 100
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle

dw_data.SetTransObject(SQLCA)



end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_excel from picturebutton within w_con_conta_bal_original
integer x = 3904
integer y = 144
integer width = 114
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom043!"
alignment htextalign = left!
end type

event clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_detalle.rowcount()



if ll_registros > 0 then

	

	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then

		//dw_detalle.SaveAs(ls_ruta_fichero, Excel!, true)



		uf_save_dw_as_excel(dw_detalle,ls_ruta_fichero)



	end if



end if

end event

type cbx_con_cuentas from checkbox within w_con_conta_bal_original
integer x = 1806
integer y = 140
integer width = 517
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar cuentas"
end type

type cbx_version_para_chequeo from checkbox within w_con_conta_bal_original
boolean visible = false
integer x = 3529
integer y = 24
integer width = 654
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Versión para chequeo"
end type

type cbx_cuentas_importe_cero from checkbox within w_con_conta_bal_original
integer x = 2359
integer y = 140
integer width = 882
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar cuentas con importe 0"
end type

type cbx_un_ejercicio from checkbox within w_con_conta_bal_original
integer x = 2359
integer y = 188
integer width = 882
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Un solo ejercicio"
end type

type gb_4 from groupbox within w_con_conta_bal_original
integer x = 1783
integer y = 104
integer width = 1467
integer height = 148
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

