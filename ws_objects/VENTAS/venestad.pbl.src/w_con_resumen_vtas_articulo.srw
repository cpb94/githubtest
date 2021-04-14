$PBExportHeader$w_con_resumen_vtas_articulo.srw
forward
global type w_con_resumen_vtas_articulo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_resumen_vtas_articulo
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_articulo
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_articulo
end type
type cb_consulta from u_boton within w_con_resumen_vtas_articulo
end type
type uo_articulo from u_em_campo_2 within w_con_resumen_vtas_articulo
end type
type pb_imprimir_preli from picturebutton within w_con_resumen_vtas_articulo
end type
type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_articulo
end type
type em_tono from u_em_campo within w_con_resumen_vtas_articulo
end type
type em_calibre from u_em_campo within w_con_resumen_vtas_articulo
end type
type st_3 from statictext within w_con_resumen_vtas_articulo
end type
type st_6 from statictext within w_con_resumen_vtas_articulo
end type
type st_5 from statictext within w_con_resumen_vtas_articulo
end type
type st_4 from statictext within w_con_resumen_vtas_articulo
end type
type dw_1 from datawindow within w_con_resumen_vtas_articulo
end type
type dw_listado from datawindow within w_con_resumen_vtas_articulo
end type
type dw_2 from datawindow within w_con_resumen_vtas_articulo
end type
type st_fam from statictext within w_con_resumen_vtas_articulo
end type
type st_form from statictext within w_con_resumen_vtas_articulo
end type
type st_9 from statictext within w_con_resumen_vtas_articulo
end type
type st_10 from statictext within w_con_resumen_vtas_articulo
end type
type st_11 from statictext within w_con_resumen_vtas_articulo
end type
type uo_1 from u_manejo_datawindow within w_con_resumen_vtas_articulo
end type
type gb_2 from groupbox within w_con_resumen_vtas_articulo
end type
type gb_1 from groupbox within w_con_resumen_vtas_articulo
end type
end forward

global type w_con_resumen_vtas_articulo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 4020
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_consulta cb_consulta
uo_articulo uo_articulo
pb_imprimir_preli pb_imprimir_preli
uo_calidad uo_calidad
em_tono em_tono
em_calibre em_calibre
st_3 st_3
st_6 st_6
st_5 st_5
st_4 st_4
dw_1 dw_1
dw_listado dw_listado
dw_2 dw_2
st_fam st_fam
st_form st_form
st_9 st_9
st_10 st_10
st_11 st_11
uo_1 uo_1
gb_2 gb_2
gb_1 gb_1
end type
global w_con_resumen_vtas_articulo w_con_resumen_vtas_articulo

type variables
String ante_articulo,retrasos,sector="",arg_articulo

end variables

forward prototypes
public subroutine f_control_tono_calibre ()
public subroutine f_procesar (datawindow data)
public subroutine f_procesar2 (datawindow data, string cliente)
end prototypes

public subroutine f_control_tono_calibre (); em_tono.enabled    =  TRUE
 em_calibre.enabled =  TRUE
IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_tono.enabled    =  FALSE
  em_tono.text       =  "0"
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
  em_calibre.enabled =  FALSE
  em_calibre.text    =  "0"
END IF  
end subroutine

public subroutine f_procesar (datawindow data);String  tono1,tono2,articulo,calidad1,calidad2,cliente,nombre_cliente,sel
DataStore p
data.Reset()
data.SetRedraw(FALSE)
Dec{0}  calibre1,r1,r,cc
Dec cantidad,cant
Dec{0}  calibre2
String busalb="",busfra=""
f_mascara_columna(data,"cantidad",f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)))
f_mascara_columna(data,"total_cantidad",f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)))
sector = f_sector_articulo(codigo_empresa,uo_articulo.em_codigo.text)


