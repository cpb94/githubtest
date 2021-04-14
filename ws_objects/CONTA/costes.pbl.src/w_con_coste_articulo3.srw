$PBExportHeader$w_con_coste_articulo3.srw
forward
global type w_con_coste_articulo3 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_coste_articulo3
end type
type st_1 from statictext within w_con_coste_articulo3
end type
type dw_1 from datawindow within w_con_coste_articulo3
end type
type dw_listado from datawindow within w_con_coste_articulo3
end type
type pb_imprimir from upb_imprimir within w_con_coste_articulo3
end type
type pb_2 from upb_carpeta within w_con_coste_articulo3
end type
type uo_1 from u_em_campo_2 within w_con_coste_articulo3
end type
type cb_1 from u_boton within w_con_coste_articulo3
end type
type cbx_estructural from checkbox within w_con_coste_articulo3
end type
type cb_2 from commandbutton within w_con_coste_articulo3
end type
type cb_3 from commandbutton within w_con_coste_articulo3
end type
type em_fdesde from u_em_campo within w_con_coste_articulo3
end type
type em_fhasta from u_em_campo within w_con_coste_articulo3
end type
type st_2 from statictext within w_con_coste_articulo3
end type
type st_3 from statictext within w_con_coste_articulo3
end type
type cbx_media from checkbox within w_con_coste_articulo3
end type
type st_4 from statictext within w_con_coste_articulo3
end type
type uo_2 from u_em_campo_2 within w_con_coste_articulo3
end type
end forward

global type w_con_coste_articulo3 from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 4878
integer height = 3152
pb_1 pb_1
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
pb_2 pb_2
uo_1 uo_1
cb_1 cb_1
cbx_estructural cbx_estructural
cb_2 cb_2
cb_3 cb_3
em_fdesde em_fdesde
em_fhasta em_fhasta
st_2 st_2
st_3 st_3
cbx_media cbx_media
st_4 st_4
uo_2 uo_2
end type
global w_con_coste_articulo3 w_con_coste_articulo3

type variables

end variables

on w_con_coste_articulo3.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.pb_2=create pb_2
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cbx_estructural=create cbx_estructural
this.cb_2=create cb_2
this.cb_3=create cb_3
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_2=create st_2
this.st_3=create st_3
this.cbx_media=create cbx_media
this.st_4=create st_4
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cbx_estructural
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.em_fdesde
this.Control[iCurrent+13]=this.em_fhasta
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.cbx_media
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.uo_2
end on

on w_con_coste_articulo3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cbx_estructural)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cbx_media)
destroy(this.st_4)
destroy(this.uo_2)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Consulta del Coste de un Articulo LOTES"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)


em_fdesde.text =  '01-01-01'
em_fhasta.text = string(today(), "dd-mm-yy")


if istr_parametros.i_nargumentos >= 1 then
	

	uo_1.em_codigo.text = istr_parametros.s_argumentos[1]
		
	uo_1.ue_valor_anterior = f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
	
	uo_1.ue_valor = uo_1.em_codigo.text
	
	if istr_parametros.i_nargumentos > 1 then
		
		if istr_parametros.s_argumentos[2] = "Planificacion" then
			
			cbx_media.checked = true
			
			
		elseif istr_parametros.s_argumentos[2] = "Partes" then 	
		
			uo_2.em_codigo.text = istr_parametros.s_argumentos[3]
			
			uo_2.ue_valor_anterior = istr_parametros.s_argumentos[3]
				
			uo_2.ue_valor= istr_parametros.s_argumentos[3]
			
			uo_2.triggerEvent("modificado")
			
		end if
		
		
	end if
	
	uo_1.triggerEvent("modificado")

	cb_1.event clicked()
		
end if
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;//string articulo

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el artículo")
//	f_activar_campo(uo_1.em_campo)
//	return
////	articulo = "%"
//else
//	articulo = uo_1.em_codigo.text
//end if
//dw_1.Retrieve(codigo_empresa,articulo)
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_coste_articulo3
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_coste_articulo3
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_coste_articulo3
integer x = 27
integer y = 24
integer width = 4645
integer height = 84
end type

type pb_1 from upb_salir within w_con_coste_articulo3
integer x = 4695
integer y = 12
integer width = 123
integer height = 112
integer taborder = 0
end type

