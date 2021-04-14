$PBExportHeader$w_mant_reclamaciones_gno.srw
forward
global type w_mant_reclamaciones_gno from wc_mantenimientos_tab
end type
type dw_cliente_final from u_datawindow within pagina_1
end type
type cb_anyadir_fase from commandbutton within pagina_2
end type
type cb_borrar_fase from commandbutton within pagina_2
end type
type dw_detalle_fase from datawindow within pagina_2
end type
type dw_situacion_final_fase from u_datawindow within pagina_2
end type
type gb_8 from groupbox within pagina_2
end type
type st_3 from statictext within pagina_3
end type
type em_fechadesde from u_em_campo within pagina_3
end type
type st_4 from statictext within pagina_3
end type
type em_fechahasta from u_em_campo within pagina_3
end type
type cb_consulta_detalle_fras from commandbutton within pagina_3
end type
type dw_detalle_facturas_cliente from datawindow within pagina_3
end type
type gb_3 from groupbox within pagina_3
end type
type gb_2 from groupbox within pagina_3
end type
type cb_borrar_linea_detalle from commandbutton within pagina_3
end type
type st_7 from statictext within pagina_3
end type
type em_albaran from u_em_campo within pagina_3
end type
type st_8 from statictext within pagina_3
end type
type em_factura from u_em_campo within pagina_3
end type
type st_9 from statictext within pagina_3
end type
type uo_articulo from u_em_campo_2 within pagina_3
end type
type dw_detalle_documento from u_datawindow within pagina_4
end type
type gb_6 from groupbox within pagina_4
end type
type cb_anyadir_documento from commandbutton within pagina_4
end type
type cb_borrar_documento from commandbutton within pagina_4
end type
type st_5 from statictext within pagina_5
end type
type em_fechadesdeabono from u_em_campo within pagina_5
end type
type st_6 from statictext within pagina_5
end type
type em_fechahastaabono from u_em_campo within pagina_5
end type
type cb_consulta_abonos from commandbutton within pagina_5
end type
type cb_borrar_abono from commandbutton within pagina_5
end type
type gb_5 from groupbox within pagina_5
end type
type gb_4 from groupbox within pagina_5
end type
type dw_detalle_abonos_cliente from datawindow within pagina_5
end type
type cb_1 from commandbutton within pagina_5
end type
type gb_10 from groupbox within pagina_5
end type
type cb_anyadir_fra_proveedor from commandbutton within pagina_6
end type
type cb_borrar_fra_proveedor from commandbutton within pagina_6
end type
type gb_7 from groupbox within pagina_6
end type
type st_2 from statictext within w_mant_reclamaciones_gno
end type
type uo_cliente from u_em_campo_2 within w_mant_reclamaciones_gno
end type
type gb_1 from groupbox within w_mant_reclamaciones_gno
end type
type st_descripcion_reclamacion from statictext within w_mant_reclamaciones_gno
end type
type pb_calculadora from picturebutton within w_mant_reclamaciones_gno
end type
type report from datawindow within w_mant_reclamaciones_gno
end type
type pb_1 from upb_imprimir within w_mant_reclamaciones_gno
end type
type dw_mail from datawindow within w_mant_reclamaciones_gno
end type
type gb_9 from groupbox within w_mant_reclamaciones_gno
end type
end forward

global type w_mant_reclamaciones_gno from wc_mantenimientos_tab
integer x = 672
integer y = 264
integer width = 3776
integer height = 2648
st_2 st_2
uo_cliente uo_cliente
gb_1 gb_1
st_descripcion_reclamacion st_descripcion_reclamacion
pb_calculadora pb_calculadora
report report
pb_1 pb_1
dw_mail dw_mail
gb_9 gb_9
end type
global w_mant_reclamaciones_gno w_mant_reclamaciones_gno

type variables





datastore ids_mail
string is_confirma_correo
dwItemStatus i_status
boolean ib_modifi = true
end variables

forward prototypes
public subroutine f_mostrar_resumen_reclamacion ()
public function boolean wf_confirmaciones (long al_registro)
public subroutine wf_mensaje_mail (integer ai_fila)
public subroutine wf_enviar_correo ()
end prototypes

public subroutine f_mostrar_resumen_reclamacion ();long    indice,total,anyo,albaran,anyo_factura,linea_albaran,indice2,total2,donde, factura,linea_factura,ll_existe_albaran
string  articulo,calidad,unidad,sel
dec     cantidad_reclamacion,cantidad_abonos,importe_reclamacion,importe_abonos,gastos_reclamacion
dec     cantidad_fra,neto,cambio,importe_fobs,importe_fletes,fletes_cobrados,importe_rappel	
dec     ld_total_gastos,ld_total_importe_reclamado
boolean articulo_insertado
string  ls_tipo
datastore detalle_abonos
total = dw_pag3.rowcount()

dw_pag7.reset()

for indice = 1 to total
	anyo                 = dw_pag3.object.ven_reclamaciones_detalle_anyo[indice]
	albaran              = dw_pag3.object.ven_reclamaciones_detalle_albaran[indice]
	linea_albaran        = dw_pag3.object.ven_reclamaciones_detalle_linea_albaran[indice]
	cantidad_reclamacion = dw_pag3.object.ven_reclamaciones_detalle_cantidad[indice]
	factura					= dw_pag3.object.vista_venlialb_reclamaciones_factura[indice]
	linea_factura			= dw_pag3.object.vista_venlialb_reclamaciones_linea_factura[indice]
	anyo_factura			= dw_pag3.object.vista_venlialb_reclamaciones_anyo[indice]
//	select articulo,					calidad,					cantidad,		
//			 neto - impdtopp,			gastos_reclamacion,	importe_fobs,
//			 importe_fletes,			fletes_cobrados,		importe_rappel	
//	into   :articulo,					:calidad,				:cantidad_fra,	
//			 :neto,						:gastos_reclamacion,	:importe_fobs,
//			 :importe_fletes,			:fletes_cobrados,		:importe_rappel	
//	from   venlifac
//	where  empresa       = :codigo_empresa
//	and    anyo          = :anyo
//	and    factura       = :factura
//	and    linea_factura = :linea_factura;

ll_existe_albaran = 0

select count(*)
into   :ll_existe_albaran
from   venlialb
where  empresa       = :codigo_empresa
and    anyo          = :anyo
and    albaran       = :albaran
and    linea		   = :linea_albaran;

if isnull(ll_existe_albaran) then ll_existe_albaran = 0

if ll_existe_albaran > 0 then
	
	ls_tipo = "A" /// Albaran

	select articulo,					calidad,					cantidad,		
			 neto - impdtopp		
	into   :articulo,					:calidad,				:cantidad_fra,	
			 :neto						
	from   venlialb
	where  empresa       = :codigo_empresa
	and    anyo          = :anyo
	and    albaran       = :albaran
	and    linea		   = :linea_albaran;
	
	cambio = f_cambio_venalb(codigo_empresa,anyo,albaran)
else
	
	ls_tipo = "F" /// Factura
	
	select articulo,					calidad,					cantidad,		
			 neto - impdtopp	, gastos_reclamacion	
	into   :articulo,					:calidad,				:cantidad_fra,	
			 :neto, :gastos_reclamacion						
	from   venlifac
	where  empresa       = :codigo_empresa
	and    anyo          = :anyo_factura
	and    factura       = :factura
	and    linea_factura		   = :linea_factura;
	
	cambio = f_cambio_venfac(codigo_empresa,anyo_factura,factura)
end if
	
	if isnull(neto)               then neto = 0
	if isnull(gastos_reclamacion) then gastos_reclamacion = 0
	if isnull(importe_fobs)       then importe_fobs = 0
	if isnull(importe_fletes)     then importe_fletes = 0
	if isnull(fletes_cobrados)    then fletes_cobrados = 0
	if isnull(importe_rappel)     then importe_rappel = 0
	
	
	
		
	neto                = neto / cambio	
	importe_rappel      = importe_rappel / cambio
	neto                = neto + fletes_cobrados - (importe_fobs + importe_fletes + importe_rappel)
	importe_reclamacion = (neto / cantidad_fra) * cantidad_reclamacion
	
	donde = dw_pag7.find("articulo = '"+articulo+"' and calidad = '"+calidad+"'",1,dw_pag7.rowcount())
	
	if donde > 0 then
		articulo_insertado   = true
		cantidad_reclamacion = cantidad_reclamacion + dw_pag7.object.cantidad_reclamacion[donde] 
		importe_reclamacion  = importe_reclamacion  + dw_pag7.object.importe_reclamacion[donde] 
		gastos_reclamacion   = gastos_reclamacion   + dw_pag7.object.importe_gastos[donde] 		
	else
		articulo_insertado   = false
		donde = dw_pag7.insertrow(0)
		dw_pag7.object.empresa[donde]        = codigo_empresa
		dw_pag7.object.articulo[donde]       = articulo
		dw_pag7.object.calidad[donde]        = calidad
		dw_pag7.object.unidad[donde]         = f_unidad_articulo(codigo_empresa,articulo)
		dw_pag7.object.cantidad_abono[donde] = 0
		dw_pag7.object.importe_abono[donde]  = 0
	end if
		
	dw_pag7.object.cantidad_reclamacion[donde] = cantidad_reclamacion
	dw_pag7.object.importe_reclamacion[donde]  = importe_reclamacion
	dw_pag7.object.importe_gastos[donde]       = gastos_reclamacion
	
	if not(articulo_insertado) then
		total2 = dw_pag5.rowcount() 
		
		for indice2 = 1 to total2
			anyo    = dw_pag5.object.venfac_anyo[indice2]
			factura = dw_pag5.object.venfac_factura[indice2]			
			
//			select sum(cantidad),			sum(neto - impdtopp),sum(importe_fobs),
//					 sum(importe_fletes),	sum(fletes_cobrados),sum(importe_rappel)	
//			into   :cantidad_abonos,		:importe_abonos,		:importe_fobs,
//					 :importe_fletes,			:fletes_cobrados,		:importe_rappel	
//			from   venlifac
//			where  empresa       = :codigo_empresa
//			and    anyo          = :anyo
//			and    factura       = :factura
//			and    articulo      = :articulo
//			and    calidad       = :calidad;
			
			select sum(cantidad),			sum(neto - impdtopp)
			into   :cantidad_abonos,		:importe_abonos
			from   venlifac
			where  empresa       = :codigo_empresa
			and    anyo          = :anyo
			and    factura       = :factura
			and    articulo      = :articulo
			and    calidad       = :calidad;			
			
			if isnull(importe_abonos)     then importe_abonos = 0			
			if isnull(importe_fobs)       then importe_fobs = 0
			if isnull(importe_fletes)     then importe_fletes = 0
			if isnull(fletes_cobrados)    then fletes_cobrados = 0
			if isnull(importe_rappel)     then importe_rappel = 0
			
			cambio = f_cambio_venfac(codigo_empresa,anyo,factura)
			
			importe_abonos      = importe_abonos / cambio	
			importe_rappel      = importe_rappel / cambio
			importe_abonos      = importe_abonos + fletes_cobrados - (importe_fobs + importe_fletes + importe_rappel)
			
			cantidad_abonos = cantidad_abonos + dw_pag7.object.cantidad_abono[donde]
			importe_abonos  = importe_abonos  + dw_pag7.object.importe_abono[donde]
			
			dw_pag7.object.cantidad_abono[donde] = cantidad_abonos
			dw_pag7.object.importe_abono[donde]  = importe_abonos
		next
		
	end if
next

total = dw_pag5.rowcount() 

for indice = 1 to total
	anyo    = dw_pag5.object.venfac_anyo[indice]
	factura = dw_pag5.object.venfac_factura[indice]			
	
	sel     = "select articulo,calidad "+&
				 "from   venlifac "+&
				 "where  empresa = '"+codigo_empresa+"' "+&
				 "and    anyo    = "+string(anyo,"####")+" "+&
				 "and    factura = "+string(factura,"########")+" "+&
				 "group  by articulo,calidad"
				 
	detalle_abonos = f_cargar_cursor(sel)
	
	total2 = detalle_abonos.rowcount()
	
	for indice2 = 1 to total2
		
		articulo = detalle_abonos.object.articulo[indice2]
		calidad  = detalle_abonos.object.calidad[indice2]
		
		if dw_pag3.find("vista_venlialb_reclamaciones_articulo = '"+articulo+"' and vista_venlialb_reclamaciones_calidad = '"+calidad+"'",1,dw_pag3.rowcount()) = 0 then						
			
//			select sum(cantidad),			sum(neto - impdtopp),sum(importe_fobs),
//					 sum(importe_fletes),	sum(fletes_cobrados),sum(importe_rappel)	
//			into   :cantidad_abonos,		:importe_abonos,		:importe_fobs,
//					 :importe_fletes,			:fletes_cobrados,		:importe_rappel	
//			from   venlifac
//			where  empresa       = :codigo_empresa
//			and    anyo          = :anyo
//			and    factura       = :factura
//			and    articulo      = :articulo
//			and    calidad       = :calidad;

			

				select sum(cantidad),			sum(neto - impdtopp)	
				into   :cantidad_abonos,		:importe_abonos
				from   venlifac
				where  empresa       = :codigo_empresa
				and    anyo          = :anyo
				and    factura       = :factura
				and    articulo      = :articulo
				and    calidad       = :calidad;
				
			cambio = f_cambio_venfac(codigo_empresa,anyo,factura)
			
			if isnull(importe_abonos)     then importe_abonos = 0			
			if isnull(importe_fobs)       then importe_fobs = 0
			if isnull(importe_fletes)     then importe_fletes = 0
			if isnull(fletes_cobrados)    then fletes_cobrados = 0
			if isnull(importe_rappel)     then importe_rappel = 0
			
			
			
			importe_abonos      = importe_abonos / cambio	
			importe_rappel      = importe_rappel / cambio
			importe_abonos      = importe_abonos + fletes_cobrados - (importe_fobs + importe_fletes + importe_rappel)
			
			donde = dw_pag7.find("articulo = '"+articulo+"' and calidad = '"+calidad+"'",1,dw_pag7.rowcount())			
			if donde = 0 then
				donde = dw_pag7.insertrow(0)
				dw_pag7.object.empresa[donde]        = codigo_empresa
				dw_pag7.object.articulo[donde]       = articulo
				dw_pag7.object.calidad[donde]        = calidad
				dw_pag7.object.unidad[donde]         = f_unidad_articulo(codigo_empresa,articulo)
				dw_pag7.object.cantidad_abono[donde] = 0
				dw_pag7.object.importe_abono[donde]  = 0
				dw_pag7.object.cantidad_reclamacion[donde] = 0
				dw_pag7.object.importe_reclamacion[donde]  = 0
				dw_pag7.object.importe_gastos[donde]       = 0
			end if
			
			cantidad_abonos = cantidad_abonos + dw_pag7.object.cantidad_abono[donde]
			importe_abonos  = importe_abonos  + dw_pag7.object.importe_abono[donde]
			
			dw_pag7.object.cantidad_abono[donde] = cantidad_abonos
			dw_pag7.object.importe_abono[donde]  = importe_abonos
		end if
	next