IF sector="S" then
		IF Trim(uo_calidad.em_codigo.text) = "" Then
			calidad1 = "."
			calidad2 = "Z"
		ELSE
			calidad1 = uo_calidad.em_codigo.text
			calidad2 = uo_calidad.em_codigo.text
		END IF
		
		IF Trim(em_tono.text) = "" Then
			tono1 = "."
			tono2 = "Z"
		  ELSE
			tono1 = Trim(em_tono.text)
			tono2 = Trim(em_tono.text)
		END IF
		
		IF Trim(em_calibre.text) = "" Then
			calibre1 = -999
			calibre2 = 1000
		ELSE
			calibre1 = Dec(em_calibre.text)
			calibre2 = Dec(em_calibre.text)
		END IF
      busalb = "  AND   venlialb.calidad between '" + calidad1 + "' and '" + calidad2+"'"+& 
		         "  AND   venlialb.tonochar between '"+tono1 +"' and '"+ tono2 +"' "+&
 		         "  AND   venlialb.calibre between "+String(calibre1,"##") +" and "+ String(calibre2,"##") 

      busfra = "  AND   venlifac.calidad between '" + calidad1 + "' and '" + calidad2+"'"+& 
		         "  AND   venlifac.tonochar between '"+tono1+"' and '"+ tono2+"' " +&
 		         "  AND   venlifac.calibre between "+String(calibre1,"##") +" and "+ String(calibre2,"##") 
End if

data.reset()
Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))
r1 = data.Retrieve(codigo_empresa, arg_articulo)

sel = "SELECT venlialb.cliente,venlialb.cantidad"+&
      " FROM  venlialb " +&
      " WHERE venlialb.empresa   ='" +codigo_empresa+"'"+&
		"  AND  venlialb.falbaran >='" +String(fecha1,"dd/mm/yy")+"'"+&
		"  AND  venlialb.falbaran <='" +String(fecha2,"dd/mm/yy")+"'"+&
		"  AND  venlialb.articulo  = '" + uo_articulo.em_codigo.text+"'"+&
		busalb


//p = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, p)

r1 = p.RowCount()
IF r1<>0 then f_mensaje_proceso("Procesando Albaranes ",1,100)

For r = 1 To r1
	cantidad = p.GetItemNumber(r,"cantidad")
	cliente  = p.GetItemSTring(r,"cliente")
	cc = data.find("cliente = '"+cliente+"'",1,data.RowCOunt())
	IF  ISNUll(cc) or cc = 0 Then
		cc = data.RowCount()+1
		data.InsertRow(cc)
		cant = 0
	ELSE
		cant = data.GetItemDecimal(cc,"cantidad")
	END IF
	data.SetItem(cc,"cliente",cliente)
	data.SetItem(cc,"cantidad",cantidad+ cant)
	
	f_mensaje_proceso("Procesando Albaranes",r,r1)
Next


// Asignando facturas
sel = "SELECT venlifac.cliente,venlifac.cantidad "+&
      " FROM  venlifac " +&
      " WHERE venlifac.empresa   ='" +codigo_empresa+"'"+&
		" AND   venlifac.ffactura >='" +String(fecha1,"dd/mm/yy")+"'"+&
		" AND   venlifac.ffactura <='" +String(fecha2,"dd/mm/yy")+"'"+&
		" AND   venlifac.articulo  ='" + uo_articulo.em_codigo.text+"'"+&
		busfra

//p = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, p)
r1 = p.RowCount()
if r1<>0 then f_mensaje_proceso("Procesando Facturas ",1,100)

For r = 1 To r1
	cantidad = p.GetItemNumber(r,"cantidad")
	cliente  = p.GetItemSTring(r,"cliente")
	cc = data.find("cliente = '"+cliente+"'",1,data.RowCOunt())
	IF  ISNUll(cc) or cc = 0 Then
		cc = data.RowCount()+1
		data.InsertRow(cc)
		cant = 0
	ELSE
		cant = data.GetItemDecimal(cc,"cantidad")
	END IF
	data.SetItem(cc,"cliente",cliente)
	data.SetItem(cc,"cantidad",cantidad+ cant)
	
	f_mensaje_proceso("Procesando Facturas",r,r1)
Next



r1 = data.RowCount() 
For r = 1 To r1
	cliente        = data.GetItemSTring(r,"cliente")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	data.SetItem(r,"nombre",nombre_cliente)
	f_mensaje_proceso("Asignando Clientes",r,r1)
Next


