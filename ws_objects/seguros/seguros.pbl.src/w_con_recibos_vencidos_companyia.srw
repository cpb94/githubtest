$PBExportHeader$w_con_recibos_vencidos_companyia.srw
forward
global type w_con_recibos_vencidos_companyia from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_vencidos_companyia
end type
type uo_situacion from u_marca_lista within w_con_recibos_vencidos_companyia
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_companyia
end type
type dw_listado from datawindow within w_con_recibos_vencidos_companyia
end type
type uo_tipodoc from u_marca_lista within w_con_recibos_vencidos_companyia
end type
type em_fecha from u_em_campo within w_con_recibos_vencidos_companyia
end type
type gb_4 from groupbox within w_con_recibos_vencidos_companyia
end type
type gb_fecha from groupbox within w_con_recibos_vencidos_companyia
end type
type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_companyia
end type
type uo_companyia from u_em_campo_2 within w_con_recibos_vencidos_companyia
end type
type gb_cuenta from groupbox within w_con_recibos_vencidos_companyia
end type
type cb_2 from u_boton within w_con_recibos_vencidos_companyia
end type
type cb_1 from u_boton within w_con_recibos_vencidos_companyia
end type
type dw_1 from datawindow within w_con_recibos_vencidos_companyia
end type
type cb_3 from commandbutton within w_con_recibos_vencidos_companyia
end type
end forward

global type w_con_recibos_vencidos_companyia from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2971
integer height = 2164
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_situacion uo_situacion
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipodoc uo_tipodoc
em_fecha em_fecha
gb_4 gb_4
gb_fecha gb_fecha
uo_1 uo_1
uo_companyia uo_companyia
gb_cuenta gb_cuenta
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
cb_3 cb_3
end type
global w_con_recibos_vencidos_companyia w_con_recibos_vencidos_companyia

type variables
String det = "S"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);string   cliente,nombre_cliente,factura,moneda,situacion,tipodoc
datetime f_factura,f_vto,f_cobro,fecha
string   sel,companyia,filtro_tipodoc,filtro_situacion
long     indice,total,donde,recibo,factura_n,anyo_factura
dec      importe
datastore cartera

uo_tipodoc.visible = false
uo_situacion.visible = false

dw_data.setredraw(false)
moneda    = "1"
fecha     = Datetime(Date(String(em_fecha.Text)))
companyia = uo_companyia.em_codigo.text

total = uo_tipodoc.dw_marca.RowCount()
filtro_tipodoc = ""
for indice = 1 To total
	if uo_tipodoc.dw_marca.object.marca[indice] = "S" then
		if filtro_tipodoc = "" then
			filtro_tipodoc = "'"+uo_tipodoc.dw_marca.object.codigo[indice]+"'"
		else
			filtro_tipodoc = filtro_tipodoc+",'"+uo_tipodoc.dw_marca.object.codigo[indice]+"'"
		end if
	end if
next

total = uo_situacion.dw_marca.RowCount()
filtro_situacion = ""
for indice = 1 To total
	if uo_situacion.dw_marca.object.marca[indice] = "S" then
		situacion = uo_situacion.dw_marca.object.codigo[indice]
		if isnull(situacion) then situacion = ""
		if filtro_situacion = "" then
			filtro_situacion = "'"+situacion+"'"
		else
			filtro_situacion = filtro_situacion+",'"+situacion+"'"
		end if
	end if
next

if filtro_tipodoc <> "" and filtro_situacion <> "" and companyia <> "" then
	filtro_tipodoc   = "and tipodoc in("+filtro_tipodoc+") "
	filtro_situacion = "and situacion in("+filtro_situacion+") "
	
	sel = "Select cliente,ffra,fvto,factura,anyofra,recibo,tipodoc,"+&
			"importe,divisas,monedas,situacion,tipodoc,fcobro "+&
			"From   carefectos "+&
			"Where  empresa = '"+codigo_empresa+"' "+&
			"And    fvto < '"+ STring(Date(fecha),"mm/dd/yyyy")+"' "+&
			"And    cliente in ("+&
			"select cliente from venriesgoclientes "+&
			"Where  empresa   = '"+codigo_empresa+"' "+&
			"and    companyia = '"+companyia+"' "+&
			"and    concedido = 'S' "+&
			"and    riesgo_concedido > 0 ) "+&
			"and    importe > 0 "+&
			filtro_tipodoc+&
			filtro_situacion	
	
	dw_data.retrieve(codigo_empresa,companyia,fecha)		
	
//	cartera = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, cartera)
	
	total = cartera.rowcount()
	
	for indice = 1 to total
		f_mensaje_proceso("Procesando:",indice,total)
		
		cliente        = cartera.object.cliente[indice]
		nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
		f_factura      = cartera.object.ffra[indice]
		f_vto          = cartera.object.fvto[indice]
		f_cobro        = cartera.object.fcobro[indice]
		factura        = cartera.object.factura[indice]
		if isnumber(factura) then
			factura_n      = dec(cartera.object.factura[indice])
		else
			factura_n      = 0
		end if
		anyo_factura   = cartera.object.anyofra[indice]
		factura        = factura+" / "+string(anyo_factura,"#,###")
		recibo         = cartera.object.recibo[indice]
		tipodoc        = cartera.object.tipodoc[indice]
		importe        = cartera.object.importe[indice]
		situacion      = cartera.object.situacion[indice]
		
		donde = dw_data.insertrow(0)
		
		dw_data.object.empresa[donde]        = codigo_empresa 
		dw_data.object.cliente[donde]        = cliente
		dw_data.object.nombre_cliente[donde] = nombre_cliente
		dw_data.object.f_factura[donde]      = f_factura
		dw_data.object.f_vto[donde]          = f_vto
		dw_data.object.f_cobro[donde]        = f_cobro
		dw_data.object.factura_n[donde]      = factura_n
		dw_data.object.factura[donde]        = factura
		dw_data.object.recibo[donde]         = recibo
		dw_data.object.tipodoc[donde]        = tipodoc
		dw_data.object.importe[donde]        = importe
		dw_data.object.situacion[donde]      = situacion
		dw_data.object.moneda[donde]         = moneda
	next
			
	destroy cartera		
	
	dw_data.sort()
	dw_data.groupcalc()
	dw_data.setredraw(true)
