$PBExportHeader$w_con_resumen_vtas_albaranes.srw
forward
global type w_con_resumen_vtas_albaranes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_albaranes
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_albaranes
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_albaranes
end type
type st_9 from statictext within w_con_resumen_vtas_albaranes
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_albaranes
end type
type st_8 from statictext within w_con_resumen_vtas_albaranes
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_albaranes
end type
type cb_1 from commandbutton within w_con_resumen_vtas_albaranes
end type
type gb_5 from groupbox within w_con_resumen_vtas_albaranes
end type
type gb_1 from groupbox within w_con_resumen_vtas_albaranes
end type
type dw_1 from datawindow within w_con_resumen_vtas_albaranes
end type
type dw_listado from datawindow within w_con_resumen_vtas_albaranes
end type
type dw_detalle from datawindow within w_con_resumen_vtas_albaranes
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_albaranes
end type
type gb_4 from groupbox within w_con_resumen_vtas_albaranes
end type
end forward

global type w_con_resumen_vtas_albaranes from w_int_con_empresa
integer width = 2949
integer height = 1656
pb_1 pb_1
pb_2 pb_2
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
cb_1 cb_1
gb_5 gb_5
gb_1 gb_1
dw_1 dw_1
dw_listado dw_listado
dw_detalle dw_detalle
uo_serie uo_serie
gb_4 gb_4
end type
global w_con_resumen_vtas_albaranes w_con_resumen_vtas_albaranes

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control_detalle (datawindow data, string familia, string formato)
end prototypes

public subroutine f_control (datawindow data);STring Sel,xfamilia,xformato,familia,formato,articulo,tipo_unidad,sector,sel1,sel2,tipo_unidad_est
Dec  cantidad,pallets,total_cajas,cajas,peso_neto,mov,j,hh
Dec  metros,metrosl,unidades
Integer r,c
DataStore d
String serie1,serie2,caja

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if


data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)))
f_contador_procesos(0,100)





Sel1 = " SELECT empresa,articulo,familia,formato,caja," +&
      " Sum(pallets) pallets,Sum(total_cajas) total_cajas,"+&
		" Sum(cajas) cajas,Sum(cantidad) cantidad,Sum(peso_neto) peso_neto,count(*) mov" +&
      " FROM   venlifac " +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
      " And    venlifac.serie     between '"+serie1+"'  and '"+serie2+"' "+&
		" And    venlifac.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" GROUP By empresa,articulo,familia,formato,caja"+ &
		" Order By empresa,articulo,familia,formato,caja"
		
		
Sel2= " SELECT empresa,articulo,familia,formato,caja," +&
      " Sum(pallets) pallets,Sum(total_cajas) total_cajas,"+&
		" Sum(cajas) cajas,Sum(cantidad) cantidad,Sum(peso_neto) peso_neto, count(*) mov" +&
      " FROM   venlialb " +&
      " WHERE  venlialb.empresa = '"+codigo_empresa+"'" +&
      " And    venlialb.serie     between '"+serie1+"'  and '"+serie2+"' "+&
		" And    venlialb.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" And    venlialb.deposito = 'N' " +&		
		" GROUP By empresa,articulo,familia,formato,caja"+ &
		" Order By empresa,articulo,familia,formato,caja"

c = 0
FOR j = 1 To 2
	IF j = 1 Then	
