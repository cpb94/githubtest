$PBExportHeader$rf_imprimir_banda_bulto.srw
forward
global type rf_imprimir_banda_bulto from window
end type
type dw_datos from datawindow within rf_imprimir_banda_bulto
end type
type st_paso3 from statictext within rf_imprimir_banda_bulto
end type
type pb_atras from picturebutton within rf_imprimir_banda_bulto
end type
type st_paso2 from statictext within rf_imprimir_banda_bulto
end type
type st_paso1 from statictext within rf_imprimir_banda_bulto
end type
type pb_aceptar from picturebutton within rf_imprimir_banda_bulto
end type
type dw_impresion_contenido_bulto_sin_prep from datawindow within rf_imprimir_banda_bulto
end type
type ln_1 from line within rf_imprimir_banda_bulto
end type
type uo_lectura_origen from u_sle_codbar within rf_imprimir_banda_bulto
end type
type pb_salir from picturebutton within rf_imprimir_banda_bulto
end type
end forward

global type rf_imprimir_banda_bulto from window
integer width = 8773
integer height = 3980
boolean titlebar = true
string title = "Traspasos de Ubicación"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_datos dw_datos
st_paso3 st_paso3
pb_atras pb_atras
st_paso2 st_paso2
st_paso1 st_paso1
pb_aceptar pb_aceptar
dw_impresion_contenido_bulto_sin_prep dw_impresion_contenido_bulto_sin_prep
ln_1 ln_1
uo_lectura_origen uo_lectura_origen
pb_salir pb_salir
end type
global rf_imprimir_banda_bulto rf_imprimir_banda_bulto

type variables
string is_tipo_movimiento_salida = '102'
string is_tipo_movimiento_entrada = '103'
long   il_color_fondo_activo,il_color_fondo_inactivo
int    ii_paso_actual = 1

str_parametros  istr_parametros
end variables

forward prototypes
public function boolean f_cargar_banda (long arg_alm_bultos_id)
public subroutine f_cargar_dw (long arg_oc)
end prototypes

public function boolean f_cargar_banda (long arg_alm_bultos_id);integer li_lineas_banda = 15,li_lineas_bulto,li_banda,li_bandas_bulto,li_row_desde_detalle,li_row_hasta_detalle
long    ll_lineas_banda

string  ls_ean_13
boolean lb_impresion_cancelada = false
long    ll_id_alm_orden_carga = 0,ll_bulto = 0

/*
SELECT count(*) as lineas
INTO   :li_lineas_bulto
FROM   venliped,   
		 articulos,   
		 almartcajas,   
		 formatos,
		 ventipolin  
WHERE ( venliped.empresa  = articulos.empresa ) 
AND   ( venliped.articulo = articulos.codigo ) 
AND   ( venliped.empresa  = almartcajas.empresa ) 
AND   ( venliped.articulo = almartcajas.articulo ) 
AND   ( venliped.caja     = almartcajas.caja ) 
AND   ( articulos.empresa = formatos.empresa ) 
AND   ( articulos.formato = formatos.codigo ) 
AND   ( venliped.empresa  = ventipolin.empresa ) 
AND   ( venliped.tipolinea = ventipolin.codigo ) 
AND ( ( venliped.empresa  = :codigo_empresa ) 
AND   ( venliped.id_alm_orden_carga = :ll_id_alm_orden_carga ) 
AND   ( venliped.bulto_desde_orden_carga <= :ll_bulto and venliped.bulto_hasta_orden_carga >= :ll_bulto ) );				
*/

li_bandas_bulto = Truncate(li_lineas_bulto / li_lineas_banda, 0)

if Mod(li_lineas_bulto,li_lineas_banda) > 0 then li_bandas_bulto ++

li_row_hasta_detalle = 0

for li_banda = 1 to li_bandas_bulto
	//Imprimimos banda a banda por la capacidad limitada de mostrar el contenido
	
	li_row_desde_detalle = li_row_hasta_detalle +1
	li_row_hasta_detalle = li_banda * li_lineas_banda
	
	ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_orden_carga,ll_bulto,li_row_desde_detalle,li_row_hasta_detalle)
	
	if ll_lineas_banda > 0 then

		ls_ean_13 = ""//ds_datos_bultos.object.alm_bultos_ean13[ll_indice_bultos]
		dw_impresion_contenido_bulto_sin_prep.object.alm_bultos_ean13[1] = ls_ean_13

		
		if li_banda = 1 then
			if not(f_imprimir_datawindow(dw_impresion_contenido_bulto_sin_prep)) then
				lb_impresion_cancelada = true
			end if
		else
			if not(lb_impresion_cancelada) then
				dw_impresion_contenido_bulto_sin_prep.print(false)
			end if
		end if
	end if				
