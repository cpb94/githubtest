$PBExportHeader$w_con_ranking_clientes.srw
forward
global type w_con_ranking_clientes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ranking_clientes
end type
type pb_2 from upb_imprimir within w_con_ranking_clientes
end type
type em_fechadesde from u_em_campo within w_con_ranking_clientes
end type
type em_fechahasta from u_em_campo within w_con_ranking_clientes
end type
type cb_1 from commandbutton within w_con_ranking_clientes
end type
type gb_1 from groupbox within w_con_ranking_clientes
end type
type st_1 from statictext within w_con_ranking_clientes
end type
type gb_3 from groupbox within w_con_ranking_clientes
end type
type uo_manejo from u_manejo_datawindow within w_con_ranking_clientes
end type
type dw_listado_clientes from datawindow within w_con_ranking_clientes
end type
type dw_detalle_cliente from datawindow within w_con_ranking_clientes
end type
type uo_serie from u_em_campo_2 within w_con_ranking_clientes
end type
type gb_4 from groupbox within w_con_ranking_clientes
end type
type uo_pais from u_em_campo_2 within w_con_ranking_clientes
end type
type uo_provincia from u_em_campo_2 within w_con_ranking_clientes
end type
type uo_agente from u_em_campo_2 within w_con_ranking_clientes
end type
type gb_2 from groupbox within w_con_ranking_clientes
end type
type gb_5 from groupbox within w_con_ranking_clientes
end type
type gb_6 from groupbox within w_con_ranking_clientes
end type
end forward

global type w_con_ranking_clientes from w_int_con_empresa
integer width = 2958
integer height = 1692
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
st_1 st_1
gb_3 gb_3
uo_manejo uo_manejo
dw_listado_clientes dw_listado_clientes
dw_detalle_cliente dw_detalle_cliente
uo_serie uo_serie
gb_4 gb_4
uo_pais uo_pais
uo_provincia uo_provincia
uo_agente uo_agente
gb_2 gb_2
gb_5 gb_5
gb_6 gb_6
end type
global w_con_ranking_clientes w_con_ranking_clientes

type variables
string filtro,grafico = "N"
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);STring Sel,moneda,nombre_moneda,serie1,serie2,cliente,nombre_cliente,paises,provincias,agentes
Dec  cantidad,pallets,total_cajas,cajas,peso_neto,mov,vtotal,vtotalpts,por,tot,t,porac
Integer r,c
DateTime f1,f2
DataStore d

dw_detalle_cliente.reset()
dw_listado_clientes.reset()

f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if
if uo_pais.em_codigo.text <> "" then
	paises = uo_pais.em_codigo.text
else
	paises = "%"
end if
if uo_provincia.em_codigo.text <> "" then
	provincias = uo_provincia.em_codigo.text
else
	provincias = "%"
end if
if uo_agente.em_codigo.text <> "" then
	agentes = uo_agente.em_codigo.text
else
	agentes = "%"
end if

data.Reset()
data.SetRedraw(FALSE)

data.Retrieve(codigo_empresa,f1,f2)
f_contador_procesos(0,100)					// dividir para el cambio del euro

// David 26-10-01	Quito la agrupacion por divisa
//Sel = " SELECT empresa,cliente,divisa,Sum(total_neto) total,Sum((total_neto) / cambio) totalpts" +&  
Sel = " SELECT empresa,cliente,Sum(total_neto) total,Sum((total_neto) / cambio) totalpts" +&  
      " FROM   venfac " +&
      " WHERE  venfac.empresa = '"+codigo_empresa+"'" +&
      " And    venfac.serie    between '"+serie1+"'  and '"+serie2+"' "+&
		" And    pais like '"+paises+"' "+&
		" And    provincia like '"+provincias+"' "+&
		" And    agente1 like '"+agentes+"' "+&
      " And    venfac.ffactura between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" GROUP By empresa,cliente"+ &
		" Order By empresa,cliente"   // David 26-10-01	Quito la agrupacion por divisa
//		" GROUP By empresa,cliente,divisa"+ &
//		" Order By empresa,cliente,divisa"
		
//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

c = 0
tot =  0
For r = 1 To d.RowCOunt()
	c = c +1
	f_mensaje_proceso("cargando Datos",r,d.RowCount())
	cliente = d.GetItemString(r,"cliente")
//	moneda = d.GetItemString(r,"divisa") // David 26-10-01	Quito la divisa. La moneda es el euro
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
//	nombre_moneda = f_nombre_moneda_abr(moneda) // David 26-10-01	Quito la divisa. La moneda es el euro
	vtotal = d.GetItemNumber(r,"total")
	vtotalpts = d.GetItemNumber(r,"totalpts")
	tot = tot + vtotalpts
	data.InsertRow(c)
	data.SetItem(c,"total",vtotal)
	data.SetItem(c,"total_pts",vtotalpts)
	data.SetItem(c,"cliente",cliente)
//	data.SetItem(c,"moneda",moneda)   // David 26-10-01	Quito la divisa. La moneda es el euro
	data.SetItem(c,"nombre_cliente",nombre_cliente)
	data.SetItem(c,"nombre_moneda",nombre_moneda)   
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

IF c <> 0 Then
	For r = 1 To c
		f_mensaje_proceso("Realizando Cálculos",r,c)
		vtotalpts = data.GetItemNumber(r,"total_pts")
		if tot = 0 then
		   por = 0
		else
			por =  vtotalpts * 100 / tot
		end if
		data.SetItem(r,"porcentaje",por)
	Next
	
