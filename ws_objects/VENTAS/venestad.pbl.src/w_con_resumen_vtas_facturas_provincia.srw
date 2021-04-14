$PBExportHeader$w_con_resumen_vtas_facturas_provincia.srw
forward
global type w_con_resumen_vtas_facturas_provincia from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_facturas_provincia
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_provincia
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_provincia
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_provincia
end type
type dw_listado from datawindow within w_con_resumen_vtas_facturas_provincia
end type
type cb_1 from commandbutton within w_con_resumen_vtas_facturas_provincia
end type
type gb_1 from groupbox within w_con_resumen_vtas_facturas_provincia
end type
type st_1 from statictext within w_con_resumen_vtas_facturas_provincia
end type
type gb_3 from groupbox within w_con_resumen_vtas_facturas_provincia
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_facturas_provincia
end type
type dw_listado_clientes from datawindow within w_con_resumen_vtas_facturas_provincia
end type
type dw_detalle_cliente from datawindow within w_con_resumen_vtas_facturas_provincia
end type
type dw_detalle from datawindow within w_con_resumen_vtas_facturas_provincia
end type
type uo_pais from u_em_campo_2 within w_con_resumen_vtas_facturas_provincia
end type
type gb_2 from groupbox within w_con_resumen_vtas_facturas_provincia
end type
end forward

global type w_con_resumen_vtas_facturas_provincia from w_int_con_empresa
integer width = 2935
integer height = 1656
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_1 gb_1
st_1 st_1
gb_3 gb_3
uo_manejo uo_manejo
dw_listado_clientes dw_listado_clientes
dw_detalle_cliente dw_detalle_cliente
dw_detalle dw_detalle
uo_pais uo_pais
gb_2 gb_2
end type
global w_con_resumen_vtas_facturas_provincia w_con_resumen_vtas_facturas_provincia

type variables
string filtro,grafico = "N"
end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control_detalle (datawindow data, string provincia)
end prototypes

public subroutine f_control (datawindow data);STring Sel,provincia1,provincia2,provincia,nombre_provincia,moneda,nombre_moneda,serie1,serie2,pais,sel2
Dec  cantidad,pallets,total_cajas,cajas,peso_neto,mov,vtotal,vtotalpts,por,tot,t
Integer r,c
DateTime f1,f2
DataStore d
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),grafico)
f_contador_procesos(0,100)

if IsNull(uo_pais.em_codigo.text) or Trim(uo_pais.em_codigo.text) = "" then
	sel2 = ""
else 
	sel2 = " and venfac.pais = '" + uo_pais.em_codigo.text + "' "
end if

Sel = " SELECT empresa,pais,provincia,divisa,Sum(total_neto - impdtopp) total,Sum((total_neto - impdtopp) * cambio) totalpts" +&
      " FROM   venfac " +&
      " WHERE  venfac.empresa = '"+codigo_empresa+"'" +&
      " And    venfac.ffactura between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		sel2 +&
		" GROUP By empresa,pais,provincia,divisa"+ &
		" Order By empresa,pais,provincia,divisa"

//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

c = 0
tot =  0
//***
//f_mensaje("rowcount",String(d.Rowcount()))
For r = 1 To d.RowCOunt()
	c = c +1
	provincia = d.GetItemString(r,"provincia")
	pais = d.GetItemString(r,"pais")
	if isnull(provincia) then
		provincia = ""
	end if
	if trim(provincia) = "" then
		nombre_provincia = "*NO DEFINIDA*"
		provincia = "zzzz"
	else	
		nombre_provincia = f_nombre_provincia(pais,provincia)
	end if
	moneda = d.GetItemString(r,"divisa")
	nombre_moneda = f_nombre_moneda_abr(moneda)
	vtotal = d.GetItemNumber(r,"total")
	vtotalpts = d.GetItemNumber(r,"totalpts")
	tot = tot + vtotalpts
	data.InsertRow(c)
	data.SetItem(c,"total",vtotal)
	data.SetItem(c,"total_pts",vtotalpts)
	data.SetItem(c,"provincia",provincia)
	data.SetItem(c,"pais",pais)
	data.SetItem(c,"moneda",moneda)
	data.SetItem(c,"nombre_provincia",nombre_provincia)
	data.SetItem(c,"nombre_moneda",nombre_moneda)
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

