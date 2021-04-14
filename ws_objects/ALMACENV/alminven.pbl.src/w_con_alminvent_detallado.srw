$PBExportHeader$w_con_alminvent_detallado.srw
forward
global type w_con_alminvent_detallado from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_alminvent_detallado
end type
type pb_2 from upb_imprimir within w_con_alminvent_detallado
end type
type uo_manejo from u_manejo_datawindow within w_con_alminvent_detallado
end type
type cb_1 from commandbutton within w_con_alminvent_detallado
end type
type gb_5 from groupbox within w_con_alminvent_detallado
end type
type dw_listado from datawindow within w_con_alminvent_detallado
end type
type dw_detalle from datawindow within w_con_alminvent_detallado
end type
type dw_1 from datawindow within w_con_alminvent_detallado
end type
type st_6 from statictext within w_con_alminvent_detallado
end type
end forward

global type w_con_alminvent_detallado from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 3333
integer height = 2172
pb_1 pb_1
pb_2 pb_2
uo_manejo uo_manejo
cb_1 cb_1
gb_5 gb_5
dw_listado dw_listado
dw_detalle dw_detalle
dw_1 dw_1
st_6 st_6
end type
global w_con_alminvent_detallado w_con_alminvent_detallado

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);STring Sel,xfamilia,xformato,familia,formato,articulo,tipo_unidad,sector,tipo_unidad_est,tipo_pallet,cadena,calidad
Dec  cantidad,pallets,cajas,peso_neto,hh
Dec  metros,metrosl,unidades
Integer r,c
datetime fechainv
DataStore d
String serie1,serie2,caja
Long posi,posi_aux


data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa)
f_contador_procesos(0,100)


fechainv=dw_1.object.fecha_inv[dw_1.getrow()]


Sel = " SELECT empresa,articulo,familia,formato,caja," +&
      " Sum(palletst) pallets, "+&
		" Sum(cajast) cajas,Sum(existenciast) cantidad,tipo_pallett,calidad " +&
      " FROM   alminvent " +&
      " WHERE  alminvent.empresa = '"+codigo_empresa+"'" +&
      " And    alminvent.fecha_inv = convert(datetime,'"+string(fechainv,'mm-dd-yyyy')+"') "+&
		" GROUP By empresa,articulo,familia,formato,calidad,caja,tipo_pallett"+ &
		" Order By empresa,articulo,familia,formato,calidad,caja,tipo_pallett"
		
		
c = 0

//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)



For r = 1 To d.RowCOunt()
	articulo = d.GetItemString(r,"articulo")
	IF f_sector_articulo(codigo_empresa,articulo)="S" then 
			cantidad = d.GetItemNumber(r,"cantidad")

//			cajas = d.GetItemNumber(r,"cajas")
//			pallets = d.GetItemNumber(r,"pallets")
			formato = d.GetItemString(r,"formato")
			familia = d.GetItemString(r,"familia")
			calidad = d.GetItemString(r,"calidad")
			caja    = d.GetItemString(r,"caja")
			tipo_pallet=d.GetItemString(r,"tipo_pallett")
			cadena=f_calculo_unidades(codigo_empresa,articulo,tipo_pallet,caja,0,0,cantidad)
			posi_aux = 1
			posi = pos(cadena,"|",1)
			if posi <> 0 then
				pallets     = dec(Mid(cadena,1,posi - 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <> 0 then
				cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux + 1))
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				posi_aux = posi + 1
			end if
			
			posi = pos(cadena,"|",posi_aux)
			if posi <>0 then
				posi_aux = posi + 1
			end if



			tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
			tipo_unidad_est = f_unidad_articulo_est(codigo_empresa,articulo)
			xfamilia = f_nombre_familia(codigo_empresa,familia)
			xformato = f_nombre_formato_abr(codigo_empresa,formato)
			peso_neto = f_calculo_peso(codigo_empresa,articulo,tipo_pallet,cajas,cajas,pallets,cantidad,caja)			
			IF tipo_unidad = "0" Then
				sector = f_compras_articulo(codigo_empresa,articulo)
				if sector = "N" then
						metros = f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,cajas)
						unidades = cantidad
					 else
						metros   = 0
						unidades = cantidad
				End if
				metrosl= f_calculo_metros_lineales(codigo_empresa,articulo,cantidad)
			  ELSE
				metros = cantidad
				metrosl =0
				if tipo_unidad <> tipo_unidad_est then
					unidades = f_calculo_unidades_cajas_est(codigo_empresa,articulo,caja,cajas) 
				  Else
					unidades = 0
				End if
			END IF
			c = data.find("familia = '"+familia+"' and formato = '"+formato+"' and calidad = '"+f_nombre_calidad_abr(codigo_empresa,calidad)+"'",1,data.RowCount())
			IF c = 0 Then
				c = data.RowCount()+1
				data.InsertRow(c)
			ELSE
				metros      =  metros      + data.GetItemNumber(c,"metros")
				metrosl     =  metrosl     + data.GetItemNumber(c,"metrosl")
				unidades    =  unidades    + data.GetItemNumber(c,"unidades")			
				peso_neto   =  peso_neto   + data.GetItemNumber(c,"peso_neto")
				cantidad    =  cantidad    + data.GetItemNumber(c,"cantidad")
				cajas       =  cajas       + data.GetItemNumber(c,"total_cajas")
				pallets     =  pallets     + data.GetItemNumber(c,"pallets")
			END IF
			data.SetItem(c,"metros",metros)
			data.SetItem(c,"metrosl",metrosl)
			data.SetItem(c,"unidades",unidades)			
			data.SetItem(c,"peso_neto",peso_neto)
			data.SetItem(c,"cantidad",cantidad)
			data.SetItem(c,"total_cajas",cajas)
			data.SetItem(c,"pallets",pallets)
			data.SetItem(c,"formato",formato)
			data.SetItem(c,"familia",familia)
			data.SetItem(c,"articulo",articulo)
			data.SetItem(c,"tipo_unidad",tipo_unidad)	
			data.SetItem(c,"familias_descripcion",xfamilia)	
			data.SetItem(c,"formatos_abreviado",xformato)	
			data.setitem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	End if
	f_mensaje_proceso("Leyendo Inventario",r,d.RowCount() )