next				


return true
end function

public subroutine f_cargar_dw (long arg_oc);string cadena
string ls_sel,ls_filtro_cliente,ls_filtro_envio,ls_filtro_articulo_calidad
long   ll_total,ll_row,ll_rows
datastore ds_datos

cadena =   "SELECT venped.empresa, ~n"+&
			  "		 venped.anyo, ~n"+&
			  "		 venped.pedido, ~n"+& 
			  "		 venped.fpedido, ~n"+&
			  "		 venped.cliente, ~n"+&
			  "		 genter.razon, ~n"+&
			  "		 venped.observaciones, ~n"+&
			  "		 venped.numpedcli, ~n"+&
			  "		 venped.envio, ~n"+&
			  "		 venenvio.descripcion, ~n"+&
			  "		 venliped.linea, ~n"+&
			  "		 venliped.articulo, ~n"+&
			  "		 isnull(venliped.descripcion,articulos.descripcion), ~n"+&
			  "		 articulos.familia, ~n"+&
			  "		 familias.descripcion, ~n"+&
			  "		 articulos.formato, ~n"+&
			  "		 formatos.abreviado, ~n"+&
			  "		 articulos.promocion, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end as articulos_unidad, ~n"+&
			  "		 isnull(unidades.abreviado,'Uds') as unidades_abreviado, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then 0 else isnull(case when articulos.decimales_unidad is null then unidades.decimales else articulos.decimales_unidad end,0) end as decimales_unidad, ~n"+&
			  "		 venliped.calidad, ~n"+&
			  "		 calidades.abreviado, ~n"+&
			  "		 venliped.tonochar, ~n"+&
			  "		 venliped.calibre, ~n"+&
			  "		 venliped.tipo_pallet, ~n"+&
			  "		 pallets.resumido, ~n"+&
			  "		 venliped.caja, ~n"+&
			  "		 almcajas.descripcion_abr, ~n"+&
			  "		 case when ventipolin.gestionar_en_piezas = 'S' then venliped.cantidad_pzs else venliped.cantidad end as venliped_cantidad, ~n"+&
			  "		 venliped.pallets, ~n"+&
			  "		 venliped.cajas, ~n"+&
			  "		 case when isnull(venliped.articulo,'') = '' then 'C' else venliped.situacion end as venliped_situacion, ~n"+&
			  "       isnull(venliped.id_alm_orden_carga,0) as id_alm_orden_carga, ~n"+&
			  "       isnull(venliped.ordenacion_orden_carga,0) as ordenacion_orden_carga, ~n"+&
			  "       isnull(venliped.bulto_desde_orden_carga,0) as bulto_desde_orden_carga, ~n"+&
			  "       isnull(venliped.bulto_hasta_orden_carga,0) as bulto_hasta_orden_carga, ~n"+&
			  "       venliped.tipolinea, ~n"+&
			  "       convert(dec(10,2), venliped.peso + ( ( case when venliped.situacion = 'P' then 0 else convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) else 0 end ) end) * pallets.peso ) ) as peso_bruto_calculado_kg, ~n"+&			  
			  "       -1 as id_alm_orden_carga_actual, ~n"+&
			  "       -1.000 as disponible, ~n"+&
			  "       0.000 as planificado, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_minima, ~n"+&
			  "       isnull(venliped.fentrega,venliped.fentrega) as fecha_fin_planificacion_maxima, ~n"+&
			  "       case when isnull(venliped.articulo,'') = '' then 40 else case venliped.situacion when 'P' then 50 when 'C' then 40 else 10 end end as estado_linea, ~n"+&
			  "       case when venliped.situacion = 'P' then 0 else convert(dec(16,2), case when isnull(palarticulo.cajaspallet,0) <> 0 then ( ( ( venliped.cantidad ) % ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) / ( isnull( case when articulos.unidad = '1' then almartcajas.metroscaja else almartcajas.piezascaja end * palarticulo.cajaspallet ,0) ) ) * 100 else 0 end ) end as porcentaje_pallet_pico, ~n"+&
			  "       venped.fentrega, ~n"+&			  
			  "       venped.usuario, ~n"+&			  
			  "       alm_orden_carga.fecha as fecha_carga, ~n"+&
			  "       isnull(ventipolin.gestionar_en_piezas,'') as gestionar_en_piezas, ~n"+&	
			  "       isnull((select count(*) from venliped as venliped_conteo_cerrado where venliped_conteo_cerrado.empresa = alm_orden_carga.empresa and venliped_conteo_cerrado.id_alm_orden_carga = alm_orden_carga.id and isnull(venliped_conteo_cerrado.articulo,'') <> '' and venliped_conteo_cerrado.situacion <> 'P'),0) as lineas_sin_cerrar ~n"+&	
			  "       ,venped.es_courier as courier ~n"+&	
  			  "       ,isnull(alm_orden_carga.confirmada,'N') as orden_confirmada ~n"+&  
			  "       ,isnull(alm_orden_carga.observaciones,'') as observaciones_oc, ~n"+&  
			  "       isnull(venliped.id_alm_orden_preparacion,0) as id_alm_orden_preparacion, ubica.code39 as ubicacion ~n"+&
			  "FROM  venped ~n"+&
			  "      INNER JOIN venliped ON venped.empresa = venliped.empresa AND venped.anyo = venliped.anyo AND venped.pedido = venliped.pedido ~n"+&
			  "      LEFT OUTER JOIN ventipolin ON ventipolin.empresa = venliped.empresa and ventipolin.codigo = venliped.tipolinea ~n"+&
			  "      INNER JOIN alm_orden_carga ON venliped.empresa = alm_orden_carga.empresa AND venliped.id_alm_orden_carga = alm_orden_carga.id AND 'S' = alm_orden_carga.confirmada ~n"+&  
			  "		LEFT OUTER JOIN venenvio ON venped.empresa = venenvio.empresa AND venped.cliente = venenvio.cliente AND venped.envio = venenvio.codigo ~n"+&
		 	  "		LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo ~n"+&
			  "      LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
			  "      LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo "+&			  
			  "      LEFT OUTER JOIN unidades ON ( case when ventipolin.gestionar_en_piezas = 'S' then '0' else articulos.unidad end ) = unidades.codigo ~n"+&
			  "		LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo ~n"+&
			  "		LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo ~n"+&
			  "		LEFT OUTER JOIN almcajas ON venliped.empresa = almcajas.empresa AND venliped.caja = almcajas.codigo ~n"+&
			  "		LEFT OUTER JOIN almartcajas ON venliped.empresa = almartcajas.empresa AND venliped.articulo = almartcajas.articulo AND venliped.caja = almartcajas.caja ~n"+&
			  "		LEFT OUTER JOIN palarticulo ON venliped.empresa = palarticulo.empresa AND venliped.articulo = palarticulo.articulo AND venliped.tipo_pallet = palarticulo.codigo AND venliped.caja = palarticulo.caja ~n"+&			  
			  "		left join (select anyo, pedido, linea, code39"+&
			  "						 from	(select alm_bultos_lineas_id, anyo, pedido, linea from venliped_reservas where empresa = '"+codigo_empresa+"') res"+&
			  "							inner join (select id, id_alm_bultos from alm_bultos_lineas where empresa = '"+codigo_empresa+"') as bullin"+&
			  "								on bullin.id = res.alm_bultos_lineas_id"+&
			  "							inner join (select id, id_ubicacion from alm_bultos where empresa = '"+codigo_empresa+"') as bul"+&
			  "								on bul.id = bullin.id_alm_bultos"+&
			  "							inner join (select id, code39 from almubimapa_codbar where empresa = '"+codigo_empresa+"') as cod"+&
			  "								on bul.id_ubicacion = cod.id) as ubica"+&
			  "	 		on ubica.anyo = venliped.anyo and ubica.pedido = venliped.pedido and ubica.linea = venliped.linea"+&
			  "		,genter ~n"+&
			  "WHERE ( venped.empresa    = genter.empresa ) ~n"+&
			  "AND   ( 'C'               = genter.tipoter ) ~n"+&
			  "AND   ( venped.cliente    = genter.codigo ) ~n"+&
			  "AND   ( venped.es_proforma = 'N' ) ~n"+&
			  "AND   ( venped.empresa    = '"+codigo_empresa+"' ) ~n"+&
			  "AND	venliped.id_alm_orden_carga = '" + string(arg_oc) + "'"

