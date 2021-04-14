$PBExportHeader$wtc_mant_almacen_salidas_new.srw
forward
global type wtc_mant_almacen_salidas_new from wt_ventana_padre
end type
type dw_salidas from datawindow within wtc_mant_almacen_salidas_new
end type
type dw_mover from u_dw within wtc_mant_almacen_salidas_new
end type
type pb_busqueda_codigo from picturebutton within wtc_mant_almacen_salidas_new
end type
end forward

global type wtc_mant_almacen_salidas_new from wt_ventana_padre
integer width = 5326
integer height = 3156
string title = "Salidas de Almacen"
dw_salidas dw_salidas
dw_mover dw_mover
pb_busqueda_codigo pb_busqueda_codigo
end type
global wtc_mant_almacen_salidas_new wtc_mant_almacen_salidas_new

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
public subroutine f_calcular_pallets_caja (integer pallets_introducidos, integer cajas_introducidas, decimal piezas_introducidas)
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
end prototypes

public function integer f_guardar ();return 1
end function

public function integer f_borrar ();/*
setnull(param_transaccion.dbms)
setnull(param_transaccion.database)
setnull(param_transaccion.servername)
setnull(param_transaccion.logid)
setnull(param_transaccion.userid)
setnull(param_transaccion.logpass)
setnull(param_transaccion.autocommit)
setnull(param_transaccion.lock)
setnull(param_transaccion.dbparm)
rtn = super::f_borrar()
return rtn
*/

return 1
end function

public subroutine f_calcular_pallets_caja (integer pallets_introducidos, integer cajas_introducidas, decimal piezas_introducidas);if dw_1.getrow() <= 0 then
	dw_mover.object.pallets[1] = 0
	dw_mover.object.cajas[1] = 0
	dw_mover.object.piezas[1] = 0
	return
end if

Integer pallets, cajas
Dec piezas, lineales, n_cajas, n_pallets, n_total
Int fila

string cod_caja, cod_articulo, cod_pallet, cod_formato, cod_unidad, ls_gestionar_en_piezas
Dec n_piezascaja, n_metroscaja, n_cajaspallet, total_cajas, total_cantidad, total_pallets, total_lineales, largo

fila = dw_1.getrow()

n_pallets = pallets_introducidos
n_cajas   = cajas_introducidas
n_total   = piezas_introducidas
								
cod_articulo = dw_1.object.almacenmovimientos_articulo[fila]
cod_caja     = dw_1.object.almacenmovimientos_caja[fila]
cod_pallet   = dw_1.object.almacenmovimientos_tipo_pallet[fila]
ls_gestionar_en_piezas = dw_1.object.gestionar_en_piezas[fila]

SELECT  articulos.formato, articulos.unidad
INTO 	  :cod_formato,:cod_unidad
FROM    articulos
WHERE   articulos.empresa = :codigo_empresa
AND     articulos.codigo  = :cod_articulo;

SELECT  almartcajas.piezascaja,almartcajas.metroscaja  
INTO    :n_piezascaja,:n_metroscaja  
FROM    almartcajas  
WHERE   almartcajas.empresa   = :codigo_empresa
AND     almartcajas.articulo  = :cod_articulo
AND     almartcajas.caja      = :cod_caja;
	
if isnull(n_piezascaja) then n_piezascaja = 0
if isnull(n_metroscaja) then n_metroscaja = 0
	
n_metroscaja = round(n_metroscaja,2)

SELECT  palarticulo.cajaspallet			 
INTO    :n_cajaspallet
FROM    palarticulo
WHERE   palarticulo.empresa  = :codigo_empresa
AND     palarticulo.articulo = :cod_articulo
AND     palarticulo.codigo   = :cod_pallet
AND     palarticulo.caja     = :cod_caja;
	
if isnull(n_cajaspallet) then n_cajaspallet = 0

//EL ALMACEN SIEMPRE EN METROS

