$PBExportHeader$w_con_compras_inter_proveedor.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_compras_inter_proveedor from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_compras_inter_proveedor
end type
type em_fechadesde from u_em_campo within w_con_compras_inter_proveedor
end type
type st_7 from statictext within w_con_compras_inter_proveedor
end type
type cb_2 from commandbutton within w_con_compras_inter_proveedor
end type
type pb_imprimir_preli from upb_imprimir within w_con_compras_inter_proveedor
end type
type cb_3 from commandbutton within w_con_compras_inter_proveedor
end type
type gb_1 from groupbox within w_con_compras_inter_proveedor
end type
type em_fechahasta from u_em_campo within w_con_compras_inter_proveedor
end type
type st_2 from statictext within w_con_compras_inter_proveedor
end type
type dw_seleccion from u_seleccion2 within w_con_compras_inter_proveedor
end type
type st_1 from statictext within w_con_compras_inter_proveedor
end type
type dw_1 from datawindow within w_con_compras_inter_proveedor
end type
type sle_busqueda from singlelineedit within w_con_compras_inter_proveedor
end type
type cbx_1 from checkbox within w_con_compras_inter_proveedor
end type
type dw_2 from datawindow within w_con_compras_inter_proveedor
end type
end forward

global type w_con_compras_inter_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5216
integer height = 3104
string title = "Estadística comparativa de Compras por Productos y Familias"
string icon = "Application!"
pb_2 pb_2
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
cb_3 cb_3
gb_1 gb_1
em_fechahasta em_fechahasta
st_2 st_2
dw_seleccion dw_seleccion
st_1 st_1
dw_1 dw_1
sle_busqueda sle_busqueda
cbx_1 cbx_1
dw_2 dw_2
end type
global w_con_compras_inter_proveedor w_con_compras_inter_proveedor

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia


This.title = "CONSULTA DE COMPRAS INTERANUALES POR PROVEEDOR"

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_2.visible = false

anyo = year(Today())
mes = month (today())
dia = day (today())

em_fechadesde.text = string(dia)+'-'+string(mes)+'-'+string(anyo - 10)
em_fechahasta.text = string(dia)+'-'+string(mes)+'-'+string(anyo)

f_activar_campo(em_fechadesde)

//NUEVO Objeto Selección
Long numero_filas, maximo_largo, largo_total, largo_cabecera, largo_cab_grupo, largo_detalles
String consulta_seleccion 

dw_seleccion.visible = false
dw_seleccion.SetTransObject(SQLCA)
consulta_seleccion =   "SELECT venmateria.codigo,   "+&
							  "       venmateria.descripcion,   "+&
	 						  "       venfamilias.familia,  "+&
						     "	    venfamilias.descripcion,   "+&
							  "       0 as seleccionado   "+&
							  "FROM  venfamilias,   "+&
							  "       venmateria  "+&
							  "WHERE ( venfamilias.empresa = venmateria.empresa ) and  "+&
							  "      ( venfamilias.tipo_materia = venmateria.codigo ) "+&
							  "ORDER BY CONVERT(Integer,venmateria.codigo) ASC, CONVERT(Integer,venfamilias.familia) ASC"

dw_seleccion.SetSQLSelect(consulta_seleccion)
numero_filas = dw_seleccion.retrieve()


end event

on w_con_compras_inter_proveedor.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_3=create cb_3
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.st_2=create st_2
this.dw_seleccion=create dw_seleccion
this.st_1=create st_1
this.dw_1=create dw_1
this.sle_busqueda=create sle_busqueda
this.cbx_1=create cbx_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_seleccion
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.sle_busqueda
this.Control[iCurrent+14]=this.cbx_1
this.Control[iCurrent+15]=this.dw_2
end on

