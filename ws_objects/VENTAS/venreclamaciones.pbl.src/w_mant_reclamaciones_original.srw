$PBExportHeader$w_mant_reclamaciones_original.srw
forward
global type w_mant_reclamaciones_original from wc_mantenimientos_tab
end type
type st_3 from statictext within pagina_2
end type
type em_fechadesde from u_em_campo within pagina_2
end type
type st_4 from statictext within pagina_2
end type
type em_fechahasta from u_em_campo within pagina_2
end type
type cb_consulta_detalle_fras from commandbutton within pagina_2
end type
type dw_detalle_facturas_cliente from datawindow within pagina_2
end type
type gb_3 from groupbox within pagina_2
end type
type gb_2 from groupbox within pagina_2
end type
type cb_borrar_linea_detalle from commandbutton within pagina_2
end type
type dw_detalle_documento from datawindow within pagina_3
end type
type gb_6 from groupbox within pagina_3
end type
type cb_anyadir_documento from commandbutton within pagina_3
end type
type cb_borrar_documento from commandbutton within pagina_3
end type
type st_5 from statictext within pagina_4
end type
type em_fechadesdeabono from u_em_campo within pagina_4
end type
type st_6 from statictext within pagina_4
end type
type em_fechahastaabono from u_em_campo within pagina_4
end type
type cb_consulta_abonos from commandbutton within pagina_4
end type
type cb_borrar_abono from commandbutton within pagina_4
end type
type gb_5 from groupbox within pagina_4
end type
type gb_4 from groupbox within pagina_4
end type
type dw_detalle_abonos_cliente from datawindow within pagina_4
end type
type cb_anyadir_fra_proveedor from commandbutton within pagina_5
end type
type cb_borrar_fra_proveedor from commandbutton within pagina_5
end type
type gb_7 from groupbox within pagina_5
end type
type cb_anyadir_fase from commandbutton within pagina_7
end type
type cb_borrar_fase from commandbutton within pagina_7
end type
type dw_detalle_fase from datawindow within pagina_7
end type
type dw_situacion_final_fase from u_datawindow within pagina_7
end type
type gb_8 from groupbox within pagina_7
end type
type st_2 from statictext within w_mant_reclamaciones_original
end type
type uo_cliente from u_em_campo_2 within w_mant_reclamaciones_original
end type
type gb_1 from groupbox within w_mant_reclamaciones_original
end type
type st_descripcion_reclamacion from statictext within w_mant_reclamaciones_original
end type
type pb_calculadora from picturebutton within w_mant_reclamaciones_original
end type
end forward

global type w_mant_reclamaciones_original from wc_mantenimientos_tab
integer width = 3643
integer height = 2324
boolean titlebar = true
boolean controlmenu = true
string icon = "C:\GNOCERAMIC\RECURSOS\genogestion2.ico"
st_2 st_2
uo_cliente uo_cliente
gb_1 gb_1
st_descripcion_reclamacion st_descripcion_reclamacion
pb_calculadora pb_calculadora
end type
global w_mant_reclamaciones_original w_mant_reclamaciones_original

forward prototypes
public subroutine f_mostrar_resumen_reclamacion ()
end prototypes

public subroutine f_mostrar_resumen_reclamacion ();long    indice,total,anyo,factura,linea_factura,indice2,total2,donde
string  articulo,calidad,unidad,sel
dec     cantidad_reclamacion,cantidad_abonos,importe_reclamacion,importe_abonos,gastos_reclamacion
dec     cantidad_fra,neto,cambio,importe_fobs,importe_fletes,fletes_cobrados,importe_rappel	
boolean articulo_insertado
datastore detalle_abonos
total = dw_pag2.rowcount()

dw_pag6.reset()

for indice = 1 to total
	anyo                 = dw_pag2.object.ven_reclamaciones_detalle_anyo[indice]
	factura              = dw_pag2.object.ven_reclamaciones_detalle_factura[indice]
	linea_factura        = dw_pag2.object.ven_reclamaciones_detalle_linea[indice]
	cantidad_reclamacion = dw_pag2.object.ven_reclamaciones_detalle_cantidad[indice]
	
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

	select articulo,					calidad,					cantidad,		
			 neto - impdtopp,			gastos_reclamacion
	into   :articulo,					:calidad,				:cantidad_fra,	
			 :neto,						:gastos_reclamacion
	from   venlifac
	where  empresa       = :codigo_empresa
	and    anyo          = :anyo
	and    factura       = :factura
	and    linea_factura = :linea_factura;
	
	if isnull(neto)               then neto = 0
	if isnull(gastos_reclamacion) then gastos_reclamacion = 0
	if isnull(importe_fobs)       then importe_fobs = 0
	if isnull(importe_fletes)     then importe_fletes = 0
	if isnull(fletes_cobrados)    then fletes_cobrados = 0
	if isnull(importe_rappel)     then importe_rappel = 0
	
	cambio = f_cambio_venfac(codigo_empresa,anyo,factura)
	
	neto                = neto / cambio	
	importe_rappel      = importe_rappel / cambio
	neto                = neto + fletes_cobrados - (importe_fobs + importe_fletes + importe_rappel)
	importe_reclamacion = (neto / cantidad_fra) * cantidad_reclamacion
	
	donde = dw_pag6.find("articulo = '"+articulo+"' and calidad = '"+calidad+"'",1,dw_pag6.rowcount())
	
	if donde > 0 then
		articulo_insertado   = true
		cantidad_reclamacion = cantidad_reclamacion + dw_pag6.object.cantidad_reclamacion[donde] 
		importe_reclamacion  = importe_reclamacion  + dw_pag6.object.importe_reclamacion[donde] 
		gastos_reclamacion   = gastos_reclamacion   + dw_pag6.object.importe_gastos[donde] 		
	else
		articulo_insertado   = false
		donde = dw_pag6.insertrow(0)
		dw_pag6.object.empresa[donde]        = codigo_empresa
		dw_pag6.object.articulo[donde]       = articulo
		dw_pag6.object.calidad[donde]        = calidad
		dw_pag6.object.unidad[donde]         = f_unidad_articulo(codigo_empresa,articulo)
		dw_pag6.object.cantidad_abono[donde] = 0
		dw_pag6.object.importe_abono[donde]  = 0
	end if
		
	dw_pag6.object.cantidad_reclamacion[donde] = cantidad_reclamacion
	dw_pag6.object.importe_reclamacion[donde]  = importe_reclamacion
	dw_pag6.object.importe_gastos[donde]       = gastos_reclamacion
	
	if not(articulo_insertado) then
		total2 = dw_pag4.rowcount() 
		
		for indice2 = 1 to total2
			anyo    = dw_pag4.object.venfac_anyo[indice2]
			factura = dw_pag4.object.venfac_factura[indice2]			
			
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
			
			cantidad_abonos = cantidad_abonos + dw_pag6.object.cantidad_abono[donde]
			importe_abonos  = importe_abonos  + dw_pag6.object.importe_abono[donde]
			
			dw_pag6.object.cantidad_abono[donde] = cantidad_abonos
			dw_pag6.object.importe_abono[donde]  = importe_abonos
		next
		
	end if