//  n_total=Dec(n_total)
IF n_total <> 0 THEN
	IF n_piezascaja = 0 or isnull(n_piezascaja) THEN 	
		total_cajas = 0											
	ELSE					
		if ls_gestionar_en_piezas = 'S' or cod_unidad <> '1' then
			//Gestion en piezas
			total_cantidad = n_total			
			
			// Quito el ceiling porque peta con Power Builder 12.5 y SQL 2008. David 07-02-2012
	//     		total_cajas = CEILING(n_total / n_piezascaja)  
			if mod (n_total , n_piezascaja ) =  0 then
				total_cajas = n_total / n_piezascaja 
			else
				total_cajas = n_total / n_piezascaja 
				total_cajas = truncate (total_cajas, 0)
				total_cajas ++
			end if
	
			cajas = TRUNCATE(n_total / n_piezascaja, 0)
			
			if n_cajaspallet > 0 then
				total_pallets  = truncate(total_cajas / n_cajaspallet,0) 
			else 
				total_pallets = 0
			end if
		else
			//Gestion em m2
			total_cantidad = n_total			
			
			// Quito el ceiling porque peta con Power Builder 12.5 y SQL 2008. David 07-02-2012
	//     		total_cajas = CEILING(n_total / n_piezascaja)  
			if mod (n_total , n_piezascaja ) =  0 then
				total_cajas = n_total / n_piezascaja 
			else
				total_cajas = n_total / n_piezascaja 
				total_cajas = truncate (total_cajas, 0)
				total_cajas ++
				
				n_total = total_cajas * n_piezascaja 
				
				if n_total > dw_1.object.stock[fila] then n_total = dw_1.object.stock[fila]
				
				total_cantidad = n_total
			end if
	
			cajas = TRUNCATE(n_total / n_piezascaja, 0)
			
			if n_cajaspallet > 0 then
				total_pallets  = truncate(total_cajas / n_cajaspallet,0) 
			else 
				total_pallets = 0
			end if			
		end if
	END IF																
ELSE
	IF n_cajas <> 0 THEN
		total_cantidad = n_cajas * n_piezascaja
		total_cajas = n_cajas
		cajas = n_cajas
		IF n_cajaspallet <> 0 then
			total_pallets = truncate(n_cajas / n_cajaspallet,0) 
		ELSE
			total_pallets = 0
		END IF
	ELSE
		IF n_pallets <> 0 THEN
			cajas = TRUNCATE(n_pallets * n_cajaspallet, 0)
			total_cajas = cajas
			total_cantidad = cajas * n_piezascaja
			total_pallets = n_pallets
		END IF
	END IF
END IF

IF largo<>0 THEN
	total_lineales = total_cantidad * (largo / 100)
END IF

if cod_caja = "901" then //SIN CAJA
	cajas = 0
	total_cajas = 0
end if

dw_mover.object.pallets[1] = total_pallets
dw_mover.object.cajas[1]   = total_cajas
dw_mover.object.piezas[1]  = total_cantidad
	
//if ftc_calcular_unidades_almacen(codigo_empresa, dw_1.object.almacenmovimientos_articulo[dw_1.getrow()], dw_1.object.almacenmovimientos_tipo_pallet[dw_1.getrow()], dw_1.object.almacenmovimientos_caja[dw_1.getrow()], pallets_introducidos, cajas_introducidas, piezas_introducidas, pallets, cajas, piezas, lineales) = 0 then	
//	dw_mover.object.pallets[1] = pallets
//	dw_mover.object.cajas[1] = cajas
//	dw_mover.object.piezas[1] = piezas
//else
//	dw_mover.object.pallets[1] = 0
//	dw_mover.object.cajas[1] = 0
//	dw_mover.object.piezas[1] = 0
//end if





end subroutine

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);If arg_KeyFlags = 2 then
	choose case arg_key
		case KeyEnter!
		case KeyN!
			pb_nuevo.triggerevent(clicked!)
		case KeyB!
			pb_borrar.triggerevent(clicked!)
		case KeyS!
			pb_grabar.triggerevent(clicked!)
		case KeyZ!
			pb_cancelar.triggerevent(clicked!)
	end choose		
else
	choose case arg_Key
		case KeyEnter!
		case KeyF2!
			pb_nuevo.triggerevent(clicked!)
		case KeyF3!
			pb_borrar.triggerevent(clicked!)
		case KeyF4!
			pb_grabar.triggerevent(clicked!)
		case KeyF8!
			pb_buscar.triggerevent(clicked!)
		case KeyF9!
			pb_busqueda_codigo.triggerevent(clicked!)
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if
end subroutine