type st_1 from statictext within w_con_coste_articulo3
integer x = 32
integer y = 140
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_coste_articulo3
integer x = 32
integer y = 244
integer width = 4809
integer height = 2680
boolean bringtotop = true
string dataobject = "dw_con_coste_articulo3"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_coste_articulo3
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_coste_articulo3
event clicked pbm_bnclicked
integer x = 4759
integer y = 128
integer taborder = 0
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type pb_2 from upb_carpeta within w_con_coste_articulo3
integer x = 2235
integer y = 128
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;  f_activar_campo(uo_1.em_campo)
  str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="w_con_articulos_tencer"
  lstr_param.s_argumentos[2]= uo_1.em_codigo.text
  OpenWithParm(wi_mant_formatos,lstr_param)

end event

type uo_1 from u_em_campo_2 within w_con_coste_articulo3
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 136
integer width = 1367
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_coste_articulo3
integer x = 4434
integer y = 128
integer width = 315
integer height = 96
integer taborder = 30
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;
decimal coste_fabricacion_teorico,coste_fabricacion_teorico_acumulado,coste_fabricacion_mermas,coste_fabricacion_real_acumulado,coste_packing,coste_compras,coste_mp
decimal coste_packing_acumulado,coste_compras_acumulado,coste_mp_acumulado, ancho, largo, coste_operacion, precio_venta, coste_mp_mermas, coste_fabricacion_mermas_acumulado, coste_mp_mermas_acumulado
decimal factor, piezas_m2, coste_estr, velocidad, correccion_velocidad
string articulo,lote,ver,operacion,unidad,requiere_stock, articulo_ant, tipo_operacion, formato, articulo_anterior
long actual
str_escandallo escandallo[300]
integer nivel,indice,k, contador_costes, piezascaja
datetime fecha_inicio, fecha_fin, fecha_primer_parte
decimal{6} metroscaja

nivel = 0

indice = 1
factor = 1

dw_1.setredraw(false)

dw_1.reset()

articulo = uo_1.em_codigo.text

lote = uo_2.em_codigo.text

fecha_inicio = datetime(em_fdesde.text)

fecha_fin = datetime(em_fhasta.text)

f_escandallo_factores(escandallo, articulo, indice, factor, nivel)

select unidad 
into :unidad
from articulos
where codigo = :articulo
and empresa = :codigo_empresa;

SELECT TOP 1 articulos.unidad, almartcajas.metroscaja, isnull(almartcajas.piezascaja , 0)
INTO :unidad, :metroscaja, :piezascaja 
FROM articulos 
LEFT JOIN almartcajas ON articulos.empresa = almartcajas.empresa AND articulos.codigo = almartcajas.articulo AND almartcajas.pordefecto = 'S' 
WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :articulo;

select art_ver_operaciones.tipo_operacion
into :tipo_operacion
from art_ver_operaciones 
where ( art_ver_operaciones.empresa = :codigo_empresa ) AND  
( art_ver_operaciones.articulo = :articulo ) AND  
( art_ver_operaciones.version = '1' );

select correccion_velocidad
into :correccion_velocidad
from art_ver_tipooperacion
where	empresa = :codigo_empresa
and codigo = :tipo_operacion ;

select formatos.abreviado
into :formato
from formatos, articulos
where formatos.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and articulos.formato = formatos.codigo
and articulos.codigo = :uo_1.em_codigo.text;


dw_1.object.t_articulo.text = string(uo_1.em_campo.text)+ "      (Cálculos realizados en "+lower(f_nombre_unidad(unidad))+")"
dw_1.object.t_formato.text = string(formato)

if isnull(lote) or lote = "" then

	select lote
	into :lote
	from articulos_coste_lote
	where empresa = :codigo_empresa
	and articulo = :articulo
	and operacion = :tipo_operacion
	and CAST(lote as float) = (select max(CAST(art.lote as float)) from articulos_coste_lote art where art.articulo = :articulo);
	
end if

k = indice - 1

