$PBExportHeader$w_con_produccion_comparativa_bases.srw
forward
global type w_con_produccion_comparativa_bases from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_con_produccion_comparativa_bases
end type
type gb_1 from groupbox within w_con_produccion_comparativa_bases
end type
type em_fdesde from u_em_campo within w_con_produccion_comparativa_bases
end type
type em_fhasta from u_em_campo within w_con_produccion_comparativa_bases
end type
type dw_1 from datawindow within w_con_produccion_comparativa_bases
end type
type cb_1 from u_boton within w_con_produccion_comparativa_bases
end type
type pb_1 from upb_salir within w_con_produccion_comparativa_bases
end type
type em_fdesde_ant from u_em_campo within w_con_produccion_comparativa_bases
end type
type em_fhasta_ant from u_em_campo within w_con_produccion_comparativa_bases
end type
type st_1 from statictext within w_con_produccion_comparativa_bases
end type
type pb_4 from upb_imprimir within w_con_produccion_comparativa_bases
end type
type gb_2 from groupbox within w_con_produccion_comparativa_bases
end type
end forward

global type w_con_produccion_comparativa_bases from w_int_con_empresa
integer width = 4599
integer height = 2704
pb_imprimir pb_imprimir
gb_1 gb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
em_fdesde_ant em_fdesde_ant
em_fhasta_ant em_fhasta_ant
st_1 st_1
pb_4 pb_4
gb_2 gb_2
end type
global w_con_produccion_comparativa_bases w_con_produccion_comparativa_bases

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string articulo, sel
datetime fecha1, fecha2
datastore regs, regs2, regs3, regs4
long i, fila
dec piezas1, piezas1_ten, metros1, metros1_ten, piezas2, piezas2_ten, metros2, metros2_ten, importe1, importe1_ten, importe2, importe2_ten
dec var_piezas1, var_piezas2, var_metros1, var_metros2, var_importe1, var_importe2

dw_1.reset()
st_1.visible = True
st_1.text = "Consultando la base de datos"

//Base cliente - Periodo1
fecha1 = Datetime(em_fdesde.text)
fecha2 = Datetime(em_fhasta.text)
				
SELECT 
		sum(venlifac.cantidad) as piezas1, 
		sum((( formatos.ancho * formatos.largo ) / 10000 ) * venlifac.cantidad) as metros1 ,
		sum(venlifac.neto  /  venlifac.cambio) as importe1
		INTO :piezas1, :metros1, :importe1
FROM
		venlifac,
		articulos,
		formatos,
		art_codestadistico
WHERE
		venlifac.empresa = articulos.empresa AND
		venlifac.articulo = articulos.codigo AND
		venlifac.empresa = art_codestadistico.empresa AND
		venlifac.articulo = art_codestadistico.codigo AND
		articulos.empresa = formatos.empresa AND
		articulos.formato = formatos.codigo AND
		venlifac.ffactura >= :fecha1 AND
		venlifac.ffactura <= :fecha2  AND
		art_codestadistico.N = 'S';
						
st_1.text = "Consultando la base de datos."	

//Base cliente - Periodo2
fecha1 = Datetime(em_fdesde_ant.text)
fecha2 = Datetime(em_fhasta_ant.text)
SELECT 
		sum(venlifac.cantidad) as piezas2, 
		sum((( formatos.ancho * formatos.largo ) / 10000 ) * venlifac.cantidad) as metros2, 
		sum(venlifac.neto  /  venlifac.cambio) as importe2
		INTO :piezas2, :metros2, :importe2
FROM 
		venlifac, 
		articulos, 
		formatos, 
		art_codestadistico 
WHERE 
		venlifac.empresa = articulos.empresa AND 
		venlifac.articulo = articulos.codigo AND 
		venlifac.empresa = art_codestadistico.empresa AND 
		venlifac.articulo = art_codestadistico.codigo AND 
		articulos.empresa = formatos.empresa AND 
		articulos.formato = formatos.codigo AND 
		venlifac.ffactura >= :fecha1 AND 
		venlifac.ffactura <= :fecha2 AND 
		art_codestadistico.N = 'S';

st_1.text = "Consultando la base de datos.."