next

destroy detalle_abonos
end subroutine

public function boolean wf_confirmaciones (long al_registro);string ls_confirma_lineas, ls_confirma_documentos
string ls_confirma_abonos, ls_confirma_gastos
string ls_situacion, ls_tipo,ls_causa, ls_fase

boolean lb_ret = true


if al_registro > 0 then
	
	ls_tipo     = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]
	ls_causa		= apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]
	ls_fase     = apartados.pagina_2.dw_detalle_fase.object.codigo_ven_reclamaciones_fases[apartados.pagina_2.dw_detalle_fase.getrow()]
	
	if apartados.pagina_2.dw_situacion_final_fase.rowcount() > 0 then
	
		ls_situacion = apartados.pagina_2.dw_situacion_final_fase.object.situacion[al_registro]
		
		select confirma_detalle_lineas, confirma_documentos, confirma_abonos_realizados,
		confirma_gastos_ocasionados, confirma_correo into :ls_confirma_lineas, :ls_confirma_documentos,
													:ls_confirma_abonos, :ls_confirma_gastos,:is_confirma_correo
		from ven_reclamaciones_rutas_fases_ti
		where empresa =:codigo_empresa
		and   codigo_ven_reclamaciones_tipos = :ls_tipo
		and   codigo_ven_reclamaciones_causa = :ls_causa
		and   fase =:ls_fase
		and   situacion = :ls_situacion
		using sqlca;
		
		////
		
		//// Control lineas de detalle
		if ls_confirma_lineas = 'S' then
			if apartados.pagina_3.dw_pagina3.rowcount( ) = 0 then
				
				messagebox ( "Atención", "Debe seleccionar un Albaran o Factura en detalle lineas")
				lb_ret = false
				return lb_ret
			else
				lb_ret = true
			end if
		end if
		
		//// Control Documentos
		if ls_confirma_documentos = 'S' then
			if apartados.pagina_4.dw_pagina4.rowcount( ) = 0 then
				
				messagebox ( "Atención", "Debe añadir al menos un Documento")
				lb_ret = false
				return lb_ret
			else
				lb_ret = true
			end if
		end if
		
		//// Control Abonos realizados
		if ls_confirma_abonos = 'S' then
			if apartados.pagina_5.dw_pagina5.rowcount( ) = 0 then
				
				messagebox ( "Atención", "Debe seleccionar una Factura en Abonos Realizados")
				lb_ret = false
				return lb_ret
			else
				lb_ret = true
			end if
		end if
		
		//// Control lineas de detalle
		if ls_confirma_lineas = 'S' then
			if apartados.pagina_3.dw_pagina3.rowcount( ) = 0 then
				
				messagebox ( "Atención", "Debe seleccionar un Albaran o Factura en detalle lineas")
				lb_ret = false
				return lb_ret
			else
				lb_ret = true
			end if
		end if
		
	end if //ffo
		
			
	
end if

return lb_ret
end function

public subroutine wf_mensaje_mail (integer ai_fila);//// Función para añadir en la ids_mail
/// el cuerpo del mensaje a enviar
string ls_codigo
string ls_cliente, ls_tipo,ls_causa,ls_descripcion,ls_articulo
string ls_formato, ls_modelo, ls_calidad,ls_operario_carga,ls_operario_prepara
string ls_texto_reclamacion,ls_texto_fase, ls_fase
integer li_tono, li_calibre,l,li_anyo,ll_fila, ll_cont
decimal lc_unidades_compras, lc_unidades_afectadas
decimal{0} lc_albaran, lc_factura
string ls_mensaje,ls_nombre_fichero, ls_email, ls_correo, ls_mail[]
string ls_factura,ls_albaran,ls_tono,ls_calibre
datetime ld_fecha
string ls_tipo_unidad,ls_des_unidad 

if is_confirma_correo = 'S' then

	ll_fila = ids_mail.insertrow(0)
	
	ls_codigo = sle_valor.text
	ls_cliente = uo_cliente.em_codigo.text + "-" + uo_cliente.em_campo.text 
	ld_fecha		=  apartados.pagina_1.dw_pagina1.object.fecha[1]
	ls_tipo	  = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]
	ls_tipo	  = f_nombre_tipos_reclamaciones( codigo_empresa ,  ls_tipo  )
	ls_descripcion = apartados.pagina_1.dw_pagina1.object.descripcion[1]
	ls_causa       = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]
	ls_causa  		= f_nombre_causas( codigo_empresa ,  ls_causa )
	ls_fase			= apartados.pagina_2.dw_pagina2.object.compute_1[ai_fila]
	if f_nulo_blanco(ls_descripcion) then ls_descripcion = ""
	if f_nulo_blanco(ls_causa) then ls_causa = ""
	if f_nulo_blanco(ls_tipo) then ls_tipo = ""
	if f_nulo_blanco(ls_fase) then ls_fase = ""
	
	
//	ls_mensaje = ls_mensaje + " " + "~n"
//	ls_mensaje = ls_mensaje + " " + "~n"
//	ls_mensaje = ls_mensaje + " " + "~n"
//	ls_mensaje = ls_mensaje + "Codigo Reclamacion: " + sle_valor.text + "~n"
//	ls_mensaje = ls_mensaje + "Cliente: " + ls_cliente + "~n"
//	ls_mensaje = ls_mensaje + "Tipo: " + ls_tipo + "-" + ls_descripcion + "~n"
//	ls_mensaje = ls_mensaje + "Causa: " + ls_causa + "~n"
//	ls_mensaje = ls_mensaje + " " + "~n"
	
	ls_mensaje = ls_mensaje + char(10) + char(13)
	ls_mensaje = ls_mensaje + char(10) + char(13)
	ls_mensaje = ls_mensaje + char(10) + char(13)
	ls_mensaje = ls_mensaje + "Código Reclamación: " + sle_valor.text + char(10) + char(13)
	ls_mensaje = ls_mensaje + "Cliente: " + ls_cliente + char(10) + char(13)
	ls_mensaje = ls_mensaje + "Tipo: " + ls_tipo + "-" + ls_descripcion + char(10) + char(13)
	ls_mensaje = ls_mensaje + "Causa: " + ls_causa + char(10) + char(13)
	ls_mensaje = ls_mensaje + " " + char(10) + char(13)
	
	for l = 1 to apartados.pagina_3.dw_pagina3.rowcount( )
		
		lc_albaran     = apartados.pagina_3.dw_pagina3.object.ven_reclamaciones_detalle_albaran[l]
		lc_factura     = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_factura[l]
		li_anyo			= year(date(apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_falbaran[l]))
		ls_articulo    = apartados.pagina_3.dw_pagina3.object.compute_4[l]
		ls_tipo_unidad = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_tipo_unidad[l]
		ls_des_unidad = apartados.pagina_3.dw_pagina3.object.compute_5[l]
		ls_calidad		= apartados.pagina_3.dw_pagina3.object.compute_3[l]
		li_tono			= apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_tono[l]
		li_calibre     = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_calibre[l]
		lc_unidades_compras = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_cantidad[l]
		lc_unidades_afectadas = apartados.pagina_3.dw_pagina3.object.ven_reclamaciones_detalle_cantidad[l]
		
		if f_nulo_cero(lc_albaran) then
				ls_albaran = ""
			else
				ls_albaran = string(lc_albaran)
		end if
		if f_nulo_cero(lc_factura) then
			ls_factura = ""
		else
			ls_factura = string(lc_factura)
		end if
		
		if f_nulo_cero(li_anyo) then li_anyo = year(today())
		
		if f_nulo_cero(li_tono) then
			ls_tono = ""
		else
			ls_tono = string(li_tono)
		end if
		
		if f_nulo_cero(li_calibre) then
			ls_calibre = ""
		else
			ls_calibre = string(li_calibre)
		end if
		/// Mensaje
//		ls_mensaje     = ls_mensaje + "CODIGO ALBARAN Nº " + ls_albaran + "~n"
//		ls_mensaje     = ls_mensaje + "CODIGO FACTURA Nº " + ls_factura + "/" + string(li_anyo)+ "~n"
//		ls_mensaje = ls_mensaje + " " + "~n"
//		ls_mensaje = ls_mensaje + " " + "~n"
//		ls_mensaje     = ls_mensaje + "Producto: " + ls_articulo + "-" + ls_des_unidad + "~n"
//		ls_mensaje     = ls_mensaje + "Calidad: " + ls_calidad + "~n"
//		ls_mensaje     = ls_mensaje + "Tono: " + ls_tono + "~n"
//		ls_mensaje     = ls_mensaje + "Calibre: " + ls_calibre + "~n"
//		ls_mensaje     = ls_mensaje + "Unid. Compradas: " + string(lc_unidades_compras,"###,###.0#") + "~n"
//		ls_mensaje     = ls_mensaje + "Unid. Afectadas: " + string(lc_unidades_afectadas,"###,###.0#") + "~n"
//		ls_mensaje = ls_mensaje + " " + "~n"
		
		
		ls_mensaje     = ls_mensaje + "CODIGO ALBARAN Nº " + ls_albaran + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "CODIGO FACTURA Nº " + ls_factura + char(10) +  char(13)
		ls_mensaje = ls_mensaje + " " + char(10) +  char(13)
		ls_mensaje = ls_mensaje + " " + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Producto: " + ls_articulo + "-" + ls_des_unidad + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Calidad: " + ls_calidad + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Tono: " + ls_tono + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Calibre: " + ls_calibre + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Unid. Compradas: " + string(lc_unidades_compras,"###,###.0#") + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Unid. Afectadas: " + string(lc_unidades_afectadas,"###,###.0#") + char(10) +  char(13)
		ls_mensaje = ls_mensaje + " " + char(10) +  char(13)
		
		ls_operario_prepara  = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_operario_prepa[l]
//		ls_operario_carga = apartados.pagina_3.dw_pagina3.object.vista_venlialb_reclamaciones_operario[l]
		if f_nulo_blanco(ls_operario_carga) then
			ls_operario_carga = ""
		end if
		if f_nulo_blanco(ls_operario_prepara) then
			ls_operario_prepara = ls_operario_carga
		end if
		
		ls_operario_prepara = f_nombre_almoperarios_abr(codigo_empresa,ls_operario_prepara )
		ls_operario_carga	  = f_nombre_almoperarios_abr(codigo_empresa,ls_operario_carga )
//		ls_mensaje     = ls_mensaje + "Operario que lo preparó: " + ls_operario_prepara + "~n"
//		ls_mensaje     = ls_mensaje + "Operario que lo cargó: " + ls_operario_carga + "~n"
		
		ls_mensaje     = ls_mensaje + "Operario que lo preparó: " + ls_operario_prepara + char(10) +  char(13)
		ls_mensaje     = ls_mensaje + "Operario que lo cargó: " + ls_operario_carga + char(10) +  char(13)
	next
	
		
		
		ls_texto_reclamacion = apartados.pagina_1.dw_pagina1.object.texto[1]
		ls_texto_fase			= apartados.pagina_2.dw_detalle_fase.object.observaciones[ai_fila]
		if f_nulo_blanco(ls_texto_reclamacion) then ls_texto_reclamacion = ""
		if f_nulo_blanco(ls_texto_fase) then ls_texto_fase = ""
		
//		ls_mensaje = ls_mensaje + " " + "~n"
//		ls_mensaje = ls_mensaje + "DESCRIPCIÓN DE LA RECLAMACIÓN:" + "~n"
//		ls_mensaje = ls_mensaje + "" +ls_texto_reclamacion + "~n"
//		ls_mensaje = ls_mensaje + " " + "~n"
//		ls_mensaje = ls_mensaje + "DESCRIPCIÓN DE LA FASE: (" + ls_fase + ")" +  "~n"
//		ls_mensaje = ls_mensaje + "" + ls_texto_fase +  "~n"
//		
		ls_mensaje = ls_mensaje + " " + char(10) + char(13)
		ls_mensaje = ls_mensaje + "DESCRIPCIÓN DE LA RECLAMACIÓN:" + char(10) +  char(13)
		ls_mensaje = ls_mensaje + "" +ls_texto_reclamacion + char(10) +  char(13)
		ls_mensaje = ls_mensaje + " " + char(10) +  char(13)
		ls_mensaje = ls_mensaje + "DESCRIPCIÓN DE LA FASE: (" + ls_fase + ")" + char(10) +  char(13)
		ls_mensaje = ls_mensaje + "" + ls_texto_fase + char(10) +  char(13)
		
		ids_mail.object.mensaje[ll_fila] = ls_mensaje
		ids_mail.object.tipo[ll_fila] = ls_tipo_unidad
	

	end if
end subroutine

public subroutine wf_enviar_correo ();string ls_cadena,ls_correo,ls_usuario,ls_tipo,ls_sel,ls_codigo_grupo,ls_codigo_reclamacion
long l,k, orden,h,g,r,tt
string ls_mensaje, asunto, observaciones
string ls_cliente, ls_comercial,ls_usuario_destino
string ls_tipo_unidad,ls_ficheros,correo1
datastore ds_usuarios, ds_documentos
ls_cadena = ""
string ls_empresa,ls_reclamacion,ls_documento,ls_clave



	