do while k > 0
	
	articulo = escandallo[k].articulo
	
	coste_fabricacion_teorico = 0
			
	coste_fabricacion_teorico_acumulado = 0
			
	coste_fabricacion_mermas = 0
			
	coste_fabricacion_real_acumulado = 0
			
	coste_packing = 0
			
	coste_compras = 0
			
	coste_mp = 0
			
	coste_mp_mermas = 0
			
	coste_packing_acumulado = 0
			
	coste_compras_acumulado = 0
			
	coste_mp_acumulado = 0
	
	select art_ver_operaciones.tipo_operacion
	into :tipo_operacion
   from art_ver_operaciones 
   where ( art_ver_operaciones.empresa = :codigo_empresa ) AND  
   ( art_ver_operaciones.articulo = :articulo ) AND  
   ( art_ver_operaciones.version = '1' );
		
	if cbx_media.checked = false then 
		
		select articulo,lote,version,operacion,coste_fabricacion_teorico,coste_fabricacion_teorico_acumulado,coste_fabricacion_mermas,
		coste_fabricacion_mermas_acumulado,
		coste_fabricacion_real_acumulado,coste_packing,coste_compras,coste_mp,coste_packing_acumulado,coste_compras_acumulado,coste_mp_acumulado,
		coste_mp_mermas_acumulado, velocidad
		into :articulo,:lote,:ver,:operacion,:coste_fabricacion_teorico,:coste_fabricacion_teorico_acumulado,:coste_fabricacion_mermas,:coste_fabricacion_mermas_acumulado,
		:coste_fabricacion_real_acumulado,:coste_packing,:coste_compras,:coste_mp,:coste_packing_acumulado,:coste_compras_acumulado,:coste_mp_acumulado, 
		:coste_mp_mermas_acumulado, :velocidad
		from articulos_coste_lote
		where empresa = :codigo_empresa
		and articulo = :articulo
		and CAST(lote as float) = :lote;
					
	else
		
		select articulo,version,operacion,
		SUM(piezas_totales_lote * coste_fabricacion_teorico) / SUM(piezas_totales_lote) as coste_fabricacion_teorico,
		SUM(piezas_totales_lote * coste_fabricacion_teorico_acumulado) / SUM(piezas_totales_lote) as coste_fabricacion_teorico_acumulado,
		SUM(piezas_totales_lote * coste_fabricacion_mermas) / SUM(piezas_totales_lote) as coste_fabricacion_mermas,
		SUM(piezas_totales_lote * coste_fabricacion_mermas_acumulado) / SUM(piezas_totales_lote) as coste_fabricacion_mermas_acumulado,
		SUM(piezas_totales_lote * coste_fabricacion_real_acumulado) / SUM(piezas_totales_lote) as coste_fabricacion_real_acumulado,
		SUM(piezas_totales_lote * coste_packing) / SUM(piezas_totales_lote) as coste_packing,
		SUM(piezas_totales_lote * coste_compras) / SUM(piezas_totales_lote) as coste_compras,
		SUM(piezas_totales_lote * coste_mp) / SUM(piezas_totales_lote) as coste_mp,
		SUM(piezas_totales_lote * coste_packing_acumulado) / SUM(piezas_totales_lote) as coste_packing_acumulado,
		SUM(piezas_totales_lote * coste_compras_acumulado) / SUM(piezas_totales_lote) as coste_compras_acumulado,
		SUM(piezas_totales_lote * coste_mp_acumulado) / SUM(piezas_totales_lote) as coste_mp_acumulado,
		SUM(piezas_totales_lote * coste_mp_mermas) / SUM(piezas_totales_lote) as coste_mp_mermas,
		SUM(piezas_totales_lote * coste_mp_mermas_acumulado) / SUM(piezas_totales_lote) as coste_mp_mermas_acumulado,
		SUM(piezas_totales_lote * velocidad) / SUM(piezas_totales_lote) as velocidad
		into :articulo,:ver,:operacion,:coste_fabricacion_teorico,:coste_fabricacion_teorico_acumulado,:coste_fabricacion_mermas, :coste_fabricacion_mermas_acumulado,
		:coste_fabricacion_real_acumulado,:coste_packing,:coste_compras,:coste_mp,:coste_packing_acumulado,:coste_compras_acumulado,:coste_mp_acumulado, 
		:coste_mp_mermas,:coste_mp_mermas_acumulado,:velocidad
		from articulos_coste_lote
		where empresa = :codigo_empresa
		and articulo = :articulo
		and fecha_ultimo_parte >= :fecha_inicio
		and fecha_ultimo_parte <= :fecha_fin
		group by articulo,version,operacion;
		
		
	end if

	precio_venta = f_precio_minimo (codigo_empresa, articulo, '1')
	
	coste_fabricacion_teorico  = coste_fabricacion_teorico / escandallo[k].factor
	coste_mp = coste_mp / escandallo[k].factor
	coste_fabricacion_mermas  = coste_fabricacion_mermas / escandallo[k].factor
	coste_mp_mermas = coste_mp_mermas / escandallo[k].factor
	coste_compras = coste_compras / escandallo[k].factor
	
	
	
	if unidad = '1' then
			
		
			if piezascaja = 0 or metroscaja = 0 then
				piezas_m2 = 0
			else
				piezas_m2 = 1 / (metroscaja / piezascaja)   //Piezas que tiene un m2 
			end if

			coste_fabricacion_teorico = coste_fabricacion_teorico * piezas_m2
			
			coste_fabricacion_teorico_acumulado = coste_fabricacion_teorico_acumulado * piezas_m2
			
			coste_fabricacion_mermas = coste_fabricacion_mermas  * piezas_m2
			
			coste_fabricacion_real_acumulado = coste_fabricacion_real_acumulado  * piezas_m2
			
			coste_packing = coste_packing  * piezas_m2
			
			coste_compras = coste_compras  * piezas_m2
			
			coste_mp = coste_mp  * piezas_m2
			
			coste_mp_mermas = coste_mp_mermas * piezas_m2
			
			coste_packing_acumulado = coste_packing_acumulado  * piezas_m2
			
			coste_compras_acumulado = coste_compras_acumulado  * piezas_m2
			
			coste_mp_acumulado = coste_mp_acumulado * piezas_m2
			
			precio_venta = precio_venta
					
	end if
		
	select  art_ver_tipooperacion.coste
	into :coste_operacion
	from art_ver_tipooperacion
	where art_ver_tipooperacion.empresa = :codigo_empresa
	and art_ver_tipooperacion.codigo = :tipo_operacion;
		
	select descripcion_abr
	into :operacion
	from art_ver_tipooperacion
	where empresa = :codigo_empresa
	and codigo = :tipo_operacion;
						
	actual = dw_1.insertrow(0)
		
	dw_1.object.cod_articulo[actual] = articulo
	dw_1.object.des_articulo[actual] = f_nombre_articulo (codigo_empresa, articulo)
	dw_1.object.operacion[actual] = operacion
	dw_1.object.velocidad[actual] = round(velocidad , 0)
	dw_1.object.correccion[actual] = correccion_velocidad
	
	//dw_1.object.coste_operacion[actual] = coste_fabricacion_teorico
	dw_1.object.coste_operacion[actual] = coste_fabricacion_teorico_acumulado
	
	//dw_1.object.importe_mp[actual] = coste_mp 
	dw_1.object.importe_mp[actual] = coste_mp_acumulado
	
	//dw_1.object.coste_fab_mermas[actual] = coste_fabricacion_mermas 
	dw_1.object.coste_fab_mermas[actual] = coste_fabricacion_mermas_acumulado
	
	//dw_1.object.coste_mp_mermas[actual] = coste_mp_mermas
	dw_1.object.coste_mp_mermas[actual] = coste_mp_mermas_acumulado 
	
	dw_1.object.precio[actual] = precio_venta 
	
	//dw_1.object.coste_packing[actual] = coste_packing
	dw_1.object.coste_packing[actual] = coste_packing_acumulado
	
	//dw_1.object.coste_compras[actual] = coste_compras
	dw_1.object.coste_compras[actual] = coste_compras_acumulado
	
	dw_1.object.coste_hora[actual] = coste_operacion
	
	dw_1.object.orden[actual] = k
		
	dw_1.object.estructura[actual] = coste_estr
		
	k = k -1
	
	/*
		
	select isnull(requiere_stock,'N')
	into :requiere_stock
	from art_versiones
	where articulo = :articulo
	and version = '1'
	and empresa = :codigo_empresa;
	
	*/
	
	articulo_anterior = ''
		
	select articulo_ant
	into :articulo_anterior
	from art_escandallo
	where articulo = :articulo
	and empresa = :codigo_empresa 
	and articulo_ant <> '0' ;
	
	select case when count(*) = 0 then 'S' else 'N' end
	into :requiere_stock
	from prodpartes_ot
	where articulo = :articulo_anterior
	and isnull(lote,'0') = :lote
	and empresa = :codigo_empresa
	and prodpartes_ot.ajuste <> 'S';
	
	
	if requiere_stock = 'S' then
		
		select count(*)
		into :contador_costes
		from articulos_coste_lote_stock
		where empresa = :codigo_empresa
		and articulo = :articulo
		and version = '1'
		and operacion = :tipo_operacion;
		
		if contador_costes > 0 then
			
			select lote_stock
			into :lote
			from articulos_coste_lote_stock
			where articulo = :articulo 
			and lote = :lote 
			and version = :ver
			and empresa = :codigo_empresa
			and operacion = :tipo_operacion
			and cantidad_pzs = (select max(cantidad_pzs) 
											from articulos_coste_lote_stock 
											where empresa = :codigo_empresa 
											and articulo = :articulo 
											and lote = :lote
											and version = '1'
											and operacion = :tipo_operacion);
											
		else
											
			select min(fecha)
			into :fecha_primer_parte
			from prodpartes_ot
			where empresa = :codigo_empresa
			and articulo = :articulo
			and isnull(lote,0) = :lote
			and version = :ver
			and operacion = :tipo_operacion
			and prodpartes_ot.ajuste <> 'S';
				
			select top 1 (isnull(lote,''))
			into :lote
			from prodpartes_ot
			where articulo = :articulo_anterior
			and fecha <= :fecha_primer_parte
			and empresa = :codigo_empresa
			and prodpartes_ot.ajuste <> 'S'
			order by fecha desc;
			
						
		end if
		
		
	end if		
	