on wtc_mant_almacen_salidas_new.create
int iCurrent
call super::create
this.dw_salidas=create dw_salidas
this.dw_mover=create dw_mover
this.pb_busqueda_codigo=create pb_busqueda_codigo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_salidas
this.Control[iCurrent+2]=this.dw_mover
this.Control[iCurrent+3]=this.pb_busqueda_codigo
end on

on wtc_mant_almacen_salidas_new.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_salidas)
destroy(this.dw_mover)
destroy(this.pb_busqueda_codigo)
end on

event open;call super::open;dw_salidas.settransobject(SQLCA)
dw_salidas.retrieve(codigo_empresa, today())

dw_mover.insertrow(0)

padre_codigo = ""
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 2560
integer y = 52
boolean enabled = false
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_almacen_salidas_new
integer x = 4741
integer y = 12
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_almacen_salidas_new
integer width = 5257
integer height = 848
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_almacen_salidas_new"
boolean vscrollbar = true
boolean border = false
end type

event dw_1::clicked;call super::clicked;String familia = ""

if row > 0 then
	if dwo.name = "p_salida" or row = 1 then
		
		//NO PERMITIR SALIDAS MANUALES DE P fila > 10 (MUELLE DISTRIBUCIÓN - MATERIAL RESERVADO) - 08/2015
		//SELECT familia INTO:familia FROM articulos WHERE empresa = :codigo_empresa AND codigo = :padre_codigo;
		//if this.object.almacenmovimientos_almacen[row] = "1" and this.object.almacenmovimientos_zona[row] = "P" and integer(this.object.almacenmovimientos_fila[row]) >= 10 then
			//MessageBox("Error", "No se permite sacar material del muelle de distribución (fila >= 10). Desprepare el material desde el mantenimiento de órdenes de preparación.")
		if this.object.reservado[row] > 0 then
			MessageBox("Error", "No se permite traspasar material preparado. Desprepare el material desde el mantenimiento de órdenes de preparación.")			
			return
		end if
		
		dw_mover.visible = true
		dw_1.setrow(row)
		dw_1.SelectRow(0, false)
		dw_1.selectrow(row, true)
		
		dw_mover.object.fecha_mov[1] = today()
		dw_mover.object.piezas[1] = Dec(dw_1.object.stock[row])
		dw_mover.EVENT itemchanged(1, dw_mover.object.piezas, String(dw_mover.object.piezas[1]))
		
		dw_mover.setfocus()
	//	dw_mover.setrow(1)
		dw_mover.SetColumn("tipomov")
	end if
end if
end event

event dw_1::retrieveend;call super::retrieveend;/*
dwobject boton

boton.create

if rowcount = 1 then
	this.EVENT clicked (0,0,1, boton)
end if
*/
if rowcount = 1 then
	dw_mover.visible = true
	dw_1.setrow(rowcount)
	dw_1.SelectRow(0, false)
	dw_1.selectrow(rowcount, true)
	
	dw_mover.object.fecha_mov[1] = today()
	dw_mover.object.piezas[1] = Dec(dw_1.object.stock[rowcount])
	dw_mover.event itemchanged(1, dw_mover.object.piezas, String(dw_mover.object.piezas[1]))
	
	dw_mover.setfocus()
//	dw_mover.setrow(1)
	dw_mover.SetColumn("tipomov")
end if	

long ll_indice