next

total = dw_pag4.rowcount() 

for indice = 1 to total
	anyo    = dw_pag4.object.venfac_anyo[indice]
	factura = dw_pag4.object.venfac_factura[indice]			
	
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
		
		if dw_pag2.find("venlifac_articulo = '"+articulo+"' and venlifac_calidad = '"+calidad+"'",1,dw_pag2.rowcount()) = 0 then						
			
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
			
			donde = dw_pag6.find("articulo = '"+articulo+"' and calidad = '"+calidad+"'",1,dw_pag6.rowcount())			
			if donde = 0 then
				donde = dw_pag6.insertrow(0)
				dw_pag6.object.empresa[donde]        = codigo_empresa
				dw_pag6.object.articulo[donde]       = articulo
				dw_pag6.object.calidad[donde]        = calidad
				dw_pag6.object.unidad[donde]         = f_unidad_articulo(codigo_empresa,articulo)
				dw_pag6.object.cantidad_abono[donde] = 0
				dw_pag6.object.importe_abono[donde]  = 0
				dw_pag6.object.cantidad_reclamacion[donde] = 0
				dw_pag6.object.importe_reclamacion[donde]  = 0
				dw_pag6.object.importe_gastos[donde]       = 0
			end if
			
			cantidad_abonos = cantidad_abonos + dw_pag6.object.cantidad_abono[donde]
			importe_abonos  = importe_abonos  + dw_pag6.object.importe_abono[donde]
			
			dw_pag6.object.cantidad_abono[donde] = cantidad_abonos
			dw_pag6.object.importe_abono[donde]  = importe_abonos
		end if
	next
next

destroy detalle_abonos
end subroutine

on w_mant_reclamaciones_original.create
int iCurrent
call super::create
this.st_2=create st_2
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.st_descripcion_reclamacion=create st_descripcion_reclamacion
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.st_descripcion_reclamacion
this.Control[iCurrent+5]=this.pb_calculadora
end on

on w_mant_reclamaciones_original.destroy
call super::destroy
destroy(this.st_2)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.st_descripcion_reclamacion)
destroy(this.pb_calculadora)
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

pag7      = true
pag_act7  = true
prin_pag7 = true
end event

event ue_recuperar;long registros

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
		if dw_pag1.object.cerrada[1] = "S" then
			dw_pag1.Modify("DataWindow.ReadOnly=Yes")
			dw_pag2.Modify("DataWindow.ReadOnly=Yes")
			dw_pag3.Modify("DataWindow.ReadOnly=Yes")
			dw_pag4.Modify("DataWindow.ReadOnly=Yes")
			dw_pag5.Modify("DataWindow.ReadOnly=Yes")
			dw_pag7.Modify("DataWindow.ReadOnly=Yes")
			apartados.pagina_7.dw_situacion_final_fase.reset()
			apartados.pagina_7.dw_situacion_final_fase.Modify("DataWindow.ReadOnly=Yes")
			cb_borrar.enabled= false
		else
			dw_pag1.Modify("DataWindow.ReadOnly=No")
			dw_pag2.Modify("DataWindow.ReadOnly=No")
			dw_pag3.Modify("DataWindow.ReadOnly=No")
			dw_pag4.Modify("DataWindow.ReadOnly=No")
			dw_pag5.Modify("DataWindow.ReadOnly=No")
			dw_pag7.Modify("DataWindow.ReadOnly=No")
			apartados.pagina_7.dw_situacion_final_fase.Modify("DataWindow.ReadOnly=No")
			cb_borrar.enabled= true
		end if
	else
			
		st_descripcion_reclamacion.text = ""	
		dw_pag1.Modify("DataWindow.ReadOnly=No")
		dw_pag2.Modify("DataWindow.ReadOnly=No")
		dw_pag3.Modify("DataWindow.ReadOnly=No")
		dw_pag4.Modify("DataWindow.ReadOnly=No")
		dw_pag5.Modify("DataWindow.ReadOnly=No")
		dw_pag7.Modify("DataWindow.ReadOnly=No")
		apartados.pagina_7.dw_situacion_final_fase.Modify("DataWindow.ReadOnly=No")
		cb_borrar.enabled= true
	end if
		
	dw_pag2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	apartados.pagina_2.cb_consulta_detalle_fras.triggerevent(clicked!)
	
	dw_pag3.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	if dw_pag3.rowcount() > 0 then		
		dw_pag3.selectrow(0,false)
		dw_pag3.selectrow(dw_pag3.rowcount(),true)
		apartados.pagina_3.dw_detalle_documento.setrow(dw_pag3.rowcount())
		apartados.pagina_3.dw_detalle_documento.scrolltorow(dw_pag3.rowcount())
	end if
	
	dw_pag4.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	apartados.pagina_4.cb_consulta_abonos.triggerevent(clicked!)
	
	dw_pag5.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	dw_pag7.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,sle_valor.Text)
	
	f_mostrar_resumen_reclamacion()
	
	CALL Super::ue_recuperar