loop	

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if



dw_1.groupcalc()
dw_1.setredraw(true)



end event

type cbx_estructural from checkbox within w_con_coste_articulo3
integer x = 3369
integer y = 140
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Coste Estructural"
boolean lefttext = true
end type

type cb_2 from commandbutton within w_con_coste_articulo3
boolean visible = false
integer x = 1783
integer y = 128
integer width = 416
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coste Prueba"
end type

event clicked;dec coste_mp , coste_fab

f_calculo_coste_articulo_mp_fab (codigo_empresa, uo_1.em_codigo.text, coste_mp, coste_fab, true)

messagebox ("FIN",STRING ( coste_mp + coste_fab))
end event

type cb_3 from commandbutton within w_con_coste_articulo3
boolean visible = false
integer x = 1554
integer y = 1860
integer width = 1957
integer height = 604
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Récalculo del coste de las mermas de todos los artículos."
end type

event clicked;datastore regs
string sel, articulo
long i
boolean correcto

connect using SQLCA;

sel =	" select distinct articulo as articulo from prodpartes_ot "+&
		" where ot_terminada = 'S' "+&
		" and operacion = '9' "
		
f_cargar_cursor_nuevo (sel, regs )
correcto = true
for i = 1 to regs.rowcount()
	articulo = regs.object.articulo[i]
	f_calculo_coste_mermas (codigo_empresa, articulo, '1')
	
	if SQLCA.SQLCode <> 0 then
		correcto = false
	end if
	f_mensaje_proceso ("Reg: ", i, regs.rowcount())
next

if not correcto then
	f_mensaje("Atención","Hubo un error al cálcular el coste. ")
	rollback using SQLCA;
else
	commit using SQLCA;	
end if




end event

type em_fdesde from u_em_campo within w_con_coste_articulo3
integer x = 2551
integer y = 144
integer width = 288
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_coste_articulo3
integer x = 3067
integer y = 144
integer width = 288
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_coste_articulo3
integer x = 2345
integer y = 156
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_coste_articulo3
integer x = 2843
integer y = 160
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_media from checkbox within w_con_coste_articulo3
integer x = 3909
integer y = 140
integer width = 503
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Media Ponderada"
boolean lefttext = true
end type

type st_4 from statictext within w_con_coste_articulo3
integer x = 1687
integer y = 140
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Lote:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_2 from u_em_campo_2 within w_con_coste_articulo3
integer x = 1893
integer y = 136
integer width = 329
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_2.em_campo.text=uo_2.em_codigo.text


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Lotes"
ue_datawindow ="dw_ayuda_lotes"
ue_filtro = "articulo =  '"+uo_1.em_codigo.text+"' "


end event

on uo_2.destroy
call u_em_campo_2::destroy
end on