/// Buscamos en la tabla de usuarios
/// según el grupo informativo del tipo de reclamación
if ids_mail.rowcount() > 0 then
	
	ls_tipo = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]
	ls_codigo_reclamacion = sle_valor.text
	ls_cliente   = uo_cliente.em_codigo.text
	
	
	select 	codigo_grupo into :ls_codigo_grupo
		from ven_reclamaciones_tipos
		where empresa = :codigo_empresa
		and   codigo  = :ls_tipo
		using sqlca;
		
	if not f_nulo_blanco(ls_tipo) then	
		
		ls_sel = "select usuario from ven_reclamaciones_grupos_usua where empresa = '" + codigo_empresa + "'" + &
		         " and codigo_grupo = '"+ ls_codigo_grupo + "'"
					
			ds_usuarios = f_cargar_cursor(ls_sel)
			
			
		for l = 1 to ids_mail.rowcount()
			
				
			ls_mensaje = ids_mail.object.mensaje[l]
			ls_tipo	  = ids_mail.object.tipo[l]
			
			for k = 1 to ds_usuarios.rowcount()
				
				ls_usuario = ds_usuarios.object.usuario[k]
				ls_tipo_unidad = f_usuarios_v_unidad(ls_usuario)
				choose case ls_tipo_unidad
					case '1'/// BASE
						if ls_tipo = ls_tipo_unidad then
							ls_correo = f_usuarios_v_email(ls_usuario)
							if not f_nulo_blanco(ls_correo) then
				   		 ls_cadena = ls_cadena + ls_correo +";"
							end if
						end if
					
					case '0' /// PIEZA ESPECIAL
						if ls_tipo = ls_tipo_unidad then
							ls_correo = f_usuarios_v_email(ls_usuario)
							if not f_nulo_blanco(ls_correo) then
				   	   	ls_cadena = ls_cadena + ls_correo +";"
							end if
						end if
					case else
						/// AMBOS
						ls_correo = f_usuarios_v_email(ls_usuario)
						if not f_nulo_blanco(ls_correo) then
				   		ls_cadena = ls_cadena + ls_correo +";"
						end if
			
				end choose


				
				 
			next
			
			
			
			/// Area Manager
			select comercialundefasa into :ls_comercial
			from venclientes
			where empresa = :codigo_empresa
			and   codigo  = :ls_cliente
			using sqlca;
			
			ls_usuario = ""
			
			if not f_nulo_blanco(ls_comercial) then
				select nombrecomercial into :ls_usuario
				from agentesundefasa
				where empresa= :codigo_empresa
				and   comercial = :ls_comercial
				using sqlca;
				
				if not f_nulo_blanco(ls_usuario) then
					ls_correo = f_usuarios_v_email(ls_usuario)
					if not f_nulo_blanco(ls_correo) then
						ls_cadena = ls_cadena + ls_correo +";"
					end if
				end if
			end if
			
			
			f_get_token_der(ls_cadena,";")
			
			//// Añadir documentos al correo
			for h = 1 to apartados.pagina_4.dw_detalle_documento.rowcount( )
			
			   ls_empresa = apartados.pagina_4.dw_detalle_documento.object.empresa[h]
				ls_cliente = apartados.pagina_4.dw_detalle_documento.object.cliente[h] 
				ls_reclamacion = apartados.pagina_4.dw_detalle_documento.object.reclamacion[h]
				ls_documento   = apartados.pagina_4.dw_detalle_documento.object.documento[h] 
				
				ls_clave = trim(ls_empresa) + "-" + trim(ls_cliente) + "-" + trim(ls_reclamacion) + &
				"-" + trim(ls_documento)
				
				ls_sel = " select documento from gestion_documental where tabla = 'ven_reclamaciones_documentos' " + &
				" and clave = '" + ls_clave + "'"
				
				ds_documentos = f_cargar_cursor(ls_sel)
				
				for g = 1 to ds_documentos.rowcount()
					
					ls_documento = ds_documentos.object.documento[g]
					if not f_nulo_blanco(ls_documento) then
					
						ls_ficheros = ls_ficheros + ls_documento + ";"
					end if
					
				next
				
				f_get_token_der(ls_ficheros,";")
			
			next 
			
			f_enviar_email(ls_cadena,"",f_nombre_empresa(codigo_empresa) + "- Incidencia notificada nº " + ls_codigo_reclamacion,ls_mensaje,ls_ficheros)

		next
		
		

		if i_status <> DataModified! then
	
		/// Enviar correo interno al usuario principal de 
		/// la reclamación.
	  		asunto        = 'RECLAMACIONES' 		
			OBSERVACIONES = ' LA RECLAMACION Nº '+ sle_valor.text +' SE HA PRODUCIDO CAMBIO ' + char(10) + char(13) 
			ls_usuario_destino =  apartados.pagina_1.dw_pagina1.object.nombre_usuario[1]
			
			
			select max(orden) into :orden
			from utimensajes where empresa = :codigo_empresa;
			
			if isnull(orden) then orden = 1
			
			orden ++
			 
		  INSERT INTO utimensajes  
						( empresa,   
						  orden,   
						  usuario,   
						  falta,   
						  destino,   
						  asunto,   
						  observaciones,   
						  flistado,   
						  listado,   
						  leido )  
			  VALUES ( :codigo_empresa,   
						  :orden,   
						  :nombre_usuario,    
						  getdate(),   
						  :ls_usuario_destino,   
						  :asunto,   
						  :observaciones,   
						  null,   
						  'N',   
						  'N' )  ;
			
			if sqlca.sqlcode = 0 then
				commit;
			else
				rollback;
			end if
		
	else
		i_status = notmodified!
	end if /// l_status
		
		
	end if
	


	ids_mail.reset()
	destroy ds_usuarios


end if






















end subroutine

on w_mant_reclamaciones_gno.create
int iCurrent
call super::create
this.st_2=create st_2
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.st_descripcion_reclamacion=create st_descripcion_reclamacion
this.pb_calculadora=create pb_calculadora
this.report=create report
this.pb_1=create pb_1
this.dw_mail=create dw_mail
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.st_descripcion_reclamacion
this.Control[iCurrent+5]=this.pb_calculadora
this.Control[iCurrent+6]=this.report
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.dw_mail
this.Control[iCurrent+9]=this.gb_9
end on

on w_mant_reclamaciones_gno.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.st_descripcion_reclamacion)
destroy(this.pb_calculadora)
destroy(this.report)
destroy(this.pb_1)
destroy(this.dw_mail)
destroy(this.gb_9)
end on

event ue_valores;call super::ue_valores;// Introducir valores activacion paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag1= TRUE
//               Si se deseandos paginas : pag1= TRUE
//						               		  : pag2= TRUE


// Introducir valores anulacion proceso de modificado e insercion
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag_act1= TRUE
//               Si se deseandos paginas : pag_act1= TRUE
//						               		  : pag_act2= TRUE

// Introducir las pantallas principales  una por tabla
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : prin_pag1= TRUE
//               Si se deseandos paginas : prin_pag2= TRUE
//						               		  : prin_pag3= TRUE

pag1      = true
pag_act1  = true
prin_pag1 = true

pag2      = true
pag_act2  = true
prin_pag2 = true

pag3      = true
pag_act3  = true
prin_pag3 = true

pag4      = true
pag_act4  = true
prin_pag4 = true

pag5      = true
pag_act5  = true
prin_pag5 = true

pag6      = true
pag_act6  = true
prin_pag6 = true

pag7      = true


end event

event ue_recuperar;long registros
string ls_codigo_contacto, ls_nombre_usuario

if uo_cliente.em_codigo.text <> "" then
	// Valores Para Funcion de bloqueo
	titulo       = This.title
	longitud     = len(trim(codigo_empresa))
	criterio[1]  = trim(codigo_empresa)+ space(20-longitud)
	longitud     = len(trim(sle_valor.text))
	criterio[2]  = trim(sle_valor.text)+space(20-longitud)
	longitud     = len(trim(uo_cliente.em_codigo.text))
	criterio[3]  = trim(uo_cliente.em_codigo.text)+space(20-longitud)
	seleccion[1] = criterio[1]+criterio[2]+criterio[3]
	//seleccion[2] = criterio[1]+criterio[2]
	tabla[1]     = "ven_reclamaciones"
	//tabla[2]     = ""
	
	registros = dw_pag1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	if registros = 1 then
		st_descripcion_reclamacion.text = " "+dw_pag1.object.descripcion[1]
		
		ls_nombre_usuario = dw_pag1.object.nombre_usuario[1]
			
		
		if dw_pag1.object.cerrada[1] = "S" then
			dw_pag1.object.DataWindow.ReadOnly = 'Yes'
			dw_pag2.object.DataWindow.ReadOnly = 'Yes'
			apartados.pagina_2.dw_detalle_fase.object.DataWindow.ReadOnly = 'Yes'
			dw_pag3.object.DataWindow.ReadOnly = 'Yes'
			dw_pag4.object.DataWindow.ReadOnly = 'Yes'
			apartados.pagina_4.dw_detalle_documento.object.DataWindow.ReadOnly = 'Yes'
			dw_pag5.object.DataWindow.ReadOnly = 'Yes'
			dw_pag6.object.DataWindow.ReadOnly = 'Yes'
			
			apartados.pagina_2.dw_situacion_final_fase.reset()
			apartados.pagina_2.dw_situacion_final_fase.object.DataWindow.ReadOnly = 'Yes'
			cb_borrar.enabled= false
			ib_modifi = false
		else
					
			dw_pag1.object.DataWindow.ReadOnly = 'No'
			dw_pag2.object.DataWindow.ReadOnly = 'No'
			apartados.pagina_2.dw_detalle_fase.object.DataWindow.ReadOnly = 'No'
			dw_pag3.object.DataWindow.ReadOnly = 'No'
			dw_pag4.object.DataWindow.ReadOnly = 'No'
			apartados.pagina_4.dw_detalle_documento.object.DataWindow.ReadOnly = 'No'
			dw_pag5.object.DataWindow.ReadOnly = 'No'
			dw_pag6.object.DataWindow.ReadOnly = 'No'
			
			apartados.pagina_2.dw_situacion_final_fase.object.DataWindow.ReadOnly = 'No'
			
			cb_borrar.enabled= true
			ib_modifi = true
			
		end if
	else
			
		st_descripcion_reclamacion.text = ""	
		dw_pag1.Modify("DataWindow.ReadOnly=No")
		dw_pag3.Modify("DataWindow.ReadOnly=No")
		dw_pag4.Modify("DataWindow.ReadOnly=No")
		dw_pag5.Modify("DataWindow.ReadOnly=No")
		dw_pag6.Modify("DataWindow.ReadOnly=No")
		dw_pag2.Modify("DataWindow.ReadOnly=No")
		apartados.pagina_2.dw_situacion_final_fase.Modify("DataWindow.ReadOnly=No")
		cb_borrar.enabled= true
	end if
	
//	ls_codigo_contacto = f_busca_contacto_crm_preferencia(codigo_empresa, "C" + uo_cliente.em_codigo.text)
//	
//	if not f_nulo_blanco(ls_codigo_contacto) then
//		dw_pag1.setitem(1,"telefonos_codigo",ls_codigo_contacto)
//	end if
		
	dw_pag3.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	if not f_nulo_blanco(apartados.pagina_3.em_fechadesde.text)  then
		apartados.pagina_3.cb_consulta_detalle_fras.triggerevent(clicked!)
	end if
	dw_pag4.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	if dw_pag4.rowcount() > 0 then		
		dw_pag4.selectrow(0,false)
		dw_pag4.selectrow(dw_pag4.rowcount(),true)
		apartados.pagina_4.dw_detalle_documento.setrow(dw_pag4.rowcount())
		apartados.pagina_4.dw_detalle_documento.scrolltorow(dw_pag4.rowcount())
	end if
	
	dw_pag5.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	apartados.pagina_5.cb_consulta_abonos.triggerevent(clicked!)
	
	dw_pag6.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	dw_pag2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	
//	
//	ls_codigo_contacto = f_busca_contacto_crm_preferencia(codigo_empresa, "C" + uo_cliente.em_codigo.text)
//	
//	if not f_nulo_blanco(ls_codigo_contacto) then
//		dw_pag1.setitem(1,"telefonos_codigo",ls_codigo_contacto)
//	end if
	
	f_mostrar_resumen_reclamacion()
	
	apartados.pagina_3.em_fechadesde.text = "01-01-"+ string(year(today()))
	apartados.pagina_3.em_fechahasta.text = "31-12-"+ string(year(today()))
	
	ids_mail.reset()
	
	
	CALL Super::ue_recuperar
else
	sle_valor.Text = ""
end if
end event

event ue_inserta_fila; pag_act2  = FALSE
pag_act3  = FALSE
pag_act4  = FALSE
pag_act5  = FALSE
pag_act6  = FALSE
CALL Super::ue_inserta_fila
pag_act2  = TRUE
pag_act3  = TRUE
pag_act4  = TRUE
pag_act5  = TRUE
pag_act6  = TRUE

string ls_codigo_contacto
string ls_comercial,ls_usuario,ls_cliente

if insercion = "S" Then
	
	ls_cliente = uo_cliente.em_codigo.text 
	
//	select comercialundefasa into :ls_comercial
//			from venclientes
//			where empresa = :codigo_empresa
//			and   codigo  = :ls_cliente
//			using sqlca;
//			
//			ls_usuario = ""
//			
//			if not f_nulo_blanco(ls_comercial) then
//				select nombrecomercial into :ls_usuario
//				from agentesundefasa
//				where empresa= :codigo_empresa
//				and   comercial = :ls_comercial
//				using sqlca;
//			end if
	// VALORES INICIALES	
	dw_pag1.SetItem(1,"empresa",codigo_empresa)
	dw_pag1.SetItem(1,"cliente",uo_cliente.em_codigo.text)
	dw_pag1.SetItem(1,"reclamacion",sle_valor.text)
	dw_pag1.setitem(1,"fecha",datetime(today(),time('00:00:00')))
	dw_pag1.setitem(1,"nombre_usuario",nombre_usuario)
	dw_pag1.setitem(1,"responsable",ls_usuario)	
	dw_pag1.SetItemStatus(1, "nombre_usuario",Primary!, DataModified!)
	i_status = apartados.pagina_1.dw_pagina1.GetItemStatus(1,"nombre_usuario", Primary!)
	
	
//	ls_codigo_contacto = f_busca_contacto_crm_preferencia(codigo_empresa, "C" + uo_cliente.em_codigo.text)
//	
//	if not f_nulo_blanco(ls_codigo_contacto) then
//		dw_pag1.setitem(1,"telefonos_codigo",ls_codigo_contacto)
//	end if
	
	apartados.pagina_3.em_fechadesde.text = "01-01-"+ string(year(today()))
	apartados.pagina_3.em_fechahasta.text = "31-12-"+ string(year(today()))
end if
end event

event open;call super::open;titulo = "Mantenimiento de Reclamaciones"
This.title = titulo

//if nombre_usuario = 'JUANJO' then
//	directorio_gestion_documental = "C:\ARCHIVODOCUMENTAL\"
//end if


f_cargar_cursor_transaccion(sqlca,ids_mail,"Select space(5000) as mensaje, space(1) as tipo from empresas where 0 = 1")
report.SetTransObject(SQLCA)
dw_pag1.SetTransObject(SQLCA)