for ll_indice = 1 to rowcount
	if ll_indice = 1 then
		this.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c_pzs_total( this.object.almacenmovimientos_empresa[ll_indice], this.object.almacenmovimientos_articulo[ll_indice], this.object.almacenmovimientos_calidad[ll_indice], this.object.almacenmovimientos_tono[ll_indice], this.object.almacenmovimientos_calibre[ll_indice], this.object.almacenmovimientos_tipo_pallet[ll_indice], this.object.almacenmovimientos_caja[ll_indice] )
	else
		if this.object.almacenmovimientos_empresa[ll_indice]     = this.object.almacenmovimientos_empresa[ll_indice - 1] and &
			this.object.almacenmovimientos_articulo[ll_indice]    = this.object.almacenmovimientos_articulo[ll_indice - 1] and &
			this.object.almacenmovimientos_calidad[ll_indice]     = this.object.almacenmovimientos_calidad[ll_indice - 1] and &
			this.object.almacenmovimientos_tono[ll_indice]        = this.object.almacenmovimientos_tono[ll_indice - 1] and &
			this.object.almacenmovimientos_calibre[ll_indice]     = this.object.almacenmovimientos_calibre[ll_indice - 1] and &
			this.object.almacenmovimientos_tipo_pallet[ll_indice] = this.object.almacenmovimientos_tipo_pallet[ll_indice - 1] and &
			this.object.almacenmovimientos_caja[ll_indice]        = this.object.almacenmovimientos_caja[ll_indice -1 ] then
			
			this.object.disponible[ll_indice] = this.object.disponible[ll_indice - 1]
		else
			this.object.disponible[ll_indice] = f_disponible_art_cal_to_ca_tp_c_pzs_total( this.object.almacenmovimientos_empresa[ll_indice], this.object.almacenmovimientos_articulo[ll_indice], this.object.almacenmovimientos_calidad[ll_indice], this.object.almacenmovimientos_tono[ll_indice], this.object.almacenmovimientos_calibre[ll_indice], this.object.almacenmovimientos_tipo_pallet[ll_indice], this.object.almacenmovimientos_caja[ll_indice] )			
		end if
	end if
	
	//this.object.pzs_caja[ll_indice] = f_piezascaja_articulo( this.object.almacenmovimientos_empresa[ll_indice] , this.object.almacenmovimientos_articulo[ll_indice] , this.object.almacenmovimientos_caja[ll_indice] )
next

//

this.setredraw(true)

end event

event dw_1::doubleclicked;call super::doubleclicked;if row > 0 then
	this.EVENT clicked(xpos, ypos, row, this.object.p_salida)
end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 3063
integer y = 52
boolean enabled = false
end type

event pb_borrar::clicked;//No se aplica funcionalidad de borrar
end event

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_almacen_salidas_new
integer x = 5097
integer y = 128
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 2734
integer y = 52
boolean enabled = false
end type

event pb_grabar::clicked;//No se aplica funcionalidad de guardar 
end event

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_almacen_salidas_new
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 2894
integer y = 52
boolean enabled = false
end type

event pb_nuevo::clicked;//No se aplica funcionalidad de nuevo
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 3218
integer y = 52
boolean enabled = false
end type

event pb_cancelar::clicked;//No se aplica funcionalidad de deshacer
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_almacen_salidas_new
integer x = 37
string powertiptext = "Buscar por Descripción (F8)"
end type

event pb_buscar::clicked;string campo

dw_mover.visible = false
dw_mover.reset()


campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
padre_busqueda.consulta =  " SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), almusos.descripcion, formatos.abreviado "+&
											" FROM articulos "+&
											" LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
											" LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(char(60), articulos.descripcion) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"
		padre_busqueda.titulos[3] = "Uso"
		padre_busqueda.titulos[4] = "Formato"
/*
choose case campo
	case "almacenmovimientos_articulo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, articulos.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "articulos_descripcion"
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY articulos.descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, articulos.descripcion "+&
											" FROM articulos "+&
											" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, articulos.codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
end choose
*/

//call super :: clicked

long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		total = dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1])
		if total > 0 then
			padre_codigo = resultado_busqueda.valores[1]
			estado = 1 // Modo edición
		else
			if numero_valores >  3 then
				MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[3])
			else
				MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[2])
			end if
		end if
	end if
else
	messagebox("Error", resultado_busqueda.error )
end if

mostrar_controles_edicion()
/*
dw_1.setfocus()
if dw_1.rowcount() > 0 then
	dw_1.SetColumn(columna)
end if
*/
end event

type dw_salidas from datawindow within wtc_mant_almacen_salidas_new
integer x = 23
integer y = 1124
integer width = 5262
integer height = 1816
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_almacen_salidas_dia_new"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_mover from u_dw within wtc_mant_almacen_salidas_new
boolean visible = false
integer x = 1449
integer y = 872
integer width = 2144
integer height = 792
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = ""
string dataobject = "dwtc_almacen_salidas_aux"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;dec ld_disponible
str_ventana_alerta parametros
string botones[2]

this.triggerevent("itemchanged")

dw_salidas.accepttext( )

if dwo.name = "b_cancelar" then
	dw_mover.visible = false
	dw_1.selectrow(0, false)
