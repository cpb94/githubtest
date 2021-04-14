$PBExportHeader$w_con_resumen_vtas_facturas_agente.srw
forward
global type w_con_resumen_vtas_facturas_agente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_facturas_agente
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_agente
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_agente
end type
type st_8 from statictext within w_con_resumen_vtas_facturas_agente
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_agente
end type
type dw_listado from datawindow within w_con_resumen_vtas_facturas_agente
end type
type gb_6 from groupbox within w_con_resumen_vtas_facturas_agente
end type
type gb_5 from groupbox within w_con_resumen_vtas_facturas_agente
end type
type uo_agente from u_em_campo_2 within w_con_resumen_vtas_facturas_agente
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_agente
end type
type gb_4 from groupbox within w_con_resumen_vtas_facturas_agente
end type
type dw_detalle from u_datawindow_consultas within w_con_resumen_vtas_facturas_agente
end type
type cb_familias from commandbutton within w_con_resumen_vtas_facturas_agente
end type
type cb_formatos from commandbutton within w_con_resumen_vtas_facturas_agente
end type
type uo_familias from u_marca_lista within w_con_resumen_vtas_facturas_agente
end type
type uo_formatos from u_marca_lista within w_con_resumen_vtas_facturas_agente
end type
type ddlb_1 from dropdownlistbox within w_con_resumen_vtas_facturas_agente
end type
type gb_2 from groupbox within w_con_resumen_vtas_facturas_agente
end type
type gb_1 from groupbox within w_con_resumen_vtas_facturas_agente
end type
type cb_1 from u_boton within w_con_resumen_vtas_facturas_agente
end type
type gb_3 from groupbox within w_con_resumen_vtas_facturas_agente
end type
end forward

global type w_con_resumen_vtas_facturas_agente from w_int_con_empresa
integer width = 2944
integer height = 1656
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
dw_listado dw_listado
gb_6 gb_6
gb_5 gb_5
uo_agente uo_agente
uo_serie uo_serie
gb_4 gb_4
dw_detalle dw_detalle
cb_familias cb_familias
cb_formatos cb_formatos
uo_familias uo_familias
uo_formatos uo_formatos
ddlb_1 ddlb_1
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
gb_3 gb_3
end type
global w_con_resumen_vtas_facturas_agente w_con_resumen_vtas_facturas_agente

type variables
string grafico = "N"
end variables

forward prototypes
public subroutine f_control_m2 (datawindow data)
public function string f_filtro ()
end prototypes

public subroutine f_control_m2 (datawindow data);STring Sel,ag1,ag2,ag,nombre_ag,cli,nombre_cli,pais,nombre_pais,moneda,nombre_moneda
string serie1,serie2,prov,nombre_prov,cliente,cliente_anterior,articulo,filtro
string tipo
Dec  total_divisas,total_pts,cantidad
real m2_total=0,total_neto,cambio
Integer r,c,pos
long cajas_total,cajas
DateTime f1,f2
DataStore d
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))
ag1 = "."
ag2= "Z"

uo_familias.visible=false
uo_formatos.visible=false

choose case ddlb_1.text
	case 'M²'
		tipo='M'
	case 'Cajas'
		tipo='C'
end choose
		
	
if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

IF Trim(uo_agente.em_codigo.text) <> "" Then
	ag1 = uo_agente.em_codigo.text
	ag2 = uo_agente.em_codigo.text
END IF
data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),grafico)
f_contador_procesos(0,100)
filtro=f_filtro()
Sel = " SELECT empresa,agente1,pais,cliente,Sum(cantidad) cantidad,sum(total_cajas) cajas,articulo" +&
      ",divisa,sum(neto - impdtopp) total_neto,cambio FROM   venlifac " +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
      " And    venlifac.serie     between '"+serie1+"'  and '"+serie2+"' "+&
		" And    venlifac.agente1     between '"+ag1+"'  and '"+ag2+"' "+&
      " And    venlifac.ffactura    between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"' and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"'" +&
		" And    venlifac.articulo<>'' "+&
		+filtro+&		
		" GROUP By empresa,agente1,pais,cliente,formato,divisa,cambio,articulo"+ &
		" Order By empresa,agente1,pais,cliente,formato,divisa,cambio"
		
cliente = ""
cliente_anterior = ""

cajas_total=0

