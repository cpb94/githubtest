$PBExportHeader$w_con_descuadres_articulos.srw
$PBExportComments$Descuadres de almacén y el histórico de movimientos
forward
global type w_con_descuadres_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_descuadres_articulos
end type
type pb_2 from upb_imprimir within w_con_descuadres_articulos
end type
type cb_2 from u_boton within w_con_descuadres_articulos
end type
type dw_1 from datawindow within w_con_descuadres_articulos
end type
type uo_1 from u_manejo_datawindow within w_con_descuadres_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_descuadres_articulos
end type
type em_tono from u_em_campo within w_con_descuadres_articulos
end type
type gb_articulo from groupbox within w_con_descuadres_articulos
end type
type gb_lote from groupbox within w_con_descuadres_articulos
end type
end forward

global type w_con_descuadres_articulos from w_int_con_empresa
integer width = 3643
integer height = 2096
pb_1 pb_1
pb_2 pb_2
cb_2 cb_2
dw_1 dw_1
uo_1 uo_1
uo_articulo uo_articulo
em_tono em_tono
gb_articulo gb_articulo
gb_lote gb_lote
end type
global w_con_descuadres_articulos w_con_descuadres_articulos

type variables
String filtro

end variables

forward prototypes
public subroutine f_proceso (datawindow data)
end prototypes

public subroutine f_proceso (datawindow data);String ls_sel,ls_almacen,ls_zona,ls_articulo,ls_calidad,ls_tono,ls_tipo_pallet,ls_caja,ls_busqueda,ls_filtro_articulo,ls_filtro_lote
int    li_fila,li_altura,li_calibre
Dec    ld_existencias_segun_movimientos,ld_existencias_segun_bultos,ld_diferencia
long   ll_indice,ll_total,ll_donde,ll_donde_inserto 
DataStore ds_datos_movimientos,ds_datos_bultos

data.Reset()
data.setredraw(false)

data.Retrieve(codigo_empresa)		

if uo_articulo.em_codigo.text <> "" then
	ls_filtro_articulo = " and alm_bultos_lineas.articulo = '"+uo_articulo.em_codigo.text+"' "
else
	ls_filtro_articulo = ""	
end if

if em_tono.text <> "" then
	ls_filtro_lote = " and alm_bultos_lineas.tono = '"+em_tono.text+"' "
else
	ls_filtro_lote = ""	
end if

ls_sel= "SELECT isnull(almubimapa_codbar.almacen,'') as almacen, "+&
        "       isnull(almubimapa_codbar.zona,'') as zona, "+&
        "       isnull(almubimapa_codbar.fila,0) as fila, "+&
        "       isnull(almubimapa_codbar.altura,0) as altura, "+&   
        "       isnull(alm_bultos_lineas.articulo,'') as articulo, "+&
        "       isnull(alm_bultos_lineas.calidad,'') as calidad, "+&
        "       isnull(alm_bultos_lineas.tono,'') as tono, "+&
        "       isnull(alm_bultos_lineas.calibre,0) as calibre, "+&
        "       isnull(alm_bultos.tipo_pallet,'') as tipo_pallet, "+&
        "       isnull(alm_bultos_lineas.caja,'') as caja, "+&
        "       sum(isnull(cantidad,0)) as cantidad "+&
        "FROM   almubimapa_codbar, "+&
        "       alm_bultos, "+&
        "       alm_bultos_lineas "+&
        "WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) "+&
        "AND   ( almubimapa_codbar.id = alm_bultos.id_ubicacion ) "+&
        "AND   ( ( alm_bultos.empresa = '"+codigo_empresa+"' ) ) "+&
		  ls_filtro_articulo+&
		  ls_filtro_lote+&
        "GROUP BY almubimapa_codbar.almacen, "+&
        "         almubimapa_codbar.zona, "+&
        "         almubimapa_codbar.fila, "+&
        "         almubimapa_codbar.altura, "+&
        "         alm_bultos_lineas.articulo, "+&
        "         alm_bultos_lineas.calidad, "+&
        "         alm_bultos_lineas.tono, "+&
        "         alm_bultos_lineas.calibre, "+&
        "         alm_bultos.tipo_pallet, "+&
        "         alm_bultos_lineas.caja"

f_cargar_cursor_transaccion(sqlca,ds_datos_bultos,ls_sel)

if uo_articulo.em_codigo.text <> "" then
	ls_filtro_articulo = " and almacenmovimientos.articulo = '"+uo_articulo.em_codigo.text+"' "
else
	ls_filtro_articulo = ""	
end if

if em_tono.text <> "" then
	ls_filtro_lote = " and almacenmovimientos.tono = '"+em_tono.text+"' "
else
	ls_filtro_lote = ""	
end if

