$PBExportHeader$w_con_resumen_cargas_albaranes.srw
forward
global type w_con_resumen_cargas_albaranes from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_con_resumen_cargas_albaranes
end type
type em_fechadesde from u_em_campo within w_con_resumen_cargas_albaranes
end type
type em_fechahasta from u_em_campo within w_con_resumen_cargas_albaranes
end type
type gb_1 from groupbox within w_con_resumen_cargas_albaranes
end type
type cb_1 from commandbutton within w_con_resumen_cargas_albaranes
end type
type uo_cliente from u_em_campo_2 within w_con_resumen_cargas_albaranes
end type
type st_1 from statictext within w_con_resumen_cargas_albaranes
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_cargas_albaranes
end type
type gb_2 from groupbox within w_con_resumen_cargas_albaranes
end type
type dw_listado from datawindow within w_con_resumen_cargas_albaranes
end type
type pb_1 from upb_salir within w_con_resumen_cargas_albaranes
end type
type dw_detalle from datawindow within w_con_resumen_cargas_albaranes
end type
end forward

global type w_con_resumen_cargas_albaranes from w_int_con_empresa
integer width = 2953
integer height = 1652
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
uo_cliente uo_cliente
st_1 st_1
uo_manejo uo_manejo
gb_2 gb_2
dw_listado dw_listado
pb_1 pb_1
dw_detalle dw_detalle
end type
global w_con_resumen_cargas_albaranes w_con_resumen_cargas_albaranes

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);   
STring Sel,usu_cliente1,usu_cliente2,cliente,articulo,calidad,tipo_pallet,&
		familia,formato,referencia,tipo_unidad,sector,caja
datetime f1,f2
Dec  cantidad,pallets,total_cajas,cajas,tono,calibre,peso_neto,mov
Integer r,c
DataStore d
data.Reset()
data.SetRedraw(FALSE)
f_contador_procesos(0,100)
if uo_cliente.em_codigo.text="" or isnull(uo_cliente.em_codigo.text) then
	usu_cliente1=char(1)
	usu_cliente2=char(255)
else
	usu_cliente1=uo_cliente.em_codigo.text
	usu_cliente2=usu_cliente1
end if
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))

data.retrieve(codigo_empresa,f1,f2)

Sel = " SELECT empresa,cliente,familia,formato,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia," +&
      " Sum(pallets) pallets,Sum(total_cajas) total_cajas,count(*) mov,"+&
		" Sum(cajas) cajas,Sum(cantidad) cantidad,Sum(peso_neto) peso_neto" +&
   	" FROM   venlifac" +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
		" and    venlifac.cliente between '"+usu_cliente1+"' and '" +usu_cliente2+"' "+&
      " And    venlifac.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" GROUP By empresa,cliente,familia,formato,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia"+ &
		" Order By empresa,cliente,familia,formato,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia"
//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
c = 0
For r = 1 To d.RowCOunt()
	articulo = d.GetItemString(r,"articulo")
	
	IF f_sector_articulo(codigo_empresa,articulo)="S" then 
			c = c +1
			cliente  = d.GetItemstring(r,"cliente")
			familia  = d.GetItemString(r,"familia")
			formato  = d.GetItemString(r,"formato")			
			//articulo = d.GetItemString(r,"articulo")
			calidad  = d.GetItemString(r,"calidad")
			tono		= d.GetItemnumber(r,"tono")
			calibre  = d.GetItemnumber(r,"calibre")
			tipo_pallet  = d.GetItemString(r,"tipo_pallet")
			caja     = d.GetItemString(r,"caja")			
			referencia	 =	d.GetItemString(r,"referencia")
			peso_neto = d.GetItemNumber(r,"peso_neto")
			cantidad = d.GetItemNumber(r,"cantidad")
			cajas = d.GetItemNumber(r,"cajas")
			total_cajas = d.GetItemNumber(r,"total_cajas")
			pallets = d.GetItemNumber(r,"pallets")
			articulo = d.GetItemString(r,"articulo")
			mov=d.GetItemnumber(r,"mov")
			// ***