//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)
c = 0
For r = 1 To d.RowCOunt()	
	
	cliente = d.Getitemstring(r,"cliente")
	
	if cliente_anterior="" then cliente_anterior = cliente
	
	if cliente <> cliente_anterior then
		c = c +1
		pos = data.InsertRow(c)
		data.SetItem(pos,"total",dec(string(total_divisas,f_mascara_moneda(moneda))))
		data.SetItem(pos,"total_pts",total_pts)
		if tipo='M' then
			data.SetItem(pos,"m2",m2_total)
		else
			data.SetItem(pos,"m2",cajas_total)
		end if
		data.SetItem(pos,"pais",pais)
		data.SetItem(pos,"moneda",moneda)
		data.SetItem(pos,"nombre_pais",nombre_pais)
		data.SetItem(pos,"nombre_moneda",nombre_moneda)
		data.SetItem(pos,"nombre_cliente",nombre_cli)
		data.SetItem(pos,"cliente",cliente_anterior)
		data.SetItem(pos,"nombre_agente",nombre_ag)
		data.SetItem(pos,"agente",ag)
		data.SetItem(pos,"nombre_provincia",nombre_prov)
		data.SetItem(pos,"provincia",prov)
		data.setitem(pos,"tipo",tipo)
		total_divisas = 0
		total_pts = 0
		m2_total  = 0
		cajas_total=0
		cliente_anterior = cliente
	end if
	
	pais     = d.GetItemString(r,"pais")
	ag       = d.GetItemString(r,"agente1")
	cantidad = d.Getitemnumber(r,"cantidad")
	cajas		= d.Getitemnumber(r,"cajas")

	articulo = d.Getitemstring(r,"articulo")
	cambio   = d.Getitemnumber(r,"cambio")
	if isnull(cambio) or cambio = 0 then
		cambio = 1
	end if
	if d.Getitemstring(r,"divisa") <> f_codigo_pts() then
		total_pts  = total_pts + (d.Getitemnumber(r,"total_neto") * cambio)
	else
		total_pts  = total_pts + d.Getitemnumber(r,"total_neto")
	end if
	total_divisas = total_divisas + d.Getitemnumber(r,"total_neto")
	moneda = d.Getitemstring(r,"divisa")
	nombre_moneda = f_nombre_moneda_abr(d.Getitemstring(r,"divisa"))
	m2_total = m2_total + f_conversion_cantidad_m2(codigo_empresa,articulo,cantidad)
	cajas_total=cajas_total + cajas
	nombre_pais = f_nombre_pais(pais)
	prov=f_provincia_genter(codigo_empresa,"C",cliente)
	nombre_prov=f_nombre_provincia(pais,prov)
	nombre_ag=f_nombre_venagentes(codigo_empresa,ag)
	nombre_cli=f_razon_genter(codigo_empresa,"C",cliente)
	
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

if d.RowCOunt()>0 then
		c = c + 1	
		pos = data.InsertRow(c)
		data.SetItem(pos,"total",dec(string(total_divisas,f_mascara_moneda(moneda))))
		data.SetItem(pos,"total_pts",total_pts)
		if tipo='M' then
			data.SetItem(pos,"m2",m2_total)
		else
			data.SetItem(pos,"m2",cajas_total)
		end if
		data.SetItem(pos,"pais",pais)
		data.SetItem(pos,"moneda",moneda)
		data.SetItem(pos,"nombre_pais",nombre_pais)
		data.SetItem(pos,"nombre_moneda",nombre_moneda)
		data.SetItem(pos,"nombre_cliente",nombre_cli)
		data.SetItem(pos,"cliente",cliente_anterior)
		data.SetItem(pos,"nombre_agente",nombre_ag)
		data.SetItem(pos,"agente",ag)
		data.SetItem(pos,"nombre_provincia",nombre_prov)
		data.SetItem(pos,"provincia",prov)
		data.setitem(pos,"tipo",tipo)		
end if


f_mensaje_proceso("Espere Por Favor",99,100)
data.Sort()
data.groupcalc()
data.SetRedraw(TRUE)
data.setfocus()
f_contador_procesos(1,1)
destroy d
end subroutine

public function string f_filtro ();string filtro
integer cont,veces

filtro=" and ("
veces=0
for cont = 1 to uo_familias.dw_marca.RowCount()
	if uo_familias.dw_marca.object.marca[cont]='S' then
		veces++
		if veces<>1 then
			filtro=filtro+" or "
		end if
		filtro=filtro+" familia ='"+uo_familias.dw_marca.object.codigo[cont]+"'"			
	end if
next
if veces>0 then
	filtro=filtro+") and ("
end if

veces=0
for cont = 1 to uo_formatos.dw_marca.RowCount()
	if uo_formatos.dw_marca.object.marca[cont]='S' then
		veces++
		if veces<>1 then
			filtro=filtro+" or "
		end if
		filtro=filtro+" formato ='"+uo_formatos.dw_marca.object.codigo[cont]+"'"			
		
	end if
next

if veces>0 then
	filtro=filtro+")"
end if

return filtro
end function

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Vtas facturas por agente"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"total",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts4",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"total",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts4",f_mascara_decimales(0))

uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_formatos.f_cargar_datos("dw_ayuda_formatos","%","","Formato","Descripción")
dw_detalle.ue_marca_linea=false
ddlb_1.text='M²'
f_activar_campo(em_fechadesde)



end event

on w_con_resumen_vtas_facturas_agente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.gb_6=create gb_6
this.gb_5=create gb_5
this.uo_agente=create uo_agente
this.uo_serie=create uo_serie
this.gb_4=create gb_4
this.dw_detalle=create dw_detalle
this.cb_familias=create cb_familias
this.cb_formatos=create cb_formatos
this.uo_familias=create uo_familias
this.uo_formatos=create uo_formatos
this.ddlb_1=create ddlb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.gb_6
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.uo_agente
this.Control[iCurrent+10]=this.uo_serie
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.dw_detalle
this.Control[iCurrent+13]=this.cb_familias
this.Control[iCurrent+14]=this.cb_formatos
this.Control[iCurrent+15]=this.uo_familias
this.Control[iCurrent+16]=this.uo_formatos
this.Control[iCurrent+17]=this.ddlb_1
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.gb_3
end on

on w_con_resumen_vtas_facturas_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.uo_agente)
destroy(this.uo_serie)
destroy(this.gb_4)
destroy(this.dw_detalle)
destroy(this.cb_familias)
destroy(this.cb_formatos)
destroy(this.uo_familias)
destroy(this.uo_formatos)
destroy(this.ddlb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.gb_3)
end on

event ue_f5;f_control_m2(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_facturas_agente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_facturas_agente
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_facturas_agente
integer x = 9
integer y = 8
integer width = 2336
integer height = 108
end type

type pb_1 from upb_salir within w_con_resumen_vtas_facturas_agente
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_facturas_agente
integer x = 2725
integer y = 192
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control_m2(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_facturas_agente
integer x = 18
integer y = 176
integer width = 274
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_resumen_vtas_facturas_agente
integer x = 293
integer y = 176
integer width = 46
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
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_facturas_agente
integer x = 334
integer y = 176
integer width = 274
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_resumen_vtas_facturas_agente
boolean visible = false
integer x = 2263
integer y = 32
integer width = 466
integer height = 168
string dataobject = "report_con_resumen_vtas_facturas_agentes"
boolean livescroll = true
end type

type gb_6 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 2235
integer y = 116
integer width = 288
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cant. en"
end type

type gb_5 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 1943
integer y = 120
integer width = 302
integer height = 172
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_agente from u_em_campo_2 within w_con_resumen_vtas_facturas_agente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 640
integer y = 176
integer width = 823
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Agentes"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_facturas_agente
event destroy ( )
integer x = 1499
integer y = 176
integer width = 439
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

type gb_4 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 1486
integer y = 112
integer width = 466
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type dw_detalle from u_datawindow_consultas within w_con_resumen_vtas_facturas_agente
integer y = 300
integer width = 2853
integer height = 1116
integer taborder = 90
string dataobject = "dw_con_resumen_vtas_facturas_agentes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_familias from commandbutton within w_con_resumen_vtas_facturas_agente
integer x = 1957
integer y = 156
integer width = 274
integer height = 64
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;if uo_familias.visible= True then
   uo_familias.visible = False
else
	uo_familias.visible= True
End if
end event

type cb_formatos from commandbutton within w_con_resumen_vtas_facturas_agente
integer x = 1957
integer y = 220
integer width = 274
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;if uo_formatos.visible= True then
   uo_formatos.visible = False
else
	uo_formatos.visible= True
End if
end event

type uo_familias from u_marca_lista within w_con_resumen_vtas_facturas_agente
event destroy ( )
boolean visible = false
integer x = 1440
integer y = 304
integer taborder = 100
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type uo_formatos from u_marca_lista within w_con_resumen_vtas_facturas_agente
event destroy ( )
boolean visible = false
integer x = 1440
integer y = 304
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type ddlb_1 from dropdownlistbox within w_con_resumen_vtas_facturas_agente
integer x = 2245
integer y = 176
integer width = 270
integer height = 284
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Cajas","M²"}
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 613
integer y = 116
integer width = 882
integer height = 176
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type gb_1 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 5
integer y = 112
integer width = 617
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

type cb_1 from u_boton within w_con_resumen_vtas_facturas_agente
integer x = 2542
integer y = 192
integer width = 174
integer height = 84
integer taborder = 50
string text = "F5 Ok"
end type

event clicked;f_control_m2(dw_detalle)
end event

type gb_3 from groupbox within w_con_resumen_vtas_facturas_agente
integer x = 2528
integer y = 152
integer width = 315
integer height = 136
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