//clipboard(cadena)


pointer oldpointer
oldpointer = SetPointer(HourGlass!)

dw_datos.reset()
dw_datos.setredraw(false)
	
ll_rows = f_cargar_cursor_transaccion(sqlca, ds_datos, cadena)

if ll_rows > 0 then
	dw_datos.object.data = ds_datos.object.data
	dw_datos.Event rowfocuschanged(1)
end if

destroy ds_datos

dw_datos.setredraw(true)

SetPointer(oldpointer)
end subroutine

on rf_imprimir_banda_bulto.create
this.dw_datos=create dw_datos
this.st_paso3=create st_paso3
this.pb_atras=create pb_atras
this.st_paso2=create st_paso2
this.st_paso1=create st_paso1
this.pb_aceptar=create pb_aceptar
this.dw_impresion_contenido_bulto_sin_prep=create dw_impresion_contenido_bulto_sin_prep
this.ln_1=create ln_1
this.uo_lectura_origen=create uo_lectura_origen
this.pb_salir=create pb_salir
this.Control[]={this.dw_datos,&
this.st_paso3,&
this.pb_atras,&
this.st_paso2,&
this.st_paso1,&
this.pb_aceptar,&
this.dw_impresion_contenido_bulto_sin_prep,&
this.ln_1,&
this.uo_lectura_origen,&
this.pb_salir}
end on

