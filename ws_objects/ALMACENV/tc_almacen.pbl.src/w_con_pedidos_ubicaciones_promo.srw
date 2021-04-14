$PBExportHeader$w_con_pedidos_ubicaciones_promo.srw
forward
global type w_con_pedidos_ubicaciones_promo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_ubicaciones_promo
end type
type pb_2 from upb_imprimir within w_con_pedidos_ubicaciones_promo
end type
type st_2 from statictext within w_con_pedidos_ubicaciones_promo
end type
type em_pedido from u_em_campo within w_con_pedidos_ubicaciones_promo
end type
type dw_listado from datawindow within w_con_pedidos_ubicaciones_promo
end type
type sle_anyo from singlelineedit within w_con_pedidos_ubicaciones_promo
end type
type st_1 from statictext within w_con_pedidos_ubicaciones_promo
end type
type cb_3 from commandbutton within w_con_pedidos_ubicaciones_promo
end type
type dw_etiquetas from datawindow within w_con_pedidos_ubicaciones_promo
end type
type dw_detalle from datawindow within w_con_pedidos_ubicaciones_promo
end type
type dw_analisis from datawindow within w_con_pedidos_ubicaciones_promo
end type
end forward

global type w_con_pedidos_ubicaciones_promo from w_int_con_empresa
integer width = 5010
integer height = 3908
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_pedido em_pedido
dw_listado dw_listado
sle_anyo sle_anyo
st_1 st_1
cb_3 cb_3
dw_etiquetas dw_etiquetas
dw_detalle dw_detalle
dw_analisis dw_analisis
end type
global w_con_pedidos_ubicaciones_promo w_con_pedidos_ubicaciones_promo

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string consulta_pedidos, consulta_almacen, anyo, pedido, articulo, zona, alm_tono, alm_calidad, filtro_datawindow, almacen
datastore registros_pedidos
int i, pasillo, orden, fila, altura, alm_calibre
long alm_cantidad, cantidad_pedido

anyo = sle_anyo.text
pedido = em_pedido.text

dw_detalle.Reset()