//			f_mensaje("articulo",f_nombre_articulo(codigo_empresa,articulo))
//			f_mensaje("cantidad",String(cantidad))
			tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
			data.InsertRow(c)
			data.SetItem(c,"tipo_unidad",tipo_unidad)	
			data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
			data.SetItem(c,"articulo",f_nombre_articulo(codigo_empresa,articulo))
			data.SetItem(c,"familia",f_nombre_familia(codigo_empresa,familia))			
			data.SetItem(c,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
			data.SetItem(c,"caja",f_nombre_caja_abr(codigo_empresa,caja))			
			data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
			data.SetItem(c,"tono",tono)
			data.SetItem(c,"calibre",calibre)
			data.SetItem(c,"referencia",referencia)
			data.SetItem(c,"peso",peso_neto)
			data.SetItem(c,"cajas",cajas)
			data.SetItem(c,"total_cajas",total_cajas)
			data.SetItem(c,"pallets",pallets)
			data.SetItem(c,"formato",f_nombre_formato(codigo_empresa,formato))
			IF tipo_unidad = "0" Then
				data.SetItem(c,"unidades",cantidad)
				sector = f_compras_articulo(codigo_empresa,articulo)
				if sector = "N" then
					data.SetItem(c,"metros",f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,total_cajas))
				else
					data.SetItem(c,"metros",0)
				End if
				data.SetItem(c,"metros_lineales",f_calculo_metros_lineales(codigo_empresa,articulo,cantidad))
			ELSE
				data.SetItem(c,"metros",cantidad)
				data.SetItem(c,"metros_lineales",0)
				data.SetItem(c,"unidades",0)
			END IF
			data.SetItem(c,"mov",mov)	
	End if
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next
Sel = " SELECT empresa,cliente,familia,formato,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia," +&
      " Sum(pallets) pallets,Sum(total_cajas) total_cajas,count(*) mov,"+&
		" Sum(cajas) cajas,Sum(cantidad) cantidad,Sum(peso_neto) peso_neto" +&
   	" FROM   venlialb" +&
      " WHERE  venlialb.empresa = '"+codigo_empresa+"'" +&
		" and    venlialb.cliente between '"+usu_cliente1+"' and '" +usu_cliente2+"' "+&
      " And    venlialb.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" And    venlialb.deposito = 'N' " +&
		" GROUP By empresa,cliente,familia,formato,articulo,calidad,tono,calibre,referencia,tipo_pallet,caja"+ &
		" Order By empresa,cliente,familia,formato,articulo,calidad,tono,calibre,referencia,tipo_pallet,caja"
		

//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
For r = 1 To d.RowCOunt()
	c = c +1
	cliente  = d.GetItemstring(r,"cliente")
	articulo = d.GetItemString(r,"articulo")
	familia  = d.GetItemString(r,"familia")
	formato  = d.GetItemString(r,"formato")	
	calidad  = d.GetItemString(r,"calidad")
	tono		= d.GetItemnumber(r,"tono")
	calibre  = d.GetItemnumber(r,"calibre")
	tipo_pallet  = d.GetItemString(r,"tipo_pallet")
	caja     = d.GetItemString(r,"caja")	
	referencia	 =	d.GetItemString(r,"referencia")
	peso_neto = d.GetItemNumber(r,"peso_neto")
	cantidad = d.GetItemNumber(r,"cantidad")
	cajas = d.GetItemNumber(r,"cajas")
	total_cajas = d.GetItemNumber(r,"total_cajas")
	pallets = d.GetItemNumber(r,"pallets")
	articulo = d.GetItemString(r,"articulo")
	mov=d.GetItemnumber(r,"mov")
	tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
	data.InsertRow(c)
	data.SetItem(c,"tipo_unidad",tipo_unidad)	
	data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
	data.SetItem(c,"articulo",f_nombre_articulo(codigo_empresa,articulo))
	data.SetItem(c,"familia",f_nombre_familia(codigo_empresa,familia))
	data.SetItem(c,"formato",f_nombre_formato(codigo_empresa,formato))	
	data.SetItem(c,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	data.SetItem(c,"caja",f_nombre_caja_abr(codigo_empresa,caja))	
	data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(c,"tono",tono)
	data.SetItem(c,"calibre",calibre)
	data.SetItem(c,"referencia",referencia)
	data.SetItem(c,"peso",peso_neto)
	data.SetItem(c,"cajas",cajas)
	data.SetItem(c,"total_cajas",total_cajas)
	data.SetItem(c,"pallets",pallets)
	IF tipo_unidad = "0" Then
		data.SetItem(c,"unidades",cantidad)
		sector = f_compras_articulo(codigo_empresa,articulo)
		if sector = "N" then
		   data.SetItem(c,"metros",f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,total_cajas))
      else
		   data.SetItem(c,"metros",0)
		End if
		data.SetItem(c,"metros_lineales",f_calculo_metros_lineales(codigo_empresa,articulo,cantidad))
	ELSE
		data.SetItem(c,"metros",cantidad)
		data.SetItem(c,"metros_lineales",0)
		data.SetItem(c,"unidades",0)
	END IF
	data.SetItem(c,"mov",mov)	

	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