data.SetSort("cantidad D")	
data.Sort()	
data.SetRedraw(TRUE)
destroy p
end subroutine

public subroutine f_procesar2 (datawindow data, string cliente);String  articulo,calidad1,calidad2,nombre_calidad,sel,calidad,nombre_cliente,tono
nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
DataStore p
data.Reset()
data.SetRedraw(FALSE)
String tono1,tono2
Dec{0}  calibre1,r1,r,cc,calibre,albaran
DateTime falbaran
Dec cantidad,cant,precio
Dec{0}  calibre2
String busalb="",busfra=""
f_mascara_columna(data,"cantidad",f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)))
f_mascara_columna(data,"total_cantidad",f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text)))

IF sector="S" then
			IF Trim(uo_calidad.em_codigo.text) = "" Then
				calidad1 = "."
				calidad2 = "Z"
			ELSE
				calidad1 = uo_calidad.em_codigo.text
				calidad2 = uo_calidad.em_codigo.text
			END IF
			IF Trim(em_tono.text) = "" Then
				tono1 = "."
				tono2 = "Z"
			ELSE
				tono1 = Trim(em_tono.text)
				tono2 = Trim(em_tono.text)
			END IF
			IF Trim(em_calibre.text) = "" Then
				calibre1 = -999
				calibre2 = 1000
			ELSE
				calibre1 = Dec(em_calibre.text)
				calibre2 = Dec(em_calibre.text)
			END IF
			Busalb =  "  AND   venlialb.calidad between '" + calidad1 + "' and '" + calidad2+"'"+& 
		             "  AND   venlialb.tonochar between '"+tono1 + "' and '"+ tono2+"' " +&
		             "  AND   venlialb.calibre between "+String(calibre1,"##") +" and "+ String(calibre2,"##") 

			Busfra =  "  AND   venlifac.calidad between '" + calidad1 + "' and '" + calidad2+"'"+& 
		             "  AND   venlifac.tonochar between '"+tono1 +"' and '"+ tono2+"' "+&
		             "  AND   venlifac.calibre between "+String(calibre1,"##") +" and "+ String(calibre2,"##") 

End if
data.reset()
Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))
data.Retrieve(codigo_empresa)
f_mensaje_proceso("Procesando Albaranes ",1,100)

sel = "SELECT calidad,tonochar,calibre,cantidad,albaran,falbaran,precio"+&
      " FROM  venlialb " +&
      " WHERE venlialb.empresa ='" +codigo_empresa+"'"+&
		"  AND   venlialb.cliente   = '"+cliente+"'"+&
		"  AND   venlialb.falbaran >='" +String(fecha1,"dd/mm/yy")+"'"+&
		"  AND   venlialb.falbaran <='" +String(fecha2,"dd/mm/yy")+"'"+&
		"  AND   venlialb.articulo  = '" + uo_articulo.em_codigo.text+"'"+&
		busalb
		
