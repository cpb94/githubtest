$PBExportHeader$w_con_pedidos_entre_fechas_clientes.srw
forward
global type w_con_pedidos_entre_fechas_clientes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_entre_fechas_clientes
end type
type pb_2 from upb_imprimir within w_con_pedidos_entre_fechas_clientes
end type
type dw_listado from datawindow within w_con_pedidos_entre_fechas_clientes
end type
type em_fechadesde from u_em_campo within w_con_pedidos_entre_fechas_clientes
end type
type em_fechahasta from u_em_campo within w_con_pedidos_entre_fechas_clientes
end type
type cb_1 from commandbutton within w_con_pedidos_entre_fechas_clientes
end type
type gb_1 from groupbox within w_con_pedidos_entre_fechas_clientes
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
end type
type gb_3 from groupbox within w_con_pedidos_entre_fechas_clientes
end type
type st_1 from statictext within w_con_pedidos_entre_fechas_clientes
end type
type uo_series from u_marca_lista within w_con_pedidos_entre_fechas_clientes
end type
type gb_6 from groupbox within w_con_pedidos_entre_fechas_clientes
end type
type dw_listado_resumen from datawindow within w_con_pedidos_entre_fechas_clientes
end type
type dw_listado_resumen_pm from datawindow within w_con_pedidos_entre_fechas_clientes
end type
type dw_detalle from datawindow within w_con_pedidos_entre_fechas_clientes
end type
type uo_agente from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
end type
type uo_familia from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
end type
type gb_4 from groupbox within w_con_pedidos_entre_fechas_clientes
end type
type gb_8 from groupbox within w_con_pedidos_entre_fechas_clientes
end type
end forward

global type w_con_pedidos_entre_fechas_clientes from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5609
integer height = 3456
long backcolor = 134217750
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
gb_6 gb_6
dw_listado_resumen dw_listado_resumen
dw_listado_resumen_pm dw_listado_resumen_pm
dw_detalle dw_detalle
uo_agente uo_agente
uo_familia uo_familia
gb_4 gb_4
gb_8 gb_8
end type
global w_con_pedidos_entre_fechas_clientes w_con_pedidos_entre_fechas_clientes

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public function integer f_control2 ()
end prototypes

public subroutine f_control (datawindow data);datastore ds_clientes
long i, fila_Actual
string sel1, cliente, v_empresa, agente, familia, familia_sql, marca, nombre_marca
date fecha1, fecha2, v_fpedido
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal v_importe, v_piezas, v_metros, v_importe2, v_piezas2, v_metros2, v_metros_lin, v_metros_lin2 


fecha1 = date(em_fechadesde.text)
fecha2 = date(em_fechahasta.text)

dia1 = day(fecha1)
mes1 = month(fecha1)
anyo1 = year(fecha1) - 1
dia2 = day(fecha2)
mes2 = month(fecha2) 
anyo2 = year(fecha2) - 1

fecha1 = Date ( anyo1, mes1, dia1)
fecha2 = Date ( anyo2, mes2, dia2)

if uo_cliente.em_codigo.text = '' or isnull(uo_cliente.em_codigo.text) then
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text
end if

if uo_agente.em_codigo.text = '' or isnull(uo_agente.em_codigo.text) then
	agente = '%'
else
	agente = uo_agente.em_codigo.text
end if

if uo_familia.em_codigo.text = '' or isnull(uo_familia.em_codigo.text) then
	familia = ""
	familia_sql = ""
else
	familia = uo_familia.em_codigo.text
	//familia_sql = " and exists (SELECT * FROM articulos WHERE empresa = genter.empresa and cliente = genter.codigo AND familia = '"+familia+"' ) "
	//familia_sql = " and genter.codigo in (SELECT cliente FROM venliped WHERE familia = '"+familia+"') "
	familia_sql = " and venclientes.grupo = '"+familia+"' "
end if