end if
end subroutine

event open;call super::open;long indice,total

This.title = " Consulta recibos vencidos por Compañia"

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fecha.text = String(Today())

uo_tipodoc.f_cargar_datos("dw_ayuda_cartipodoc","","","Codigo","Tipo de Documento")
uo_situacion.f_cargar_datos("dw_ayuda_carsituacion","","","Codigo","Situación")

total = uo_tipodoc.dw_marca.RowCount()

for indice = 1 To total
	//if uo_tipodoc.dw_marca.object.codigo[indice] <> "" and
	uo_tipodoc.dw_marca.object.marca[indice] = "S"
next

total = uo_situacion.dw_marca.RowCount()

for indice = 1 To total
	if uo_situacion.dw_marca.object.codigo[indice] = "3" or uo_situacion.dw_marca.object.codigo[indice] = "9" then
		uo_situacion.dw_marca.deleterow(indice)
		total = uo_situacion.dw_marca.RowCount()
	end if
	uo_situacion.dw_marca.object.marca[indice] = "S"
next

f_activar_campo(em_fecha)


end event

on w_con_recibos_vencidos_companyia.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_situacion=create uo_situacion
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipodoc=create uo_tipodoc
this.em_fecha=create em_fecha
this.gb_4=create gb_4
this.gb_fecha=create gb_fecha
this.uo_1=create uo_1
this.uo_companyia=create uo_companyia
this.gb_cuenta=create gb_cuenta
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_situacion
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_tipodoc
this.Control[iCurrent+6]=this.em_fecha
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_fecha
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.uo_companyia
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.cb_3
end on

on w_con_recibos_vencidos_companyia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_situacion)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipodoc)
destroy(this.em_fecha)
destroy(this.gb_4)
destroy(this.gb_fecha)
destroy(this.uo_1)
destroy(this.uo_companyia)
destroy(this.gb_cuenta)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_3)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_vencidos_companyia
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_vencidos_companyia
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_vencidos_companyia
integer x = 14
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_con_recibos_vencidos_companyia
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_situacion from u_marca_lista within w_con_recibos_vencidos_companyia
boolean visible = false
integer x = 571
integer y = 284
integer width = 1449
boolean border = false
end type

on uo_situacion.destroy
call u_marca_lista::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_companyia
integer x = 2729
integer y = 156
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
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_companyia.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_vencidos_companyia
boolean visible = false
integer x = 274
integer y = 76
integer width = 539
integer height = 92
string dataobject = "report_con_recibos_vencidos_companyia"
boolean livescroll = true
end type

type uo_tipodoc from u_marca_lista within w_con_recibos_vencidos_companyia
boolean visible = false
integer x = 261
integer y = 284
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipodoc.destroy
call u_marca_lista::destroy
end on

type em_fecha from u_em_campo within w_con_recibos_vencidos_companyia
integer x = 37
integer y = 168
integer width = 283
integer height = 80
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_4 from groupbox within w_con_recibos_vencidos_companyia
integer x = 1970
integer y = 112
integer width = 297
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_fecha from groupbox within w_con_recibos_vencidos_companyia
integer y = 112
integer width = 352
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha"
end type

type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_companyia
integer x = 2254
integer y = 108
end type

event valores;call super::valores;dw_data = dw_1

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_companyia from u_em_campo_2 within w_con_recibos_vencidos_companyia
event destroy ( )
integer x = 370
integer y = 164
integer width = 992
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_companyia.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_segcompanyia(codigo_empresa,this.em_codigo.text)
If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de compañias"
ue_datawindow ="dw_ayuda_segcompanyias"
ue_filtro = ""

end event

type gb_cuenta from groupbox within w_con_recibos_vencidos_companyia
integer x = 352
integer y = 112
integer width = 1033
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Compañia"
end type

type cb_2 from u_boton within w_con_recibos_vencidos_companyia
integer x = 1394
integer y = 156
integer width = 274
integer height = 104
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Tipo Doc."
end type

event clicked;uo_tipodoc.visible = not(uo_tipodoc.visible)
uo_situacion.visible = false
end event

type cb_1 from u_boton within w_con_recibos_vencidos_companyia
integer x = 1673
integer y = 156
integer width = 293
integer height = 104
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Situación"
end type

event clicked;uo_situacion.visible = not(uo_situacion.visible)
uo_tipodoc.visible = false
end event

type dw_1 from datawindow within w_con_recibos_vencidos_companyia
integer y = 284
integer width = 2871
integer height = 1616
string dataobject = "dw_con_recibos_vencidos_companyia"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

type cb_3 from commandbutton within w_con_recibos_vencidos_companyia
integer x = 1984
integer y = 152
integer width = 270
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_cargar(dw_1)
f_activar_campo(uo_companyia.em_campo)
end event