//Base Tencer - Periodo1
fecha1 = Datetime(em_fdesde.text)
fecha2 = Datetime(em_fhasta.text)
SELECT 
		sum(venlifac.cantidad) as piezas1, 
		sum((( formatos.ancho * formatos.largo ) / 10000 ) * venlifac.cantidad) as metros1, 
		sum(venlifac.neto  /  venlifac.cambio) as importe1 
		INTO :piezas1_ten, :metros1_ten, :importe1_ten
FROM 
		venlifac, 
		articulos, 
		formatos, 
		art_codestadistico 
WHERE 
		venlifac.empresa = articulos.empresa AND 
		venlifac.articulo = articulos.codigo AND 
		venlifac.empresa = art_codestadistico.empresa AND 
		venlifac.articulo = art_codestadistico.codigo AND 
		articulos.empresa = formatos.empresa AND 
		articulos.formato = formatos.codigo AND 
		venlifac.ffactura >= :fecha1 AND 
		venlifac.ffactura <= :fecha2 AND 
		art_codestadistico.N = 'N'; 

st_1.text = "Consultando la base de datos..."

//Base Tencer - Periodo2
fecha1 = Datetime(em_fdesde_ant.text)
fecha2 = Datetime(em_fhasta_ant.text)
SELECT 
		sum(venlifac.cantidad) as piezas2, 
		sum((( formatos.ancho * formatos.largo ) / 10000 ) * venlifac.cantidad) as metros2, 
		sum(venlifac.neto  /  venlifac.cambio) as importe2 
		INTO :piezas2_ten, :metros2_ten, :importe2_ten
FROM 
		venlifac, 
		articulos, 
		formatos, 
		art_codestadistico 
WHERE 
		venlifac.empresa = articulos.empresa AND 
		venlifac.articulo = articulos.codigo AND 
		venlifac.empresa = art_codestadistico.empresa AND 
		venlifac.articulo = art_codestadistico.codigo AND 
		articulos.empresa = formatos.empresa AND 
		articulos.formato = formatos.codigo AND 
		venlifac.ffactura >= :fecha1 AND 
		venlifac.ffactura <= :fecha2  AND 
		art_codestadistico.N = 'N';

st_1.text = "Consultando la base de datos...."

dw_1.object.seccion[1] = "Base Cliente"
dw_1.object.piezas1[1] = piezas1
dw_1.object.metros1[1] = metros1
dw_1.object.importe1[1] = importe1

dw_1.object.piezas2[1] = piezas2
dw_1.object.metros2[1] = metros2
dw_1.object.importe2[1] = importe2

dw_1.object.seccion_ten[1] = "Base Tencer"
dw_1.object.piezas1_ten[1] = piezas1_ten
dw_1.object.metros1_ten[1] = metros1_ten
dw_1.object.importe1_ten[1] = importe1_ten

dw_1.object.piezas2_ten[1] = piezas2_ten
dw_1.object.metros2_ten[1] = metros2_ten
dw_1.object.importe2_ten[1] = importe2_ten

dw_1.object.seccion_tot[1] = "Totales"

if piezas1 <> 0 then
	dw_1.object.var_piezas[1] = (piezas2 - piezas1) / piezas1*100
else
	dw_1.object.var_piezas[1] = 0
end if
if piezas1_ten <> 0 then
	dw_1.object.var_piezas2[1] = (piezas2_ten - piezas1_ten) / piezas1_ten * 100
else
	dw_1.object.var_piezas2[1] = 0
end if

if metros1 <> 0 then
	dw_1.object.var_metros[1] = (metros2 - metros1) / metros1 * 100
else
	dw_1.object.var_metros[1] = 0
end if
if metros1_ten <> 0 then
	dw_1.object.var_metros2[1] = (metros2_ten - metros1_ten) / metros1_ten * 100
else
	dw_1.object.var_metros2[1] = 0
end if

if importe1 <> 0 then
	dw_1.object.var_importe[1] = (importe2 - importe1) / importe1 * 100
else
	dw_1.object.var_importe[1] = 0
end if
if importe1_ten <> 0 then
	dw_1.object.var_importe2[1] = (importe2_ten - importe1_ten) / importe1_ten * 100
else
	dw_1.object.var_importe2[1] = 0
end if

st_1.text = "Consulta finalizada"	
st_1.textcolor = RGB(0,200,0)

dw_1.object.t_1.text = em_fdesde.text+" / "+em_fhasta.text
dw_1.object.t_2.text = em_fdesde_ant.text+" / "+em_fhasta_ant.text