sel1 = 	" select genter.codigo, "+&
			" genter.razon, "+&
			" ISNULL((SELECT TOP 1 cliente_marca FROM articulos WHERE cliente = genter.codigo AND uso = '3' AND cliente_marca IS NOT NULL AND LTRIM(RTRIM(cliente_marca)) <> ''), genter.codigo)  as marca   "+& 
			" from genter LEFT JOIN venclientes ON genter.empresa = venclientes.empresa AND genter.codigo  = venclientes.codigo "+&
			" where genter.empresa =  "+codigo_empresa+&
			" and genter.tipoter = 'C' "+& 
			" and genter.codigo like '"+cliente+"' "+&
			" and (venclientes.agente1 like '"+agente+"' OR genter.codigo IN (SELECT cliente_marca FROM articulos INNER JOIN venclientes ON articulos.empresa = venclientes.empresa AND articulos.cliente = venclientes.codigo WHERE venclientes.agente1 like '"+agente+"') )  "

f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle.Setredraw(false)
dw_detalle.reset()
dw_Detalle.object.actual.text =  "Desde "+em_fechadesde.text+" hasta "+em_fechahasta.text
dw_Detalle.object.Anterior.text = "Desde "+string(fecha1,"dd-mm-yy")+" hasta "+string(fecha2,"dd-mm-yy")

for i = 1 to ds_clientes.rowcount()
	fila_actual = dw_detalle.insertrow(0)
	cliente = ds_clientes.object.genter_codigo[i]
	
	v_piezas = 0
	v_metros = 0
	v_importe = 0
	v_piezas2 = 0
	v_metros2 = 0
	v_importe2 = 0
	
	if familia = "" then
		f_piezas_metros_metrosl_importe_cliente (v_piezas, v_metros, v_importe, v_metros_lin, date(em_fechadesde.text), date(em_fechahasta.text), cliente)
		f_piezas_metros_metrosl_importe_cliente (v_piezas2, v_metros2, v_importe2, v_metros_lin2, fecha1, fecha2, cliente)
	else
		f_piezas_metros_metrosl_importe_familia (v_piezas, v_metros, v_importe, v_metros_lin, date(em_fechadesde.text), date(em_fechahasta.text), cliente, familia)
		f_piezas_metros_metrosl_importe_familia (v_piezas2, v_metros2, v_importe2, v_metros_lin2, fecha1, fecha2, cliente, familia)
	end if
	if isnull(v_piezas) then v_piezas = 0
	if isnull(v_metros) then v_metros = 0
	if isnull(v_importe) then v_importe = 0
	if isnull(v_piezas2) then v_piezas = 0
	if isnull(v_metros2) then v_metros = 0
	if isnull(v_importe2) then v_importe = 0
	
	nombre_marca = ""
	marca = ds_clientes.object.marca[i]
	dw_detalle.object.marca[fila_actual] = marca
	SELECT razon INTO :nombre_marca FROM genter WHERE empresa =:codigo_empresa AND tipoter = 'C' AND codigo = :marca ;
	dw_detalle.object.nombre_marca[fila_actual] = nombre_marca
	
	dw_detalle.object.cliente[fila_actual] = ds_clientes.object.genter_razon[i]
	dw_detalle.object.piezas[fila_actual] = v_piezas
	dw_detalle.object.importe[fila_actual] = v_importe
	dw_detalle.object.metros[fila_actual] = v_metros

	dw_detalle.object.piezas2[fila_actual] = v_piezas2
	dw_detalle.object.importe2[fila_actual] = v_importe2
	dw_detalle.object.metros2[fila_actual] = v_metros2
	f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
next



dw_detalle.setfilter("importe > 0 or importe2 > 0")
dw_detalle.filter()

dw_detalle.Setredraw(True)

destroy ds_clientes
end subroutine

public function integer f_control2 ();return 0
end function

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Pedidos por Clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
//dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
end event

on w_con_pedidos_entre_fechas_clientes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.gb_6=create gb_6
this.dw_listado_resumen=create dw_listado_resumen
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.dw_detalle=create dw_detalle
this.uo_agente=create uo_agente
this.uo_familia=create uo_familia
this.gb_4=create gb_4
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.uo_series
this.Control[iCurrent+12]=this.gb_6
this.Control[iCurrent+13]=this.dw_listado_resumen
this.Control[iCurrent+14]=this.dw_listado_resumen_pm
this.Control[iCurrent+15]=this.dw_detalle
this.Control[iCurrent+16]=this.uo_agente
this.Control[iCurrent+17]=this.uo_familia
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.gb_8
end on