//p = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, p)
r1 = p.RowCount()
if r1=0 then f_mensaje_proceso("Procesando Albaranes ",100,100)
For r = 1 To r1
   cantidad = p.GetItemNumber(r,"cantidad")
	calidad  = p.GetItemSTring(r,"calidad")
	tono     = p.GetItemString(r,"tonochar")
	calibre  = p.GetItemNumber(r,"calibre")
	albaran  = p.GetItemNumber(r,"albaran")
	precio   = p.GetItemNumber(r,"precio")
	falbaran = p.GetItemDatetime(r,"falbaran")
	cc = data.RowCount()+1
	data.InsertRow(cc)
	cant = 0
	data.SetItem(cc,"calidad", f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(cc,"tono",tono)
	data.SetItem(cc,"calibre",calibre)
	data.SetItem(cc,"cantidad",cantidad)
	data.SetItem(cc,"docu","Alb-"+trim(string(albaran,'###,###')))
	data.SetItem(cc,"ffactura",falbaran)
	data.SetItem(cc,"precio",precio)
	data.SetItem(cc,"cliente",cliente)
	
	f_mensaje_proceso("Procesando Albaranes",r,r1)
Next


// Procesando facturas

f_mensaje_proceso("Procesando Facturas ",1,100)
sel = "SELECT calidad,tonochar,calibre,cantidad,factura,ffactura,precio"+&
      " FROM  venlifac " +&
      " WHERE venlifac.empresa ='" +codigo_empresa+"'"+&
		"  AND   venlifac.ffactura >='" +String(fecha1,"dd/mm/yy")+"'"+&
		"  AND   venlifac.ffactura <='" +String(fecha2,"dd/mm/yy")+"'"+&
		"  AND   venlifac.cliente   = '"+cliente+"'"+&
		"  AND   venlifac.articulo  = '" + uo_articulo.em_codigo.text+"'"+&
		busfra
		
//p = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, p)
r1 = p.RowCount()
if r1=0 then f_mensaje_proceso("Procesando Facturas ",100,100)
For r = 1 To r1
	cantidad = p.GetItemNumber(r,"cantidad")
	calidad  = p.GetItemSTring(r,"calidad")
	tono     = p.GetItemString(r,"tonochar")
	calibre  = p.GetItemNumber(r,"calibre")
	albaran  = p.GetItemNumber(r,"factura")
	precio   = p.GetItemNumber(r,"precio")
	falbaran = p.GetItemDatetime(r,"ffactura")
	cc = data.RowCount()+1
	data.InsertRow(cc)
	cant = 0
	data.SetItem(cc,"calidad", f_nombre_calidad_abr(codigo_empresa,calidad))
	data.SetItem(cc,"tono",tono)
	data.SetItem(cc,"calibre",calibre)
	data.SetItem(cc,"cantidad",cantidad)
	data.SetItem(cc,"docu","Fra-"+trim(string(albaran,'###,###')))
	data.SetItem(cc,"ffactura",falbaran)
	data.SetItem(cc,"precio",precio)
	data.SetItem(cc,"cliente",cliente)
	
	f_mensaje_proceso("Procesando Facturas",r,r1)
Next

data.SetSort("ffactura D")	
data.Sort()	
data.SetRedraw(TRUE)
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA VENTAS POR ARTICULO"
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca

f_activar_campo(uo_articulo.em_campo)


end event

on w_con_resumen_vtas_articulo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_consulta=create cb_consulta
this.uo_articulo=create uo_articulo
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_calidad=create uo_calidad
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_3=create st_3
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.dw_2=create dw_2
this.st_fam=create st_fam
this.st_form=create st_form
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.uo_1=create uo_1
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.em_fechahasta
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.uo_articulo
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.uo_calidad
this.Control[iCurrent+8]=this.em_tono
this.Control[iCurrent+9]=this.em_calibre
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.dw_listado
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.st_fam
this.Control[iCurrent+18]=this.st_form
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.st_10
this.Control[iCurrent+21]=this.st_11
this.Control[iCurrent+22]=this.uo_1
this.Control[iCurrent+23]=this.gb_2
this.Control[iCurrent+24]=this.gb_1
end on

on w_con_resumen_vtas_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_consulta)
destroy(this.uo_articulo)
destroy(this.pb_imprimir_preli)
destroy(this.uo_calidad)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.dw_2)
destroy(this.st_fam)
destroy(this.st_form)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.uo_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_articulo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_articulo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_articulo
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_resumen_vtas_articulo
integer x = 2734
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_resumen_vtas_articulo
integer x = 2304
integer y = 208
integer width = 274
integer height = 72
integer taborder = 60
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_articulo
integer x = 2583
integer y = 208
integer width = 274
integer height = 72
integer taborder = 70
boolean bringtotop = true
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_consulta from u_boton within w_con_resumen_vtas_articulo
integer x = 1783
integer y = 304
integer width = 457
integer height = 84
integer taborder = 80
string text = "&Consulta"
end type

event clicked;// compone texto del articulo

arg_articulo = Trim(uo_articulo.em_campo.text)
if Trim(uo_calidad.em_campo.text) <>"" then
	arg_articulo = arg_articulo +" ---- "+uo_calidad.em_campo.text
end if
if trim(em_tono.text)<>"" then
	arg_articulo = arg_articulo + "/"+em_tono.text
End if
if trim(em_calibre.text)<>"" then
	arg_articulo = arg_articulo + "/"+em_calibre.text
