$PBExportHeader$w_carga_lineas_seguros_nueva.srw
forward
global type w_carga_lineas_seguros_nueva from w_int_con_empresa
end type
type pb_1 from upb_salir within w_carga_lineas_seguros_nueva
end type
type dw_listado_detalle from datawindow within w_carga_lineas_seguros_nueva
end type
type pb_2 from upb_imprimir within w_carga_lineas_seguros_nueva
end type
type uo_companyia from u_em_campo_2 within w_carga_lineas_seguros_nueva
end type
type st_6 from statictext within w_carga_lineas_seguros_nueva
end type
type cb_borrar from u_boton within w_carga_lineas_seguros_nueva
end type
type st_1 from statictext within w_carga_lineas_seguros_nueva
end type
type em_anyo from u_em_campo within w_carga_lineas_seguros_nueva
end type
type st_2 from statictext within w_carga_lineas_seguros_nueva
end type
type uo_mes from u_em_campo_2 within w_carga_lineas_seguros_nueva
end type
type uo_tipo_documento from u_marca_lista within w_carga_lineas_seguros_nueva
end type
type dw_detalle from datawindow within w_carga_lineas_seguros_nueva
end type
type st_3 from statictext within w_carga_lineas_seguros_nueva
end type
type gb_1 from groupbox within w_carga_lineas_seguros_nueva
end type
type uo_1 from u_manejo_datawindow within w_carga_lineas_seguros_nueva
end type
type clientes_primera_venta from structure within w_carga_lineas_seguros_nueva
end type
end forward

type clientes_primera_venta from structure
	string		cliente
	long		primera_factura
end type

global type w_carga_lineas_seguros_nueva from w_int_con_empresa
integer width = 2894
integer height = 1668
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
pb_2 pb_2
uo_companyia uo_companyia
st_6 st_6
cb_borrar cb_borrar
st_1 st_1
em_anyo em_anyo
st_2 st_2
uo_mes uo_mes
uo_tipo_documento uo_tipo_documento
dw_detalle dw_detalle
st_3 st_3
gb_1 gb_1
uo_1 uo_1
end type
global w_carga_lineas_seguros_nueva w_carga_lineas_seguros_nueva

type variables



end variables

forward prototypes
public function boolean f_procesar ()
public subroutine f_cargar_datos (datawindow dw_carga)
end prototypes

public function boolean f_procesar ();string   var_companyia,var_cliente,var_forma_pago,var_situacion,var_declarado
string   var_factura_s,var_cobrado,documento_pago
int      var_anyo,var_anyo_factura
long     var_orden,var_factura,indice,total,indice_documentos
dec      var_total_factura,var_importe,pendiente_cartera
datetime var_fecha_factura,var_primer_vto,var_ultimo_vto,var_fecha_notificacion
boolean  bien = true

Str_vencimientos vencimientos

var_anyo      = Dec(em_anyo.text)  
var_companyia = uo_companyia.em_codigo.text

Select Max(orden) 
Into   :var_orden 
From   seglinventas  
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo;

IF IsNull(var_orden) Then var_orden = 0