if anyo <> '' then
	
				
	consulta_pedidos = " SELECT venliped.empresa, "+&  
      "  venliped.anyo,  "+&
      "  venliped.articulo,  "+& 
      "  venliped.calidad,   "+& 
      "  venliped.cantidad, "+& 
      "  venliped.tipo_pallet, "+&   
      "  venliped.pedido,   "+& 
      "  articulos.descripcion, "+&   
      "  calidades.abreviado,   "+& 
      "  pallets.resumido,  "+&  
      "  venliped.tonochar, "+& 
	   "  sum(isnull(venliped.cantidad_pzs,0)) as cantidad_pedido, "+& 
	   " (select sum(isnull(vista_almacen.cantidad,0)) from vista_almacen "+&
	  	" where vista_almacen.empresa = venliped.empresa and vista_almacen.articulo = venliped.articulo and vista_almacen.almacen in ('6','11') "+&
		" and vista_almacen.tipo_ubicacion = 1) as stock "+& 
    	"	FROM venliped "+& 
		"	LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo "+& 
		"	LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+& 
		"	LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo  "+& 
      "	,unidades  "+& 
   	"	WHERE ( venliped.tipo_unidad = unidades.codigo ) and  "+& 
      "  ( venliped.empresa = '"+codigo_empresa+"' ) AND  "+& 
    	"	( venliped.anyo = '"+anyo+"' ) AND "+& 
	 	"	( venliped.pedido = '"+pedido+"' )  AND "+& 
	 	"	( venliped.tipolinea = '4' )  AND "+& 
		"	articulos.promocion = 'N' "+& 
		"	GROUP BY venliped.articulo,  "+& 
      "   venliped.anyo,   "+& 
      "   venliped.empresa, "+& 
      "   venliped.calidad, "+&   
      "   venliped.tono,  "+&  
      "   venliped.calibre, "+&   
      "   venliped.cantidad, "+& 
      "   venliped.tipo_pallet, "+&   
      "   venliped.pedido,  "+&  
		" isnull (venliped.cantidad_pzs,0), "+& 
      "   articulos.descripcion,  "+&  
      "   calidades.abreviado,  "+&  
      "   pallets.resumido,  "+&  
      "   venliped.tonochar	"+& 
		" ORDER BY venliped.empresa ASC, "+&   
      "   venliped.anyo ASC  "	
		
	f_cargar_cursor_trans(SQLCA, consulta_pedidos, registros_pedidos)
	
	if registros_pedidos.rowcount() > 0 then
		
		for i = 1 to registros_pedidos.rowcount()
			
			articulo = registros_pedidos.object.venliped_articulo[i]
			
			cantidad_pedido = registros_pedidos.object.cantidad_pedido[i]
			
			zona = ""
			pasillo = 0
			orden = 0
			alm_cantidad = 0
			fila = 0
			altura = 0
			alm_tono = ""
			alm_calibre = 0
			almacen = ""
			alm_calidad = ""
			
			select top 1 vista_almacen.zona,almubizonas.pasillo,almubizonas.orden, vista_almacen.cantidad, 
			
			vista_almacen.fila, vista_almacen.altura, vista_almacen.tono, vista_almacen.calibre, vista_almacen.almacen, vista_almacen.calidad
			
			into :zona, :pasillo, :orden, :alm_cantidad, :fila, :altura, :alm_tono, :alm_calibre, :almacen, :alm_calidad
			
			from vista_almacen
			
			inner join almubizonas on vista_almacen.empresa = almubizonas.empresa  
			
			and vista_almacen.zona = almubizonas.zona and vista_almacen.almacen = almubizonas.almacen
			
			where  vista_almacen.empresa = :codigo_empresa
			
			and vista_almacen.almacen = '11'

			and vista_almacen.tipo_ubicacion = 1
			
			and vista_almacen.articulo = :articulo 
	
			and vista_almacen.cantidad >= :cantidad_pedido

			order by almubizonas.pasillo asc, vista_almacen.fila desc, vista_almacen.altura asc using SQLCA;
			
			dw_detalle.object.codigo_articulo [i] = registros_pedidos.object.venliped_articulo[i]
			
			dw_detalle.object.descripcion [i] = registros_pedidos.object.articulos_descripcion[i]
			
			dw_detalle.object.calidad[i] = registros_pedidos.object.venliped_calidad[i]
			
			dw_detalle.object.tipo_palet[i] = registros_pedidos.object.pallets_resumido[i]
			
			dw_detalle.object.pedido[i] = registros_pedidos.object.cantidad_pedido[i]
			
			dw_detalle.object.stock[i] = registros_pedidos.object.stock[i]
			
			
			
			dw_detalle.object.almacen[i] = almacen
			
			dw_detalle.object.pasillo[i] = pasillo
			
			dw_detalle.object.zona[i] = zona
			
			dw_detalle.object.fila[i] = fila
			
			dw_detalle.object.altura[i] = altura
			
			dw_detalle.object.alm_tono[i] = alm_tono
			
			dw_detalle.object.alm_calibre[i] = alm_calibre
			
			dw_detalle.object.alm_stock[i] = alm_cantidad
			
			dw_detalle.object.alm_calidad[i] = alm_calidad
			
			dw_detalle.object.numero_pedido[i] = registros_pedidos.object.venliped_pedido[i]
			
			dw_detalle.object.anyo_pedido[i] = registros_pedidos.object.venliped_anyo[i]

		next
		
		filtro_datawindow = "pasillo, fila desc , altura asc"
		
		dw_detalle.setsort(filtro_datawindow)
		
		dw_detalle.sort()
		
	end if
		
end if

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido por Referencia"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

dw_etiquetas.SetTransObject(SQLCA)

dw_analisis.SetTransObject(SQLCA)

//dw_analisis_stock2.SetTransObject(SQLCA)
end event

event ue_listar;
dw_report = dw_detalle
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa, integer(sle_anyo.text), integer(em_pedido.text) )
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar

end event

on w_con_pedidos_ubicaciones_promo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_pedido=create em_pedido
this.dw_listado=create dw_listado
this.sle_anyo=create sle_anyo
this.st_1=create st_1
this.cb_3=create cb_3
this.dw_etiquetas=create dw_etiquetas
this.dw_detalle=create dw_detalle
this.dw_analisis=create dw_analisis
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_pedido
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.sle_anyo
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.dw_etiquetas
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.dw_analisis
end on

on w_con_pedidos_ubicaciones_promo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_pedido)
destroy(this.dw_listado)
destroy(this.sle_anyo)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.dw_etiquetas)
destroy(this.dw_detalle)
destroy(this.dw_analisis)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_ubicaciones_promo
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_ubicaciones_promo
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_pedido)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_ubicaciones_promo
integer x = 14
integer y = 8
integer width = 4887
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_ubicaciones_promo
integer x = 4663
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_ubicaciones_promo
integer x = 4503
integer y = 120
integer taborder = 0
string picturename = "print!"
end type

event clicked;/*
str_parametros pa
DataWindow datawindow

if dw_analisis.visible = true then
	pa.s_listado = dw_analisis.DataObject
	datawindow = dw_analisis
else
	pa.s_listado = dw_report.DataObject
	datawindow = dw_report

end if
OpenWithParm(w_impresoras_v2,datawindow)
IF Message.DoubleParm = -1 THEN
 listado="N"
 RETURN
ELSE
 listado="S"
END IF

*/