IF c <> 0 Then
	For r = 1 To c
		vtotalpts = data.GetItemNumber(r,"total_pts")
		por =  vtotalpts * 100 / tot
		data.SetItem(r,"porcentaje",por)
	Next
	
END IF

f_mensaje_proceso("Espere Por Favor",99,100)
data.groupcalc()
data.SetRedraw(TRUE)
data.SetSort("pais A, provincia A")
data.Sort()

f_contador_procesos(1,1)
destroy d
end subroutine

public subroutine f_control_detalle (datawindow data, string provincia);STring Sel,moneda,nombre_moneda,serie1,serie2,cliente,nombre_cliente
Dec  cantidad,pallets,total_cajas,cajas,peso_neto,mov,vtotal,vtotalpts,por,tot,t
Integer r,c
DateTime f1,f2
DataStore d
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),grafico)
f_contador_procesos(0,100)
Sel = " SELECT empresa,cliente,divisa,Sum(total_neto) total,Sum(total_neto * cambio) totalpts" +&
      " FROM   venfac " +&
      " WHERE  venfac.empresa = '"+codigo_empresa+"'" +&
      " And    venfac.provincia    = '"+provincia+"'"+&
      " And    venfac.ffactura between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" GROUP By empresa,cliente,divisa"+ &
		" Order By empresa,cliente,divisa"
		
//		" And    venfac.serie    between '"+serie1+"'  and '"+serie2+"' "+&
//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
c = 0
tot =  0
For r = 1 To d.RowCOunt()
	c = c +1
	cliente = d.GetItemString(r,"cliente")
	moneda = d.GetItemString(r,"divisa")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	nombre_moneda = f_nombre_moneda_abr(moneda)
	vtotal = d.GetItemNumber(r,"total")
	vtotalpts = d.GetItemNumber(r,"totalpts")
	tot = tot + vtotalpts
	data.InsertRow(c)
	data.SetItem(c,"total",vtotal)
	data.SetItem(c,"total_pts",vtotalpts)
	data.SetItem(c,"cliente",cliente)
	data.SetItem(c,"moneda",moneda)
	data.SetItem(c,"nombre_cliente",nombre_cliente)
	data.SetItem(c,"nombre_moneda",nombre_moneda)
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next


IF c <> 0 Then
	For r = 1 To c
		vtotalpts = data.GetItemNumber(r,"total_pts")
		por =  vtotalpts * 100 / tot
		data.SetItem(r,"porcentaje",por)
	Next
	
END IF

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.SetSort("total_pts D")
data.Sort()
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

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Ventas facturas por provincias"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_detalle_cliente.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado_clientes.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"total",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"total",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts",f_mascara_decimales(0))
dw_detalle.Object.elgrafico.visible = 0
f_activar_campo(em_fechadesde)


end event

on w_con_resumen_vtas_facturas_provincia.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.gb_3=create gb_3
this.uo_manejo=create uo_manejo
this.dw_listado_clientes=create dw_listado_clientes
this.dw_detalle_cliente=create dw_detalle_cliente
this.dw_detalle=create dw_detalle
this.uo_pais=create uo_pais
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.uo_manejo
this.Control[iCurrent+11]=this.dw_listado_clientes
this.Control[iCurrent+12]=this.dw_detalle_cliente
this.Control[iCurrent+13]=this.dw_detalle
this.Control[iCurrent+14]=this.uo_pais
this.Control[iCurrent+15]=this.gb_2
end on

on w_con_resumen_vtas_facturas_provincia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.gb_3)
destroy(this.uo_manejo)
destroy(this.dw_listado_clientes)
destroy(this.dw_detalle_cliente)
destroy(this.dw_detalle)
destroy(this.uo_pais)
destroy(this.gb_2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_facturas_provincia
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_facturas_provincia
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_facturas_provincia
integer width = 2359
integer height = 108
end type

type pb_1 from upb_salir within w_con_resumen_vtas_facturas_provincia
integer x = 2720
integer y = 16
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_provincia
integer x = 2706
integer y = 184
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_provincia
integer x = 27
integer y = 176
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_provincia
integer x = 398
integer y = 176
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_resumen_vtas_facturas_provincia
boolean visible = false
integer x = 2377
integer y = 72
integer width = 41
integer height = 36
string dataobject = "report_resumen_vtas_facturas_provincia"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_resumen_vtas_facturas_provincia
integer x = 1742
integer y = 180
integer width = 457
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)