Next

data.SetSort("familias_descripcion,formatos_abreviado")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.VScrollBar = TRUE
f_contador_procesos(1,1)

destroy d
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Inventario"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_1.settransobject(sqlca)
dw_1.retrieve(codigo_empresa,year(today()))
dw_1.SetRowFocusIndicator(Hand!)

f_mascara_columna(dw_detalle,"tpallets",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tcajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tunidades",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_detalle,"tmetros",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"tkilos",f_mascara_decimales(0))

f_mascara_columna(dw_detalle,"totalpallets",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"totalcajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"totalunidades",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"totalmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_detalle,"totalmetros",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"totalkilos",f_mascara_decimales(0))


f_mascara_columna(dw_detalle,"t1pallets",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"t1cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"t1unidades",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"t1metros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_detalle,"t1metros",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"t1kilos",f_mascara_decimales(0))




f_mascara_columna(dw_listado,"tpallets",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tcajas",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tunidades",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_listado,"tmetros",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"tkilos",f_mascara_decimales(0))

f_mascara_columna(dw_listado,"totalpallets",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"totalcajas",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"totalunidades",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"totalmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_listado,"totalmetros",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"totalkilos",f_mascara_decimales(0))


f_mascara_columna(dw_listado,"t1pallets",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"t1cajas",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"t1unidades",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"t1metros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_listado,"t1metros",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"t1kilos",f_mascara_decimales(0))

// Pantalla detalle

end event

on w_con_alminvent_detallado.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_manejo=create uo_manejo
this.cb_1=create cb_1
this.gb_5=create gb_5
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.dw_1=create dw_1
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.st_6
end on

on w_con_alminvent_detallado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_manejo)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.dw_1)
destroy(this.st_6)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_alminvent_detallado
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_alminvent_detallado
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_alminvent_detallado
integer x = 18
integer y = 4
integer width = 2432
integer height = 104
end type

type pb_1 from upb_salir within w_con_alminvent_detallado
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_alminvent_detallado
integer x = 2697
integer y = 256
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type uo_manejo from u_manejo_datawindow within w_con_alminvent_detallado
integer x = 2592
integer y = 196
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type cb_1 from commandbutton within w_con_alminvent_detallado
integer x = 2117
integer y = 220
integer width = 416
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control(dw_detalle)
dw_Detalle.SetRedraw(true)

end event

type gb_5 from groupbox within w_con_alminvent_detallado
integer x = 2098
integer y = 176
integer width = 453
integer height = 164
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado from datawindow within w_con_alminvent_detallado
integer x = 2569
integer y = 32
integer width = 46
integer height = 36
integer taborder = 30
string dataobject = "report_con_alminvent_detallado"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_alminvent_detallado
integer y = 372
integer width = 3250
integer height = 1580
string dataobject = "dw_con_alminvent_detallado"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_con_alminvent_detallado
integer x = 672
integer y = 112
integer width = 777
integer height = 260
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_con_invent_dif1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on getfocus;This.BorderStyle=StyleLowered!
end on

on losefocus;This.BorderStyle=StyleRaised!
end on

type st_6 from statictext within w_con_alminvent_detallado
integer x = 64
integer y = 136
integer width = 3122
integer height = 300
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