else
	sle_valor.Text = ""
end if
end event

event ue_inserta_fila;pag_act2  = FALSE
pag_act3  = FALSE
pag_act4  = FALSE
pag_act5  = FALSE
pag_act7  = FALSE
CALL Super::ue_inserta_fila
pag_act2  = TRUE
pag_act3  = TRUE
pag_act4  = TRUE
pag_act5  = TRUE
pag_act7  = TRUE

if insercion = "S" Then
	// VALORES INICIALES	
	dw_pag1.SetItem(1,"empresa",codigo_empresa)
	dw_pag1.SetItem(1,"cliente",uo_cliente.em_codigo.text)
	dw_pag1.SetItem(1,"reclamacion",sle_valor.text)
	dw_pag1.setitem(1,"fecha",today())
end if
end event

event open;call super::open;titulo = "Mantenimiento de Reclamaciones"
This.title = titulo

dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
apartados.pagina_2.dw_detalle_facturas_cliente.SetTransObject(SQLCA)

dw_pag3.SetTransObject(SQLCA)
dw_pag3.Sharedata(apartados.pagina_3.dw_detalle_documento)

dw_pag4.SetTransObject(SQLCA)
apartados.pagina_4.dw_detalle_abonos_cliente.SetTransObject(SQLCA)

dw_pag5.SetTransObject(SQLCA)

f_mascara_columna(dw_pag5,"importe_fra_proveedor",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))

dw_pag7.SetTransObject(SQLCA)
dw_pag7.Sharedata(apartados.pagina_7.dw_detalle_fase)

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
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.enabled       = true
uo_cliente.em_campo.enabled  = true
apartados.pagina_3.cb_anyadir_documento.enabled     = false
apartados.pagina_3.cb_borrar_documento.enabled      = false
apartados.pagina_5.cb_anyadir_fra_proveedor.enabled = false
apartados.pagina_5.cb_borrar_fra_proveedor.enabled  = false
apartados.pagina_7.cb_anyadir_fase.enabled          = false
apartados.pagina_7.cb_borrar_fase.enabled           = false
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.enabled      = false
uo_cliente.em_campo.enabled = false
apartados.pagina_3.cb_anyadir_documento.enabled     = true
apartados.pagina_3.cb_borrar_documento.enabled      = true
apartados.pagina_5.cb_anyadir_fra_proveedor.enabled = true
apartados.pagina_5.cb_borrar_fra_proveedor.enabled  = true
apartados.pagina_7.cb_anyadir_fase.enabled          = true
apartados.pagina_7.cb_borrar_fase.enabled           = true
end event

event ue_actualiza_dw;long    indice,lineas_borradas,lineas,anyo,factura,linea_factura
dec     cantidad_reclamacion,total_cantidad_reclamacion,importe_total_reclamacion
dec     gastos_reclamacion
boolean bien = true

lineas_borradas = dw_pag2.deletedcount()

for indice = 1 to lineas_borradas
	anyo          = dw_pag2.getitemnumber(indice,"ven_reclamaciones_detalle_anyo",Delete!,true)
	factura       = dw_pag2.getitemnumber(indice,"ven_reclamaciones_detalle_factura",Delete!,true)
	linea_factura = dw_pag2.getitemnumber(indice,"ven_reclamaciones_detalle_linea",Delete!,true)
//GNO PACO MARIN MMF 13/02/2008
//NO INSERTAMOS EL IMPORTE EN LAS LINEAS
//	
//	update venlifac 
//	set    gastos_reclamacion = 0
//	where  empresa       = :codigo_empresa
//	and    anyo          = :anyo
//	and    factura       = :factura
//	and    linea_factura = :linea_factura;
	
	if sqlca.sqlcode <> 0 then
		bien = false
	end if
next

lineas = dw_pag2.rowcount()
total_cantidad_reclamacion = 0
for indice = 1 to lineas
	total_cantidad_reclamacion = total_cantidad_reclamacion + dw_pag2.object.ven_reclamaciones_detalle_cantidad[indice]
next

lineas = dw_pag5.rowcount()
importe_total_reclamacion = 0
for indice = 1 to lineas
	importe_total_reclamacion = importe_total_reclamacion + dw_pag5.object.importe_fra_proveedor[indice]
next

lineas = dw_pag2.rowcount()

for indice = 1 to lineas
	cantidad_reclamacion = dw_pag2.object.ven_reclamaciones_detalle_cantidad[indice]
	if total_cantidad_reclamacion <> 0 then
		gastos_reclamacion = (importe_total_reclamacion / total_cantidad_reclamacion) * cantidad_reclamacion
	else
		gastos_reclamacion = 0
	end if
	anyo          = dw_pag2.object.ven_reclamaciones_detalle_anyo[indice]
	factura       = dw_pag2.object.ven_reclamaciones_detalle_factura[indice]
	linea_factura = dw_pag2.object.ven_reclamaciones_detalle_linea[indice]
//GNO PACO MARIN MMF 13/02/2008
//NO INSERTAMOS EL IMPORTE EN LAS LINEAS
//	
//	update venlifac 
//	set    gastos_reclamacion = :gastos_reclamacion
//	where  empresa       = :codigo_empresa
//	and    anyo          = :anyo
//	and    factura       = :factura
//	and    linea_factura = :linea_factura;
	
	if sqlca.sqlcode <> 0 then
		bien = false
	end if
	