ls_sel= "SELECT isnull(almacenmovimientos.almacen,'') as almacen, "+&
		  "		 isnull(almacenmovimientos.zona,'') as zona, "+&
		  "		 isnull(almacenmovimientos.fila,0) as fila, "+&
		  "		 isnull(almacenmovimientos.altura,0) as altura, "+&
		  "		 isnull(almacenmovimientos.articulo,'') as articulo, "+&
		  "		 isnull(almacenmovimientos.calidad,'') as calidad, "+&
		  "		 isnull(almacenmovimientos.tono,'') as tono, "+&
		  "		 isnull(almacenmovimientos.calibre,0) as calibre, "+&
		  "		 isnull(almacenmovimientos.tipo_pallet,'') as tipo_pallet, "+&
		  "		 isnull(almacenmovimientos.caja,'') as caja, "+&
		  "		 sum(isnull(almacenmovimientos.cantidade,0) - isnull(almacenmovimientos.cantidads,0)) as existencias "+&
		  "FROM   almacenmovimientos "+&
		  "WHERE  almacenmovimientos.empresa = '"+codigo_empresa+"' "+&
		  ls_filtro_articulo+&
		  ls_filtro_lote+&		  
		  "GROUP BY almacenmovimientos.almacen, "+&
		  "		 almacenmovimientos.zona, "+&
		  "		 almacenmovimientos.fila, "+&
		  "		 almacenmovimientos.altura, "+&
		  "		 almacenmovimientos.articulo, "+&
		  "		 almacenmovimientos.calidad, "+&
		  "		 almacenmovimientos.tono, "+&
		  "		 almacenmovimientos.calibre, "+&
		  "		 almacenmovimientos.tipo_pallet, "+&
		  "		 almacenmovimientos.caja"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos_movimientos,ls_sel)

For ll_indice = 1 To ll_total
	f_mensaje_proceso("Movimientos",ll_indice,ll_total)
	
	ls_almacen     = ds_datos_movimientos.object.almacen[ll_indice]
	ls_zona        = ds_datos_movimientos.object.zona[ll_indice]
	li_fila        = ds_datos_movimientos.object.fila[ll_indice]
	li_altura      = ds_datos_movimientos.object.altura[ll_indice]	
	ls_articulo    = ds_datos_movimientos.object.articulo[ll_indice]
	ls_calidad     = ds_datos_movimientos.object.calidad[ll_indice]
	ls_tono        = ds_datos_movimientos.object.tono[ll_indice]
	li_calibre     = ds_datos_movimientos.object.calibre[ll_indice]
	ls_tipo_pallet = ds_datos_movimientos.object.tipo_pallet[ll_indice]
	ls_caja        = ds_datos_movimientos.object.caja[ll_indice]
	ld_existencias_segun_movimientos = ds_datos_movimientos.object.existencias[ll_indice]
	
	ls_busqueda = "almacen     = '"+ls_almacen+"' and "+&
					  "zona        = '"+ls_zona+"' and "+&
					  "fila        = "+string(li_fila,"##0")+" and "+&
					  "altura      = "+string(li_altura,"##0")+" and "+&
					  "articulo    = '"+ls_articulo+"' and "+&
					  "calidad     = '"+ls_calidad+"' and "+&
					  "tono        = '"+ls_tono+"' and "+&
					  "calibre     = "+string(li_calibre,"0")+" and "+&
					  "tipo_pallet = '"+ls_tipo_pallet+"' and "+&
					  "caja        = '"+ls_caja+"'"					  
	
	ll_donde = ds_datos_bultos.find(ls_busqueda,1,ds_datos_bultos.rowcount())
	
	if ll_donde > 0 then
		ld_existencias_segun_bultos = ds_datos_bultos.object.cantidad[ll_donde]
		ds_datos_bultos.deleterow(ll_donde)
	else
		ld_existencias_segun_bultos = 0
	end if
	
	ld_diferencia = ld_existencias_segun_movimientos - ld_existencias_segun_bultos
	
	if ld_diferencia <> 0 then
		ll_donde_inserto = data.insertrow(0)
		
		data.object.almacen[ll_donde_inserto]         = ls_almacen
		data.object.zona[ll_donde_inserto]            = ls_zona
		data.object.fila[ll_donde_inserto]            = li_fila
		data.object.altura[ll_donde_inserto]          = li_altura
		data.object.codigo_articulo[ll_donde_inserto] = ls_articulo
		data.object.articulo[ll_donde_inserto]        = f_nombre_articulo(codigo_empresa,ls_articulo)
		data.object.formato[ll_donde_inserto]         = f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,ls_articulo))
		data.object.calidad[ll_donde_inserto]         = ls_calidad
		data.object.tonochar[ll_donde_inserto]        = ls_tono
		data.object.calibre[ll_donde_inserto]         = li_calibre
		data.object.tipo_pallet[ll_donde_inserto]     = ls_tipo_pallet
		data.object.tipo_caja[ll_donde_inserto]       = ls_caja
		data.object.cantidad1[ll_donde_inserto]       = ld_existencias_segun_movimientos
		data.object.cantidad2[ll_donde_inserto]       = ld_existencias_segun_bultos
		data.object.diferencia[ll_donde_inserto]      = ld_diferencia
		
	end if
Next

destroy ds_datos_movimientos