on rf_imprimir_banda_bulto.destroy
destroy(this.dw_datos)
destroy(this.st_paso3)
destroy(this.pb_atras)
destroy(this.st_paso2)
destroy(this.st_paso1)
destroy(this.pb_aceptar)
destroy(this.dw_impresion_contenido_bulto_sin_prep)
destroy(this.ln_1)
destroy(this.uo_lectura_origen)
destroy(this.pb_salir)
end on

event open;il_color_fondo_activo   = st_paso1.backcolor
il_color_fondo_inactivo = st_paso2.backcolor

dw_impresion_contenido_bulto_sin_prep.Object.DataWindow.Zoom = 65
dw_datos.Object.DataWindow.Zoom = 120


dw_impresion_contenido_bulto_sin_prep.settransobject(sqlca)

uo_lectura_origen.SetFocus()
uo_lectura_origen.event getfocus()

istr_parametros = Message.PowerObjectParm

if istr_parametros.i_nargumentos = 2 then
	uo_lectura_origen.sle_codbar.text = istr_parametros.s_argumentos[2]
	uo_lectura_origen.sle_codbar.event modified()
end if
end event

type dw_datos from datawindow within rf_imprimir_banda_bulto
integer x = 4709
integer width = 4014
integer height = 3860
integer taborder = 50
boolean titlebar = true
string title = "ORDEN DE CARGA ACTUAL"
string dataobject = "dw_consulta_situacion_ordenes_carga_bandas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_paso3 from statictext within rf_imprimir_banda_bulto
boolean visible = false
integer x = 2917
integer y = 4
integer width = 1403
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
string text = "3"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_atras from picturebutton within rf_imprimir_banda_bulto
integer y = 3176
integer width = 800
integer height = 700
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Back.png"
string disabledname = "C:\bmp\RF\Back_dis.png"
alignment htextalign = left!
end type

event clicked;choose case ii_paso_actual
	case 2
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
	case 3
		/*
		uo_lectura_destino.SetFocus()
		uo_lectura_destino.event getfocus()			
		*/
	case else
		uo_lectura_origen.SetFocus()
		uo_lectura_origen.event getfocus()		
end choose
end event

type st_paso2 from statictext within rf_imprimir_banda_bulto
integer x = 1463
integer y = 4
integer width = 1403
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Impresión"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_paso1 from statictext within rf_imprimir_banda_bulto
integer x = 18
integer y = 4
integer width = 1403
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
string text = "Bulto"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_aceptar from picturebutton within rf_imprimir_banda_bulto
integer x = 3863
integer y = 3172
integer width = 800
integer height = 700
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\db-Post.png"
string disabledname = "C:\bmp\RF\db-Post_dis.png"
alignment htextalign = left!
end type