on w_con_compras_inter_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.st_2)
destroy(this.dw_seleccion)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.sle_busqueda)
destroy(this.cbx_1)
destroy(this.dw_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_compras_inter_proveedor
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_compras_inter_proveedor
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_compras_inter_proveedor
integer y = 20
integer width = 5038
integer height = 84
end type

type pb_2 from upb_salir within w_con_compras_inter_proveedor
integer x = 5056
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type em_fechadesde from u_em_campo within w_con_compras_inter_proveedor
integer x = 905
integer y = 132
integer width = 411
integer height = 80
integer taborder = 10
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type st_7 from statictext within w_con_compras_inter_proveedor
integer x = 635
integer y = 132
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_compras_inter_proveedor
event clicked pbm_bnclicked
integer x = 4686
integer y = 120
integer width = 361
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String consulta, filtro, anyo, mes, dia
Datetime fecha1, fecha2
Int i

filtro = ""
dw_1.reset()
dw_2.reset()
anyo = mid(em_fechadesde.text,7)
mes = mid(em_fechadesde.text,4,2)
dia = mid(em_fechadesde.text,1,2)
fecha1 = Datetime(Date(anyo+"/"+mes+"/"+dia),Time(0))
anyo = mid(em_fechahasta.text,7)
mes = mid(em_fechahasta.text,4,2)
dia = mid(em_fechahasta.text,1,2)
fecha2 = DateTime(Date(anyo+"/"+mes+"/"+dia),Time(0))

dw_seleccion.visible = false
dw_1.retrieve(codigo_empresa,fecha1,fecha2)
dw_2.retrieve(codigo_empresa,fecha1,fecha2)

if sle_busqueda.text <> "" then
	filtro = "genter_razon = '"+sle_busqueda.text+"'"
else
	filtro = "1 = 1"
end if

if Long(dw_seleccion.devolver_seleccionados()) > 0 then
	filtro = filtro + " AND " + f_reemplazar(f_reemplazar(dw_seleccion.devolver_resultado(),"venmateria.codigo","venmprima_tipo_materia"),"venfamilias.familia","venmprima_familia")
end if

dw_1.setfilter(filtro)
dw_1.Filter()
dw_1.SetSort("total_proveedor1 desc")		
dw_1.sort()
dw_1.GroupCalc()

dw_2.setfilter(filtro)
dw_2.Filter()

end event

type pb_imprimir_preli from upb_imprimir within w_con_compras_inter_proveedor
event clicked pbm_bnclicked
integer x = 5056
integer y = 120
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_cargar(dw_1)
f_imprimir_datawindow(dw_1)
if Messagebox("Impresión gráfica", "¿Desea imprimir la gráfica asociada?", Question!, YesNo!,1) = 1 then
	dw_2.print(true)
end if
	


end event

type cb_3 from commandbutton within w_con_compras_inter_proveedor
integer x = 9
integer y = 132
integer width = 562
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos / Familias"
end type

event clicked;//uo_productos.visible = not(uo_productos.visible)
//uo_familias.visible = false

dw_seleccion.visible = not(dw_seleccion.visible)

end event

type gb_1 from groupbox within w_con_compras_inter_proveedor
integer y = 92
integer width = 585
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type em_fechahasta from u_em_campo within w_con_compras_inter_proveedor
integer x = 1577
integer y = 132
integer width = 434
integer height = 80
integer taborder = 20
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_compras_inter_proveedor
integer x = 1330
integer y = 132
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_seleccion from u_seleccion2 within w_con_compras_inter_proveedor
integer y = 228
integer height = 948
integer taborder = 70
boolean bringtotop = true
end type

type st_1 from statictext within w_con_compras_inter_proveedor
integer x = 2066
integer y = 140
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_compras_inter_proveedor
integer x = 27
integer y = 236
integer width = 5138
integer height = 2676
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_compras_inter_prov"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type sle_busqueda from singlelineedit within w_con_compras_inter_proveedor
event key pbm_keydown
integer x = 2450
integer y = 128
integer width = 1262
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

event key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT genter.codigo, genter.razon "+&
							"FROM genter "+&
							"WHERE genter.tipoter = 'P' AND genter.empresa = '"+codigo_empresa+"'"


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Proveedor"

IF not isnull(this.text) and this.text <> "" THEN
	busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		//busqueda.filtro = this.text
		busqueda.filtro_es_codigo = false
	else
		//Es código
		busqueda.filtro_es_codigo = true
	end if
END IF

IF KeyDown(KeyEnter!) OR (not isnull(Message.LongParm) and Message.LongParm = 1001) THEN  
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado > 0 then
		this.text = resultado.valores[2]
	end if
END IF

end event

event losefocus;/*
Long es_texto

if isnull(this.text) or trim(this.text) = "" then
	es_texto = 1
else
	es_texto = Long(this.text)
end if

if es_texto = 0 then
	IF KeyDown(KeyTab!) THEN
		this.triggerevent("key",0,1001)
	END IF
end if
*/

IF KeyDown(KeyTab!) THEN
	this.triggerevent("key",0,1001)
END IF
end event

type cbx_1 from checkbox within w_con_compras_inter_proveedor
integer x = 3781
integer y = 136
integer width = 773
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ver Gráfica"
boolean lefttext = true
end type

event clicked;if this.checked = true then
	dw_2.visible = true
else
	dw_2.visible = false
end if
end event

type dw_2 from datawindow within w_con_compras_inter_proveedor
integer x = 27
integer y = 236
integer width = 5138
integer height = 2676
integer taborder = 90
string title = "none"
string dataobject = "graf_con_compras_inter_prov"
boolean livescroll = true
end type