//data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
f_contador_procesos(1,1)
//COMMIT;

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

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen cargas por clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

f_mascara_columna(dw_detalle,"tpallets",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tcajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tunidades",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_detalle,"tmetros",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"tkilos",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tkilosfam",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tkilosfor",f_mascara_decimales(0))

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
f_mascara_columna(dw_listado,"tkilosfam",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tkilosfor",f_mascara_decimales(0))

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

end event

on w_con_resumen_cargas_albaranes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.uo_manejo=create uo_manejo
this.gb_2=create gb_2
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.em_fechahasta
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.uo_manejo
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.dw_detalle
end on

on w_con_resumen_cargas_albaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.uo_manejo)
destroy(this.gb_2)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.dw_detalle)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_cargas_albaranes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_cargas_albaranes
integer y = 4
integer height = 40
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_cargas_albaranes
integer x = 5
integer y = 4
integer width = 2683
end type

type pb_2 from upb_imprimir within w_con_resumen_cargas_albaranes
integer x = 2715
integer y = 180
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;if dw_detalle.rowcount()<>0 then
	dw_listado.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
	integer bien
	bien=dw_detalle.RowsCopy(1,dw_detalle.RowCount(), Primary!, dw_listado, 1, Primary!)
	if bien=-1 or isnull(bien) then messagebox("Error al copiar lineas","Avise al administrador del sistema")
	f_imprimir_datawindow(dw_listado)
else
	f_control(dw_detalle)
	this.triggerevent(clicked!)
end if
//if trim(uo_cliente.em_campo.text)="" then
//	uo_cliente.em_codigo.text = ""
//	uo_cliente.em_campo.text = ""
//End if
//f_control(dw_listado)
//f_imprimir_datawindow(dw_listado)

end event

type em_fechadesde from u_em_campo within w_con_resumen_cargas_albaranes
integer x = 37
integer y = 176
integer width = 288
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_cargas_albaranes
integer x = 393
integer y = 176
integer width = 288
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_resumen_cargas_albaranes
integer y = 100
integer width = 699
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type cb_1 from commandbutton within w_con_resumen_cargas_albaranes
integer x = 1915
integer y = 176
integer width = 293
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_codigo.text = ""
	uo_cliente.em_campo.text = ""
End if
f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_resumen_cargas_albaranes
integer x = 731
integer y = 176
integer width = 1170
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type st_1 from statictext within w_con_resumen_cargas_albaranes
integer x = 334
integer y = 168
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_con_resumen_cargas_albaranes
integer x = 2235
integer y = 132
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_2 from groupbox within w_con_resumen_cargas_albaranes
integer x = 709
integer y = 100
integer width = 1518
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type dw_listado from datawindow within w_con_resumen_cargas_albaranes
boolean visible = false
integer y = 308
integer width = 265
integer height = 176
string dataobject = "report_con_resumen_cargas_albaranes"
boolean livescroll = true
end type

type pb_1 from upb_salir within w_con_resumen_cargas_albaranes
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type dw_detalle from datawindow within w_con_resumen_cargas_albaranes
integer y = 288
integer width = 2857
integer height = 1124
string dataobject = "dw_con_resumen_cargas_albaranes1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