event clicked;integer li_lineas_bulto,li_max_lineas_banda = 15,li_banda,li_bandas_bulto
integer li_row_desde_detalle,li_row_hasta_detalle,li_bulto_orden_carga,li_lineas_pedido_bulto,li_bulto_desde_orden_carga,li_bulto_hasta_orden_carga
integer li_ultimo_bulto_orden_carga,li_indice_lineas_pedido_bulto
long    ll_lineas_banda,ll_id_alm_bultos
string  ls_sel
str_venliped lstr_venliped
datastore ds_datos_bulto

dw_impresion_contenido_bulto_sin_prep.setredraw(false)

dw_impresion_contenido_bulto_sin_prep.Object.DataWindow.Zoom = 100

ll_id_alm_bultos = uo_lectura_origen.il_id_bulto

//Renumeración del bulto si es necesario (Renumerar el numero de bulto en venliped)
SELECT min(isnull(venliped_reservas.bulto_orden_carga,0)) as bulto_desde_orden_carga,
		 max(isnull(venliped_reservas.bulto_orden_carga,0)) as bulto_hasta_orden_carga 
INTO   :li_bulto_desde_orden_carga,
		 :li_bulto_hasta_orden_carga
FROM   alm_orden_carga,   
		 venliped,   
		 venped,
		 venliped_reservas,
		 alm_bultos_lineas,
		 alm_bultos   