//		d= f_cargar_cursor(sel1)
		f_Cargar_cursor_nuevo(sel1, d)
	end if
	IF j = 2 Then	
		//d= f_cargar_cursor(sel2)
		f_Cargar_cursor_nuevo(sel2, d)
	end if

	For r = 1 To d.RowCOunt()
		articulo = d.GetItemString(r,"articulo")
		IF f_sector_articulo(codigo_empresa,articulo)="S" then 
				peso_neto = d.GetItemNumber(r,"peso_neto")
				cantidad = d.GetItemNumber(r,"cantidad")
				cajas = d.GetItemNumber(r,"cajas")
				mov = d.GetItemNumber(r,"mov")
				total_cajas = d.GetItemNumber(r,"total_cajas")
				pallets = d.GetItemNumber(r,"pallets")
				formato = d.GetItemString(r,"formato")
				familia = d.GetItemString(r,"familia")
				caja    = d.GetItemString(r,"caja")
				tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
				tipo_unidad_est = f_unidad_articulo_est(codigo_empresa,articulo)
				xfamilia = f_nombre_familia(codigo_empresa,familia)
				xformato = f_nombre_formato_abr(codigo_empresa,formato)
				IF tipo_unidad = "0" Then
					sector = f_compras_articulo(codigo_empresa,articulo)
					if sector = "N" then
							metros = f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,total_cajas)
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
 					   unidades = f_calculo_unidades_cajas_est(codigo_empresa,articulo,caja,total_cajas) 
					  Else
						unidades = 0
					End if
				END IF
				c = data.find("familia = '"+familia+"' and formato = '"+formato+"'",1,data.RowCount())
				IF c = 0 Then
					c = data.RowCount()+1
					data.InsertRow(c)
				ELSE
					metros      =  metros      + data.GetItemNumber(c,"metros")
					metrosl     =  metrosl     + data.GetItemNumber(c,"metrosl")
					unidades    =  unidades    + data.GetItemNumber(c,"unidades")			
					peso_neto   =  peso_neto   + data.GetItemNumber(c,"peso_neto")
					cantidad    =  cantidad    + data.GetItemNumber(c,"cantidad")
					cajas       =  cajas       + data.GetItemNumber(c,"cajas")
					total_cajas =  total_cajas + data.GetItemNumber(c,"total_cajas")
					pallets     =  pallets     + data.GetItemNumber(c,"pallets")
					mov         =  mov  + data.GetItemNumber(c,"movimientos")
				END IF
				data.SetItem(c,"metros",metros)
				data.SetItem(c,"metrosl",metrosl)
				data.SetItem(c,"unidades",unidades)			
				data.SetItem(c,"peso_neto",peso_neto)
				data.SetItem(c,"cantidad",cantidad)
				data.SetItem(c,"cajas",cajas)
				data.SetItem(c,"total_cajas",total_cajas)
				data.SetItem(c,"pallets",pallets)
				data.SetItem(c,"formato",formato)
				data.SetItem(c,"familia",familia)
				data.SetItem(c,"articulo",articulo)
				data.SetItem(c,"tipo_unidad",tipo_unidad)	
				data.SetItem(c,"familias_descripcion",xfamilia)	
				data.SetItem(c,"formatos_abreviado",xformato)	
				data.SetItem(c,"movimientos",mov)	
		End if
		IF j = 1 Then
			f_mensaje_proceso("Leyendo facturas",r,d.RowCount() )
		ELSE
			f_mensaje_proceso("Leyendo albaranes",r,d.RowCount() )
		END IF
	Next
Next

data.SetSort("familias_descripcion,formatos_abreviado")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.VScrollBar = TRUE
f_contador_procesos(1,1)

destroy d
end subroutine

public subroutine f_control_detalle (datawindow data, string familia, string formato);String envio,var_clase,nombre_articulo
STring Sel,usu_cliente1,usu_cliente2,cliente,articulo,calidad,tipo_pallet,referencia,tipo_unidad,sector,tipo_unidad_est,caja

Dec  cantidad,pallets,total_cajas,cajas,tono,calibre,peso_neto,mov,albaran,vanyo,kilos
DateTime falbaran
Integer r,c
DataStore d

String serie1,serie2

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),familia,formato)
f_contador_procesos(0,100)

Sel = " SELECT empresa,falbaran,anyo_albaran,albaran,cliente,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia," +&
      " pallets,total_cajas,cajas,cantidad,envio,peso,clase" +&
   	" FROM   venlifac" +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
		" And    venlifac.serie     between '"+serie1+"'  and '"+serie2+"' "+&
		" and    venlifac.familia = '"+familia+"' " +&
		" and    venlifac.formato = '"+formato+"' " +&
      " And    venlifac.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "

//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
c = 0
For r = 1 To d.RowCOunt()
	c = c +1
	cliente  = d.GetItemstring(r,"cliente")
	articulo = d.GetItemString(r,"articulo")
	calidad  = d.GetItemString(r,"calidad")
	tono		= d.GetItemnumber(r,"tono")
	calibre  = d.GetItemnumber(r,"calibre")
	kilos    = d.GetItemnumber(r,"peso")
	var_clase= d.GetItemString(r,"clase")
	tipo_pallet  = d.GetItemString(r,"tipo_pallet")
	caja     = d.GetItemstring(r,"caja")
	referencia	 =	d.GetItemString(r,"referencia")
	cantidad = d.GetItemNumber(r,"cantidad")
	cajas = d.GetItemNumber(r,"cajas")
	total_cajas = d.GetItemNumber(r,"total_cajas")
	pallets = d.GetItemNumber(r,"pallets")
	articulo = d.GetItemString(r,"articulo")
	albaran = d.GetItemNumber(r,"albaran")
	vanyo = d.GetItemNumber(r,"anyo_albaran")
	falbaran = d.GetItemdatetime(r,"falbaran")
	tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
	tipo_unidad_est = f_unidad_articulo_est(codigo_empresa,articulo)
	data.InsertRow(c)
	data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
	data.SetItem(c,"articulo",f_nombre_articulo(codigo_empresa,articulo))
	data.SetItem(c,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	//data.SetItem(c,"caja",f_nombre_caja_abr(codigo_empresa,caja))	
	data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(c,"tono",tono)
	data.SetItem(c,"calibre",calibre)
	data.SetItem(c,"referencia",referencia)
	data.SetItem(c,"cajas",cajas)
	data.SetItem(c,"anyo",vanyo)
	data.SetItem(c,"albaran",albaran)
	data.SetItem(c,"kilos",kilos)
	data.SetItem(c,"falbaran",falbaran)
	data.SetItem(c,"total_cajas",total_cajas)
	data.SetItem(c,"pallets",pallets)
	data.SetItem(c,"envio",f_nombre_venenvio(codigo_empresa,cliente,d.GetItemString(r,"envio")))
		
	IF tipo_unidad = "0" Then		
		data.SetItem(c,"unidades",cantidad)
		sector = f_compras_articulo(codigo_empresa,articulo)
		if sector = "N" then
		      data.SetItem(c,"metros",f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,total_cajas))
		  ELSE
			   data.SetItem(c,"metros",0)			
		End if
	ELSE
		data.SetItem(c,"metros",cantidad)
		if tipo_unidad <> tipo_unidad_est then
			data.SetItem(c,"unidades", f_calculo_unidades_cajas_est(codigo_empresa,articulo,caja,total_cajas) )
		  Else
			data.SetItem(c,"unidades",0)
      End if
	END IF
		f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next
Sel = " SELECT empresa,anyo,albaran,falbaran,cliente,articulo,calidad,tono,calibre,tipo_pallet,caja,referencia," +&
      "  pallets,total_cajas,cajas, cantidad,envio,peso,clase" +&
   	" FROM   venlialb" +&
      " WHERE  venlialb.empresa = '"+codigo_empresa+"'" +&
		" And    venlialb.serie     between '"+serie1+"'  and '"+serie2+"' "+&
		" and    venlialb.familia = '"+familia+"' "+&
		" and    venlialb.formato = '"+formato+"' " +&
      " And    venlialb.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "

//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
For r = 1 To d.RowCOunt()
	c = c +1
	cliente  = d.GetItemstring(r,"cliente")
	articulo = d.GetItemString(r,"articulo")
	calidad  = d.GetItemString(r,"calidad")
	tono		= d.GetItemnumber(r,"tono")
	calibre  = d.GetItemnumber(r,"calibre")
	var_clase= d.GetItemString(r,"clase")
	tipo_pallet  = d.GetItemString(r,"tipo_pallet")
	caja     = d.GetItemString(r,"caja")
	referencia	 =	d.GetItemString(r,"referencia")
	albaran = d.GetItemNumber(r,"albaran")
	vanyo = d.GetItemNumber(r,"anyo")
	kilos    = d.GetItemnumber(r,"peso")
	falbaran = d.GetItemdatetime(r,"falbaran")
	cantidad = d.GetItemNumber(r,"cantidad")
	cajas = d.GetItemNumber(r,"cajas")
	total_cajas = d.GetItemNumber(r,"total_cajas")
	pallets = d.GetItemNumber(r,"pallets")
	articulo = d.GetItemString(r,"articulo")

	tipo_unidad = f_unidad_articulo(codigo_empresa,articulo)
	tipo_unidad_est = f_unidad_articulo_est(codigo_empresa,articulo)
	
	CHOOSE CASE var_clase
		CASE "M"
			nombre_articulo = trim(f_nombre_articulo(codigo_empresa,articulo))+" Muestras"
		case "S"
			nombre_articulo = trim(f_nombre_articulo(codigo_empresa,articulo))+" S/Cargo "
		case else
			nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
   END CHOOSE

	
	data.InsertRow(c)
	data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
	data.SetItem(c,"articulo",nombre_articulo)
	data.SetItem(c,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
	data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(c,"tono",tono)
	data.SetItem(c,"calibre",calibre)
	data.SetItem(c,"albaran",albaran)
	data.SetItem(c,"anyo",vanyo)
	data.SetItem(c,"falbaran",falbaran)
	data.SetItem(c,"referencia",referencia)
	data.SetItem(c,"kilos",kilos)
	data.SetItem(c,"cajas",cajas)
	data.SetItem(c,"total_cajas",total_cajas)
	data.SetItem(c,"pallets",pallets)
	data.SetItem(c,"envio",f_nombre_venenvio(codigo_empresa,cliente,d.GetItemString(r,"envio")))
	IF tipo_unidad = "0" Then
		data.SetItem(c,"unidades",cantidad)
		sector = f_compras_articulo(codigo_empresa,articulo)
		if sector = "N" then
		      data.SetItem(c,"metros",f_calculo_metros_desde_cajas(codigo_empresa,articulo,caja,total_cajas))
		  ELSE
			   data.SetItem(c,"metros",0)			
		End if
	ELSE
		data.SetItem(c,"metros",cantidad)
		if tipo_unidad <> tipo_unidad_est then
				data.SetItem(c,"unidades", f_calculo_unidades_cajas_est(codigo_empresa,articulo,caja,total_cajas) )
			  Else
				data.SetItem(c,"unidades",0)
      End if
	END IF
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next
data.SetSort("empresa,cliente,albaran,referencia,tipo_pallet")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
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

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen cargas entre fechas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)

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