dw_pag1.sharedata(apartados.pagina_1.dw_cliente_final)
apartados.pagina_1.dw_cliente_final.visible = false
dw_pag3.SetTransObject(SQLCA)
apartados.pagina_3.dw_detalle_facturas_cliente.SetTransObject(SQLCA)

dw_pag4.SetTransObject(SQLCA)
dw_pag4.Sharedata(apartados.pagina_4.dw_detalle_documento)

dw_pag5.SetTransObject(SQLCA)
apartados.pagina_5.dw_detalle_abonos_cliente.SetTransObject(SQLCA)

dw_pag6.SetTransObject(SQLCA)

f_mascara_columna(dw_pag6,"importe_fra_proveedor",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))

dw_pag2.SetTransObject(SQLCA)
dw_pag2.Sharedata(apartados.pagina_2.dw_detalle_fase)

// Si recibo el codigo lo visualizo

if istr_parametros.i_nargumentos > 1 then
	uo_cliente.em_codigo.text = istr_parametros.s_argumentos[2]
	uo_cliente.em_campo.text  = f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	
	If Trim(uo_cliente.em_campo.text) = "" then
		uo_cliente.em_campo.text  = ""
		uo_cliente.em_codigo.text = ""
	else
		sle_valor.text            = istr_parametros.s_argumentos[3]	
		This.TriggerEvent("ue_recuperar")		
	end if 
	
	f_activar_campo(sle_valor)
else
	uo_cliente.em_campo.setfocus()
end if

i_status = notmodified!
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.enabled       = true
uo_cliente.em_campo.enabled  = true
apartados.pagina_4.cb_anyadir_documento.enabled     = false
apartados.pagina_4.cb_borrar_documento.enabled      = false
apartados.pagina_6.cb_anyadir_fra_proveedor.enabled = false
apartados.pagina_6.cb_borrar_fra_proveedor.enabled  = false
apartados.pagina_2.cb_anyadir_fase.enabled          = false
apartados.pagina_2.cb_borrar_fase.enabled           = false
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
if ib_modifi then
	pb_calculadora.enabled      = false
	uo_cliente.em_campo.enabled = false
	apartados.pagina_4.cb_anyadir_documento.enabled     = true
	apartados.pagina_4.cb_borrar_documento.enabled      = true
	apartados.pagina_6.cb_anyadir_fra_proveedor.enabled = true
	apartados.pagina_6.cb_borrar_fra_proveedor.enabled  = true
	apartados.pagina_2.cb_anyadir_fase.enabled          = true
	apartados.pagina_2.cb_borrar_fase.enabled           = true
end if
end event

event ue_actualiza_dw;long    indice,lineas_borradas,lineas,anyo,anyo_factura,linea_factura, factura,albaran,linea_albaran
dec     cantidad_reclamacion,total_cantidad_reclamacion,importe_total_reclamacion
dec     gastos_reclamacion
boolean bien = true
string ls_email



if dw_pag1.rowcount() > 0 then
	if f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]) then
	 MessageBox(" Tipo Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
	  apartados.SelectTab(1)
	  apartados.pagina_1.dw_pagina1.setfocus()
	  apartados.pagina_1.dw_pagina1.SetColumn("codigo_ven_reclamaciones_tipos")
		return		
	end if
end if


if dw_pag1.rowcount() > 0 then
	if f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]) then
	 MessageBox(" Causa Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
			  apartados.SelectTab(1)
			  apartados.pagina_1.dw_pagina1.setfocus()
			  apartados.pagina_1.dw_pagina1.SetColumn("codigo_ven_reclamaciones_causa")
		return		
	end if
end if


lineas_borradas = dw_pag3.deletedcount()

for indice = 1 to lineas_borradas
	anyo          = dw_pag3.getitemnumber(indice,"ven_reclamaciones_detalle_anyo",Delete!,true)
	albaran       = dw_pag3.getitemnumber(indice,"ven_reclamaciones_detalle_albaran",Delete!,true)
	linea_albaran = dw_pag3.getitemnumber(indice,"ven_reclamaciones_detalle_linea_albaran",Delete!,true)
	factura		  = dw_pag3.getitemnumber(indice, "vista_venlialb_reclamaciones_factura",Delete!,true)
	linea_factura = dw_pag3.getitemnumber(indice, "vista_venlialb_reclamaciones_linea_factura",Delete!,true)
	anyo_factura  = dw_pag3.getitemnumber(indice, "vista_venlialb_reclamaciones_anyo",Delete!,true)
//INSERTAMOS EL IMPORTE EN LAS LINEAS

	if not f_nulo_cero(factura) then
	
		update venlifac 
		set    gastos_reclamacion = 0
		where  empresa       = :codigo_empresa
		and    anyo			   = :anyo_factura
		and    factura     	= :factura
		and    linea_factura = :linea_factura;
		
		if sqlca.sqlcode <> 0 then
			bien = false
		end if
		
	else
		update venlialb 
		set    gastos_reclamacion = 0
		where  empresa       = :codigo_empresa
		and    anyo			   = :anyo
		and    albaran     	= :albaran
		and    linea		   = :linea_albaran;
		
		if sqlca.sqlcode <> 0 then
			bien = false
		end if
	end if
next

lineas = dw_pag3.rowcount()
total_cantidad_reclamacion = 0
for indice = 1 to lineas
	total_cantidad_reclamacion = total_cantidad_reclamacion + dw_pag3.object.ven_reclamaciones_detalle_cantidad[indice]
next

lineas = dw_pag6.rowcount()
importe_total_reclamacion = 0
for indice = 1 to lineas
	importe_total_reclamacion = importe_total_reclamacion + dw_pag6.object.importe_fra_proveedor[indice]
next

lineas = dw_pag3.rowcount()

for indice = 1 to lineas
	cantidad_reclamacion = dw_pag3.object.ven_reclamaciones_detalle_cantidad[indice]
	if total_cantidad_reclamacion <> 0 then
		gastos_reclamacion = (importe_total_reclamacion / total_cantidad_reclamacion) * cantidad_reclamacion
	else
		gastos_reclamacion = 0
	end if
	anyo          = dw_pag3.object.ven_reclamaciones_detalle_anyo[indice]
	albaran       = dw_pag3.object.ven_reclamaciones_detalle_albaran[indice]
	linea_albaran = dw_pag3.object.ven_reclamaciones_detalle_linea_albaran[indice]
	factura		  = dw_pag3.object.vista_venlialb_reclamaciones_factura[indice]
	linea_factura = dw_pag3.object.vista_venlialb_reclamaciones_linea_factura[indice]
	anyo_factura  = dw_pag3.object.vista_venlialb_reclamaciones_anyo[indice]

//NO INSERTAMOS EL IMPORTE EN LAS LINEAS
	if not f_nulo_cero(factura) then
		update venlifac 
		set    gastos_reclamacion = :gastos_reclamacion
		where  empresa       = :codigo_empresa
		and    anyo				= :anyo_factura
		and    factura       = :factura
		and    linea_factura = :linea_factura;
		
		if sqlca.sqlcode <> 0 then
			bien = false
		end if
		
	else
		update venlialb 
		set    gastos_reclamacion = :gastos_reclamacion
		where  empresa       = :codigo_empresa
		and    anyo			   = :anyo
		and    albaran     	= :albaran
		and    linea		   = :linea_albaran;
	end if
		
next

if bien then
	/// Enviamos el correo electrónico
	/// Añadimos los correos según grupo informativo
	 wf_enviar_correo()
	
	call super::ue_actualiza_dw
else
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar los gastos en las lineas de facturas.")
end if
end event

event close;call super::close;destroy (ids_mail)
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_reclamaciones_gno
integer x = 3186
integer y = 172
integer taborder = 60
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_reclamaciones_gno
integer x = 2779
integer y = 172
integer taborder = 50
end type

event cb_borrar::clicked;if dw_pag1.object.cerrada[1] <> "S" or nombre_usuario = "GENOGESTION" then
	call super::clicked
else
	messagebox("¡Atención!","¡No se puede eliminar una reclamación cerrada!",StopSign!)
end if
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_reclamaciones_gno
integer x = 2373
integer y = 172
end type

event cb_insertar::clicked;///
string ls_v_outlook
boolean lb_continuar

if dw_pag1.rowcount() > 0 then
	if f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]) then
	 MessageBox(" Tipo Reclamación Campo obligatorio","Introducir el campo Tipo Reclamación ",Exclamation!, OK!,1)
	  apartados.SelectTab(1)
	  apartados.pagina_1.dw_pagina1.setfocus()
	  apartados.pagina_1.dw_pagina1.SetColumn("codigo_ven_reclamaciones_tipos")
		return		
	end if
end if


if dw_pag1.rowcount() > 0 then
	if f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.descripcion[1]) then
	 MessageBox(" Descripción Reclamación Campo obligatorio","Introducir el campo Descripcion reclamación ",Exclamation!, OK!,1)
	  apartados.SelectTab(1)
	  apartados.pagina_1.dw_pagina1.setfocus()
	  apartados.pagina_1.dw_pagina1.SetColumn("descripcion")
		return		
	end if
end if


if dw_pag1.rowcount() > 0 then
	if f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]) then
	 MessageBox(" Causa Campo obligatorio","Introducir el campo  Causa",Exclamation!, OK!,1)
			  apartados.SelectTab(1)
			  apartados.pagina_1.dw_pagina1.setfocus()
			  apartados.pagina_1.dw_pagina1.SetColumn("codigo_ven_reclamaciones_causa")
		return		
	end if
end if




call super::clicked


if dw_pag1.rowcount() > 0 then
	if not f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]) and &
	 not f_nulo_blanco(apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]) then
	 
	 	ls_v_outlook = f_usuarios_v_outlook(nombre_usuario)
		if ls_v_outlook  = "S" then
			lb_continuar = wf_confirmaciones(1)
		else
			lb_continuar = true
		end if
		if lb_continuar then
			apartados.SelectTab(2)
			apartados.pagina_2.dw_pagina2.setfocus()
		 else
			apartados.SelectTab(3)
			apartados.pagina_3.dw_pagina3.setfocus()
			
		end if
				
			 
			  //apartados.pagina_2.dw_pagina1.SetColumn("codigo_ven_reclamaciones_causa")
		return		
	end if
end if
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_reclamaciones_gno
integer taborder = 0
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_reclamaciones_gno
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_reclamaciones_gno
integer x = 375
integer y = 196
integer width = 206
integer height = 76
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "Selección de Reclamaciones"
ue_datawindow = "dw_ayuda_ven_reclamaciones_gno"
ue_filtro     = "cliente = '"+uo_cliente.em_codigo.text+"'"
st_descripcion_reclamacion.text = ""
end event

event sle_valor::modificado;call super::modificado;
if not f_nulo_blanco(sle_valor.text) then
	apartados.SelectTab(1)
	apartados.pagina_1.dw_pagina1.setfocus()
	apartados.pagina_1.dw_pagina1.SetColumn("descripcion")
	
end if
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_reclamaciones_gno
integer x = 37
integer y = 204
integer width = 334
integer height = 68
integer textsize = -8
fontcharset fontcharset = ansi!
string text = "Reclamación:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_reclamaciones_gno
integer x = 18
integer y = 284
integer width = 3639
integer height = 2196
integer taborder = 70
string dragicon = "Application!"
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
end type

event apartados::pulsar_datawindow;call super::pulsar_datawindow;if ib_modifi then

if dw_pag1.rowcount() > 0 then
	if dw_pag1.object.cerrada[1] = "S" then
		
	
		pb_calculadora.enabled      = false
		uo_cliente.em_campo.enabled = false
		apartados.pagina_4.cb_anyadir_documento.enabled     = false
		apartados.pagina_4.cb_borrar_documento.enabled      = false
		apartados.pagina_6.cb_anyadir_fra_proveedor.enabled = false
		apartados.pagina_6.cb_borrar_fra_proveedor.enabled  = false
		apartados.pagina_2.cb_anyadir_fase.enabled          = false
		apartados.pagina_2.cb_borrar_fase.enabled           = false
	//	cb_insertar.enabled= false
	//	cb_borrar.enabled= false
	
	
end if	
end if
end if
end event

event apartados::selectionchanged;call super::selectionchanged;

IF newindex = 2 THEN 
	
	
	if apartados.pagina_2.dw_pagina2.rowcount() <> 0 then
		apartados.pagina_2.dw_pagina2.selectrow(0,false)
		apartados.pagina_2.dw_pagina2.selectrow(apartados.pagina_2.dw_pagina2.rowcount(),true)
		
		//messagebox(string(currentrow),apartados.pagina_2.dw_detalle_fase.rowcount())
		
		apartados.pagina_2.dw_pagina2.setrow(apartados.pagina_2.dw_pagina2.rowcount())
	end if
end if


end event

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3602
integer height = 2068
string text = "Reclamación"
string picturename = "Custom037!"
long picturemaskcolor = 553648127
dw_cliente_final dw_cliente_final
end type

on pagina_1.create
this.dw_cliente_final=create dw_cliente_final
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cliente_final
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_cliente_final)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 24
integer width = 3575
integer height = 2032
string dataobject = "dw_mant_reclamaciones1"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina1::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
// bus_campo = This.GetColumnName()

if ib_modifi then 

	if dwo.type = "column" or dwo.type = "compute" then 
		bus_campo = dwo.name
		this.setcolumn(bus_campo)
	 string ls_tipos,ls_cliente
	 CHOOSE CASE bus_campo
		CASE "codigo_ven_reclamaciones_tipos"
			bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos"
			bus_titulo = "VENTANA SELECCION DE TIPOS DE RECLAMACION"
			valor_empresa = true
		CASE "codigo_ven_reclamaciones_causa"
			ls_tipos = this.object.codigo_ven_reclamaciones_tipos[1]
			bus_filtro     = "codigo_ven_reclamaciones_tipos = '" + ls_tipos +"'" + &
			" and ven_reclamaciones_causas_tipos_empresa = '"+string(codigo_empresa)+"'"
			bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos_causas"
			bus_titulo = "VENTANA SELECCION DE CAUSAS POR TIPOS"
			valor_empresa = true
		CASE "codigo_ven_reclamaciones_situa"
			bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
			bus_titulo = "VENTANA SELECCION DE SITUACIONES"
			valor_empresa = true
		CASE "ven_reclamaciones_respo_codigo"
			bus_datawindow = "dw_ayuda_ven_reclamaciones_responsables"
			bus_titulo     = "AYUDA SELECCION RESPONSABLES DE LA RECLAMACION"
			valor_empresa  = TRUE		
		case "telefonos_codigo", "contacto"
			ls_cliente     = "C" + trim(uo_cliente.em_codigo.text)
			bus_filtro     = "crm_tercero_codigo = '"+ls_cliente+"'"
			bus_datawindow = "dw_ayuda_contactos_crm"
			bus_titulo     = "VENTANA SELECCION DE CONTACTOS"
			valor_empresa = true	
	//		bus_filtro     = "tipoter = 'C' and codigo = '"+uo_cliente.em_codigo.text+"'"
	//		bus_datawindow = "dw_ayuda_telefonos"
	//		bus_titulo     = "VENTANA SELECCION DE CONTACTOS"
	//		valor_empresa = true					
		CASE ELSE
			SetNull(bus_campo)
	 END CHOOSE
	 CALL Super::rbuttondown
	END IF
	