DataWindow datawindow


if (dw_analisis.visible) then
	datawindow = dw_analisis
end if

if (dw_detalle.visible) then
	datawindow = dw_detalle
end if

f_imprimir_datawindow(datawindow)

end event

type st_2 from statictext within w_con_pedidos_ubicaciones_promo
integer x = 18
integer y = 136
integer width = 334
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pedido"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pedido from u_em_campo within w_con_pedidos_ubicaciones_promo
integer x = 759
integer y = 128
integer width = 425
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16773367
end type

event modificado;call super::modificado; 
 f_control()


end event

event rbuttondown;call super::rbuttondown;return 
end event

event tecla_enter;call super::tecla_enter;return 
end event

event tecla_tabulador;call super::tecla_tabulador;IF Len(This.text)=0  Then 
    return
END IF

end event

type dw_listado from datawindow within w_con_pedidos_ubicaciones_promo
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_pedidos_refcli"
boolean livescroll = true
end type

type sle_anyo from singlelineedit within w_con_pedidos_ubicaciones_promo
integer x = 402
integer y = 128
integer width = 265
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16773367
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_pedidos_ubicaciones_promo
integer x = 677
integer y = 128
integer width = 87
integer height = 84
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_con_pedidos_ubicaciones_promo
integer x = 1207
integer y = 112
integer width = 663
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir etiquetas pieza"
end type

event clicked;integer i, numero_etiquetas

long filas

string ls_comando, articulo, articulo_aux


filas = dw_detalle.RowCount()

if PrintSetup ( ) = 1 then
	
	if filas > 0 then
		
		articulo_aux = ""

		for i=1 to filas 
			
				articulo = dw_detalle.object.codigo_articulo[i]
					
				if articulo <> articulo_aux then
					
					dw_etiquetas.retrieve(codigo_empresa, articulo)
					
					articulo_aux = articulo
					
					numero_etiquetas = dw_detalle.object.pedido[i]
			
					ls_comando =" datawindow.print.copies = "+string(numero_etiquetas)
				
					dw_etiquetas.Modify(ls_comando)
			
					dw_etiquetas.Print(TRUE)
					
				end if
								
		next
		
	end if
end if
end event

type dw_etiquetas from datawindow within w_con_pedidos_ubicaciones_promo
boolean visible = false
integer x = 677
integer y = 684
integer width = 2821
integer height = 1700
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_promo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from datawindow within w_con_pedidos_ubicaciones_promo
integer x = 14
integer y = 244
integer width = 4933
integer height = 3484
string dataobject = "dw_con_pedidos_ubicaciones_promo_nueva"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

event clicked;
/*

string ordenar


choose case dwo.name
		
		
	case "articulo_t"
		
		ordenar = "descripcion"
		
	case "calidad_t"
		
		ordenar = "calidad"
		
	case "tipo_palet_t"
		
		ordenar = "tipo_palet"
		
	case "pedido_t"
		
		ordenar = "pedido"
		
	case "stock_t"
		
		ordenar = "stock"
		
	case "almacen_t"
		
		ordenar = "almacen"
		
	case "zona_t"
		
		ordenar = "zona"
		
	case "fila_t"
		
		ordenar = "fila"
		
	case "altura_t"
		
		ordenar = "altura"
		
	case "alm_calidad_t"
		
		ordenar = "alm_calidad"
		
	case "alm_tono_t"
		
		ordenar = "alm_tono"
		
	case "alm_calibre_t"
		
		ordenar = "alm_calibre"
		
	case "t_existencias"
		
		ordenar = "alm_stock"
				
end choose


this.setsort(ordenar)

this.sort()

*/



end event

type dw_analisis from datawindow within w_con_pedidos_ubicaciones_promo
boolean visible = false
integer y = 240
integer width = 4933
integer height = 3484
string title = "none"
string dataobject = "dw_analisis"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ordenar

choose case dwo.name
		
	case "articulo_t"
		
		ordenar = "descripcion asc"
		
	case "pedido_total_t"
		
		ordenar = "pedido_total desc"
		
	case "pedido_interno_t"
		
		ordenar = "pedido_interno desc"
		
	case "stock_total_t"
		
		ordenar = "stock_total desc"
		
	case "necesidad_t"
		
		ordenar = "necesidad desc"
		
	case "necesidad_inc_t"
		
		ordenar = "necesidad_inc desc"
					
end choose

dw_analisis.setsort(ordenar)	
dw_analisis.sort()
	

end event