end event

type gb_1 from groupbox within w_con_resumen_vtas_facturas_provincia
integer x = 5
integer y = 104
integer width = 736
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

type st_1 from statictext within w_con_resumen_vtas_facturas_provincia
integer x = 352
integer y = 180
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
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

type gb_3 from groupbox within w_con_resumen_vtas_facturas_provincia
integer x = 1723
integer y = 136
integer width = 489
integer height = 152
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_facturas_provincia
integer x = 2235
integer y = 136
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_clientes from datawindow within w_con_resumen_vtas_facturas_provincia
boolean visible = false
integer x = 2432
integer y = 80
integer width = 41
integer height = 36
integer taborder = 20
string dataobject = "report_resumen_vtas_facturas_prov_detall"
boolean livescroll = true
end type

type dw_detalle_cliente from datawindow within w_con_resumen_vtas_facturas_provincia
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
event rbuttondown pbm_dwnrbuttondown
boolean visible = false
integer y = 296
integer width = 2848
integer height = 1124
integer taborder = 70
string dataobject = "dw_con_resumen_vtas_facturas_prov_detall"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;choose case f_objeto_datawindow(This)
	case "grafico" 
		IF grafico = "N" Then
			grafico = "S"
			this.Object.elgrafico.x = 0
			this.Object.elgrafico.y = 0
			this.Object.elgrafico.height = 1100
			this.Object.elgrafico.width = 3031
			this.Object.elgrafico.visible = 1
		ELSE
			grafico = "N"
			this.Object.elgrafico.visible = 0
		END IF
	case "salir"
		this.visible=false
	case "imprimir"
		dw_listado_clientes.Reset()
		dw_listado_clientes.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),grafico)
		dw_detalle_cliente.RowsCopy(1,dw_detalle_cliente.RowCount(), Primary!,dw_listado_clientes, 1, Primary!)
		f_imprimir_datawindow(dw_listado_clientes)
end choose	
end event

event doubleclicked;this.Object.elgrafico.visible = 0
grafico = "N"
end event

event rbuttondown;if isnull(row) or row=0 then return


end event

type dw_detalle from datawindow within w_con_resumen_vtas_facturas_provincia
integer y = 304
integer width = 2848
integer height = 1124
string dataobject = "dw_con_resumen_vtas_facturas_provincia"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;this.Object.elgrafico.visible = 0
grafico = "N"
end event

event clicked;IF f_objeto_datawindow(This)= "grafico" Then
	IF grafico = "N" Then
		grafico = "S"
		this.Object.elgrafico.x = 0
		this.Object.elgrafico.y = 0
		this.Object.elgrafico.height = 1100
		this.Object.elgrafico.width = 3031
		this.Object.elgrafico.visible = 1
	ELSE
		grafico = "N"
		this.Object.elgrafico.visible = 0
	END IF

END IF
end event

event rbuttondown;if isnull(row) or row=0 then return

dw_detalle_cliente.visible=true

f_control_detalle(dw_detalle_cliente,getitemstring(row,"provincia"))

end event

type uo_pais from u_em_campo_2 within w_con_resumen_vtas_facturas_provincia
event destroy ( )
integer x = 768
integer y = 176
integer width = 690
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 

end event

event losefocus;call super::losefocus;valor_empresa = TRUE
end event

event getfocus;call super::getfocus;valor_empresa = FALSE
	ue_titulo = "Selección de Paises"
	ue_datawindow ="dw_ayuda_paises"
	ue_filtro = ""

end event

type gb_2 from groupbox within w_con_resumen_vtas_facturas_provincia
integer x = 745
integer y = 108
integer width = 736
integer height = 176
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pais"
end type