END IF

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.SetSort("total_pts D")
data.Sort()

porac = 0
IF c <> 0 Then
	For r = 1 To c
		f_mensaje_proceso("Realizando Cálculos",r,c)
		por =  data.GetItemNumber(r,"porcentaje")
		porac = porac + por
		data.SetItem(r,"porcac",porac)
	Next
	
END IF
f_contador_procesos(1,1)
destroy d

end subroutine

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Ranking de clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle_cliente.SetTransObject(SQLCA)
dw_listado_clientes.SetTransObject(SQLCA)
f_activar_campo(em_fechadesde)


end event

on w_con_ranking_clientes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.gb_3=create gb_3
this.uo_manejo=create uo_manejo
this.dw_listado_clientes=create dw_listado_clientes
this.dw_detalle_cliente=create dw_detalle_cliente
this.uo_serie=create uo_serie
this.gb_4=create gb_4
this.uo_pais=create uo_pais
this.uo_provincia=create uo_provincia
this.uo_agente=create uo_agente
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.uo_manejo
this.Control[iCurrent+10]=this.dw_listado_clientes
this.Control[iCurrent+11]=this.dw_detalle_cliente
this.Control[iCurrent+12]=this.uo_serie
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.uo_pais
this.Control[iCurrent+15]=this.uo_provincia
this.Control[iCurrent+16]=this.uo_agente
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_5
this.Control[iCurrent+19]=this.gb_6
end on

on w_con_ranking_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.gb_3)
destroy(this.uo_manejo)
destroy(this.dw_listado_clientes)
destroy(this.dw_detalle_cliente)
destroy(this.uo_serie)
destroy(this.gb_4)
destroy(this.uo_pais)
destroy(this.uo_provincia)
destroy(this.uo_agente)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_6)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle_cliente)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ranking_clientes
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ranking_clientes
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ranking_clientes
integer x = 14
integer y = 4
integer width = 2501
integer height = 108
end type

type pb_1 from upb_salir within w_con_ranking_clientes
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ranking_clientes
integer x = 2697
integer y = 180
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado_clientes)
f_imprimir_datawindow(dw_listado_clientes)


end event

type em_fechadesde from u_em_campo within w_con_ranking_clientes
integer x = 27
integer y = 176
integer width = 352
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_ranking_clientes
integer x = 443
integer y = 176
integer width = 361
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_ranking_clientes
integer x = 1742
integer y = 180
integer width = 475
integer height = 88
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle_cliente)

end event

type gb_1 from groupbox within w_con_ranking_clientes
integer x = 5
integer y = 104
integer width = 823
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

type st_1 from statictext within w_con_ranking_clientes
integer x = 384
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

type gb_3 from groupbox within w_con_ranking_clientes
integer x = 1723
integer y = 136
integer width = 507
integer height = 144
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_manejo from u_manejo_datawindow within w_con_ranking_clientes
integer x = 2226
integer y = 132
integer width = 649
integer height = 172
end type

event valores;call super::valores;dw_data       = dw_detalle_cliente
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado_clientes from datawindow within w_con_ranking_clientes
integer x = 2565
integer y = 332
integer width = 101
integer height = 100
string dataobject = "report_con_ranking_clientes"
boolean livescroll = true
end type

type dw_detalle_cliente from datawindow within w_con_ranking_clientes
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
event rbuttondown pbm_dwnrbuttondown
integer y = 476
integer width = 2848
integer height = 968
string dataobject = "dw_con_ranking_clientes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_serie from u_em_campo_2 within w_con_ranking_clientes
event destroy ( )
integer x = 864
integer y = 172
integer width = 453
integer taborder = 30
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

type gb_4 from groupbox within w_con_ranking_clientes
integer x = 846
integer y = 112
integer width = 489
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type uo_pais from u_em_campo_2 within w_con_ranking_clientes
event destroy ( )
integer x = 32
integer y = 344
integer width = 453
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_pais.em_campo.text = f_nombre_pais(uo_pais.em_codigo.text)


end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION PAISES"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = "" 	
valor_empresa = FALSE
end event

type uo_provincia from u_em_campo_2 within w_con_ranking_clientes
event destroy ( )
integer x = 530
integer y = 340
integer width = 704
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_provincia.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_provincia.em_campo.text = f_nombre_provincia(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)


end event

event getfocus;call super::getfocus;valor_empresa  = FALSE
ue_titulo    	= "AYUDA SELECCION DE PROVINCIAS"
ue_datawindow	= "dw_ayuda_provincias"
ue_filtro      = "pais = '" + uo_pais.em_codigo.text + "' "

end event

type uo_agente from u_em_campo_2 within w_con_ranking_clientes
event destroy ( )
integer x = 1275
integer y = 344
integer width = 704
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)


end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venagentes"
ue_titulo     =  "AYUDA SELECCION AGENTES"
ue_filtro     =  ""

end event

type gb_2 from groupbox within w_con_ranking_clientes
integer x = 14
integer y = 288
integer width = 494
integer height = 168
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "País"
end type

type gb_5 from groupbox within w_con_ranking_clientes
integer x = 512
integer y = 288
integer width = 745
integer height = 168
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Provincia"
end type

type gb_6 from groupbox within w_con_ranking_clientes
integer x = 1262
integer y = 288
integer width = 745
integer height = 168
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Agente"
end type