next


if bien then
	call super::ue_actualiza_dw
else
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar los gastos en las lineas de facturas.")
end if
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_reclamaciones_original
integer x = 3058
integer y = 124
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_reclamaciones_original
integer x = 2651
integer y = 124
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_reclamaciones_original
integer x = 2245
integer y = 124
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_reclamaciones_original
integer taborder = 0
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_reclamaciones_original
integer x = 5
integer y = 4
fontcharset fontcharset = oem!
fontfamily fontfamily = roman!
string facename = "Roman"
long textcolor = 8388608
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_reclamaciones_original
integer x = 366
integer y = 204
integer width = 206
integer height = 76
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "Selección de Reclamaciones"
ue_datawindow = "dw_ayuda_ven_reclamaciones"
ue_filtro     = "cliente = '"+uo_cliente.em_codigo.text+"'"
st_descripcion_reclamacion.text = ""
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_reclamaciones_original
integer x = 27
integer y = 212
integer width = 334
integer height = 68
integer textsize = -8
fontcharset fontcharset = ansi!
string text = "Reclamación:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_reclamaciones_original
integer x = 0
integer y = 320
integer width = 3611
integer height = 1664
integer taborder = 70
string dragicon = "Application!"
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
end type

event apartados::pulsar_datawindow;call super::pulsar_datawindow;
if dw_pag1.object.cerrada[1] = "S" then
	

	pb_calculadora.enabled      = false
	uo_cliente.em_campo.enabled = false
	apartados.pagina_3.cb_anyadir_documento.enabled     = false
	apartados.pagina_3.cb_borrar_documento.enabled      = false
	apartados.pagina_5.cb_anyadir_fra_proveedor.enabled = false
	apartados.pagina_5.cb_borrar_fra_proveedor.enabled  = false
	apartados.pagina_7.cb_anyadir_fase.enabled          = false
	apartados.pagina_7.cb_borrar_fase.enabled           = false
//	cb_insertar.enabled= false
//	cb_borrar.enabled= false
end if
end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3575
integer height = 1536
string text = "Reclamación"
string picturename = "Custom037!"
long picturemaskcolor = 553648127
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 0
integer width = 3575
integer height = 1536
string dataobject = "dw_mant_reclamaciones1"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina1::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "codigo_ven_reclamaciones_tipos"
 		bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE RECLAMACION"
		valor_empresa = true
   CASE "codigo_ven_reclamaciones_causa"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_causas"
     	bus_titulo = "VENTANA SELECCION DE CAUSAS"
		valor_empresa = true
   CASE "codigo_ven_reclamaciones_situa"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo = "VENTANA SELECCION DE SITUACIONES"
		valor_empresa = true
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()
 
 CHOOSE CASE bus_campo
	CASE "codigo_ven_reclamaciones_tipos"
 		bus_datawindow = "dw_ayuda_ven_reclamaciones_tipos"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE RECLAMACION"
		valor_empresa = true
   CASE "codigo_ven_reclamaciones_causa"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_causas"
     	bus_titulo = "VENTANA SELECCION DE CAUSAS"
		valor_empresa = true

   CASE "codigo_ven_reclamaciones_situa"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo = "VENTANA SELECCION DE SITUACIONES"
		valor_empresa = true
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key


end event

event dw_pagina1::itemchanged;call super::itemchanged;long ll_indice,ll_total,ll_donde,ll_registros
string ls_tipo_reclamacion,ls_causa_reclamacion,ls_situacion_inicial,ls_fase_inicial

choose case dwo.name
	case "codigo_ven_reclamaciones_tipos"
		ls_tipo_reclamacion  = data
		ls_causa_reclamacion = this.object.codigo_ven_reclamaciones_causa[row]
		
		this.object.codigo_ven_reclamaciones_causa[row] = ""		
		this.event itemchanged(row,this.object.codigo_ven_reclamaciones_causa,this.object.codigo_ven_reclamaciones_causa[row])
	case "codigo_ven_reclamaciones_causa"
		ls_tipo_reclamacion  = this.object.codigo_ven_reclamaciones_tipos[row]		
		ls_causa_reclamacion = data
		
		if ls_tipo_reclamacion <> "" and ls_causa_reclamacion <> "" then
			ll_total = apartados.pagina_7.dw_pagina7.rowcount()
			
			for ll_indice = 1 to ll_total
				apartados.pagina_7.dw_pagina7.setrow(1)
				apartados.pagina_7.cb_borrar_fase.triggerevent(clicked!)
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
					apartados.pagina_7.cb_anyadir_fase.triggerevent(clicked!)
					
					ll_donde = apartados.pagina_7.dw_pagina7.rowcount()
					apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases[ll_donde] = ls_fase_inicial		
					apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases[ll_donde])					
					
					apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i[ll_donde] = ls_situacion_inicial		
					apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i[ll_donde])										

				end if
			else
				return 2
			end if
		else
			ll_total = apartados.pagina_7.dw_pagina7.rowcount()
			
			for ll_indice = 1 to ll_total
				apartados.pagina_7.dw_pagina7.setrow(1)
				apartados.pagina_7.cb_borrar_fase.triggerevent(clicked!)
			next
		end if
end choose

end event

event dw_pagina1::sqlpreview;call super::sqlpreview;//messagebox("sql", sqlsyntax)
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3575
integer height = 1536
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
end type

on pagina_2.create
this.st_3=create st_3
this.em_fechadesde=create em_fechadesde
this.st_4=create st_4
this.em_fechahasta=create em_fechahasta
this.cb_consulta_detalle_fras=create cb_consulta_detalle_fras
this.dw_detalle_facturas_cliente=create dw_detalle_facturas_cliente
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_borrar_linea_detalle=create cb_borrar_linea_detalle
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
end on