end if
end event

event dw_pagina1::key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()
 string ls_tipos,ls_cliente
 
 
if ib_modifi then
 
 CHOOSE CASE bus_campo
	CASE "codigo_ven_reclamaciones_tipos"
 		bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE RECLAMACION"
		valor_empresa = true
    CASE "codigo_ven_reclamaciones_causa"
		ls_tipos = this.object.codigo_ven_reclamaciones_tipos[1]
		bus_filtro     = "codigo_ven_reclamaciones_tipos = '" + ls_tipos +"'" + &
		" and ven_reclamaciones_causas_tipos_empresa = '"+string(codigo_empresa)+"'"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos_causas"
     	bus_titulo = "VENTANA SELECCION DE CAUSAS POR TIPOS"
		valor_empresa = true

   CASE "codigo_ven_reclamaciones_situa"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo = "VENTANA SELECCION DE SITUACIONES"
		valor_empresa = true
	CASE "ven_reclamaciones_respo_codigo"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_responsables"
		bus_titulo     = "AYUDA SELECCION RESPONSABLES DE LA RECLAMACION"
		valor_empresa  = TRUE		
	case "telefonos_codigo"
		ls_cliente     = "C" + trim(uo_cliente.em_codigo.text)
		bus_filtro     = "crm_tercero_codigo = '"+ls_cliente+"'"
		bus_datawindow = "dw_ayuda_contactos_crm"
		bus_titulo     = "VENTANA SELECCION DE CONTACTOS"
		valor_empresa = true	
		//		bus_filtro     = "tipoter = 'C' and codigo = '"+uo_cliente.em_codigo.text+"'"
//		bus_datawindow = "dw_ayuda_telefonos"
//		bus_titulo     = "VENTANA SELECCION DE CONTACTOS"
//		valor_empresa = true			
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key
 
end if


end event

event dw_pagina1::itemchanged;call super::itemchanged;long ll_indice,ll_total,ll_donde,ll_registros
string ls_tipo_reclamacion,ls_causa_reclamacion,ls_situacion_inicial,ls_fase_inicial
string ls_codigo_contacto

choose case dwo.name
		
	case "contacto", "telefonos_codigo"
		
		ls_codigo_contacto = f_busca_contacto_crm_preferencia(codigo_empresa, "C" + uo_cliente.em_codigo.text)
		
		if not f_nulo_blanco(ls_codigo_contacto) then
			dw_pag1.setitem(1,"telefonos_codigo",ls_codigo_contacto)
		end if
				
	case "codigo_ven_reclamaciones_tipos"
		ls_tipo_reclamacion  = data
		ls_causa_reclamacion = this.object.codigo_ven_reclamaciones_causa[row]
		
		this.object.codigo_ven_reclamaciones_causa[row] = ""
		this.setitem(row,"codigo_ven_reclamaciones_causa","")
		this.event itemchanged(row,this.object.codigo_ven_reclamaciones_causa,this.object.codigo_ven_reclamaciones_causa[row])
	case "codigo_ven_reclamaciones_causa"
		ls_tipo_reclamacion  = this.object.codigo_ven_reclamaciones_tipos[row]		
		ls_causa_reclamacion = data
		
		ls_situacion_inicial = this.object.cerrada[1]
		if ls_situacion_inicial<> "S" then
		
			if ls_tipo_reclamacion <> "" and ls_causa_reclamacion <> "" then
				ll_total = apartados.pagina_2.dw_pagina2.rowcount()
			
				for ll_indice = 1 to ll_total
					apartados.pagina_2.dw_pagina2.setrow(1)
					apartados.pagina_2.cb_borrar_fase.triggerevent(clicked!)
				next			
				
				ll_registros = 0
				
				select count(*)
				into   :ll_registros
				from   ven_reclamaciones_causas_tipos
				where  empresa = :codigo_empresa
				and    codigo_ven_reclamaciones_tipos = :ls_tipo_reclamacion
				and    codigo_ven_reclamaciones_causa = :ls_causa_reclamacion;
				
				if isnull(ll_registros) then ll_registros = 0
				
				if ll_registros = 1 then								
					select fase_inicial,situacion_inicial
					into   :ls_fase_inicial,:ls_situacion_inicial
					from   ven_reclamaciones_causas_tipos
					where  empresa = :codigo_empresa
					and    codigo_ven_reclamaciones_tipos = :ls_tipo_reclamacion
					and    codigo_ven_reclamaciones_causa = :ls_causa_reclamacion;		
					
					if isnull(ls_fase_inicial) then ls_fase_inicial = ""
					if isnull(ls_situacion_inicial) then ls_situacion_inicial = ""
					
					if trim(ls_fase_inicial) <> "" and trim(ls_situacion_inicial) <> "" then
						apartados.pagina_2.cb_anyadir_fase.triggerevent(clicked!)
						
						ll_donde = apartados.pagina_2.dw_pagina2.rowcount()
						apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases[ll_donde] = ls_fase_inicial		
						apartados.pagina_2.dw_pagina2.event itemchanged(row,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases[ll_donde])					
						
						apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i[ll_donde] = ls_situacion_inicial		
						apartados.pagina_2.dw_pagina2.event itemchanged(row,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i[ll_donde])										
	
					end if
					this.object.codigo_ven_reclamaciones_causa[row] = ls_causa_reclamacion
				else
					this.object.codigo_ven_reclamaciones_causa[row] = ""
					return 2
				end if
			else
				ll_total = apartados.pagina_2.dw_pagina2.rowcount()
				
				for ll_indice = 1 to ll_total
					apartados.pagina_2.dw_pagina2.setrow(1)
					apartados.pagina_2.cb_borrar_fase.triggerevent(clicked!)
				next
			end if
			
			
			return 2
		end if ///situacion cerrada
end choose

end event

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE dwo.name

	CASE 'pb_telefonos_codigo'
		
//		lstr_param.i_nargumentos=3
//		lstr_param.s_argumentos[2]= "C" + trim(uo_cliente.em_codigo.text)
//		lstr_param.s_argumentos[3]= this.getitemstring( this.GetRow(),"telefonos_codigo")
//  	 	//OpenSheetWithParm(w_mant_contactos_crm,lstr_param,ventana_padre,5,Original!)  
//	
//		
		
		lstr_param.i_nargumentos   = 4
		lstr_param.s_argumentos[2] = uo_cliente.em_codigo.text
		lstr_param.s_argumentos[3] = "C"
		lstr_param.s_argumentos[4] = this.object.telefonos_codigo[row]

		OpenSheetWithParm(wi_mant_telefonos,lstr_param,ventana_padre,3,Original!)
//		
//		OpenWithParm(wi_mant_telefonos,lstr_param) 	
//		
	CASE 'pb_codigo_ven_reclamaciones_tipos'
		lstr_param.i_nargumentos   = 2
		lstr_param.s_argumentos[2] = this.object.codigo_ven_reclamaciones_tipos[row]
		//lstr_param.s_argumentos[1] = this.object.codigo_ven_reclamaciones_causa[row]
		
		OpenSheetWithParm(w_mant_ven_reclamaciones_tipos,lstr_param,w_mant_reclamaciones_gno,3,Original!)
		
	CASE 'pb_codigo_ven_reclamaciones_causa'
		lstr_param.i_nargumentos   = 2
		lstr_param.s_argumentos[2] = this.object.codigo_ven_reclamaciones_causa[row]
		
		OpenSheetWithParm(w_mant_ven_reclamaciones_causas,lstr_param,w_mant_reclamaciones_gno,3,Original!)
	CASE 'pb_ven_reclamaciones_respo_codigo'
		lstr_param.i_nargumentos   = 2
		lstr_param.s_argumentos[2] = this.object.ven_reclamaciones_respo_codigo[row]
		
		OpenSheetWithParm(w_mant_ven_reclamaciones_responsables,lstr_param,ventana_padre,3,Original!)  
	CASE 'pb_codigo_ven_reclamaciones_situa'
		lstr_param.i_nargumentos   = 2
		lstr_param.s_argumentos[2] = this.object.codigo_ven_reclamaciones_situa[row]
		
		OpenSheetWithParm(w_mant_ven_reclamaciones_situaciones,lstr_param,ventana_padre,3,Original!)  		
	CASE 'p_cliente_final'
		apartados.pagina_1.dw_cliente_final.visible = not apartados.pagina_1.dw_cliente_final.visible
		if apartados.pagina_1.dw_cliente_final.visible = true then
			apartados.pagina_1.dw_cliente_final.setfocus()
			apartados.pagina_1.dw_cliente_final.SetColumn("nombre_cliente_final")
		end if
END CHOOSE
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
event create ( )
event destroy ( )
integer width = 3602
integer height = 2068
string text = "Fases"
string picturename = "SetDefaultClass!"
cb_anyadir_fase cb_anyadir_fase
cb_borrar_fase cb_borrar_fase
dw_detalle_fase dw_detalle_fase
dw_situacion_final_fase dw_situacion_final_fase
gb_8 gb_8
end type

on pagina_2.create
this.cb_anyadir_fase=create cb_anyadir_fase
this.cb_borrar_fase=create cb_borrar_fase
this.dw_detalle_fase=create dw_detalle_fase
this.dw_situacion_final_fase=create dw_situacion_final_fase
this.gb_8=create gb_8
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_anyadir_fase
this.Control[iCurrent+2]=this.cb_borrar_fase
this.Control[iCurrent+3]=this.dw_detalle_fase
this.Control[iCurrent+4]=this.dw_situacion_final_fase
this.Control[iCurrent+5]=this.gb_8
end on

on pagina_2.destroy
call super::destroy
destroy(this.cb_anyadir_fase)
destroy(this.cb_borrar_fase)
destroy(this.dw_detalle_fase)
destroy(this.dw_situacion_final_fase)
destroy(this.gb_8)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 12
integer width = 1307
integer height = 1952
string dataobject = "dw_mant_reclamaciones9"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina2::rowfocuschanged;call super::rowfocuschanged;int li_retorno


if currentrow <> 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	
	//messagebox(string(currentrow),apartados.pagina_2.dw_detalle_fase.rowcount())
	
	dw_detalle_fase.setrow(currentrow)
	li_retorno = dw_detalle_fase.scrolltorow(currentrow)
//	if li_retorno <> currentrow then
//		dw_detalle_fase.Scroll(currentrow - li_retorno)
//	end if
//	//messagebox("",li_retorno)
end if


end event

event dw_pagina2::itemchanged;call super::itemchanged;string ls_situacion_inicial,ls_situacion_final,ls_fase,ls_tipo_reclamacion,ls_causa_reclamacion
string ls_fase_siguiente,ls_situacion_siguiente,ls_cierre_reclamacion
string ls_sel,ls_situacion
long   ll_indice,ll_total,ll_donde
datastore ds_datos

if row= 0 then return
//.Dapartados.pagina_2.dw_pagina2.describe("#.Name")
choose case dwo.name
	case "codigo_ven_reclamaciones_sit_i"
		ls_situacion_inicial = data
		ls_situacion_final   = this.object.codigo_ven_reclamaciones_sit_f[row]
		if trim(ls_situacion_final) = "" then
			apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_situa[1] = ls_situacion_inicial
		else
			return 2
		end if
	case "codigo_ven_reclamaciones_sit_f"
		ls_situacion_final   = data
		if data <> "" then
			ls_fase              = apartados.pagina_2.dw_detalle_fase.object.codigo_ven_reclamaciones_fases[apartados.pagina_2.dw_detalle_fase.getrow()]
			ls_tipo_reclamacion  = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]
			ls_causa_reclamacion = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]
			
			select fase_siguiente,situacion_siguiente,cierra_reclamacion
			into   :ls_fase_siguiente,:ls_situacion_siguiente,:ls_cierre_reclamacion
			from   ven_reclamaciones_rutas_fases_ti
			where  empresa = :codigo_empresa
			and    codigo_ven_reclamaciones_tipos = :ls_tipo_reclamacion
			and    codigo_ven_reclamaciones_causa = :ls_causa_reclamacion
			and    fase                           = :ls_fase
			and    situacion                      = :ls_situacion_final;		
			
			if isnull(ls_fase_siguiente) then ls_fase_siguiente = ""
			if isnull(ls_situacion_siguiente) then ls_situacion_siguiente = ""
			
			if trim(ls_fase_siguiente) <> "" and trim(ls_situacion_siguiente) <> "" then
				apartados.pagina_2.cb_anyadir_fase.triggerevent(clicked!)
				
				ll_donde = apartados.pagina_2.dw_pagina2.rowcount()
				apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases[ll_donde] = ls_fase_siguiente		
				apartados.pagina_2.dw_pagina2.event itemchanged(row,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases[ll_donde])					
				
				apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i[ll_donde] = ls_situacion_siguiente		
				apartados.pagina_2.dw_pagina2.event itemchanged(row,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_i[ll_donde])																
			
				apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_situa[1] = ls_situacion_siguiente
			end if
			
			if ls_cierre_reclamacion = "S" then
				
				apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_situa[1] = ls_situacion_siguiente
				apartados.pagina_1.dw_pagina1.object.cerrada[1] = ls_cierre_reclamacion
		end if
		end if		
	case "codigo_ven_reclamaciones_fases"
		ls_fase              = data
		ls_tipo_reclamacion  = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_tipos[1]
		ls_causa_reclamacion = apartados.pagina_1.dw_pagina1.object.codigo_ven_reclamaciones_causa[1]
		
		apartados.pagina_2.dw_situacion_final_fase.reset()
		
		ls_sel = "select situacion "+&
					"from ven_reclamaciones_rutas_fases_ti "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and   codigo_ven_reclamaciones_tipos = '"+ls_tipo_reclamacion+"' "+&
					"and   codigo_ven_reclamaciones_causa = '"+ls_causa_reclamacion+"' "+&
					"and   fase = '"+ls_fase+"' "+&
					"order by orden"
		
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice = 1 to ll_total
			ls_situacion = ds_datos.object.situacion[ll_indice]
			
			ll_donde = apartados.pagina_2.dw_situacion_final_fase.insertrow(0)
			apartados.pagina_2.dw_situacion_final_fase.object.marcada[ll_donde]     = "N"
			apartados.pagina_2.dw_situacion_final_fase.object.situacion[ll_donde]   = ls_situacion
			apartados.pagina_2.dw_situacion_final_fase.object.descripcion[ll_donde] = f_nombre_situaciones(codigo_empresa,ls_situacion)
			
		next
	case "observaciones"
		ls_situacion_final = this.object.codigo_ven_reclamaciones_sit_f[row]
		if isnull(ls_situacion_final) then ls_situacion_final = ''
		if trim(ls_situacion_final) <> '' then
			//return 1
		end if