WHERE ( venliped.empresa                       = venped.empresa ) 
and  	( venliped.anyo                          = venped.anyo ) 
and  	( venliped.pedido                        = venped.pedido ) 
and  	( venliped.id_alm_orden_carga            = alm_orden_carga.id ) 
and  	( venliped.empresa                       = venliped_reservas.empresa ) 
and  	( venliped.anyo                          = venliped_reservas.anyo ) 
and  	( venliped.pedido                        = venliped_reservas.pedido ) 
and  	( venliped.linea                         = venliped_reservas.linea ) 
and  	( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
and  	( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) 
and 	( ( alm_bultos.id                        = :ll_id_alm_bultos ) );

if li_bulto_desde_orden_carga = 0 and li_bulto_hasta_orden_carga > 0 then
	//Hay lineas de reserva del bulto que no tienen numero de bulto asignado
	li_bulto_orden_carga = li_bulto_hasta_orden_carga
	
	update venliped_reservas
	set    venliped_reservas.bulto_orden_carga = :li_bulto_orden_carga
   from   alm_bultos,   
          alm_bultos_lineas,   
          venliped_reservas  
   where ( alm_bultos.id                                 = alm_bultos_lineas.id_alm_bultos ) 
	and   ( alm_bultos_lineas.id                          = venliped_reservas.alm_bultos_lineas_id ) 
	and ( ( alm_bultos.id                                 = :ll_id_alm_bultos ) 
	and   ( isnull(venliped_reservas.bulto_orden_carga,0) = 0 ) );	
	
	if sqlca.sqlcode <> 0 then
		rollback;
	else
		update venliped
		set    venliped.bulto_desde_orden_carga = :li_bulto_orden_carga,
				 venliped.bulto_hasta_orden_carga = :li_bulto_orden_carga 
		from   alm_bultos,   
				 alm_bultos_lineas,   
				 venliped_reservas,
				 venliped
		where ( alm_bultos.id                              = alm_bultos_lineas.id_alm_bultos ) 
		and   ( alm_bultos_lineas.id                       = venliped_reservas.alm_bultos_lineas_id ) 
		and   ( venliped_reservas.empresa                  = venliped.empresa )
		and   ( venliped_reservas.anyo                     = venliped.anyo )
		and   ( venliped_reservas.pedido                   = venliped.pedido )
		and   ( venliped_reservas.linea                    = venliped.linea )		
		and ( ( alm_bultos.id                              = :ll_id_alm_bultos ) 
		and   ( isnull(venliped.bulto_desde_orden_carga,0) = 0 and isnull(venliped.bulto_hasta_orden_carga,0) = 0 ) );	
		
		if sqlca.sqlcode <> 0 then
			rollback;
		else
			commit;
		end if
	end if
	
else

	select max(isnull(venliped.bulto_hasta_orden_carga,0))
	into   :li_ultimo_bulto_orden_carga 
	from 	 venliped  
	where ( venliped.empresa            = :codigo_empresa ) 
	and   ( venliped.id_alm_orden_carga = :uo_lectura_origen.il_id_alm_orden_carga_bulto );	
	
	if li_bulto_desde_orden_carga = 0 then
		//Debemos renumerar el bulto según la orden de carga
		
		ls_sel = "SELECT venliped.anyo, "+&
					"		  venliped.pedido, "+&
					"		  venliped.linea "+&
					"FROM   alm_orden_carga, "+& 
					"		  venliped, "+&
					"		  venped, "+&
					"		  venliped_reservas, "+&
					"		  alm_bultos_lineas, "+&
					"		  alm_bultos "+&
					"WHERE ( venliped.empresa                       = venped.empresa ) "+&
					"and   ( venliped.anyo                          = venped.anyo ) "+&
					"and   ( venliped.pedido                        = venped.pedido ) "+&
					"and   ( venliped.id_alm_orden_carga            = alm_orden_carga.id ) "+&
					"and   ( venliped.empresa                       = venliped_reservas.empresa ) "+&
					"and   ( venliped.anyo                          = venliped_reservas.anyo ) "+&
					"and   ( venliped.pedido                        = venliped_reservas.pedido ) "+&
					"and   ( venliped.linea                         = venliped_reservas.linea ) "+&
					"and   ( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) "+&
					"and   ( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) "+&
					"and ( ( alm_bultos.id                          = "+string(ll_id_alm_bultos)+" ) ) "+&
					"GROUP BY venliped.anyo, "+&
					"			 venliped.pedido, "+&
					"			 venliped.linea"
					
		li_lineas_pedido_bulto = f_cargar_cursor_transaccion(sqlca,ds_datos_bulto,ls_sel) 
		
		if li_lineas_pedido_bulto = 1 then
			//Si hay una sola linea de pedido puede ser un bulto de pallet/s completo/s o un bulto de picking
			lstr_venliped.empresa = codigo_empresa
			lstr_venliped.anyo    = ds_datos_bulto.object.venliped_anyo[1]
			lstr_venliped.pedido  = ds_datos_bulto.object.venliped_pedido[1]
			lstr_venliped.linea   = ds_datos_bulto.object.venliped_linea[1]
			
			f_cargar_str_venliped(lstr_venliped.empresa,lstr_venliped.anyo,lstr_venliped.pedido,lstr_venliped.linea,lstr_venliped)
			
			if isnull(lstr_venliped.bulto_desde_orden_carga) then lstr_venliped.bulto_desde_orden_carga = 0
			if isnull(lstr_venliped.bulto_hasta_orden_carga) then lstr_venliped.bulto_hasta_orden_carga = 0
			
			if lstr_venliped.bulto_desde_orden_carga = 0 and lstr_venliped.bulto_hasta_orden_carga = 0 then
				lstr_venliped.bulto_desde_orden_carga = li_ultimo_bulto_orden_carga +1
				lstr_venliped.bulto_hasta_orden_carga = lstr_venliped.bulto_desde_orden_carga + ( lstr_venliped.pallets -1)
				
				update venliped 
				set    venliped.bulto_desde_orden_carga = :lstr_venliped.bulto_desde_orden_carga,
						 venliped.bulto_hasta_orden_carga = :lstr_venliped.bulto_hasta_orden_carga 
				where  venliped.empresa = :lstr_venliped.empresa 
				and    venliped.anyo    = :lstr_venliped.anyo 
				and    venliped.pedido  = :lstr_venliped.pedido 
				and    venliped.linea   = :lstr_venliped.linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
				end if
				
				li_bulto_orden_carga = lstr_venliped.bulto_desde_orden_carga
			else
				//Si ya teniamos asignado bulto desde y bulto hasta debemos obtener cual es el ultimo bulto que hemos utilizado
				
				select max(isnull(venliped_reservas.bulto_orden_carga,0))
				into   :li_bulto_orden_carga 
				from 	 venliped,
						 venliped_reservas 
				where ( venliped.empresa            = venliped_reservas.empresa ) 
				and   ( venliped.anyo               = venliped_reservas.anyo ) 
				and   ( venliped.pedido             = venliped_reservas.pedido ) 
				and   ( venliped.linea              = venliped_reservas.linea ) 
				and ( ( venliped.empresa            = :codigo_empresa ) 
				and   ( venliped.id_alm_orden_carga = :uo_lectura_origen.il_id_alm_orden_carga_bulto ) 
				and   ( venliped_reservas.bulto_orden_carga between :lstr_venliped.bulto_desde_orden_carga and :lstr_venliped.bulto_hasta_orden_carga ) );		
				
				if li_bulto_orden_carga = 0 then
					li_bulto_orden_carga = lstr_venliped.bulto_desde_orden_carga
				else
					li_bulto_orden_carga ++
				end if
			end if				
		else
			//Si hay mas de una linea de pedido es un bulto de picking
			lstr_venliped.bulto_desde_orden_carga = li_ultimo_bulto_orden_carga +1
			lstr_venliped.bulto_hasta_orden_carga = lstr_venliped.bulto_desde_orden_carga
			
			li_bulto_orden_carga = lstr_venliped.bulto_desde_orden_carga
			
			for li_indice_lineas_pedido_bulto = 1 to li_lineas_pedido_bulto
				lstr_venliped.empresa = codigo_empresa
				lstr_venliped.anyo    = ds_datos_bulto.object.venliped_anyo[li_indice_lineas_pedido_bulto]
				lstr_venliped.pedido  = ds_datos_bulto.object.venliped_pedido[li_indice_lineas_pedido_bulto]
				lstr_venliped.linea   = ds_datos_bulto.object.venliped_linea[li_indice_lineas_pedido_bulto]	
				
				update venliped 
				set    venliped.bulto_desde_orden_carga = :lstr_venliped.bulto_desde_orden_carga,
						 venliped.bulto_hasta_orden_carga = :lstr_venliped.bulto_hasta_orden_carga 
				where  venliped.empresa = :lstr_venliped.empresa 
				and    venliped.anyo    = :lstr_venliped.anyo 
				and    venliped.pedido  = :lstr_venliped.pedido 
				and    venliped.linea   = :lstr_venliped.linea;
				
				if sqlca.sqlcode <> 0 then
					rollback;
				else
					commit;
				end if				
			next
		end if		
	else
		li_bulto_orden_carga = li_bulto_desde_orden_carga
	end if
		
	//Vamos a asignar el numero de bulto que corresponda a la tabla venliped_reservas
		
	update venliped_reservas
	set    venliped_reservas.bulto_orden_carga = :li_bulto_orden_carga
   from   alm_bultos,   
          alm_bultos_lineas,   
          venliped_reservas  
   where ( alm_bultos.id                                 = alm_bultos_lineas.id_alm_bultos ) 
	and   ( alm_bultos_lineas.id                          = venliped_reservas.alm_bultos_lineas_id ) 
	and ( ( alm_bultos.id                                 = :ll_id_alm_bultos ) 
	and   ( isnull(venliped_reservas.bulto_orden_carga,0) = 0 ) );	
	
	if sqlca.sqlcode <> 0 then
		rollback;
	else		
		commit;
	end if
	
end if

//Proceso impresion bandas

SELECT count(*) as lineas
INTO   :li_lineas_bulto
FROM   alm_orden_carga,   
		 venliped,   
		 venped,
		 venliped_reservas,
		 alm_bultos_lineas,
		 alm_bultos   
WHERE ( venliped.empresa                       = venped.empresa ) 
and  	( venliped.anyo                          = venped.anyo ) 
and  	( venliped.pedido                        = venped.pedido ) 
and  	( venliped.id_alm_orden_carga            = alm_orden_carga.id ) 
and  	( venliped.empresa                       = venliped_reservas.empresa ) 
and  	( venliped.anyo                          = venliped_reservas.anyo ) 
and  	( venliped.pedido                        = venliped_reservas.pedido ) 
and  	( venliped.linea                         = venliped_reservas.linea ) 
and  	( venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ) 
and  	( alm_bultos_lineas.id_alm_bultos        = alm_bultos.id ) 
and 	( ( alm_bultos.id                        = :ll_id_alm_bultos ) );

li_bandas_bulto = Truncate(li_lineas_bulto / li_max_lineas_banda, 0)

if Mod(li_lineas_bulto,li_max_lineas_banda) > 0 then li_bandas_bulto ++

li_row_hasta_detalle = 0

for li_banda = 1 to li_bandas_bulto
	//Imprimimos banda a banda por la capacidad limitada de mostrar el contenido
	
	li_row_desde_detalle = li_row_hasta_detalle +1
	li_row_hasta_detalle = li_banda * li_max_lineas_banda
	
	ll_lineas_banda = dw_impresion_contenido_bulto_sin_prep.retrieve(ll_id_alm_bultos,li_row_desde_detalle,li_row_hasta_detalle)
	
	if ll_lineas_banda > 0 then
		
		dw_impresion_contenido_bulto_sin_prep.print(false)

	end if				
next				
//

dw_impresion_contenido_bulto_sin_prep.Object.DataWindow.Zoom = 65

dw_impresion_contenido_bulto_sin_prep.setredraw(true)

///ACTUALIZAMOS CONTADOR DE VECES QUE SE HA IMPRESO

UPDATE venliped_reservas

SET	 banda_impresa = isnull(banda_impresa, 0) + 1

FROM	 venliped_reservas
		 inner join alm_bultos_lineas 
		 	on  venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id  
			 
WHERE	 alm_bultos_lineas.id_alm_bultos = :ll_id_alm_bultos;

if sqlca.sqlcode <> 0 then
	rollback;
else		
	commit;
end if

f_cargar_dw(dw_impresion_contenido_bulto_sin_prep.object.alm_orden_carga_id[dw_impresion_contenido_bulto_sin_prep.getrow()])

//uo_lectura_origen.SetFocus()
//uo_lectura_origen.event getfocus()
end event

type dw_impresion_contenido_bulto_sin_prep from datawindow within rf_imprimir_banda_bulto
boolean visible = false
integer x = 18
integer y = 1228
integer width = 4640
integer height = 1948
integer taborder = 20
boolean enabled = false
string title = "Impresion Contenido Bulto Sin Preparar"
string dataobject = "dw_banda_bulto_alm_bultos_id"
boolean border = false
boolean livescroll = true
end type

event retrieveend;integer lirowcount

lirowcount = rowcount
end event

type ln_1 from line within rf_imprimir_banda_bulto
long linecolor = 16711680
integer linethickness = 15
integer beginx = 4690
integer endx = 4690
integer endy = 3864
end type

type uo_lectura_origen from u_sle_codbar within rf_imprimir_banda_bulto
integer y = 168
integer height = 1052
integer taborder = 10
boolean bringtotop = true
boolean ib_mostrar_desplegado = true
boolean ib_permitir_desplegar = false
string is_descripcion = "LECTURA ORIGEN"
end type

on uo_lectura_origen.destroy
call u_sle_codbar::destroy
end on

event ue_siguiente_objeto;call super::ue_siguiente_objeto;
pb_atras.visible   = true
pb_atras.BringToTop = true
pb_aceptar.visible = true
pb_aceptar.BringToTop = true
end event

event getfocus;call super::getfocus;ii_paso_actual = 1

st_paso1.backcolor         = il_color_fondo_activo
st_paso2.backcolor         = il_color_fondo_inactivo

pb_atras.visible           = false
pb_aceptar.visible         = false
dw_impresion_contenido_bulto_sin_prep.visible = false
end event

event modified;call super::modified;dw_impresion_contenido_bulto_sin_prep.reset()

if il_id_bulto = 0 then
	f_reset()
	messagebox("¡Atención!","Debe seleccionar un bulto.",StopSign!)
	this.SetFocus()
	this.event getfocus()	
else
	if ib_bulto_asociado_a_orden_de_carga then
		dw_impresion_contenido_bulto_sin_prep.setredraw(false)
		
		if dw_impresion_contenido_bulto_sin_prep.retrieve(il_id_bulto,1,15) <= 0 then
			Messagebox("Error","Ha seleccionado un Bulto sin O.C. Asociada~nDebe hacer la lectura de la etiqueta de un bulto con Orden de Carga asociada.")
			this.SetFocus()
			this.event getfocus()
		else
			
			f_cargar_dw(dw_impresion_contenido_bulto_sin_prep.object.alm_orden_carga_id[dw_impresion_contenido_bulto_sin_prep.getrow()])
			
			dw_impresion_contenido_bulto_sin_prep.visible = true
			dw_impresion_contenido_bulto_sin_prep.BringToTop = false
			
			pb_aceptar.SetFocus()
		end if
		
		dw_impresion_contenido_bulto_sin_prep.setredraw(true)
	else		
		Messagebox("Error","Ha seleccionado un Bulto sin O.C. Asociada~nDebe hacer la lectura de la etiqueta de un bulto con Orden de Carga asociada.")
		this.SetFocus()
		this.event getfocus()			
	end if
end if
end event

type pb_salir from picturebutton within rf_imprimir_banda_bulto
integer x = 4320
integer width = 357
integer height = 316
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\salir.png"
string disabledname = "C:\bmp\RF\salir_dis.tif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