on pagina_2.destroy
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
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 0
integer width = 3575
integer height = 684
integer taborder = 0
string dataobject = "dw_mant_reclamaciones2"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina2::dragdrop;long   donde,donde_origen
string cliente,reclamacion   

//Soltamos el objeto
DataWindow origen
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
		this.object.ven_reclamaciones_detalle_anyo[donde]        = origen.object.anyo[donde_origen]   
		this.object.ven_reclamaciones_detalle_factura[donde]     = origen.object.factura[donde_origen]   
		this.object.ven_reclamaciones_detalle_linea[donde]       = origen.object.linea_factura[donde_origen]   
		this.object.ven_reclamaciones_detalle_cantidad[donde]    = origen.object.cantidad[donde_origen]   
		this.object.ven_reclamaciones_detalle_descripcion[donde] = ''
		this.object.venlifac_falbaran[donde]                     = origen.object.falbaran[donde_origen]   
		this.object.venlifac_articulo[donde]                     = origen.object.articulo[donde_origen]   
		this.object.venlifac_tipo_unidad[donde]                  = origen.object.tipo_unidad[donde_origen]   
		this.object.venlifac_formato[donde]                      = f_formato_articulo(codigo_empresa,origen.object.articulo[donde_origen])
		this.object.venlifac_calidad[donde]                      = origen.object.calidad[donde_origen]   
		this.object.venlifac_calibre[donde]                      = origen.object.calibre[donde_origen]   
		this.object.venlifac_cantidad[donde]                     = origen.object.cantidad[donde_origen]   
		this.object.venlifac_descripcion[donde]                  = origen.object.descripcion[donde_origen]   
		this.object.venlifac_tipo_pallet[donde]                  = origen.object.tipo_pallet[donde_origen]   
		this.object.venlifac_ffactura[donde]                     = origen.object.ffactura[donde_origen]   
		this.object.venlifac_tono[donde]                         = origen.object.venlifac_tono[donde_origen]  
	end if
end if
end event

event dw_pagina2::clicked;call super::clicked;this.selectrow(0,false)
if row > 0 then		
	this.selectrow(row,true)
	this.setrow(row)
	cb_borrar_linea_detalle.enabled = true
else
	cb_borrar_linea_detalle.enabled = false
	this.setrow(row)
end if
end event

event dw_pagina2::retrieveend;cb_borrar_linea_detalle.enabled = false
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3575
integer height = 1536
string text = "Documentos"
string picturename = "Custom092!"
long picturemaskcolor = 553648127
dw_detalle_documento dw_detalle_documento
gb_6 gb_6
cb_anyadir_documento cb_anyadir_documento
cb_borrar_documento cb_borrar_documento
end type

on pagina_3.create
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

on pagina_3.destroy
call super::destroy
destroy(this.dw_detalle_documento)
destroy(this.gb_6)
destroy(this.cb_anyadir_documento)
destroy(this.cb_borrar_documento)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 0
integer width = 1307
integer height = 1440
string dataobject = "dw_mant_reclamaciones4"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::clicked;call super::clicked;//if row > 0 then
//	this.selectrow(0,false)
//	this.selectrow(row,true)
//	dw_detalle_documento.setrow(row)
//	dw_detalle_documento.scrolltorow(row)
//end if
end event

event dw_pagina3::rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	dw_detalle_documento.setrow(currentrow)
	dw_detalle_documento.scrolltorow(currentrow)
end if
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
event create ( )
event destroy ( )
integer width = 3575
integer height = 1536
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
end type

on pagina_4.create
this.st_5=create st_5
this.em_fechadesdeabono=create em_fechadesdeabono
this.st_6=create st_6
this.em_fechahastaabono=create em_fechahastaabono
this.cb_consulta_abonos=create cb_consulta_abonos
this.cb_borrar_abono=create cb_borrar_abono
this.gb_5=create gb_5
this.gb_4=create gb_4
this.dw_detalle_abonos_cliente=create dw_detalle_abonos_cliente
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
end on

on pagina_4.destroy
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
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 0
integer y = 0
integer width = 3575
integer height = 684
string dataobject = "dw_mant_reclamaciones5"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina4::clicked;call super::clicked;this.selectrow(0,false)
if row > 0 then		
	this.selectrow(row,true)
	this.setrow(row)
	cb_borrar_abono.enabled = true
else
	cb_borrar_abono.enabled = false
	this.setrow(row)
end if
end event

event dw_pagina4::retrieveend;cb_borrar_abono.enabled = false
end event

event dw_pagina4::dragdrop;long   donde,donde_origen
string cliente,reclamacion   

//Soltamos el objeto
DataWindow origen
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
end event

event dw_pagina4::dragwithin;if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3575
integer height = 1536
string text = "Gastos Ocasionados"
string picturename = "\bmp\dolar.bmp"
long picturemaskcolor = 553648127
cb_anyadir_fra_proveedor cb_anyadir_fra_proveedor
cb_borrar_fra_proveedor cb_borrar_fra_proveedor
gb_7 gb_7
end type

on pagina_5.create
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

on pagina_5.destroy
call super::destroy
destroy(this.cb_anyadir_fra_proveedor)
destroy(this.cb_borrar_fra_proveedor)
destroy(this.gb_7)
end on

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 0
integer y = 0
integer width = 3575
integer height = 1440
string dataobject = "dw_mant_reclamaciones7"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina5::key;bus_filtro     = ""
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
end event

event dw_pagina5::rbuttondown;bus_filtro     = ""
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
end event