end choose
end event

event dw_pagina2::retrieveend;call super::retrieveend;//string ls_pepe


//ls_pepe = '0'

apartados.pagina_2.dw_situacion_final_fase.reset()

if this.rowcount() > 0 and apartados.pagina_1.dw_pagina1.rowcount() > 0 then
	
	if apartados.pagina_1.dw_pagina1.object.cerrada[1] <> 'S' then
		this.event itemchanged(rowcount,this.object.codigo_ven_reclamaciones_fases,this.object.codigo_ven_reclamaciones_fases[rowcount])
	end if
end if

end event

event dw_pagina2::clicked;call super::clicked;
//this.event rowfocuschanged(this.getrow())
end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;//if row <> 0 then
//	this.selectrow(0,false)
//	this.selectrow(row,true)
//	
//	apartados.pagina_2.dw_detalle_fase.setrow(2)
//	apartados.pagina_2.dw_detalle_fase.scrolltorow(2)
//end if
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3602
integer height = 2068
string text = "Detalle Lineas"
string picturename = "SetNextStatement!"
long picturemaskcolor = 553648127
st_3 st_3
em_fechadesde em_fechadesde
st_4 st_4
em_fechahasta em_fechahasta
cb_consulta_detalle_fras cb_consulta_detalle_fras
dw_detalle_facturas_cliente dw_detalle_facturas_cliente
gb_3 gb_3
gb_2 gb_2
cb_borrar_linea_detalle cb_borrar_linea_detalle
st_7 st_7
em_albaran em_albaran
st_8 st_8
em_factura em_factura
st_9 st_9
uo_articulo uo_articulo
end type

on pagina_3.create
this.st_3=create st_3
this.em_fechadesde=create em_fechadesde
this.st_4=create st_4
this.em_fechahasta=create em_fechahasta
this.cb_consulta_detalle_fras=create cb_consulta_detalle_fras
this.dw_detalle_facturas_cliente=create dw_detalle_facturas_cliente
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_borrar_linea_detalle=create cb_borrar_linea_detalle
this.st_7=create st_7
this.em_albaran=create em_albaran
this.st_8=create st_8
this.em_factura=create em_factura
this.st_9=create st_9
this.uo_articulo=create uo_articulo
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_consulta_detalle_fras
this.Control[iCurrent+6]=this.dw_detalle_facturas_cliente
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_borrar_linea_detalle
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.em_albaran
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.em_factura
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.uo_articulo
end on

on pagina_3.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_fechadesde)
destroy(this.st_4)
destroy(this.em_fechahasta)
destroy(this.cb_consulta_detalle_fras)
destroy(this.dw_detalle_facturas_cliente)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_borrar_linea_detalle)
destroy(this.st_7)
destroy(this.em_albaran)
destroy(this.st_8)
destroy(this.em_factura)
destroy(this.st_9)
destroy(this.uo_articulo)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 0
integer width = 3849
integer height = 684
integer taborder = 0
string dataobject = "dw_mant_reclamaciones2_new"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::dragdrop;long   donde,donde_origen
string cliente,reclamacion   

//Soltamos el objeto

if ib_modifi  then
DataWindow origen
if dw_pag1.object.cerrada[1] <> "S" then
	if source <> this then
		if source.TypeOf() = DataWindow! then
			cliente     = uo_cliente.em_codigo.text
			reclamacion = sle_valor.text
			
			origen = source
			donde_origen = origen.getrow()
			donde        = this.insertrow(0)
			origen.object.ven_reclamaciones_detalle_reclamacion[donde_origen] = reclamacion
	
			this.object.ven_reclamaciones_detalle_empresa[donde]     = codigo_empresa
			this.object.ven_reclamaciones_detalle_cliente[donde]     = cliente
			this.object.ven_reclamaciones_detalle_reclamacion[donde] = reclamacion
			this.object.ven_reclamaciones_detalle_anyo[donde]        = origen.object.vista_venlialb_reclamaciones_anyo_albaran[donde_origen]   
			this.object.ven_reclamaciones_detalle_albaran[donde]     = origen.object.vista_venlialb_reclamaciones_albaran[donde_origen]   
			this.object.ven_reclamaciones_detalle_linea_albaran[donde] = origen.object.vista_venlialb_reclamaciones_linea[donde_origen]   
			this.object.ven_reclamaciones_detalle_cantidad[donde]    = origen.object.vista_venlialb_reclamaciones_cantidad[donde_origen]   
			this.object.ven_reclamaciones_detalle_descripcion[donde] = ''
			this.object.vista_venlialb_reclamaciones_falbaran[donde]     = origen.object.vista_venlialb_reclamaciones_falbaran[donde_origen]   
			this.object.vista_venlialb_reclamaciones_articulo[donde]     = origen.object.vista_venlialb_reclamaciones_articulo[donde_origen]   
			this.object.vista_venlialb_reclamaciones_tipo_unidad[donde]  = origen.object.vista_venlialb_reclamaciones_tipo_unidad[donde_origen]   
			this.object.vista_venlialb_reclamaciones_formato[donde]      = f_formato_articulo(codigo_empresa,origen.object.vista_venlialb_reclamaciones_articulo[donde_origen])
			this.object.vista_venlialb_reclamaciones_calidad[donde]      = origen.object.vista_venlialb_reclamaciones_calidad[donde_origen]   
			this.object.vista_venlialb_reclamaciones_calibre[donde]      = origen.object.vista_venlialb_reclamaciones_calibre[donde_origen]   
			this.object.vista_venlialb_reclamaciones_cantidad[donde]     = origen.object.vista_venlialb_reclamaciones_cantidad[donde_origen]   
			this.object.vista_venlialb_reclamaciones_descripcion[donde]  = origen.object.vista_venlialb_reclamaciones_descripcion[donde_origen]   
			this.object.vista_venlialb_reclamaciones_tipo_pallet[donde]  = origen.object.vista_venlialb_reclamaciones_tipo_pallet[donde_origen]   
			this.object.vista_venlialb_reclamaciones_ffactura[donde]     = origen.object.vista_venlialb_reclamaciones_ffactura[donde_origen]   
			this.object.vista_venlialb_reclamaciones_tono[donde]         = origen.object.vista_venlialb_reclamaciones_tono[donde_origen] 
			this.object.vista_venlialb_reclamaciones_factura[donde]  	= origen.object.vista_venlialb_reclamaciones_factura[donde_origen]  
			this.object.vista_venlialb_reclamaciones_albaran[donde]     = origen.object.vista_venlialb_reclamaciones_albaran[donde_origen]   
			/// Comprobamos si existe la línea                                                 
		end if
	end if
end if
end if
end event

event dw_pagina3::clicked;call super::clicked;if ib_modifi then


	this.selectrow(0,false)
	if row > 0 then		
		this.selectrow(row,true)
		this.setrow(row)
		cb_borrar_linea_detalle.enabled = true
	else
		cb_borrar_linea_detalle.enabled = false
		this.setrow(row)
	end if
end if
end event

event dw_pagina3::retrieveend;cb_borrar_linea_detalle.enabled = false
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 3602
integer height = 2068
string text = "Documentos"
string picturename = "Custom092!"
long picturemaskcolor = 553648127
dw_detalle_documento dw_detalle_documento
gb_6 gb_6
cb_anyadir_documento cb_anyadir_documento
cb_borrar_documento cb_borrar_documento
end type

on pagina_4.create
this.dw_detalle_documento=create dw_detalle_documento
this.gb_6=create gb_6
this.cb_anyadir_documento=create cb_anyadir_documento
this.cb_borrar_documento=create cb_borrar_documento
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle_documento
this.Control[iCurrent+2]=this.gb_6
this.Control[iCurrent+3]=this.cb_anyadir_documento
this.Control[iCurrent+4]=this.cb_borrar_documento
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_detalle_documento)
destroy(this.gb_6)
destroy(this.cb_anyadir_documento)
destroy(this.cb_borrar_documento)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 0
integer y = 0
integer width = 1307
integer height = 1956
string dataobject = "dw_mant_reclamaciones4"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina4::clicked;call super::clicked;//if row > 0 then
//	this.selectrow(0,false)
//	this.selectrow(row,true)
//	dw_detalle_documento.setrow(row)
//	dw_detalle_documento.scrolltorow(row)
//end if
end event

event dw_pagina4::rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	dw_detalle_documento.setrow(currentrow)
	dw_detalle_documento.scrolltorow(currentrow)
end if
end event

event dw_pagina4::retrieveend;call super::retrieveend;dw_detalle_documento.event retrieveend(rowcount)
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
event create ( )
event destroy ( )
integer width = 3602
integer height = 2068
string text = "Abonos Realizados"
string picturename = "Custom048!"
long picturemaskcolor = 553648127
st_5 st_5
em_fechadesdeabono em_fechadesdeabono
st_6 st_6
em_fechahastaabono em_fechahastaabono
cb_consulta_abonos cb_consulta_abonos
cb_borrar_abono cb_borrar_abono
gb_5 gb_5
gb_4 gb_4
dw_detalle_abonos_cliente dw_detalle_abonos_cliente
cb_1 cb_1
gb_10 gb_10
end type

on pagina_5.create
this.st_5=create st_5
this.em_fechadesdeabono=create em_fechadesdeabono
this.st_6=create st_6
this.em_fechahastaabono=create em_fechahastaabono
this.cb_consulta_abonos=create cb_consulta_abonos
this.cb_borrar_abono=create cb_borrar_abono
this.gb_5=create gb_5
this.gb_4=create gb_4
this.dw_detalle_abonos_cliente=create dw_detalle_abonos_cliente
this.cb_1=create cb_1
this.gb_10=create gb_10
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.em_fechadesdeabono
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.em_fechahastaabono
this.Control[iCurrent+5]=this.cb_consulta_abonos
this.Control[iCurrent+6]=this.cb_borrar_abono
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.dw_detalle_abonos_cliente
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.gb_10
end on

on pagina_5.destroy
call super::destroy
destroy(this.st_5)
destroy(this.em_fechadesdeabono)
destroy(this.st_6)
destroy(this.em_fechahastaabono)
destroy(this.cb_consulta_abonos)
destroy(this.cb_borrar_abono)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.dw_detalle_abonos_cliente)
destroy(this.cb_1)
destroy(this.gb_10)
end on

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 0
integer y = 0
integer width = 3575
integer height = 940
string dataobject = "dw_mant_reclamaciones5"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina5::clicked;call super::clicked;if ib_modifi then

	this.selectrow(0,false)
	if row > 0 then		
		this.selectrow(row,true)
		this.setrow(row)
		cb_borrar_abono.enabled = true
	else
		cb_borrar_abono.enabled = false
		this.setrow(row)
	end if
end if
end event

event dw_pagina5::retrieveend;cb_borrar_abono.enabled = false
end event

event dw_pagina5::dragdrop;long   donde,donde_origen
string cliente,reclamacion   


if ib_modifi then
//Soltamos el objeto
DataWindow origen
if dw_pag1.object.cerrada[1] <> "S" then
	if source <> this then
		if source.TypeOf() = DataWindow! then
			cliente     = uo_cliente.em_codigo.text
			reclamacion = sle_valor.text
			
			origen = source
			donde_origen = origen.getrow()
			donde        = this.insertrow(0)
			origen.object.ven_reclamaciones_abonos_reclamacion[donde_origen] = reclamacion
	
			this.object.ven_reclamaciones_abonos_empresa[donde]     = codigo_empresa
			this.object.ven_reclamaciones_abonos_cliente[donde]     = cliente
			this.object.ven_reclamaciones_abonos_reclamacion[donde] = reclamacion
			this.object.ven_reclamaciones_abonos_anyo[donde]        = origen.object.venfac_anyo[donde_origen]   
			this.object.ven_reclamaciones_abonos_factura[donde]     = origen.object.venfac_factura[donde_origen]   
			this.object.venfac_anyo[donde]                          = origen.object.venfac_anyo[donde_origen]   
			this.object.venfac_factura[donde]                       = origen.object.venfac_factura[donde_origen]   		
			this.object.venfac_divisa[donde]                        = origen.object.venfac_divisa[donde_origen]   
			this.object.venfac_cambio[donde]                        = origen.object.venfac_cambio[donde_origen]   
			this.object.venfac_ffactura[donde]                      = origen.object.venfac_ffactura[donde_origen]   
			this.object.venfac_total_fac[donde]                     = origen.object.venfac_total_fac[donde_origen]   
			this.object.venfac_total_fac_pts[donde]                 = origen.object.venfac_total_fac_pts[donde_origen]   
			this.object.venfac_textcomercial2[donde]                = origen.object.venfac_textcomercial2[donde_origen]   
		end if
	end if
end if
end if
end event

event dw_pagina5::dragwithin;if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3602
integer height = 2068
string text = "Gastos Ocasionados"
string picturename = "\bmp\dolar.bmp"
long picturemaskcolor = 553648127
cb_anyadir_fra_proveedor cb_anyadir_fra_proveedor
cb_borrar_fra_proveedor cb_borrar_fra_proveedor
gb_7 gb_7
end type

on pagina_6.create
this.cb_anyadir_fra_proveedor=create cb_anyadir_fra_proveedor
this.cb_borrar_fra_proveedor=create cb_borrar_fra_proveedor
this.gb_7=create gb_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_anyadir_fra_proveedor
this.Control[iCurrent+2]=this.cb_borrar_fra_proveedor
this.Control[iCurrent+3]=this.gb_7
end on

