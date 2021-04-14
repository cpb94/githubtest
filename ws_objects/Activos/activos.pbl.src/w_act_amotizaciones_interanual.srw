$PBExportHeader$w_act_amotizaciones_interanual.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_act_amotizaciones_interanual from w_int_con_empresa
end type
type pb_2 from upb_salir within w_act_amotizaciones_interanual
end type
type em_fechadesde from u_em_campo within w_act_amotizaciones_interanual
end type
type st_7 from statictext within w_act_amotizaciones_interanual
end type
type cb_2 from commandbutton within w_act_amotizaciones_interanual
end type
type pb_imprimir_preli from upb_imprimir within w_act_amotizaciones_interanual
end type
type cb_3 from commandbutton within w_act_amotizaciones_interanual
end type
type em_fechahasta from u_em_campo within w_act_amotizaciones_interanual
end type
type st_2 from statictext within w_act_amotizaciones_interanual
end type
type cbx_1 from checkbox within w_act_amotizaciones_interanual
end type
type gb_2 from groupbox within w_act_amotizaciones_interanual
end type
type dw_1 from datawindow within w_act_amotizaciones_interanual
end type
type dw_2 from datawindow within w_act_amotizaciones_interanual
end type
type st_titulo from statictext within w_act_amotizaciones_interanual
end type
type p_logo from picture within w_act_amotizaciones_interanual
end type
type dw_seleccion from u_seleccion2_busqueda within w_act_amotizaciones_interanual
end type
type st_1 from statictext within w_act_amotizaciones_interanual
end type
end forward

global type w_act_amotizaciones_interanual from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5216
integer height = 3140
string title = "Estadística comparativa de Compras por Productos y Familias"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
cb_3 cb_3
em_fechahasta em_fechahasta
st_2 st_2
cbx_1 cbx_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
st_titulo st_titulo
p_logo p_logo
dw_seleccion dw_seleccion
st_1 st_1
end type
global w_act_amotizaciones_interanual w_act_amotizaciones_interanual

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia


This.title = "Amortizaciones Interanuales por Familias de Activos"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_2.visible = false

anyo = year(Today())
mes = month (today())
dia = day (today())

em_fechadesde.text = string(anyo - 1)
em_fechahasta.text = string(anyo)

f_activar_campo(em_fechadesde)

//NUEVO Objeto Selección
Long numero_filas, maximo_largo, largo_total, largo_cabecera, largo_cab_grupo, largo_detalles
String consulta_seleccion 

dw_seleccion.visible = false
dw_seleccion.SetTransObject(SQLCA)
consulta_seleccion =   "SELECT act_familias.familia,"+&   
         				  "		 act_familias.descripcion,   "+&
							  "		 act_bienesdet.elemento,   "+&
							  "		 act_bienesdet.descripcion,   "+&
							  "  	    0 as seleccionado  "+&
							  "FROM   act_familias,    "+&
							  "		 act_bienesdet    "+&
							  "WHERE ( act_familias.empresa = act_bienesdet.empresa ) and  "+&
							  "      ( act_familias.familia = act_bienesdet.familia ) "+&
							  "ORDER BY CONVERT(Integer,act_familias.familia) ASC, CONVERT(Integer,act_bienesdet.elemento) ASC"

dw_seleccion.SetSQLSelect(consulta_seleccion)
numero_filas = dw_seleccion.retrieve()


end event

on w_act_amotizaciones_interanual.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_3=create cb_3
this.em_fechahasta=create em_fechahasta
this.st_2=create st_2
this.cbx_1=create cbx_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_seleccion=create dw_seleccion
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.st_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cbx_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.st_titulo
this.Control[iCurrent+14]=this.p_logo
this.Control[iCurrent+15]=this.dw_seleccion
this.Control[iCurrent+16]=this.st_1
end on