End if

dw_2.reset()
f_procesar(dw_1)
end event

type uo_articulo from u_em_campo_2 within w_con_resumen_vtas_articulo
integer x = 1147
integer y = 208
integer width = 763
integer height = 72
integer taborder = 20
boolean border = true
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
//f_mensaje("fam",f_nombre_familia(codigo_empresa,f_familia_articulo(codigo_empresa,uo_articulo.em_codigo.text)))
st_fam.text = f_nombre_familia(codigo_empresa,f_familia_articulo(codigo_empresa,uo_articulo.em_codigo.text))
st_form.text = f_nombre_formato_abr(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
String mascara
mascara = f_mascara_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))

f_mascara_columna(dw_1,"cantidads",mascara)
f_mascara_columna(dw_1,"cantidade",mascara)
f_mascara_columna(dw_1,"stock",mascara)
f_mascara_columna(dw_listado,"cantidads",mascara)
f_mascara_columna(dw_listado,"cantidade",mascara)
f_mascara_columna(dw_listado,"stock",mascara)
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_resumen_vtas_articulo
integer x = 2734
integer y = 300
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "PRINT!"
end type

event clicked;f_procesar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_articulo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1915
integer y = 208
integer width = 151
integer height = 72
integer taborder = 30
boolean border = true
end type

event modificado;call super::modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF

f_control_tono_calibre()
f_activar_campo(uo_calidad.em_campo)


end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type em_tono from u_em_campo within w_con_resumen_vtas_articulo
integer x = 2071
integer y = 208
integer width = 133
integer height = 72
integer taborder = 40
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##"
end type

type em_calibre from u_em_campo within w_con_resumen_vtas_articulo
integer x = 2208
integer y = 208
integer width = 91
integer height = 72
integer taborder = 50
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

type st_3 from statictext within w_con_resumen_vtas_articulo
integer x = 1147
integer y = 136
integer width = 768
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_resumen_vtas_articulo
integer x = 1915
integer y = 136
integer width = 155
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_resumen_vtas_articulo
integer x = 2071
integer y = 136
integer width = 137
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_resumen_vtas_articulo
integer x = 2208
integer y = 136
integer width = 91
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_resumen_vtas_articulo
integer x = 27
integer y = 412
integer width = 1435
integer height = 3416
string dataobject = "dw_con_resumen_vtas_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF GetRow() <> 0 Then 
	f_procesar2(dw_2,GetItemString(GetRow(),"cliente"))
End if	
end event

event clicked;IF GetRow() <> 0 Then 
	f_procesar2(dw_2,GetItemString(GetRow(),"cliente"))
End if	
end event

type dw_listado from datawindow within w_con_resumen_vtas_articulo
boolean visible = false
integer x = 5
integer width = 914
integer height = 88
boolean bringtotop = true
string dataobject = "report_con_resumen_vtas_articulos"
boolean livescroll = true
end type

type dw_2 from datawindow within w_con_resumen_vtas_articulo
integer x = 1458
integer y = 412
integer width = 1422
integer height = 3416
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_articulos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_fam from statictext within w_con_resumen_vtas_articulo
integer x = 23
integer y = 208
integer width = 576
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_form from statictext within w_con_resumen_vtas_articulo
integer x = 599
integer y = 208
integer width = 544
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_9 from statictext within w_con_resumen_vtas_articulo
integer x = 23
integer y = 136
integer width = 576
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Familia"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_10 from statictext within w_con_resumen_vtas_articulo
integer x = 599
integer y = 136
integer width = 544
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Formato"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_11 from statictext within w_con_resumen_vtas_articulo
integer x = 2299
integer y = 136
integer width = 558
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Entre"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_1 from u_manejo_datawindow within w_con_resumen_vtas_articulo
integer x = 2258
integer y = 256
integer width = 613
integer height = 148
boolean border = true
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type gb_2 from groupbox within w_con_resumen_vtas_articulo
integer x = 23
integer y = 264
integer width = 1737
integer height = 140
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_con_resumen_vtas_articulo
integer x = 1765
integer y = 264
integer width = 494
integer height = 140
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