on pagina_6.destroy
call super::destroy
destroy(this.cb_anyadir_fra_proveedor)
destroy(this.cb_borrar_fra_proveedor)
destroy(this.gb_7)
end on

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer x = 0
integer y = 12
integer width = 3575
integer height = 1940
string dataobject = "dw_mant_reclamaciones7"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina6::key;if ib_modifi then

	bus_filtro     = ""
	bus_titulo     = ""
	bus_datawindow = ""
	bus_campo      = This.GetColumnName()
	valor_empresa  = TRUE
	CHOOSE CASE bus_campo
		CASE "proveedor"
			bus_filtro =""
			bus_datawindow = "dw_ayuda_proveedores"
			bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::key
end if
end event

event dw_pagina6::rbuttondown;if ib_modifi then

	bus_filtro     = ""
	bus_titulo     = ""
	bus_datawindow = ""
	bus_campo      = This.GetColumnName()
	valor_empresa  = TRUE
	CHOOSE CASE bus_campo
		CASE "proveedor"
			bus_filtro =""
			bus_datawindow = "dw_ayuda_proveedores"
			bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	CALL Super::RbuttonDown
end if
end event

event dw_pagina6::clicked;call super::clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3602
integer height = 2068
string text = "Resumen"
string picturename = "Properties!"
long picturemaskcolor = 553648127
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 0
integer y = 0
integer width = 3575
integer height = 2048
string dataobject = "dw_mant_reclamaciones8"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3602
integer height = 2068
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type dw_cliente_final from u_datawindow within pagina_1
integer x = 608
integer y = 516
integer width = 2889
integer height = 1100
integer taborder = 11
boolean titlebar = true
string title = "DATOS USUARIO FINAL"
string dataobject = "dw_mant_reclamaciones1_1"
boolean controlmenu = true
end type

event clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

	
CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais_colocacion")
   OpenSheetWithParm(wi_mant_paises,lstr_param,ventana_padre,5,Original!)  

CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais_colocacion")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"provincia_colocacion")
   OpenSheetWithParm(wi_mant_provincias,lstr_param,ventana_padre,5,Original!)

CASE 'pb_codpostal'
   lstr_param.i_nargumentos  = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais_colocacion")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"codigo_postal_colocacion")
   OpenSheetWithParm(wi_mant_codpostales,lstr_param,ventana_padre,5,Original!)


END CHOOSE
end event

event rbuttondown;
bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_datawindow =""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
		CASE "pais_colocacion"

		bus_filtro=""
		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
 		
   CASE "provincia_colocacion"

		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais_colocacion")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
//  
	CASE "codigo_postal_colocacion"

 	if not f_nulo_blanco(GetItemString(This.GetRow(),"pais_colocacion")) and &
	 not f_nulo_blanco(GetItemString(This.GetRow(),"provincia_colocacion")) then
		
		bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais_colocacion")+"' " + &
							 " and provincia = '" +GetItemString(This.GetRow(),"provincia_colocacion")+"' " 
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
	end if
	
	
 
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key;//IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	bus_filtro=""
	bus_titulo=""
	valor_empresa = TRUE	
	bus_campo = This.GetColumnName()

 	CHOOSE CASE bus_campo
		
		 		
		CASE "pais_colocacion"
 			bus_filtro = ""
			bus_datawindow = "dw_ayuda_paises"
			bus_titulo = "VENTANA SELECCION DE PAISES"
			valor_empresa = FALSE
			
   	CASE "provincia_colocacion"
	  		bus_datawindow = "dw_ayuda_provincias"
     		bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais_colocacion")+"'"
			bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
			valor_empresa = false
		CASE "codigo_postal_colocacion"

		if not f_nulo_blanco(GetItemString(This.GetRow(),"provincia_colocacion")) then
			bus_datawindow = "dw_ayuda_codpostales"
      	bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais_colocacion")+"' " + &
							 " and provincia = '" +GetItemString(This.GetRow(),"provincia_colocacion")+"' " 
      	bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
			valor_empresa = FALSE
		end if

	
		CASE ELSE
			SetNull(bus_campo)

 	END CHOOSE
 	
	CALL Super::Key

//END IF

end event

type cb_anyadir_fase from commandbutton within pagina_2
boolean visible = false
integer x = 9
integer y = 1456
integer width = 608
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Añadir Fase"
end type

event clicked;long indice,total,donde,codigo
datetime  ldt_fecha_inicio

total = dw_pag2.rowcount()

ldt_fecha_inicio = datetime(today(),now())

codigo = 0

for indice = 1 to total
	if dec(dw_pag2.object.codigo[indice]) > codigo then	
		codigo = dec(dw_pag2.object.codigo[indice])
	end if
next

codigo ++

donde = dw_pag2.insertrow(0)

dw_pag2.object.empresa[donde]                        = codigo_empresa
dw_pag2.object.cliente[donde]                        = uo_cliente.em_codigo.text
dw_pag2.object.reclamacion[donde]                    = sle_valor.text
dw_pag2.object.codigo[donde]                         = string(codigo,"###")
dw_pag2.object.codigo_ven_reclamaciones_fases[donde] = ""
dw_pag2.object.fecha_inicio[donde]                   = ldt_fecha_inicio
dw_pag2.object.fecha_fin[donde]                      = ldt_fecha_inicio
dw_pag2.object.usuario_inicio[donde]                 = nombre_usuario
dw_pag2.object.usuario_fin[donde]                    = ""
dw_pag2.object.codigo_ven_reclamaciones_sit_i[donde] = ""
dw_pag2.object.codigo_ven_reclamaciones_sit_f[donde] = ""
dw_pag2.object.observaciones[donde]                  = ""


dw_pag2.selectrow(0,false)
dw_pag2.selectrow(donde,true)
dw_pag2.setrow(donde)
dw_pag2.scrolltorow(donde)
dw_detalle_fase.setfocus()
dw_detalle_fase.setrow(donde)
dw_detalle_fase.scrolltorow(donde)
dw_detalle_fase.setcolumn("observaciones")

end event

type cb_borrar_fase from commandbutton within pagina_2
boolean visible = false
integer x = 690
integer y = 1456
integer width = 608
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Borrar Fase"
end type

event clicked;string descripcion
long   donde

donde = dw_pagina2.getrow()