on w_con_pedidos_entre_fechas_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.gb_6)
destroy(this.dw_listado_resumen)
destroy(this.dw_listado_resumen_pm)
destroy(this.dw_detalle)
destroy(this.uo_agente)
destroy(this.uo_familia)
destroy(this.gb_4)
destroy(this.gb_8)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_entre_fechas_clientes
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_entre_fechas_clientes
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_entre_fechas_clientes
integer x = 32
integer y = 8
integer width = 2875
integer height = 84
integer textsize = -9
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 134217750
end type

type pb_1 from upb_salir within w_con_pedidos_entre_fechas_clientes
integer x = 5371
integer y = 136
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedidos_entre_fechas_clientes
integer x = 5166
integer y = 132
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
	f_imprimir_datawindow(dw_detalle)

end event

type dw_listado from datawindow within w_con_pedidos_entre_fechas_clientes
boolean visible = false
integer x = 3415
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fechadesde from u_em_campo within w_con_pedidos_entre_fechas_clientes
integer x = 27
integer y = 148
integer width = 302
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 134217748
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_pedidos_entre_fechas_clientes
integer x = 398
integer y = 148
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 134217748
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_pedidos_entre_fechas_clientes
integer x = 4805
integer y = 132
integer width = 338
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	f_control(dw_detalle)

end event

type gb_1 from groupbox within w_con_pedidos_entre_fechas_clientes
integer x = 9
integer y = 96
integer width = 690
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Fecha de Pedido"
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
event destroy ( )
integer x = 722
integer y = 148
integer width = 1125
integer taborder = 30
boolean border = true
long backcolor = 16777215
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

type gb_3 from groupbox within w_con_pedidos_entre_fechas_clientes
integer x = 704
integer y = 96
integer width = 1170
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Cliente"
end type

type st_1 from statictext within w_con_pedidos_entre_fechas_clientes
integer x = 343
integer y = 148
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
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

type uo_series from u_marca_lista within w_con_pedidos_entre_fechas_clientes
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type gb_6 from groupbox within w_con_pedidos_entre_fechas_clientes
integer x = 4763
integer y = 92
integer width = 754
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
end type

type dw_listado_resumen from datawindow within w_con_pedidos_entre_fechas_clientes
boolean visible = false
integer x = 3602
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3_r"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_resumen_pm from datawindow within w_con_pedidos_entre_fechas_clientes
boolean visible = false
integer x = 3790
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle from datawindow within w_con_pedidos_entre_fechas_clientes
integer x = 18
integer y = 272
integer width = 5504
integer height = 2992
string dataobject = "dw_pedidos_entre_fechas_clientes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;String orden = ""
if row = 0 then
	if dwo.name = "piezas_t" then
		orden = "piezas D"
	elseif dwo.name = "piezas_t2" then
		orden = "piezas2 D"
	elseif dwo.name = "metros_t" then
		orden = "metros D"
	elseif dwo.name = "metros_t2" then
		orden = "metros2 D"
	elseif dwo.name = "importe_t" then
		orden = "importe D"
	elseif dwo.name = "importe_t2" then
		orden = "importe2 D"
	end if
	if orden <> "" then
		dw_detalle.setsort(orden)
		dw_detalle.sort()
	end if
end if
end event

type uo_agente from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
event destroy ( )
integer x = 1906
integer y = 148
integer width = 978
integer taborder = 40
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Agente"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type uo_familia from u_em_campo_2 within w_con_pedidos_entre_fechas_clientes
event destroy ( )
integer x = 2921
integer y = 148
integer width = 407
integer taborder = 80
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_4 from groupbox within w_con_pedidos_entre_fechas_clientes
integer x = 1883
integer y = 96
integer width = 1024
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Agente"
end type

type gb_8 from groupbox within w_con_pedidos_entre_fechas_clientes
integer x = 2898
integer y = 96
integer width = 471
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217750
string text = "Familia"
end type