ll_total = ds_datos_bultos.rowcount()

For ll_indice = 1 To ll_total
	f_mensaje_proceso("Bultos",ll_indice,ll_total)
	
	ls_almacen     = ds_datos_bultos.object.almacen[ll_indice]
	ls_zona        = ds_datos_bultos.object.zona[ll_indice]
	li_fila        = ds_datos_bultos.object.fila[ll_indice]
	li_altura      = ds_datos_bultos.object.altura[ll_indice]	
	ls_articulo    = ds_datos_bultos.object.articulo[ll_indice]
	ls_calidad     = ds_datos_bultos.object.calidad[ll_indice]
	ls_tono        = ds_datos_bultos.object.tono[ll_indice]
	li_calibre     = ds_datos_bultos.object.calibre[ll_indice]
	ls_tipo_pallet = ds_datos_bultos.object.tipo_pallet[ll_indice]
	ls_caja        = ds_datos_bultos.object.caja[ll_indice]
	ld_existencias_segun_movimientos = 0	
	ld_existencias_segun_bultos = ds_datos_bultos.object.cantidad[ll_indice]
	
	ld_diferencia = ld_existencias_segun_movimientos - ld_existencias_segun_bultos
	
	if ld_diferencia <> 0 then
		ll_donde_inserto = data.insertrow(0)
		
		data.object.almacen[ll_donde_inserto]         = ls_almacen
		data.object.zona[ll_donde_inserto]            = ls_zona
		data.object.fila[ll_donde_inserto]            = li_fila
		data.object.altura[ll_donde_inserto]          = li_altura
		data.object.codigo_articulo[ll_donde_inserto] = ls_articulo
		data.object.articulo[ll_donde_inserto]        = f_nombre_articulo(codigo_empresa,ls_articulo)
		data.object.formato[ll_donde_inserto]         = f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,ls_articulo))
		data.object.calidad[ll_donde_inserto]         = ls_calidad
		data.object.tonochar[ll_donde_inserto]        = ls_tono
		data.object.calibre[ll_donde_inserto]         = li_calibre
		data.object.tipo_pallet[ll_donde_inserto]     = ls_tipo_pallet
		data.object.tipo_caja[ll_donde_inserto]       = ls_caja
		data.object.cantidad1[ll_donde_inserto]       = ld_existencias_segun_movimientos
		data.object.cantidad2[ll_donde_inserto]       = ld_existencias_segun_bultos
		data.object.diferencia[ll_donde_inserto]      = ld_diferencia
		
	end if
Next

destroy ds_datos_bultos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
end event

on w_con_descuadres_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_2=create cb_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.uo_articulo=create uo_articulo
this.em_tono=create em_tono
this.gb_articulo=create gb_articulo
this.gb_lote=create gb_lote
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.em_tono
this.Control[iCurrent+8]=this.gb_articulo
this.Control[iCurrent+9]=this.gb_lote
end on

on w_con_descuadres_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.uo_articulo)
destroy(this.em_tono)
destroy(this.gb_articulo)
destroy(this.gb_lote)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_descuadres_articulos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_descuadres_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_descuadres_articulos
integer x = 5
end type

type pb_1 from upb_salir within w_con_descuadres_articulos
integer x = 3470
integer y = 8
integer height = 124
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_descuadres_articulos
integer x = 3497
integer y = 148
boolean originalsize = false
end type

event clicked;call super::clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = ""
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

u_imp.event ue_imprimir(dw_1)

destroy u_imp


end event

type cb_2 from u_boton within w_con_descuadres_articulos
integer x = 2496
integer y = 152
integer width = 526
integer height = 92
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_con_descuadres_articulos
event key pbm_dwnkey
integer y = 260
integer width = 3621
integer height = 1668
integer taborder = 20
string dataobject = "dw_con_descuadres_articulos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_1 from u_manejo_datawindow within w_con_descuadres_articulos
integer x = 3022
integer y = 104
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_articulo from u_em_campo_2 within w_con_descuadres_articulos
event destroy ( )
integer x = 23
integer y = 152
integer width = 1486
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;String var_tipo_unidad,var_descripcion,var_formato

select descripcion,unidad,formato
Into   :var_descripcion,:var_tipo_unidad,:var_formato
from   articulos
Where  articulos.empresa  =  :codigo_empresa
And    articulos.codigo   =  :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = var_descripcion
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
	 uo_articulo.em_campo.text=""
	 uo_articulo.em_codigo.text=""
	 uo_articulo.em_campo.SetFocus()
	 Return
 End if
END IF

end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end event

type em_tono from u_em_campo within w_con_descuadres_articulos
integer x = 1554
integer y = 152
integer width = 617
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "xxxxxxxxxxxxxxxxxxxx"
end type

type gb_articulo from groupbox within w_con_descuadres_articulos
integer y = 104
integer width = 1531
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo"
end type

type gb_lote from groupbox within w_con_descuadres_articulos
integer x = 1536
integer y = 104
integer width = 654
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lote"
end type