total = dw_detalle.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando",indice,total)
	
	if bien then
		var_orden ++
		
		var_anyo_factura = dw_detalle.object.anyo[indice]
		var_factura      = dw_detalle.object.factura[indice]
		var_factura_s    = string(var_factura,"##########")
		
		select cliente,			codpago,				ffactura,				total_fac_pts
		into   :var_cliente,		:var_forma_pago,	:var_fecha_factura,	:var_total_factura
		from   venfac
		where  empresa = :codigo_empresa
		and    anyo    = :var_anyo_factura
		and    factura = :var_factura;
		
		if sqlca.sqlcode <> 0 then
			bien = false		
		end if				
		
		vencimientos = f_vencimientos_factura_sin_precartera(codigo_empresa,var_anyo_factura,var_factura)
		
		var_primer_vto = DateTime(vencimientos.vencimiento[1])
		var_ultimo_vto = DateTime(vencimientos.vencimiento[vencimientos.efectos])
		
		var_situacion  = dw_detalle.object.situacion[indice]
		choose case var_situacion
			case "No solicitado"
				var_declarado = "N"
			case "Primera venta"
				var_declarado = "S"
			case "Solicitado"
				var_declarado = "S"
			case "Denegado"
				var_declarado = "N"
			case "Concedido"
				var_declarado = "S"						
		end choose
		
		setnull(var_fecha_notificacion)
		
		pendiente_cartera = 0
		
		select sum(importe)
		into   :pendiente_cartera
		from   carefectos
		where  empresa   = :codigo_empresa
		and    anyofra   = :var_anyo_factura
		and    factura   = :var_factura_s
		and    situacion <> '9'
		and    (agrupado <>'S' or agrupado is null);
		
		if isnull(pendiente_cartera) then pendiente_cartera = 0
		
		var_importe = pendiente_cartera
		var_cobrado = "N"
		
		if var_importe <> 0 then
			insert into seglinventas
				(empresa, 					anyo, 					orden, 
				 companyia, 				anyo_factura, 			factura, 
				 fecha_factura, 			cliente, 				importe, 
				 primer_vto, 				ultimo_vto, 			forma_pago, 
				 situacion, 				cobrado, 				declarado, 
				 fecha_notificacion)
			values
				(:codigo_empresa, 		:var_anyo, 				:var_orden, 
				 :var_companyia, 			:var_anyo_factura, 	:var_factura, 
				 :var_fecha_factura, 	:var_cliente, 			:var_importe, 
				 :var_primer_vto, 		:var_ultimo_vto, 		:var_forma_pago, 
				 :var_situacion, 			:var_cobrado, 			:var_declarado, 
				 :var_fecha_notificacion);
				 
			if sqlca.sqlcode <> 0 then
				bien = false
			end if		
		end if
		
		if pendiente_cartera <> var_total_factura then
			var_orden ++
			var_importe   = var_total_factura - pendiente_cartera
			var_cobrado   = "S"
			
			if var_situacion = "Concedido" then
				//Marcamos a declarar los tipos de documentos que indicamos en el marca lista
				documento_pago = f_tipodoc_carforpag(codigo_empresa,var_forma_pago)
				
				indice_documentos = uo_tipo_documento.dw_marca.find("codigo = '"+documento_pago+"'",1,uo_tipo_documento.dw_marca.rowcount())
							
				if indice_documentos > 0 then
					if uo_tipo_documento.dw_marca.object.marca[indice_documentos] = "S" then
						var_declarado = "S"
					else
						var_declarado = "N"
					end if
				else
					var_declarado = "N"
				end if
			else
				var_declarado = "N"
			end if
			
			insert into seglinventas
				(empresa, 					anyo, 					orden, 
				 companyia, 				anyo_factura, 			factura, 
				 fecha_factura, 			cliente, 				importe, 
				 primer_vto, 				ultimo_vto, 			forma_pago, 
				 situacion, 				cobrado, 				declarado, 
				 fecha_notificacion)
			values
				(:codigo_empresa, 		:var_anyo, 				:var_orden, 
				 :var_companyia, 			:var_anyo_factura, 	:var_factura, 
				 :var_fecha_factura, 	:var_cliente, 			:var_importe, 
				 :var_primer_vto, 		:var_ultimo_vto, 		:var_forma_pago, 
				 :var_situacion, 			:var_cobrado, 			:var_declarado, 
				 :var_fecha_notificacion);
				 
			if sqlca.sqlcode <> 0 then
				bien = false
			end if		
			
		end if	
	end if
next

return bien
end function

public subroutine f_cargar_datos (datawindow dw_carga);string    sel,cliente,moneda,moneda_empresa,nombre_moneda_empresa,situacion,filtro_pais
string    companyia
long      indice,total,anyo,factura,donde
dec       divisas,importe,cambio
datetime  fecha_desde,fecha_hasta,ffactura