if donde > 0 then
	descripcion = dw_pagina2.object.codigo_ven_reclamaciones_fases[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina2.object.fecha_inicio[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar la fase :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina2.deleterow(donde)
		if dw_pagina2.rowcount() > 0 then
			if donde > dw_pagina2.rowcount() then
				donde = donde -1
			end if
			dw_pagina2.selectrow(0,false)
			dw_pagina2.selectrow(donde,true)
			dw_pagina2.setrow(donde)
			dw_pagina2.scrolltorow(donde)	
			dw_detalle_fase.setrow(donde)
			dw_detalle_fase.scrolltorow(donde)			
		end if
	end if
end if
end event

type dw_detalle_fase from datawindow within pagina_2
integer x = 1317
integer width = 2258
integer height = 1744
integer taborder = 12
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones9_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

event itemchanged;
string ls_situacion_inicial,ls_situacion_final,ls_fase,ls_tipo_reclamacion,ls_causa_reclamacion
string ls_fase_siguiente,ls_situacion_siguiente,ls_cierre_reclamacion
string ls_sel,ls_situacion
long   ll_indice,ll_total,ll_donde
datastore ds_datos

if row= 0 then return

choose case dwo.name
	case "observaciones"
		ls_situacion_final = this.object.codigo_ven_reclamaciones_sit_f[row]
		if isnull(ls_situacion_final) then ls_situacion_final = ''
		if trim(ls_situacion_final) <> '' then
			//return 1
		end if
	case else
		apartados.pagina_2.dw_pagina2.event itemchanged(row,dwo,data)
end choose
end event

event itemerror;return 1
end event

type dw_situacion_final_fase from u_datawindow within pagina_2
integer x = 1317
integer y = 1772
integer width = 2258
integer height = 292
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones9_3"
end type

event itemchanged;call super::itemchanged;long   ll_donde
string situacion,ls_v_outlook 
boolean lb_continuar

if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
	if data = "S" then
		/// 1º Verificamos si el usuario tiene chequeado el outlook
		/// Comprobación de los avisos de confirmacion
		/// según el tipo de reclmación y su situacion
		ls_v_outlook = f_usuarios_v_outlook(nombre_usuario)
		if ls_v_outlook  = "S" then
			lb_continuar = wf_confirmaciones(row)
		else
			lb_continuar = true
		end if
		
		if lb_continuar then
		
			// Preguntamos
			if MessageBox("Fase "," Desea Concluir la Fase " + f_nombre_fases( codigo_empresa ,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_fases[apartados.pagina_2.dw_pagina2.getrow()] ) + " y pasar a la siguiente?", Question!, YesNo!, 2) <> 1 then
				lb_continuar = false
			else
				lb_continuar = true
			end if
			if lb_continuar then
				apartados.pagina_2.dw_pagina2.accepttext( )
				apartados.pagina_2.dw_detalle_fase.accepttext( )
				ll_donde = apartados.pagina_2.dw_pagina2.rowcount()
				apartados.pagina_2.dw_pagina2.object.fecha_fin[ll_donde] = datetime(today(),now())
				apartados.pagina_2.dw_pagina2.event itemchanged(apartados.pagina_2.dw_pagina2.getrow(),apartados.pagina_2.dw_pagina2.object.fecha_fin,string(apartados.pagina_2.dw_pagina2.object.fecha_fin[ll_donde]))							
				
				apartados.pagina_2.dw_pagina2.object.usuario_fin[ll_donde] = nombre_usuario	
				apartados.pagina_2.dw_pagina2.event itemchanged(apartados.pagina_2.dw_pagina2.getrow(),apartados.pagina_2.dw_pagina2.object.usuario_fin,apartados.pagina_2.dw_pagina2.object.usuario_fin[ll_donde])												
				
				apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_f[ll_donde] = this.object.situacion[row]		
				apartados.pagina_2.dw_pagina2.event itemchanged(apartados.pagina_2.dw_pagina2.getrow(),apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_f,apartados.pagina_2.dw_pagina2.object.codigo_ven_reclamaciones_sit_f[ll_donde])													
			
				/// Es correcto añadimos en ids_mail
				/// los campos que irán en el correo electrónico
				if ls_v_outlook  = "S" then
					wf_mensaje_mail(ll_donde)
				end if
	
			else
				//messagebox("Atenciónb", "Debe Revisar la configuración del tipo de reclamación")
				return 2
			end if
			return 2
		end if
end if	
//end if	

end event

type gb_8 from groupbox within pagina_2
integer y = 1948
integer width = 1307
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within pagina_3
integer x = 14
integer y = 712
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 128
long backcolor = 12632256
string text = "Fecha Albaran:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within pagina_3
integer x = 407
integer y = 712
integer width = 283
integer height = 76
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_4 from statictext within pagina_3
integer x = 690
integer y = 720
integer width = 46
integer height = 64
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
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within pagina_3
integer x = 736
integer y = 712
integer width = 283
integer height = 76
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_consulta_detalle_fras from commandbutton within pagina_3
integer x = 2016
integer y = 700
integer width = 270
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;datetime f_desde,f_hasta
string   cliente, ls_filtro

cliente = uo_cliente.em_codigo.text
f_desde = datetime(date(em_fechadesde.text))
f_hasta = datetime(date(em_fechahasta.text))

apartados.pagina_3.dw_detalle_facturas_cliente.setfilter("")
apartados.pagina_3.dw_detalle_facturas_cliente.filter()

apartados.pagina_3.dw_detalle_facturas_cliente.retrieve(codigo_empresa,cliente,f_desde,f_hasta)

if not f_nulo_blanco(em_albaran.text) then
	
	
	ls_filtro  = ("vista_venlialb_reclamaciones_albaran = " + em_albaran.text + "") 
	apartados.pagina_3.dw_detalle_facturas_cliente.setfilter(ls_filtro)
	apartados.pagina_3.dw_detalle_facturas_cliente.filter()
	
	
	
end if

if not f_nulo_blanco(em_factura.text) then
	
	ls_filtro  = ("vista_venlialb_reclamaciones_factura = " + em_factura.text + "") 
	apartados.pagina_3.dw_detalle_facturas_cliente.setfilter(ls_filtro)
	apartados.pagina_3.dw_detalle_facturas_cliente.filter()
	
	
end if


if not f_nulo_blanco(uo_articulo.em_campo.text) then
	
	ls_filtro  = ("vista_venlialb_reclamaciones_articulo = '" + uo_articulo.em_codigo.text + "'") 
	apartados.pagina_3.dw_detalle_facturas_cliente.setfilter(ls_filtro)
	apartados.pagina_3.dw_detalle_facturas_cliente.filter()
	
		
end if
end event

type dw_detalle_facturas_cliente from datawindow within pagina_3
integer y = 888
integer width = 3849
integer height = 1180
string dragicon = "\bmp\Dragitem.ico"
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones3_new"
boolean minbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string reclamacion
if row > 0 then
	if not(cb_insertar.enabled) then
		apartados.TriggerEvent("pulsar_datawindow")
	end if	
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)
	//reclamacion = this.object.ven_reclamaciones_detalle_reclamacion[row]
	if isnull(reclamacion) then reclamacion = ""
	if trim(reclamacion) = "" then
		drag(begin!)
	end if
end if
end event

type gb_3 from groupbox within pagina_3
integer x = 2542
integer y = 660
integer width = 1317
integer height = 128
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within pagina_3
integer y = 672
integer width = 2299
integer height = 208
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_borrar_linea_detalle from commandbutton within pagina_3
integer x = 2551
integer y = 696
integer width = 1298
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Linea Seleccionada"
end type

event clicked;long   donde,anyo,albaran,linea_albaran,total_lineas
string busqueda

if dw_pagina3.getrow() > 0 then
	if messagebox("Confirmación","¿Desea borrar la linea seleccionada?",Question!,YesNo!,2)= 1 then
		donde         = dw_pagina3.getrow()
		anyo          = dw_pagina3.object.ven_reclamaciones_detalle_anyo[donde]
		albaran      = dw_pagina3.object.ven_reclamaciones_detalle_albaran[donde]
		linea_albaran = dw_pagina3.object.ven_reclamaciones_detalle_linea_albaran[donde]
		dw_pagina3.deleterow(donde)
		
		total_lineas = apartados.pagina_3.dw_detalle_facturas_cliente.rowcount()
		if total_lineas > 0 then
			busqueda = "vista_venlialb_reclamaciones_anyo_albaran = "+string(anyo,"####")+" and vista_venlialb_reclamaciones_albaran = "+string(albaran,"########")+" and vista_venlialb_reclamaciones_linea = "+string(linea_albaran,"####")
			donde = apartados.pagina_3.dw_detalle_facturas_cliente.find(busqueda,1,total_lineas)
			
			if donde > 0 then
				apartados.pagina_3.dw_detalle_facturas_cliente.object.ven_reclamaciones_detalle_reclamacion[donde] = ""
				apartados.pagina_3.dw_detalle_facturas_cliente.object.ven_reclamaciones_detalle_descripcion[donde] = ""
			end if
		end if
	end if
end if
end event

type st_7 from statictext within pagina_3
integer x = 1033
integer y = 712
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 128
long backcolor = 12632256
string text = "Albaran:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_albaran from u_em_campo within pagina_3
integer x = 1271
integer y = 708
integer width = 219
integer height = 76
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#####"
string displaydata = ""
end type

type st_8 from statictext within pagina_3
integer x = 1513
integer y = 708
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 128
long backcolor = 12632256
string text = "Factura:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_factura from u_em_campo within pagina_3
integer x = 1751
integer y = 708
integer width = 219
integer height = 76
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#####"
string displaydata = ""
end type

type st_9 from statictext within pagina_3
integer x = 14
integer y = 784
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 128
long backcolor = 12632256
string text = "Articulo:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within pagina_3
event destroy ( )
integer x = 407
integer y = 788
integer width = 1792
integer height = 72
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF

end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

type dw_detalle_documento from u_datawindow within pagina_4
integer x = 1317
integer width = 2258
integer height = 2048
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones4_2"
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

type gb_6 from groupbox within pagina_4
integer y = 1928
integer width = 1307
integer height = 116
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_anyadir_documento from commandbutton within pagina_4
integer x = 9
integer y = 1964
integer width = 608
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Añadir Documento"
end type

event clicked;long indice,total,donde,documento

total = dw_pag4.rowcount()

documento = 0

for indice = 1 to total
	if dec(dw_pag4.object.documento[indice]) > documento then	
		documento = dec(dw_pag4.object.documento[indice])
	end if
next

documento ++

donde = dw_pag4.insertrow(0)

dw_pag4.object.empresa[donde]     = codigo_empresa
dw_pag4.object.cliente[donde]     = uo_cliente.em_codigo.text
dw_pag4.object.reclamacion[donde] = sle_valor.text
dw_pag4.object.documento[donde]   = string(documento,"###")

dw_pag4.selectrow(0,false)
dw_pag4.selectrow(donde,true)
dw_pag4.setrow(donde)
dw_pag4.scrolltorow(donde)
dw_detalle_documento.setfocus()
dw_detalle_documento.setrow(donde)
dw_detalle_documento.scrolltorow(donde)
dw_detalle_documento.setcolumn("fecha")

end event

type cb_borrar_documento from commandbutton within pagina_4
integer x = 690
integer y = 1964
integer width = 608
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Borrar Documento"
end type

event clicked;string descripcion
long   donde

donde = dw_pagina4.getrow()

if donde > 0 then
	descripcion = dw_pagina4.object.descripcion[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina4.object.fecha[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar el documento :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina4.deleterow(donde)
		if dw_pagina4.rowcount() > 0 then
			if donde > dw_pagina4.rowcount() then
				donde = donde -1
			end if
			dw_pagina4.selectrow(0,false)
			dw_pagina4.selectrow(donde,true)
			dw_pagina4.setrow(donde)
			dw_pagina4.scrolltorow(donde)	
			dw_detalle_documento.setrow(donde)
			dw_detalle_documento.scrolltorow(donde)			
		end if
	end if
end if
end event

type st_5 from statictext within pagina_5
integer x = 14
integer y = 956
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 128
long backcolor = 12632256
string text = "Fecha Abono:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fechadesdeabono from u_em_campo within pagina_5
integer x = 407
integer y = 956
integer width = 283
integer height = 76
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_6 from statictext within pagina_5
integer x = 690
integer y = 960
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahastaabono from u_em_campo within pagina_5
integer x = 736
integer y = 956
integer width = 283
integer height = 76
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_consulta_abonos from commandbutton within pagina_5
integer x = 1029
integer y = 956
integer width = 270
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;datetime f_desde,f_hasta
string   cliente

cliente = uo_cliente.em_codigo.text
f_desde = datetime(date(em_fechadesdeabono.text))
f_hasta = datetime(date(em_fechahastaabono.text))

apartados.pagina_5.dw_detalle_abonos_cliente.retrieve(codigo_empresa,cliente,f_desde,f_hasta)

end event

type cb_borrar_abono from commandbutton within pagina_5
integer x = 2267
integer y = 952
integer width = 1298
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Linea Seleccionada"
end type

event clicked;long   donde,anyo,factura,total_lineas
string busqueda

if dw_pagina5.getrow() > 0 then
	if messagebox("Confirmación","¿Desea borrar la linea seleccionada?",Question!,YesNo!,2)= 1 then
		donde         = dw_pagina5.getrow()
		anyo          = dw_pagina5.object.venfac_anyo[donde]
		factura       = dw_pagina5.object.venfac_factura[donde]
		
		dw_pagina5.deleterow(donde)
		
		total_lineas = apartados.pagina_5.dw_detalle_abonos_cliente.rowcount()
		if total_lineas > 0 then
			busqueda = "venfac_anyo = "+string(anyo,"####")+" and venfac_factura = "+string(factura,"########")
			donde = apartados.pagina_5.dw_detalle_abonos_cliente.find(busqueda,1,total_lineas)
			
			if donde > 0 then
				apartados.pagina_5.dw_detalle_abonos_cliente.object.ven_reclamaciones_abonos_reclamacion[donde] = ""
			end if
		end if
	end if
end if
end event

type gb_5 from groupbox within pagina_5
integer x = 2258
integer y = 920
integer width = 1317
integer height = 128
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within pagina_5
integer y = 920
integer width = 1317
integer height = 128
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type dw_detalle_abonos_cliente from datawindow within pagina_5
integer x = 5
integer y = 1056
integer width = 3575
integer height = 940
integer taborder = 20
string dragicon = "\bmp\Dragitem.ico"
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones6"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string reclamacion
if row > 0 then
	if not(cb_insertar.enabled) then
		apartados.TriggerEvent("pulsar_datawindow")
	end if	
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)
	
	reclamacion = this.object.ven_reclamaciones_abonos_reclamacion[row]
	if isnull(reclamacion) then reclamacion = ""
	if trim(reclamacion) = "" then
		drag(begin!)
	end if
end if
end event

type cb_1 from commandbutton within pagina_5
integer x = 1326
integer y = 952
integer width = 923
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Generar Abono"
end type

event clicked;int  li_anyo,li_anyo_albaran,lineas_de_abono_generadas,ll_indice_lineas_abonar,li_anyo_fra_abonar
long ll_factura,ll_linea_factura,ll_indice,ll_total,ll_albaran,ll_linea_albaran,ll_fra_abonar
dec  ld_cantidad_reclamacion,ld_cantidad_reclamacion_negativa

str_parametros lstr_param

ll_total = dw_pag3.rowcount()

ll_indice_lineas_abonar = 3
li_anyo_fra_abonar      = 0
ll_fra_abonar           = 0
for ll_indice = 1 to ll_total
	li_anyo                 = dw_pag3.object.ven_reclamaciones_detalle_anyo[ll_indice]
	ll_factura              = dw_pag3.object.ven_reclamaciones_detalle_factura[ll_indice]
	ll_linea_factura        = dw_pag3.object.ven_reclamaciones_detalle_linea_factura[ll_indice]
	ld_cantidad_reclamacion = dw_pag3.object.ven_reclamaciones_detalle_cantidad[ll_indice]
	ld_cantidad_reclamacion_negativa = - ld_cantidad_reclamacion
	
	if (li_anyo_fra_abonar = 0 and ll_fra_abonar = 0) or (li_anyo_fra_abonar = li_anyo and ll_fra_abonar = ll_factura) then
		//Comprobamos si esa linea ya ha generado abonos
		select anyo_albaran, 
				 albaran, 
				 linea
		into   :li_anyo_albaran, 
				 :ll_albaran, 
				 :ll_linea_albaran
		from   venlifac
		where  empresa = :codigo_empresa
		and    anyo    = :li_anyo
		and    factura = :ll_factura
		and    linea_factura = :ll_linea_factura;
		
		if isnull(li_anyo_albaran) then li_anyo_albaran = 0
		if isnull(ll_albaran) then ll_albaran = 0
		if isnull(ll_linea_albaran) then ll_linea_albaran = 0
		
		if li_anyo_albaran <> 0 and ll_albaran <> 0 and ll_linea_albaran <> 0 then
			lineas_de_abono_generadas = 0
			
			select count(*)
			into   :lineas_de_abono_generadas
			from   venlifac
			where  empresa      = :codigo_empresa
			and    anyo_albaran = :li_anyo_albaran
			and    albaran      = :ll_albaran
			and    linea        = :ll_linea_albaran
			and    cantidad     = :ld_cantidad_reclamacion_negativa
			and   (anyo <> :li_anyo or factura <> :ll_factura);
			
			if isnull(lineas_de_abono_generadas) then lineas_de_abono_generadas = 0
			
		else
			lineas_de_abono_generadas = 0
		end if
		
		if lineas_de_abono_generadas = 0 then			
			li_anyo_fra_abonar = li_anyo 
			ll_fra_abonar      = ll_factura
			ll_indice_lineas_abonar ++
			lstr_param.s_argumentos[ll_indice_lineas_abonar] = string(ll_linea_albaran,"###0")
			ll_indice_lineas_abonar ++
			lstr_param.s_argumentos[ll_indice_lineas_abonar] = string(ld_cantidad_reclamacion,"#########0.00####")
		end if	
	end if	
next

lstr_param.i_nargumentos   = ll_indice_lineas_abonar
lstr_param.s_argumentos[2] = string(li_anyo_fra_abonar,"###0")
lstr_param.s_argumentos[3] = string(ll_fra_abonar,"#####0")

//OpenSheetWithParm(w_int_genera_facturas_abono,lstr_param,apartados.GetParent(),3,Original!)  

end event

type gb_10 from groupbox within pagina_5
integer x = 1317
integer y = 920
integer width = 942
integer height = 128
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_anyadir_fra_proveedor from commandbutton within pagina_6
integer x = 9
integer y = 1968
integer width = 608
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Añadir factura"
end type

event clicked;long indice,total,donde,gasto

total = dw_pag6.rowcount()

gasto = 0

for indice = 1 to total
	if dec(dw_pag6.object.gasto[indice]) > gasto then	
		gasto = dec(dw_pag6.object.gasto[indice])
	end if
next

gasto ++

donde = dw_pag6.insertrow(0)

dw_pag6.object.empresa[donde]     = codigo_empresa
dw_pag6.object.cliente[donde]     = uo_cliente.em_codigo.text
dw_pag6.object.reclamacion[donde] = sle_valor.text
dw_pag6.object.gasto[donde]       = string(gasto,"###")

dw_pag6.selectrow(0,false)
dw_pag6.selectrow(donde,true)
dw_pag6.setrow(donde)
dw_pag6.scrolltorow(donde)
dw_pag6.setfocus()
dw_pag6.setcolumn("proveedor")

end event

type cb_borrar_fra_proveedor from commandbutton within pagina_6
integer x = 690
integer y = 1968
integer width = 608
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Borrar Factura"
end type

event clicked;string descripcion
long   donde

donde = dw_pagina6.getrow()

if donde > 0 then
	descripcion = dw_pagina6.object.fra_proveedor[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina6.object.fecha_fra_proveedor[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar la factura :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina6.deleterow(donde)
		if dw_pagina6.rowcount() > 0 then
			if donde > dw_pagina6.rowcount() then
				donde = donde -1
			end if
			dw_pagina6.selectrow(0,false)
			dw_pagina6.selectrow(donde,true)
			dw_pagina6.setrow(donde)
			dw_pagina6.scrolltorow(donde)	
		end if
	end if
end if
end event

type gb_7 from groupbox within pagina_6
integer y = 1932
integer width = 1307
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_mant_reclamaciones_gno
integer x = 37
integer y = 124
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_mant_reclamaciones_gno
event destroy ( )
integer x = 375
integer y = 116
integer width = 1586
integer height = 76
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text = f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text) = "" then
	uo_cliente.em_campo.text  = ""
	uo_cliente.em_codigo.text = ""
	Return
end if 
sle_valor.text = ""
end event

event getfocus;call super::getfocus;
ue_titulo     = "Selección de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_1 from groupbox within w_mant_reclamaciones_gno
integer x = 14
integer y = 76
integer width = 2167
integer height = 208
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_descripcion_reclamacion from statictext within w_mant_reclamaciones_gno
integer x = 590
integer y = 200
integer width = 1367
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
boolean enabled = false
boolean focusrectangle = false
end type

type pb_calculadora from picturebutton within w_mant_reclamaciones_gno
integer x = 1966
integer y = 116
integer width = 201
integer height = 156
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\calcula.bmp"
string disabledname = "\bmp\calculadisabled.bmp"
alignment htextalign = left!
end type

event clicked;string cliente
long   ultima_reclamacion

cliente = uo_cliente.em_codigo.text

ids_mail.reset() 

if cliente <> "" then
	
	
	select max(convert(int,reclamacion))
	into   :ultima_reclamacion
	from   ven_reclamaciones
	where  empresa = :codigo_empresa;
	//and    cliente = :cliente;
	
	if isnull(ultima_reclamacion) then ultima_reclamacion = 0
	
	ultima_reclamacion ++
	
	sle_valor.text = string(ultima_reclamacion,"#####")
	st_descripcion_reclamacion.text = ""
	apartados.TriggerEvent("pulsar_datawindow")
else
	
	messagebox ("Cliente", "Debe seleccionar un cliente")
end if
end event

type report from datawindow within w_mant_reclamaciones_gno
boolean visible = false
integer x = 2245
integer y = 8
integer width = 265
integer height = 84
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "report_mant_reclamaciones1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from upb_imprimir within w_mant_reclamaciones_gno
integer x = 2235
integer y = 168
integer taborder = 11
boolean bringtotop = true
end type

event clicked;call super::clicked;long registros

registros = report.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,trim(sle_valor.Text))

if registros > 0 then
	f_imprimir_datawindow(report)
else
	messagebox("Atención!","No hay registros para imprimir.")
end if

end event

type dw_mail from datawindow within w_mant_reclamaciones_gno
boolean visible = false
integer x = 2665
integer y = 20
integer width = 265
integer height = 84
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_comodin"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_9 from groupbox within w_mant_reclamaciones_gno
integer x = 2181
integer y = 660
integer width = 1317
integer height = 128
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