elseif dwo.name = "b_salida" then 
	String familia, tipo_unidad, orden
	Long fila, fila_dw_origen
	String almacen_origen, zona_origen, calidad, tono, tipo_pallet, caja
	Int fila_origen, altura_origen, calibre
	
	//VALIDACIÓN
	if isnull(padre_codigo) or padre_codigo = "" then
		MessageBox("Error","Error seleccionando el artículo. Por favor, búsque el artículo de nuevo.")
		return
	end if
	if isnull(this.object.tipomov[1]) or this.object.tipomov[1] = "" then
		MessageBox("Error","Debe introducir un tipo de movimiento válido")
		return
	end if
	if isnull(this.object.piezas[1]) or this.object.piezas[1] <= 0 then
		MessageBox("Error","Debe introducir las piezas que desea sacar.")
		return
	end if
		
	ld_disponible = f_disponible_art_cal_to_ca_tp_c_pzs_total( dw_1.object.almacenmovimientos_empresa[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_articulo[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_calidad[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_tono[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_calibre[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_tipo_pallet[dw_1.getrow()] , &
																		  dw_1.object.almacenmovimientos_caja[dw_1.getrow()] )	
																		  
		
	//dw_1.object.disponible[dw_1.getrow()]
	
	if this.object.piezas[1] > ld_disponible then
		MessageBox("Error","No puede sacar más piezas de las disponibles.")
		return
	else
		if this.object.piezas[1] > dw_1.object.stock[dw_1.getrow()] then
			MessageBox("Error","No puede sacar más piezas de las existentes en la ubicación.")
			return
		end if		
	end if
	
	if String(this.object.fecha_mov[1], "dd/mm/yyyy") <> String(today(), "dd/mm/yyyy") then
		parametros.titulo = "Atención"
		parametros.subtitulo = "Fecha Movimiento"
		parametros.mensaje = "La fecha del movimiento es distinta a la fecha actual, ¿desea continuar?"
		parametros.tipo = 2
		botones[1] = "Sí"
		botones[2] = "No"
		parametros.botones = botones
		parametros.mostrar_imagen = true
		openwithparm(wtc_ventana_alerta, parametros)
		borrar = Int(Message.DoubleParm)
		if borrar <> 1 then
			return
		end if
	end if
	
	SELECT familia INTO :familia 
	FROM articulos 
	WHERE empresa = :codigo_empresa AND codigo = :padre_codigo using trans_ts;
	
//Lo hace f_movimiento almacen	
//	//CALCULO DEL ORDEN
//	
//	str_colisiones p_colisiones
//	rtn = 1
//
//	p_colisiones.empresa = codigo_empresa
//	p_colisiones.tabla = "almacenmovimientos"
//	p_colisiones.campo = "orden"
//	p_colisiones.filtro = " fecha_mov = '"+String(this.object.fecha_mov[1], "dd/mm/yyyy")+"' "
//	p_colisiones.buscar_huecos = false
//	orden = f_colisiones(trans_ts, p_colisiones)
	
	//INSERCIÓN 
	rtn  = 1
	
	fila = dw_salidas.insertrow(0)
	fila_dw_origen = dw_1.getrow()
	if fila > 0 then
		str_movimiento_almacen lstr_movimiento_almacen
		
		lstr_movimiento_almacen.empresa            = codigo_empresa
		lstr_movimiento_almacen.articulo           = padre_codigo
		lstr_movimiento_almacen.calidad            = dw_1.object.almacenmovimientos_calidad[fila_dw_origen]
		lstr_movimiento_almacen.tono               = dw_1.object.almacenmovimientos_tono[fila_dw_origen]
		lstr_movimiento_almacen.calibre            = dw_1.object.almacenmovimientos_calibre[fila_dw_origen]
		lstr_movimiento_almacen.tipo_pallet        = dw_1.object.almacenmovimientos_tipo_pallet[fila_dw_origen]
		lstr_movimiento_almacen.caja               = dw_1.object.almacenmovimientos_caja[fila_dw_origen]
		lstr_movimiento_almacen.cantidad           = (this.object.piezas[1] * -1)
		lstr_movimiento_almacen.orden_carga_anyo   = 0
		lstr_movimiento_almacen.orden_carga_codigo = ""
		lstr_movimiento_almacen.orden_carga_linea  = 0
		lstr_movimiento_almacen.tipo_movimiento    = this.object.tipomov[1]
		lstr_movimiento_almacen.observaciones      = ""
		lstr_movimiento_almacen.almacen            = dw_1.object.almacenmovimientos_almacen[fila_dw_origen]
		lstr_movimiento_almacen.zona               = dw_1.object.almacenmovimientos_zona[fila_dw_origen]
		lstr_movimiento_almacen.fila               = dw_1.object.almacenmovimientos_fila[fila_dw_origen]
		lstr_movimiento_almacen.altura             = dw_1.object.almacenmovimientos_altura[fila_dw_origen]
		lstr_movimiento_almacen.tercero            = ""
		lstr_movimiento_almacen.documento          = ""
		lstr_movimiento_almacen.fecha              = datetime(this.object.fecha_mov[1])
		lstr_movimiento_almacen.id_ubicacion       = 0
		lstr_movimiento_almacen.id_alm_bultos		 = dw_1.object.alm_bultos_id[fila_dw_origen]
		
		//Introduce pallet a pallet
		if f_movimiento_almacen(lstr_movimiento_almacen) then
				
			almacen_origen = dw_1.object.almacenmovimientos_almacen[fila_dw_origen]
			zona_origen = dw_1.object.almacenmovimientos_zona[fila_dw_origen]
			fila_origen = dw_1.object.almacenmovimientos_fila[fila_dw_origen]
			altura_origen = dw_1.object.almacenmovimientos_altura[fila_dw_origen]
			calidad = dw_1.object.almacenmovimientos_calidad[fila_dw_origen]
			tono = dw_1.object.almacenmovimientos_tono[fila_dw_origen]
			calibre = dw_1.object.almacenmovimientos_calibre[fila_dw_origen]
			tipo_pallet = dw_1.object.almacenmovimientos_tipo_pallet[fila_dw_origen]
			caja = dw_1.object.almacenmovimientos_caja[fila_dw_origen]
			
			dw_salidas.object.almacenmovimientos_empresa[fila] = codigo_empresa
			dw_salidas.object.fecha_mov[fila] = this.object.fecha_mov[1]
			dw_salidas.object.orden[fila] = Long(orden)
			dw_salidas.object.fecha_intr[fila] = datetime(today(), now())
			dw_salidas.object.origen[fila] = ""
			dw_salidas.object.almacenmovimientos_almacen[fila] = almacen_origen
			dw_salidas.object.almacenmovimientos_zona[fila] = zona_origen
			dw_salidas.object.almacenmovimientos_fila[fila] = fila_origen
			dw_salidas.object.almacenmovimientos_altura[fila] = altura_origen
			dw_salidas.object.almacenmovimientos_articulo[fila] = padre_codigo
			dw_salidas.object.familia[fila] = familia
			dw_salidas.object.almacenmovimientos_formato[fila] = dw_1.object.almacenmovimientos_formato[fila_dw_origen]
			dw_salidas.object.almacenmovimientos_calidad[fila] = calidad
			dw_salidas.object.almacenmovimientos_tono[fila] = tono
			dw_salidas.object.almacenmovimientos_calibre[fila] = calibre
			dw_salidas.object.almacenmovimientos_tipo_pallet[fila] = tipo_pallet
			dw_salidas.object.almacenmovimientos_caja[fila] = caja
			dw_salidas.object.cantidade[fila] = 0
			dw_salidas.object.cantidads[fila] = this.object.piezas[1]
			dw_salidas.object.tipomov[fila] = this.object.tipomov[1]
			dw_salidas.object.tipo_unidad[fila] = "0"
			dw_salidas.object.usuario[fila] = nombre_usuario
			//dw_salidas.object.observaciones[fila] = 
			//dw_salidas.object.trazabilidad[fila] = 
		else
			rtn = 0
		end if
		
	else 
		rtn = 0
	end if
	
	//GUARDADO
	
	//QUITAMOS OBSERVACIONES SI EL STOCK QUEDA A 0 para la ubicación de salida
	if rtn = 1 and (this.object.piezas[1] = dw_1.object.stock[dw_1.getrow()]) then
		DELETE FROM almacenmovimientos_observaciones 
		WHERE empresa = :codigo_empresa AND almacen = :almacen_origen AND zona = :zona_origen AND fila = :fila_origen 
			AND altura = :altura_origen AND articulo = :padre_codigo AND calidad = :calidad AND tono = :tono 
			AND calibre = :calibre AND tipo_pallet = :tipo_pallet AND caja = :caja 
		USING trans_ts;
		
		if trans_ts.Sqlcode <> 0 then
			rtn = 0
		end if
	end if

//LO hace la funcion f_movimiento_almacen
//	if rtn = 1 then
//		dw_salidas.SetTransObject(trans_ts)	
//		rtn = dw_salidas.update()
//	end if
	
	if rtn = 1 then
		//Salida de los bultos
		COMMIT USING sqlca;
		COMMIT USING trans_ts;
	else
		ROLLBACK USING sqlca;
		ROLLBACK USING trans_ts;
		MessageBox("Error de guardado", "No ha sido posible realizar el guardado. Intentelo de nuevo y si el error se repite, póngase en contacto con el administrador.")
	end if
	
	dw_salidas.SetTransObject(SQLCA)
	dw_1.retrieve(codigo_empresa, padre_codigo)
	dw_salidas.retrieve(codigo_empresa, today())
	dw_mover.visible = false
	dw_1.selectrow(0, false)
	this.reset()
end if
end event

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

if isnull(row) then
	return
end if

CHOOSE CASE dwo.name
	CASE "tipomov"
		SELECT descripcion
		INTO :resultado
		FROM almtipomov
		WHERE empresa = :codigo_empresa AND codigo_real = 'S' AND interno = 'N'  
		and tipomov = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.almtipomov_descripcion[Row] = resultado
		else
			dwo.Primary[row] = ''
			this.object.almtipomov_descripcion[Row] = ''
			return 2			
		end if
		
	CASE "pallets"
		post f_calcular_pallets_caja(integer(data), 0 , 0)
	CASE "cajas"
		post f_calcular_pallets_caja(0, integer(data), 0)		
	CASE "piezas"				
		post f_calcular_pallets_caja(0, 0 , dec(data))
	CASE "fecha_mov"
		this.object.fecha_mov[Row] = Date(data)
END CHOOSE


this.Accepttext()

end event

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false

If KeyFlags = 2 then
	dwobject b_salida
	choose case key
		case KeyS!
			b_salida = dw_mover.object.b_salida
			dw_mover.EVENT Clicked(0, 0, 0, b_salida)
//			dw_mover.triggerevent(clicked!)
	end choose		
elseif key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tipomov"
			busqueda.titulo_ventana = "Búsqueda de Tipos de Movimiento"
			busqueda.consulta  = " SELECT tipomov, resumido, descripcion "+&
										" FROM almtipomov "+&
										" WHERE empresa = '"+codigo_empresa+"' AND codigo_real = 'S' AND interno = 'N' "+&
										" ORDER BY CONVERT(integer, tipomov) "
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipomov[this.GetRow()] 					= resultado.valores[1]		
				this.object.almtipomov_descripcion[this.GetRow()] = resultado.valores[3]		
			end if
	END CHOOSE
end if	



end event

event losefocus;call super::losefocus;this.triggerevent("itemchanged")
end event

type pb_busqueda_codigo from picturebutton within wtc_mant_almacen_salidas_new
integer x = 197
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Preview_32x32.png"
alignment htextalign = right!
string powertiptext = "Busqueda por Codigo"
end type

event clicked;string campo

dw_mover.visible = false
dw_mover.reset()

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = true
padre_busqueda.consulta =  " SELECT articulos.codigo, articulos.codigo, CONVERT(char(60),articulos.descripcion), almusos.descripcion, formatos.abreviado "+&
									" FROM articulos "+&
									" LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
									" LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
									" WHERE articulos.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(char(60), articulos.descripcion) ASC"

padre_busqueda.titulos[1] = "Código"
padre_busqueda.titulos[2] = "Código"
padre_busqueda.titulos[3] = "Descripción"
padre_busqueda.titulos[4] = "Uso"
padre_busqueda.titulos[5] = "Formato"

long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		total = dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1])
		if total > 0 then
			padre_codigo = resultado_busqueda.valores[1]
			estado = 1 // Modo edición
		else
			if numero_valores >  3 then
				MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[3])
			else
				MessageBox("Atención", "No queda stock en ninguna ubicación del artículo "+resultado_busqueda.valores[2])
			end if
		end if
	end if
else
	messagebox("Error", resultado_busqueda.error )
end if

mostrar_controles_edicion()
/*
dw_1.setfocus()
if dw_1.rowcount() > 0 then
	dw_1.SetColumn(columna)
end if
*/
end event