datastore facturas

dw_carga.setredraw(false)

companyia = uo_companyia.em_codigo.text

dw_carga.retrieve(codigo_empresa,companyia,uo_mes.em_codigo.text,em_anyo.text)

moneda_empresa        = f_moneda_empresa(codigo_empresa)
nombre_moneda_empresa = f_nombre_moneda_abr(moneda_empresa)

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

if companyia = "1" then
	filtro_pais = "and pais in ('11') "
else
	filtro_pais = "and pais not in ('11') "
end if


sel = "Select cliente,anyo,factura,ffactura,total_fac,total_fac_pts,divisa,cambio "+&
		"from   venfac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and ffactura between '"+string(fecha_desde,"dd/mm/yy")+"' "+&
					 "and '"+string(fecha_hasta,"dd/mm/yy")+"' "+&
		"and cliente in( "+&
		"select codigo from genter "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    tipoter = 'C' "+&
		"and    codigo <> '"+f_codigo_cliente_empresa(codigo_empresa)+"' "+&
		filtro_pais+" )"
		
//facturas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, facturas)
total = facturas.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando facturas:",indice,total)
	cliente   = facturas.object.cliente[indice]	
	anyo      = facturas.object.anyo[indice]	
	factura   = facturas.object.factura[indice]	
	ffactura      = facturas.object.ffactura[indice]	
	divisas   = facturas.object.total_fac[indice]	
	importe   = facturas.object.total_fac_pts[indice]	
	moneda    = facturas.object.divisa[indice]	
	cambio    = facturas.object.cambio[indice]	

	situacion = f_situ_seguro_fra_cliente_companyia(codigo_empresa,anyo,factura,ffactura,cliente,companyia)
	
	donde     = dw_carga.insertrow(0)
	
	dw_carga.object.empresa[donde]               = codigo_empresa
	dw_carga.object.cliente[donde]               = cliente
	dw_carga.object.nombre_cliente[donde]        = f_razon_genter(codigo_empresa,"C",cliente)
	dw_carga.object.anyo[donde]                  = anyo
	dw_carga.object.factura[donde]               = factura
	dw_carga.object.ffra[donde]                  = ffactura
	dw_carga.object.divisas[donde]               = divisas
	dw_carga.object.importe[donde]               = importe
	dw_carga.object.moneda[donde]                = moneda
	dw_carga.object.nombre_moneda[donde]         = f_nombre_moneda_abr(moneda)
	dw_carga.object.moneda_empresa[donde]        = moneda_empresa
	dw_carga.object.nombre_moneda_empresa[donde] = nombre_moneda_empresa
	dw_carga.object.situacion[donde]             = situacion
	dw_carga.object.cambio[donde]                = cambio
next
			
destroy facturas

dw_carga.sort()
dw_carga.groupcalc()
dw_carga.setredraw(true)
end subroutine

event open;call super::open;string sel,codigo,texto,marca
long indice,total
datastore documentos

istr_parametros.s_titulo_ventana = "Carga Facturas seguros"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_listado_detalle.SetTransObject(SQLCA)
uo_companyia.em_codigo.text = "1"
uo_companyia.triggerEvent("modificado")

em_anyo.text = String(year(Today()))
uo_mes.em_codigo.text = String(Month(Today()) - 1 )

IF uo_mes.em_codigo.text = "0" Then
	uo_mes.em_codigo.text = "12"
	em_anyo.text = String(Dec(em_anyo.text) - 1)
END IF

uo_mes.em_campo.text  = f_nombre_mes(Dec(uo_mes.em_codigo.text))

sel = "select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"' order by texto"

//documentos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, documentos)