f_mascara_columna(dw_1,"tpallets",f_mascara_decimales(0))
f_mascara_columna(dw_1,"tcajas",f_mascara_decimales(0))
f_mascara_columna(dw_1,"tunidades",f_mascara_decimales(0))
f_mascara_columna(dw_1,"tmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_1,"tmetros",f_mascara_decimales(2))
f_mascara_columna(dw_1,"tkilos",f_mascara_decimales(0))

f_mascara_columna(dw_1,"totalpallets",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalcajas",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalunidades",f_mascara_decimales(0))
f_mascara_columna(dw_1,"totalmetros_lineales",f_mascara_decimales(1))
f_mascara_columna(dw_1,"totalmetros",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totalkilos",f_mascara_decimales(0))


end event

on w_con_resumen_vtas_albaranes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_manejo=create uo_manejo
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_5=create gb_5
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.uo_serie=create uo_serie
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.gb_5
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.dw_detalle
this.Control[iCurrent+14]=this.uo_serie
this.Control[iCurrent+15]=this.gb_4
end on

on w_con_resumen_vtas_albaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_manejo)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.uo_serie)
destroy(this.gb_4)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_albaranes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_albaranes
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_albaranes
integer x = 18
integer y = 4
integer width = 2432
integer height = 104
end type

type pb_1 from upb_salir within w_con_resumen_vtas_albaranes
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_albaranes
integer x = 2706
integer y = 204
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_albaranes
integer x = 2235
integer y = 156
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_9 from statictext within w_con_resumen_vtas_albaranes
integer x = 32
integer y = 176
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_resumen_vtas_albaranes
integer x = 270
integer y = 176
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_resumen_vtas_albaranes
integer x = 599
integer y = 176
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_albaranes
integer x = 823
integer y = 176
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_resumen_vtas_albaranes
integer x = 1746
integer y = 156
integer width = 416
integer height = 108
integer taborder = 50
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

type gb_5 from groupbox within w_con_resumen_vtas_albaranes
integer x = 1728
integer y = 112
integer width = 453
integer height = 164
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_resumen_vtas_albaranes
integer x = 5
integer y = 128
integer width = 1175
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_con_resumen_vtas_albaranes
boolean visible = false
integer y = 288
integer width = 2871
integer height = 1124
integer taborder = 60
string dataobject = "dw_con_detalle_cargas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This)= "ob_salir" Then
		this.visible = False
END IF


end event

type dw_listado from datawindow within w_con_resumen_vtas_albaranes
integer x = 2569
integer y = 32
integer width = 46
integer height = 36
integer taborder = 70
string dataobject = "report_con_resumen_vtas_albaranes"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_resumen_vtas_albaranes
integer x = 9
integer y = 304
integer width = 2871
integer height = 964
string dataobject = "dw_con_resumen_vtas_albaranes1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;
if dw_detalle.Getrow()=0 then return
string var_familia,var_formato
var_familia = getitemstring(Getrow(),"familia")
var_formato = getitemstring(Getrow(),"formato")



dw_1.visible=true
f_control_detalle(dw_1,var_familia,var_formato)



end event

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_albaranes
event destroy ( )
integer x = 1225
integer y = 168
integer width = 453
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_resumen_vtas_albaranes
integer x = 1184
integer y = 112
integer width = 539
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