event dw_pagina5::clicked;call super::clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3575
integer height = 1536
string text = "Resumen"
string picturename = "Properties!"
long picturemaskcolor = 553648127
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer x = 0
integer y = 0
integer width = 3575
integer height = 1440
string dataobject = "dw_mant_reclamaciones8"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
event create ( )
event destroy ( )
integer width = 3575
integer height = 1536
string text = "Fases"
string picturename = "SetDefaultClass!"
cb_anyadir_fase cb_anyadir_fase
cb_borrar_fase cb_borrar_fase
dw_detalle_fase dw_detalle_fase
dw_situacion_final_fase dw_situacion_final_fase
gb_8 gb_8
end type

on pagina_7.create
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

on pagina_7.destroy
call super::destroy
destroy(this.cb_anyadir_fase)
destroy(this.cb_borrar_fase)
destroy(this.dw_detalle_fase)
destroy(this.dw_situacion_final_fase)
destroy(this.gb_8)
end on

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 0
integer y = 0
integer width = 1307
integer height = 1440
string dataobject = "dw_mant_reclamaciones9"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina7::rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	dw_detalle_fase.setrow(currentrow)
	dw_detalle_fase.scrolltorow(currentrow)
end if
end event

event dw_pagina7::itemchanged;call super::itemchanged;string ls_situacion_inicial,ls_situacion_final,ls_fase,ls_tipo_reclamacion,ls_causa_reclamacion
string ls_fase_siguiente,ls_situacion_siguiente,ls_cierre_reclamacion
string ls_sel,ls_situacion
long   ll_indice,ll_total,ll_donde
datastore ds_datos

if row= 0 then return

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
			ls_fase              = apartados.pagina_7.dw_detalle_fase.object.codigo_ven_reclamaciones_fases[apartados.pagina_7.dw_detalle_fase.getrow()]
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
				apartados.pagina_7.cb_anyadir_fase.triggerevent(clicked!)
				
				ll_donde = apartados.pagina_7.dw_pagina7.rowcount()
				apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases[ll_donde] = ls_fase_siguiente		
				apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_fases[ll_donde])					
				
				apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i[ll_donde] = ls_situacion_siguiente		
				apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_i[ll_donde])																
			
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
		
		apartados.pagina_7.dw_situacion_final_fase.reset()
		
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
			
			ll_donde = apartados.pagina_7.dw_situacion_final_fase.insertrow(0)
			apartados.pagina_7.dw_situacion_final_fase.object.marcada[ll_donde]     = "N"
			apartados.pagina_7.dw_situacion_final_fase.object.situacion[ll_donde]   = ls_situacion
			apartados.pagina_7.dw_situacion_final_fase.object.descripcion[ll_donde] = f_nombre_situaciones(codigo_empresa,ls_situacion)
			
		next
end choose
end event

event dw_pagina7::retrieveend;call super::retrieveend;
apartados.pagina_7.dw_situacion_final_fase.reset()

if rowcount() > 0 and dw_pag1.object.cerrada[1] <> 'S' then
//	this.setrow(rowcount)
//	dw_detalle_fase.setrow(rowcount)
//	dw_detalle_fase.scrolltorow(rowcount)	
	this.event itemchanged(rowcount,this.object.codigo_ven_reclamaciones_fases,this.object.codigo_ven_reclamaciones_fases[rowcount])
end if

end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3575
integer height = 1536
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type st_3 from statictext within pagina_2
integer x = 18
integer y = 712
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 8388608
long backcolor = 12632256
string text = "Fecha Factura:"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within pagina_2
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

type st_4 from statictext within pagina_2
integer x = 690
integer y = 716
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

type em_fechahasta from u_em_campo within pagina_2
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

type cb_consulta_detalle_fras from commandbutton within pagina_2
integer x = 1029
integer y = 712
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
f_desde = datetime(date(em_fechadesde.text))
f_hasta = datetime(date(em_fechahasta.text))

apartados.pagina_2.dw_detalle_facturas_cliente.retrieve(codigo_empresa,cliente,f_desde,f_hasta)

end event

type dw_detalle_facturas_cliente from datawindow within pagina_2
integer y = 800
integer width = 3575
integer height = 728
string dragicon = "\bmp\Dragitem.ico"
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones3"
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
	reclamacion = this.object.ven_reclamaciones_detalle_reclamacion[row]
	if isnull(reclamacion) then reclamacion = ""
	if trim(reclamacion) = "" then
		drag(begin!)
	end if
end if
end event

type gb_3 from groupbox within pagina_2
integer x = 2258
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

type gb_2 from groupbox within pagina_2
integer y = 672
integer width = 1317
integer height = 128
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

type cb_borrar_linea_detalle from commandbutton within pagina_2
integer x = 2267
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

event clicked;long   donde,anyo,factura,linea_factura,total_lineas
string busqueda

if dw_pagina2.getrow() > 0 then
	if messagebox("Confirmación","¿Desea borrar la linea seleccionada?",Question!,YesNo!,2)= 1 then
		donde         = dw_pagina2.getrow()
		anyo          = dw_pagina2.object.ven_reclamaciones_detalle_anyo[donde]
		factura       = dw_pagina2.object.ven_reclamaciones_detalle_factura[donde]
		linea_factura = dw_pagina2.object.ven_reclamaciones_detalle_linea[donde]
		dw_pagina2.deleterow(donde)
		
		total_lineas = apartados.pagina_2.dw_detalle_facturas_cliente.rowcount()
		if total_lineas > 0 then
			busqueda = "anyo = "+string(anyo,"####")+" and factura = "+string(factura,"########")+" and linea_factura = "+string(linea_factura,"####")
			donde = apartados.pagina_2.dw_detalle_facturas_cliente.find(busqueda,1,total_lineas)
			
			if donde > 0 then
				apartados.pagina_2.dw_detalle_facturas_cliente.object.ven_reclamaciones_detalle_reclamacion[donde] = ""
				apartados.pagina_2.dw_detalle_facturas_cliente.object.ven_reclamaciones_detalle_descripcion[donde] = ""
			end if
		end if
	end if