total      = documentos.rowcount()
If total > 0 THEN
	FOR indice = 1 To total
		codigo  = documentos.object.tipodoc[indice]
		texto   = documentos.object.texto[indice]
		choose case codigo
			case "2" //Letra Pagare
				marca  = "S"
			case "3" //
				marca  = "S"
			case "15" //
				marca  = "S"
			case else
				marca  = "N"
		end choose
		uo_tipo_documento.dw_marca.InsertRow(indice)
		uo_tipo_documento.dw_marca.object.marca[indice]  = marca
		uo_tipo_documento.dw_marca.object.codigo[indice] = codigo
		uo_tipo_documento.dw_marca.object.texto[indice]  = texto
	NEXT
END IF

uo_tipo_documento.st_titulo1.text = "Tipo Doc."
uo_tipo_documento.st_titulo2.text = "Descripcion"

destroy documentos

f_activar_campo(uo_companyia.em_campo)


end event

on w_carga_lineas_seguros_nueva.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.pb_2=create pb_2
this.uo_companyia=create uo_companyia
this.st_6=create st_6
this.cb_borrar=create cb_borrar
this.st_1=create st_1
this.em_anyo=create em_anyo
this.st_2=create st_2
this.uo_mes=create uo_mes
this.uo_tipo_documento=create uo_tipo_documento
this.dw_detalle=create dw_detalle
this.st_3=create st_3
this.gb_1=create gb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.uo_companyia
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_anyo
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.uo_mes
this.Control[iCurrent+11]=this.uo_tipo_documento
this.Control[iCurrent+12]=this.dw_detalle
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.uo_1
end on

on w_carga_lineas_seguros_nueva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.pb_2)
destroy(this.uo_companyia)
destroy(this.st_6)
destroy(this.cb_borrar)
destroy(this.st_1)
destroy(this.em_anyo)
destroy(this.st_2)
destroy(this.uo_mes)
destroy(this.uo_tipo_documento)
destroy(this.dw_detalle)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.uo_1)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_carga_lineas_seguros_nueva
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_carga_lineas_seguros_nueva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_carga_lineas_seguros_nueva
integer x = 27
integer y = 4
integer width = 2427
end type

type pb_1 from upb_salir within w_carga_lineas_seguros_nueva
integer x = 2706
integer y = 8
integer width = 110
integer height = 104
integer taborder = 0
end type

type dw_listado_detalle from datawindow within w_carga_lineas_seguros_nueva
boolean visible = false
integer x = 96
integer width = 494
integer height = 92
boolean bringtotop = true
string dataobject = "report_carga_lineas_seguros_nuevo"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_carga_lineas_seguros_nueva
integer x = 2697
integer y = 212
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;f_cargar_datos(dw_listado_detalle)
f_imprimir_datawindow(dw_listado_detalle)
f_activar_campo(uo_companyia.em_campo)
end event

type uo_companyia from u_em_campo_2 within w_carga_lineas_seguros_nueva
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 297
integer y = 128
integer width = 1344
integer height = 80
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_companyia.em_campo.text=f_nombre_segcompanyia(codigo_empresa,uo_companyia.em_codigo.text)
If Trim(uo_companyia.em_campo.text)="" then
	uo_companyia.em_campo.text=""
	uo_companyia.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de compañias"
ue_datawindow ="dw_ayuda_segcompanyias"
ue_filtro = ""

end event

on uo_companyia.destroy
call u_em_campo_2::destroy
end on

type st_6 from statictext within w_carga_lineas_seguros_nueva
integer x = 18
integer y = 140
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Compañia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_borrar from u_boton within w_carga_lineas_seguros_nueva
event clicked pbm_bnclicked
integer x = 1303
integer y = 220
integer width = 338
integer height = 72
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;f_cargar_datos(dw_detalle)
end event

type st_1 from statictext within w_carga_lineas_seguros_nueva
integer x = 142
integer y = 228
integer width = 137
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_carga_lineas_seguros_nueva
integer x = 297
integer y = 216
integer height = 80
integer taborder = 20
end type