end subroutine

on w_con_produccion_comparativa_bases.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.em_fdesde_ant=create em_fdesde_ant
this.em_fhasta_ant=create em_fhasta_ant
this.st_1=create st_1
this.pb_4=create pb_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.em_fdesde
this.Control[iCurrent+4]=this.em_fhasta
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.em_fdesde_ant
this.Control[iCurrent+9]=this.em_fhasta_ant
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.pb_4
this.Control[iCurrent+12]=this.gb_2
end on

on w_con_produccion_comparativa_bases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.em_fdesde_ant)
destroy(this.em_fhasta_ant)
destroy(this.st_1)
destroy(this.pb_4)
destroy(this.gb_2)
end on

event open;call super::open;integer permiso
String anyo, anyo_ant

istr_parametros.s_titulo_ventana =   "Comparativa de artículos sobre base de cliente frente a base Tencer"
//istr_parametros.s_listado        =   "dw_con_porduccion_secciones_lineas"
This.title                       =   istr_parametros.s_titulo_ventana

em_fdesde.setfocus()

//em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
anyo = String(Year(today())-1)
anyo_ant = String(Year(today())-2)
em_fhasta.text = string("31/12/"+anyo_ant)
em_fdesde.text = string("01/01/"+anyo_ant)
em_fhasta_ant.text = string("31/12/"+anyo)
em_fdesde_ant.text = string("01/01/"+anyo)

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
	case 1
//		menu_planificacion.m_archivo.m_grabar.disable()
//		menu_planificacion.m_herramientas.m_borrarseleccin.disable()
//		menu_planificacion.m_herramientas.m_moverantes.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_herramientas.m_borrarot.disable()
//		menu_planificacion.m_herramientas.m_moverdespus.disable()
//		menu_planificacion.m_procesos.disable()
//		menu_planificacion.m_procesos.m_generar1.disable()
//		menu_planificacion.m_seleccionar.disable()
//		menu_planificacion.m_listados.disable()
end choose



end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_produccion_comparativa_bases
integer x = 718
integer y = 1096
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_produccion_comparativa_bases
boolean visible = false
integer x = 1253
integer y = 1752
integer width = 178
integer height = 96
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_produccion_comparativa_bases
integer x = 46
integer y = 8
integer width = 4357
integer height = 80
integer textsize = -9
end type

type pb_imprimir from upb_imprimir within w_con_produccion_comparativa_bases
event clicked pbm_bnclicked
boolean visible = false
integer x = 3616
integer y = 136
integer width = 123
integer height = 104
integer taborder = 0
boolean enabled = false
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type gb_1 from groupbox within w_con_produccion_comparativa_bases
integer x = 46
integer y = 96
integer width = 805
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo 1"
end type

type em_fdesde from u_em_campo within w_con_produccion_comparativa_bases
integer x = 82
integer y = 156
integer width = 361
integer height = 80
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_produccion_comparativa_bases
integer x = 462
integer y = 156
integer width = 361
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_1 from datawindow within w_con_produccion_comparativa_bases
integer x = 46
integer y = 272
integer width = 4494
integer height = 2224
string dataobject = "dw_con_produccion_comp_bases1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_produccion_comparativa_bases
integer x = 4014
integer y = 144
integer width = 389
integer height = 96
integer taborder = 50
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_produccion_comparativa_bases
integer x = 4430
integer y = 20
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type em_fdesde_ant from u_em_campo within w_con_produccion_comparativa_bases
integer x = 914
integer y = 156
integer width = 361
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta_ant from u_em_campo within w_con_produccion_comparativa_bases
integer x = 1298
integer y = 156
integer width = 366
integer height = 80
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_1 from statictext within w_con_produccion_comparativa_bases
boolean visible = false
integer x = 1765
integer y = 140
integer width = 2185
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_4 from upb_imprimir within w_con_produccion_comparativa_bases
integer x = 4425
integer y = 144
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean originalsize = false
string powertiptext = "Imprimir ficha técnica."
end type

event clicked;call super::clicked;f_imprimir_datawindow(dw_1)
end event

type gb_2 from groupbox within w_con_produccion_comparativa_bases
integer x = 882
integer y = 96
integer width = 805
integer height = 156
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Periodo 2"
end type