end if
end event

type dw_detalle_documento from datawindow within pagina_3
integer x = 1317
integer width = 2258
integer height = 1536
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones4_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

type gb_6 from groupbox within pagina_3
integer y = 1420
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

type cb_anyadir_documento from commandbutton within pagina_3
integer x = 9
integer y = 1456
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

total = dw_pag3.rowcount()

documento = 0

for indice = 1 to total
	if dec(dw_pag3.object.documento[indice]) > documento then	
		documento = dec(dw_pag3.object.documento[indice])
	end if
next

documento ++

donde = dw_pag3.insertrow(0)

dw_pag3.object.empresa[donde]     = codigo_empresa
dw_pag3.object.cliente[donde]     = uo_cliente.em_codigo.text
dw_pag3.object.reclamacion[donde] = sle_valor.text
dw_pag3.object.documento[donde]   = string(documento,"###")

dw_pag3.selectrow(0,false)
dw_pag3.selectrow(donde,true)
dw_pag3.setrow(donde)
dw_pag3.scrolltorow(donde)
dw_detalle_documento.setfocus()
dw_detalle_documento.setrow(donde)
dw_detalle_documento.scrolltorow(donde)
dw_detalle_documento.setcolumn("fecha")

end event

type cb_borrar_documento from commandbutton within pagina_3
integer x = 690
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
boolean enabled = false
string text = "Borrar Documento"
end type

event clicked;string descripcion
long   donde

donde = dw_pagina3.getrow()