type st_2 from statictext within w_carga_lineas_seguros_nueva
integer x = 576
integer y = 228
integer width = 146
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Mes:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_mes from u_em_campo_2 within w_carga_lineas_seguros_nueva
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 731
integer y = 216
integer width = 530
integer height = 80
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mes.em_campo.text=f_nombre_mes(Dec(uo_mes.em_codigo.text))
If Trim(uo_mes.em_campo.text)="" then
	uo_mes.em_campo.text=""
	uo_mes.em_codigo.text=""
	Return
end if 

end event

on uo_mes.destroy
call u_em_campo_2::destroy
end on

type uo_tipo_documento from u_marca_lista within w_carga_lineas_seguros_nueva
boolean visible = false
integer x = 873
integer y = 312
integer taborder = 70
boolean border = false
end type

on uo_tipo_documento.destroy
call u_marca_lista::destroy
end on

type dw_detalle from datawindow within w_carga_lineas_seguros_nueva
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 9
integer y = 320
integer width = 2811
integer height = 1108
string dataobject = "dw_carga_lineas_seguros_nuevo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;String var_empresa,var_companyia
Dec    var_anyo,numero,pendientes
DateTime fecha1,fecha2

if f_objeto_datawindow(This) = "procesar" then
	
	fecha1 = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
	
	if dec(uo_mes.em_codigo.text) < 12 then
		fecha2 = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
	else
		fecha2 = DateTime(MDY(1,01,Dec(em_anyo.text)+1))
	end if
	
	fecha2 = DateTime(RelativeDate(Date(fecha2),-1))
	var_empresa   = codigo_empresa
   var_anyo      = Dec(em_anyo.text)  
   var_companyia = uo_companyia.em_codigo.text
	
//	// Comprobamos si hay facturas anteriores pendientes de notificar
//	
//	select count(*) 
//	into   :pendientes
//	from   seglinventas
//	where  empresa            = :codigo_empresa
//	and    anyo               = :var_anyo 
//	and    fecha_factura      < :fecha1
//	and    companyia          = :var_companyia
//	and    fecha_notificacion is null
//	and    declarado          = "S";
//	
//	if Isnull(pendientes) then pendientes = 0	
//	
//	if pendientes = 0 then// Si no hay permitimos notificar	
		select  count(*) 
		into :numero 
		from seglinventas
		where   empresa        = :codigo_empresa
		and     anyo           = :var_anyo 
		and     fecha_factura >= :fecha1
		and     fecha_factura <= :fecha2
		and     companyia      = :var_companyia
		and     fecha_notificacion is not null;
		
		if Isnull(numero) then numero = 0
		if numero = 0 then
			delete from seglinventas
			where   empresa        = :codigo_empresa
			and     anyo           = :var_anyo 
			and     fecha_factura >= :fecha1
			and     fecha_factura <= :fecha2
			and     companyia      = :var_companyia;
			
			if sqlca.sqlcode = 0 then
				if Not f_procesar() then
					f_mensaje("Error en proceso","La operacion no se contabliliza")
					Rollback;
				else
					Commit;
				end if
			else
				f_mensaje("Error borrando","La operacion no se contabliliza")
				Rollback;				
			end if
		else
			f_mensaje("No se puede procesar"," Mes notificado")
		end if
//	else// Si hay pendientes de notificar lo decimos y.
//		f_mensaje("No se puede procesar"," Existen facturas a meses anteriores sin notificar")
//	end if
end if
end event

type st_3 from statictext within w_carga_lineas_seguros_nueva
integer x = 1650
integer y = 124
integer width = 553
integer height = 176
integer taborder = 50
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Marcar documentos de cobro a declarar aunque esten cobrados"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;uo_tipo_documento.visible = not(uo_tipo_documento.visible)
end event

type gb_1 from groupbox within w_carga_lineas_seguros_nueva
integer y = 84
integer width = 2226
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type uo_1 from u_manejo_datawindow within w_carga_lineas_seguros_nueva
integer x = 2222
integer y = 164
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_companyia.em_campo)
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