on w_act_amotizaciones_interanual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_3)
destroy(this.em_fechahasta)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_seleccion)
destroy(this.st_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_act_amotizaciones_interanual
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_act_amotizaciones_interanual
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_act_amotizaciones_interanual
boolean visible = false
integer width = 5038
integer height = 84
end type

type pb_2 from upb_salir within w_act_amotizaciones_interanual
integer x = 5019
integer y = 128
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type em_fechadesde from u_em_campo within w_act_amotizaciones_interanual
integer x = 1193
integer y = 148
integer width = 411
integer height = 80
integer taborder = 10
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
double increment = 1
string minmax = "2001~~3000"
end type

type st_7 from statictext within w_act_amotizaciones_interanual
integer x = 933
integer y = 152
integer width = 224
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_act_amotizaciones_interanual
event clicked pbm_bnclicked
integer x = 4462
integer y = 128
integer width = 361
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String consulta, filtro, anyo, mes, dia
Long fecha1, fecha2
Int i

filtro = ""
dw_1.reset()
dw_2.reset()

fecha1 = Long(em_fechadesde.text)
fecha2 = Long(em_fechahasta.text)
dw_seleccion.visible = false
dw_1.retrieve(codigo_empresa,fecha1,fecha2)
dw_2.retrieve(codigo_empresa,fecha1,fecha2)

if Long(dw_seleccion.devolver_seleccionados()) > 0 then
	filtro = f_reemplazar(f_reemplazar(dw_seleccion.devolver_resultado(2,1),"act_familias.familia","act_bienesdet_familia"),"act_bienesdet.elemento","act_bienesdet_elemento")
end if
//MessageBox("Debug",filtro)
dw_1.setfilter(filtro)
dw_1.Filter()
dw_1.sort()		
dw_1.GroupCalc()

dw_2.setfilter(filtro)
dw_2.Filter()


end event

type pb_imprimir_preli from upb_imprimir within w_act_amotizaciones_interanual
event clicked pbm_bnclicked
integer x = 4846
integer y = 128
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;f_imprimir_datawindow(dw_1)
/*
if Messagebox("Impresión gráfica", "¿Desea imprimir la gráfica asociada?", Question!, YesNo!,1) = 1 then
	dw_2.print(true)
end if
*/
	


end event

type cb_3 from commandbutton within w_act_amotizaciones_interanual
integer x = 14
integer y = 140
integer width = 562
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias / Activos"
end type

event clicked;//uo_productos.visible = not(uo_productos.visible)
//uo_familias.visible = false

dw_seleccion.visible = not(dw_seleccion.visible)

end event

type em_fechahasta from u_em_campo within w_act_amotizaciones_interanual
integer x = 1961
integer y = 148
integer width = 434
integer height = 80
integer taborder = 20
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
double increment = 1
string minmax = "2001~~3000"
end type

type st_2 from statictext within w_act_amotizaciones_interanual
integer x = 1719
integer y = 152
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_act_amotizaciones_interanual
boolean visible = false
integer x = 2674
integer y = 144
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
long backcolor = 67108864
string text = "Ver Gráfica"
boolean lefttext = true
end type

event clicked;if this.checked = true then
	dw_2.visible = true
else
	dw_2.visible = false
end if
end event

type gb_2 from groupbox within w_act_amotizaciones_interanual
integer x = 599
integer y = 104
integer width = 1920
integer height = 140
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ejercicios"
end type

type dw_1 from datawindow within w_act_amotizaciones_interanual
integer x = 27
integer y = 276
integer width = 5138
integer height = 2668
integer taborder = 80
string title = "none"
string dataobject = "dw_act_amortizaciones_interanual"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_2 from datawindow within w_act_amotizaciones_interanual
integer x = 27
integer y = 272
integer width = 5138
integer height = 2676
integer taborder = 90
string title = "none"
string dataobject = "graf_act_amortizaciones_interanual"
boolean livescroll = true
end type

type st_titulo from statictext within w_act_amotizaciones_interanual
integer x = 23
integer y = 20
integer width = 1710
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within w_act_amotizaciones_interanual
integer x = 4658
integer y = 16
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_seleccion from u_seleccion2_busqueda within w_act_amotizaciones_interanual
integer x = 27
integer y = 272
integer taborder = 40
boolean bringtotop = true
end type

on dw_seleccion.destroy
call u_seleccion2_busqueda::destroy
end on

type st_1 from statictext within w_act_amotizaciones_interanual
integer x = 2638
integer y = 156
integer width = 1486
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nota: Aparecen también los activos dados de baja"
boolean focusrectangle = false
end type