if donde > 0 then
	descripcion = dw_pagina3.object.descripcion[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina3.object.fecha[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar el documento :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina3.deleterow(donde)
		if dw_pagina3.rowcount() > 0 then
			if donde > dw_pagina3.rowcount() then
				donde = donde -1
			end if
			dw_pagina3.selectrow(0,false)
			dw_pagina3.selectrow(donde,true)
			dw_pagina3.setrow(donde)
			dw_pagina3.scrolltorow(donde)	
			dw_detalle_documento.setrow(donde)
			dw_detalle_documento.scrolltorow(donde)			
		end if
	end if
end if
end event

type st_5 from statictext within pagina_4
integer x = 18
integer y = 712
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 8388608
long backcolor = 12632256
string text = "Fecha Abono:"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fechadesdeabono from u_em_campo within pagina_4
integer x = 407
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

type st_6 from statictext within pagina_4
integer x = 690
integer y = 716
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

type em_fechahastaabono from u_em_campo within pagina_4
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

type cb_consulta_abonos from commandbutton within pagina_4
integer x = 1029
integer y = 712
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

apartados.pagina_4.dw_detalle_abonos_cliente.retrieve(codigo_empresa,cliente,f_desde,f_hasta)

end event

type cb_borrar_abono from commandbutton within pagina_4
integer x = 2267
integer y = 696
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

if dw_pagina4.getrow() > 0 then
	if messagebox("Confirmación","¿Desea borrar la linea seleccionada?",Question!,YesNo!,2)= 1 then
		donde         = dw_pagina4.getrow()
		anyo          = dw_pagina4.object.ven_reclamaciones_detalle_anyo[donde]
		factura       = dw_pagina4.object.ven_reclamaciones_detalle_factura[donde]
		
		dw_pagina4.deleterow(donde)
		
		total_lineas = apartados.pagina_4.dw_detalle_abonos_cliente.rowcount()
		if total_lineas > 0 then
			busqueda = "anyo = "+string(anyo,"####")+" and factura = "+string(factura,"########")
			donde = apartados.pagina_4.dw_detalle_abonos_cliente.find(busqueda,1,total_lineas)
			
			if donde > 0 then
				apartados.pagina_4.dw_detalle_abonos_cliente.object.ven_reclamaciones_detalle_reclamacion[donde] = ""
			end if
		end if
	end if
end if
end event

type gb_5 from groupbox within pagina_4
integer x = 2258
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

type gb_4 from groupbox within pagina_4
integer y = 672
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

type dw_detalle_abonos_cliente from datawindow within pagina_4
integer y = 800
integer width = 3575
integer height = 728
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

type cb_anyadir_fra_proveedor from commandbutton within pagina_5
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
boolean enabled = false
string text = "Añadir factura"
end type

event clicked;long indice,total,donde,gasto

total = dw_pag5.rowcount()

gasto = 0

for indice = 1 to total
	if dec(dw_pag5.object.gasto[indice]) > gasto then	
		gasto = dec(dw_pag5.object.gasto[indice])
	end if
next

gasto ++

donde = dw_pag5.insertrow(0)

dw_pag5.object.empresa[donde]     = codigo_empresa
dw_pag5.object.cliente[donde]     = uo_cliente.em_codigo.text
dw_pag5.object.reclamacion[donde] = sle_valor.text
dw_pag5.object.gasto[donde]       = string(gasto,"###")

dw_pag5.selectrow(0,false)
dw_pag5.selectrow(donde,true)
dw_pag5.setrow(donde)
dw_pag5.scrolltorow(donde)
dw_pag5.setfocus()
dw_pag5.setcolumn("proveedor")

end event

type cb_borrar_fra_proveedor from commandbutton within pagina_5
integer x = 690
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
boolean enabled = false
string text = "Borrar Factura"
end type

event clicked;string descripcion
long   donde

donde = dw_pagina5.getrow()

if donde > 0 then
	descripcion = dw_pagina5.object.fra_proveedor[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina5.object.fecha_fra_proveedor[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar la factura :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina5.deleterow(donde)
		if dw_pagina5.rowcount() > 0 then
			if donde > dw_pagina5.rowcount() then
				donde = donde -1
			end if
			dw_pagina5.selectrow(0,false)
			dw_pagina5.selectrow(donde,true)
			dw_pagina5.setrow(donde)
			dw_pagina5.scrolltorow(donde)	
		end if
	end if
end if
end event

type gb_7 from groupbox within pagina_5
integer y = 1420
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

type cb_anyadir_fase from commandbutton within pagina_7
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
boolean enabled = false
string text = "Añadir Fase"
end type

event clicked;long indice,total,donde,codigo
datetime  ldt_fecha_inicio

total = dw_pag7.rowcount()

ldt_fecha_inicio = datetime(today(),now())

codigo = 0

for indice = 1 to total
	if dec(dw_pag7.object.codigo[indice]) > codigo then	
		codigo = dec(dw_pag7.object.codigo[indice])
	end if
next

codigo ++

donde = dw_pag7.insertrow(0)

dw_pag7.object.empresa[donde]                        = codigo_empresa
dw_pag7.object.cliente[donde]                        = uo_cliente.em_codigo.text
dw_pag7.object.reclamacion[donde]                    = sle_valor.text
dw_pag7.object.codigo[donde]                         = string(codigo,"###")
dw_pag7.object.codigo_ven_reclamaciones_fases[donde] = ""
dw_pag7.object.fecha_inicio[donde]                   = ldt_fecha_inicio
dw_pag7.object.fecha_fin[donde]                      = ldt_fecha_inicio
dw_pag7.object.usuario_inicio[donde]                 = nombre_usuario
dw_pag7.object.usuario_fin[donde]                    = ""
dw_pag7.object.codigo_ven_reclamaciones_sit_i[donde] = ""
dw_pag7.object.codigo_ven_reclamaciones_sit_f[donde] = ""
dw_pag7.object.observaciones[donde]                  = ""


dw_pag7.selectrow(0,false)
dw_pag7.selectrow(donde,true)
dw_pag7.setrow(donde)
dw_pag7.scrolltorow(donde)
dw_detalle_fase.setfocus()
dw_detalle_fase.setrow(donde)
dw_detalle_fase.scrolltorow(donde)
dw_detalle_fase.setcolumn("observaciones")

end event

type cb_borrar_fase from commandbutton within pagina_7
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

donde = dw_pagina7.getrow()

if donde > 0 then
	descripcion = dw_pagina7.object.codigo_ven_reclamaciones_fases[donde]
	descripcion = descripcion + " de fecha : " + string(dw_pagina7.object.fecha_inicio[donde],"dd/mm/yy")
	if messagebox("Confirmación","Desea borrar la fase :~n"+descripcion,Question!,YesNo!,2) = 1 then
		dw_pagina7.deleterow(donde)
		if dw_pagina7.rowcount() > 0 then
			if donde > dw_pagina7.rowcount() then
				donde = donde -1
			end if
			dw_pagina7.selectrow(0,false)
			dw_pagina7.selectrow(donde,true)
			dw_pagina7.setrow(donde)
			dw_pagina7.scrolltorow(donde)	
			dw_detalle_fase.setrow(donde)
			dw_detalle_fase.scrolltorow(donde)			
		end if
	end if
end if
end event

type dw_detalle_fase from datawindow within pagina_7
integer x = 1317
integer width = 2258
integer height = 1236
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
apartados.pagina_7.dw_pagina7.event itemchanged(row,dwo,data)
end event

type dw_situacion_final_fase from u_datawindow within pagina_7
integer x = 1317
integer y = 1244
integer width = 2258
integer height = 292
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_mant_reclamaciones9_3"
end type

event itemchanged;call super::itemchanged;long   ll_donde
string situacion

if not(cb_insertar.enabled) then
	apartados.TriggerEvent("pulsar_datawindow")
else
	if data = "S" then
	
		ll_donde = apartados.pagina_7.dw_pagina7.rowcount()
		apartados.pagina_7.dw_pagina7.object.fecha_fin[ll_donde] = datetime(today(),now())
		apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.fecha_fin,string(apartados.pagina_7.dw_pagina7.object.fecha_fin[ll_donde]))							
		
		apartados.pagina_7.dw_pagina7.object.usuario_fin[ll_donde] = nombre_usuario	
		apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.usuario_fin,apartados.pagina_7.dw_pagina7.object.usuario_fin[ll_donde])												
		
		apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_f[ll_donde] = this.object.situacion[row]		
		apartados.pagina_7.dw_pagina7.event itemchanged(row,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_f,apartados.pagina_7.dw_pagina7.object.codigo_ven_reclamaciones_sit_f[ll_donde])													
	end if	
end if	

end event

type gb_8 from groupbox within pagina_7
integer y = 1420
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

type st_2 from statictext within w_mant_reclamaciones_original
integer x = 27
integer y = 132
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

type uo_cliente from u_em_campo_2 within w_mant_reclamaciones_original
event destroy ( )
integer x = 366
integer y = 124
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

type gb_1 from groupbox within w_mant_reclamaciones_original
integer x = 5
integer y = 84
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

type st_descripcion_reclamacion from statictext within w_mant_reclamaciones_original
integer x = 581
integer y = 208
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

type pb_calculadora from picturebutton within w_mant_reclamaciones_original
integer x = 1957
integer y = 124
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

if cliente <> "" then
	select max(convert(int,reclamacion))
	into   :ultima_reclamacion
	from   ven_reclamaciones
	where  empresa = :codigo_empresa
	and    cliente = :cliente;
	
	if isnull(ultima_reclamacion) then ultima_reclamacion = 0
	
	ultima_reclamacion ++
	
	sle_valor.text = string(ultima_reclamacion,"#####")
	st_descripcion_reclamacion.text = ""
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

