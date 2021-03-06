$PBExportHeader$w_con_facturacion_por_colecciones.srw
forward
global type w_con_facturacion_por_colecciones from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturacion_por_colecciones
end type
type pb_2 from upb_imprimir within w_con_facturacion_por_colecciones
end type
type cb_1 from commandbutton within w_con_facturacion_por_colecciones
end type
type gb_6 from groupbox within w_con_facturacion_por_colecciones
end type
type dw_resumen from datawindow within w_con_facturacion_por_colecciones
end type
type uo_cliente from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type uo_g1 from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type uo_g2 from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type uo_g3 from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type uo_g4 from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type ddlb_pt from dropdownlistbox within w_con_facturacion_por_colecciones
end type
type ddlb_nc from dropdownlistbox within w_con_facturacion_por_colecciones
end type
type ddlb_av from dropdownlistbox within w_con_facturacion_por_colecciones
end type
type uo_ct from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type uo_rl from u_em_campo_2 within w_con_facturacion_por_colecciones
end type
type ddlb_n from dropdownlistbox within w_con_facturacion_por_colecciones
end type
type st_3 from statictext within w_con_facturacion_por_colecciones
end type
type st_4 from statictext within w_con_facturacion_por_colecciones
end type
type gb_4 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_125 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_20 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_18 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_16 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_13 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_11 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_10 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_9 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_7 from groupbox within w_con_facturacion_por_colecciones
end type
type gb_1 from groupbox within w_con_facturacion_por_colecciones
end type
end forward

global type w_con_facturacion_por_colecciones from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4690
integer height = 2732
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_cliente uo_cliente
uo_g1 uo_g1
uo_g2 uo_g2
uo_g3 uo_g3
uo_g4 uo_g4
ddlb_pt ddlb_pt
ddlb_nc ddlb_nc
ddlb_av ddlb_av
uo_ct uo_ct
uo_rl uo_rl
ddlb_n ddlb_n
st_3 st_3
st_4 st_4
gb_4 gb_4
gb_125 gb_125
gb_20 gb_20
gb_18 gb_18
gb_16 gb_16
gb_13 gb_13
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_7 gb_7
gb_1 gb_1
end type
global w_con_facturacion_por_colecciones w_con_facturacion_por_colecciones

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, codestadistico
string g1, g2, g3, g4, pt, nc, rect, av, pl, ct, tm, n


if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
else
	v_cliente = uo_cliente.em_codigo.text
end if


data.SetTransObject(SQLCA)
data.Reset()

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22


if uo_g1.em_campo.text <> "" and not isnull(uo_g1.em_campo.text) then
	g1 = uo_g1.em_campo.text
	codestadistico = codestadistico + "   G1: "+uo_g1.em_campo.text
else
	g1 = '%' // Codición que siempre se cumplirá
end if
if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	g2 = uo_g2.em_campo.text
	codestadistico = codestadistico + "   G2: "+uo_g2.em_campo.text
else
	g2 = '%' // Codición que siempre se cumplirá
end if
if uo_g3.em_campo.text <> "" and not isnull(uo_g3.em_campo.text) then
	g3 = uo_g3.em_campo.text
	codestadistico = codestadistico + "   G3: "+uo_g3.em_campo.text
else
	g3 = '%' // Codición que siempre se cumplirá
end if
if uo_g4.em_campo.text <> "" and not isnull(uo_g4.em_campo.text) then
	g4 = uo_g4.em_campo.text
	codestadistico = codestadistico + "   G4: "+uo_g4.em_campo.text
else
	g4 = '%' // Codición que siempre se cumplirá
end if
if (ddlb_pt.text = "Todo" or ddlb_pt.text = "" ) then
	pt = '%' // Codición que siempre se cumplirá
else
	pt = ddlb_pt.text
	codestadistico = codestadistico + "   PT: "+ddlb_pt.text
	
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	nc = '%' // Codición que siempre se cumplirá
else
	nc = ddlb_nc.text
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
end if

if (ddlb_av.text = "Todo" or ddlb_av.text = "" ) then
	av = '%' // Codición que siempre se cumplirá
else
	av = ddlb_av.text
	codestadistico = codestadistico + "   AV: "+ddlb_av.text
end if
if uo_ct.em_campo.text <> "" and not isnull(uo_ct.em_campo.text) then
	ct = uo_ct.em_campo.text
	codestadistico = codestadistico + "   CT: "+uo_ct.em_campo.text
else
	ct = '%' // Codición que siempre se cumplirá
end if
if uo_rl.em_campo.text <> "" and not isnull(uo_rl.em_campo.text) then
	tm = uo_rl.em_campo.text
	codestadistico = codestadistico + "   RL: "+uo_rl.em_campo.text
else
	tm = '%' // Codición que siempre se cumplirá
end if
if (ddlb_n.text = "Todo" or ddlb_n.text = "" ) then
	n = '%' // Codición que siempre se cumplirá
else
	n = ddlb_n.text
	codestadistico = codestadistico + "   N: "+ddlb_n.text
end if

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22


data.Retrieve(codigo_empresa, v_cliente, g1, g2, g3, g4, pt, nc, av, ct, tm, n)


/*
string filtro, seccion, linea, turno, articulo, formato
string restriccion_cliente, restriccion_g1, restriccion_g2, restriccion_g3, restriccion_g4
string restriccion_pt, restriccion_nc, restriccion_n , restriccion_rect, restriccion_pant
string restriccion_av, restriccion_pl, restriccion_ct, restriccion_en, restriccion_rl
string restriccion_global, restriccion_coleccion
datetime fecha1, fecha2
string general, codestadistico

dw_1.reset()
if cbx_2.checked then
	dw_1.Modify("DataWindow.Trailer.4.Height=0") 
	dw_1.Modify("DataWindow.Detail.Height=0") 
end if

fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.st_fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text	
	general = general + "Articulo: "+uo_articulo.em_campo.text
end if

if uo_formato.em_codigo.text = "" or isnull(uo_formato.em_codigo.text) then
	formato = "%"
else
	formato = uo_formato.em_codigo.text
	general = general + "   Formato: "+uo_formato.em_campo.text
end if

if uo_cliente.em_campo.text <> "" and not isnull(uo_cliente.em_campo.text) then
	restriccion_cliente = "(articulos_cliente = '"+uo_cliente.em_codigo.text+"' )"
	general = general + "   Cliente: "+uo_cliente.em_campo.text	
else
	restriccion_cliente = '((1=1) or  (isnull(articulos_cliente)))' // Codición que siempre se cumplirá
end if

if uo_coleccion.em_campo.text <> "" and not isnull(uo_coleccion.em_campo.text) then
	restriccion_coleccion = "(articulos_coleccion = '"+uo_coleccion.em_codigo.text+"' )"
	general = general + "   Colección: "+uo_coleccion.em_campo.text	
else
	restriccion_coleccion = '((1=1) or  (isnull(articulos_coleccion)))' // Codición que siempre se cumplirá
end if

if uo_g1.em_campo.text <> "" and not isnull(uo_g1.em_campo.text) then
	restriccion_g1 = "(art_codestadistico_g1 = '"+uo_g1.em_campo.text+"')"
	codestadistico = codestadistico + "   G1: "+uo_g1.em_campo.text
else
	restriccion_g1 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	restriccion_g2 = "(art_codestadistico_g2 = '"+uo_g2.em_campo.text+"')"
	codestadistico = codestadistico + "   G2: "+uo_g2.em_campo.text	
else
	restriccion_g2 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g3.em_campo.text <> "" and not isnull(uo_g3.em_campo.text) then
	restriccion_g3 = "(art_codestadistico_g3 = '"+uo_g3.em_campo.text+"')"
	codestadistico = codestadistico + "   G3: "+uo_g3.em_campo.text
else
	restriccion_g3 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g4.em_campo.text <> "" and not isnull(uo_g4.em_campo.text) then
	restriccion_g4 = "(art_codestadistico_g4 = '"+uo_g4.em_campo.text+"')"
	codestadistico = codestadistico + "   G4: "+uo_g4.em_campo.text
else
	restriccion_g4 = '1=1' // Codición que siempre se cumplirá
end if

//choose case ddlb_global.text
//	case "Todo"
//		restriccion_global = '1=1' 
//		general = general + "   Todo "
//	case ""
//		restriccion_global = '1=1' 
//		general = general + "   Todo "
//	case "Acabado"
//		restriccion_global = " (art_codestadistico_g2 <> 'N')  and (art_codestadistico_g2 <> 'B') and (art_codestadistico_g2 <> 'Z') "
//		general = general + "   Acabado "
//	case "Intermedio"
//		restriccion_global = " ((art_codestadistico_g2 = 'N') or (art_codestadistico_g2 = 'B') or (art_codestadistico_g2 = 'Z')) "
//		general = general + "   Intermedio "
//	case "Base"
//		restriccion_global = " ((art_codestadistico_g2 = 'N') or (art_codestadistico_g2 = 'B') or (art_codestadistico_g2 = 'Z')) "
//		general = general + "   Base "
//		
//end choose 

choose case ddlb_global.text
	case "Todo"
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case ""
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case "Acabado"
		restriccion_global = " (articulos_uso = '3' ) "
		general = general + "   Acabado "
	case "Intermedio"
		restriccion_global = "  (articulos_uso = '2' ) " 
		general = general + "   Intermedio "
	case "Base"
		restriccion_global = " (articulos_uso = '1' ) "
		general = general + "   Base "		
end choose 
		
if (ddlb_pt.text = "Todo" or ddlb_pt.text = "" ) then
	restriccion_pt = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pt = "(art_codestadistico_pt = '"+ddlb_pt.text+"')"
	codestadistico = codestadistico + "   PT: "+ddlb_pt.text
	
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	restriccion_nc = '1=1' // Codición que siempre se cumplirá
else
	restriccion_nc = "(art_codestadistico_nc = '"+ddlb_nc.text+"')"
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
end if

if (ddlb_av.text = "Todo" or ddlb_av.text = "" ) then
	restriccion_av = '1=1' // Codición que siempre se cumplirá
else
	restriccion_av = "(art_codestadistico_av = '"+ddlb_av.text+"')"
	codestadistico = codestadistico + "   AV: "+ddlb_av.text
end if

if (ddlb_pl.text = "Todo" or ddlb_pl.text = "" ) then
	restriccion_pl = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pl = "(art_codestadistico_pl = '"+ddlb_pl.text+"')"
	codestadistico = codestadistico + "   PL: "+ddlb_pl.text
end if

if (ddlb_n.text = "Todo" or ddlb_n.text = "" ) then
	restriccion_n = '1=1' // Codición que siempre se cumplirá
else
	restriccion_n = "(art_codestadistico_n = '"+ddlb_n.text+"')"
	codestadistico = codestadistico + "   N: "+ddlb_n.text
end if

if uo_ct.em_campo.text <> "" and not isnull(uo_ct.em_campo.text) then
	restriccion_ct = "(art_codestadistico_ct = '"+uo_ct.em_campo.text+"')"
	codestadistico = codestadistico + "   CT: "+uo_ct.em_campo.text
else
	restriccion_ct = '1=1' // Codición que siempre se cumplirá
end if

if uo_en.em_campo.text <> "" and not isnull(uo_en.em_campo.text) then
	restriccion_en = "(art_codestadistico_en = '"+uo_en.em_campo.text+"')"
	codestadistico = codestadistico + "   EN: "+uo_en.em_campo.text
else
	restriccion_en = '1=1' // Codición que siempre se cumplirá
end if

if uo_rl.em_campo.text <> "" and not isnull(uo_rl.em_campo.text) then
	restriccion_rl = "(art_codestadistico_tm = '"+uo_rl.em_campo.text+"')"
	codestadistico = codestadistico + "   RL: "+uo_rl.em_campo.text
else
	restriccion_rl = '1=1' // Codición que siempre se cumplirá
end if

if (ddlb_rectificado.text = "Todo" or ddlb_rectificado.text = "" ) then
	restriccion_rect = '1=1' // Codición que siempre se cumplirá
else
	restriccion_rect = "(art_codestadistico_rectificado = '"+ddlb_rectificado.text+"')"
	codestadistico = codestadistico + "   Rectificado: "+ddlb_rectificado.text
end if

if sle_cod_pantallas.text = '' or isnull(sle_cod_pantallas.text) then
	restriccion_pant = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pant = "(articulos_codigo_pantallas like '"+sle_cod_pantallas.text+"%')"
	codestadistico = codestadistico + "   codigo Pantallas: "+sle_cod_pantallas.text
end if

dw_1.object.general.text = general
dw_1.object.codestadistico.text = codestadistico

filtro = ""
filtro = restriccion_cliente+" and "+ &
			restriccion_global+" and "+ &
			restriccion_coleccion+" and "+ &
			restriccion_g1+" and "+ &
			restriccion_g2+" and "+ &
			restriccion_g3+" and "+ &
			restriccion_g4+" and "+ &
			restriccion_pt+" and "+ &
			restriccion_nc+" and "+ &
			restriccion_av+" and "+ &
			restriccion_pl+" and "+ &
			restriccion_pant+" and "+ &
			restriccion_ct+" and "+ &
			restriccion_en+" and "+ &
			restriccion_rl+" and "+ &
			restriccion_rect+" and "+ &
			restriccion_n

			
dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.Retrieve(codigo_empresa,fecha1, fecha2, articulo, formato)



if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
*/
end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Ventas por Colecciones de Diseño."
This.title=istr_parametros.s_titulo_ventana


//em_anyo.text = string (year(today()))
end event

on w_con_facturacion_por_colecciones.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.uo_g1=create uo_g1
this.uo_g2=create uo_g2
this.uo_g3=create uo_g3
this.uo_g4=create uo_g4
this.ddlb_pt=create ddlb_pt
this.ddlb_nc=create ddlb_nc
this.ddlb_av=create ddlb_av
this.uo_ct=create uo_ct
this.uo_rl=create uo_rl
this.ddlb_n=create ddlb_n
this.st_3=create st_3
this.st_4=create st_4
this.gb_4=create gb_4
this.gb_125=create gb_125
this.gb_20=create gb_20
this.gb_18=create gb_18
this.gb_16=create gb_16
this.gb_13=create gb_13
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_7=create gb_7
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.uo_g1
this.Control[iCurrent+8]=this.uo_g2
this.Control[iCurrent+9]=this.uo_g3
this.Control[iCurrent+10]=this.uo_g4
this.Control[iCurrent+11]=this.ddlb_pt
this.Control[iCurrent+12]=this.ddlb_nc
this.Control[iCurrent+13]=this.ddlb_av
this.Control[iCurrent+14]=this.uo_ct
this.Control[iCurrent+15]=this.uo_rl
this.Control[iCurrent+16]=this.ddlb_n
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.gb_125
this.Control[iCurrent+21]=this.gb_20
this.Control[iCurrent+22]=this.gb_18
this.Control[iCurrent+23]=this.gb_16
this.Control[iCurrent+24]=this.gb_13
this.Control[iCurrent+25]=this.gb_11
this.Control[iCurrent+26]=this.gb_10
this.Control[iCurrent+27]=this.gb_9
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.gb_1
end on

on w_con_facturacion_por_colecciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.uo_g1)
destroy(this.uo_g2)
destroy(this.uo_g3)
destroy(this.uo_g4)
destroy(this.ddlb_pt)
destroy(this.ddlb_nc)
destroy(this.ddlb_av)
destroy(this.uo_ct)
destroy(this.uo_rl)
destroy(this.ddlb_n)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_4)
destroy(this.gb_125)
destroy(this.gb_20)
destroy(this.gb_18)
destroy(this.gb_16)
destroy(this.gb_13)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_7)
destroy(this.gb_1)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturacion_por_colecciones
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturacion_por_colecciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturacion_por_colecciones
integer y = 8
integer width = 4430
integer height = 88
boolean italic = true
end type

type pb_1 from upb_salir within w_con_facturacion_por_colecciones
integer x = 4466
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_facturacion_por_colecciones
integer x = 4453
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_facturacion_por_colecciones
integer x = 4155
integer y = 140
integer width = 288
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	
	f_control(dw_resumen)
	

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type gb_6 from groupbox within w_con_facturacion_por_colecciones
integer x = 4137
integer y = 100
integer width = 462
integer height = 160
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_resumen from datawindow within w_con_facturacion_por_colecciones
integer x = 27
integer y = 284
integer width = 4571
integer height = 2124
integer taborder = 70
string dataobject = "dw_con_ventas_colecciones"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 37
integer y = 144
integer width = 1573
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type uo_g1 from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 1701
integer y = 148
integer width = 142
integer height = 68
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g1.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g1.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo1
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g1.em_campo.text = descripcion
IF Trim(uo_g1.em_campo.text)="" THEN 
 IF Trim(uo_g1.em_codigo.text)<>"" Then uo_g1.em_campo.SetFocus()
 uo_g1.em_campo.text=""
 uo_g1.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G1"
ue_datawindow = "dw_ayuda_art_grupo1"
ue_filtro     = ""

end event

type uo_g2 from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 1865
integer y = 148
integer width = 169
integer height = 68
integer taborder = 90
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g2.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g2.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo2
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g2.em_campo.text = descripcion
IF Trim(uo_g2.em_campo.text)="" THEN 
 IF Trim(uo_g2.em_codigo.text)<>"" Then uo_g2.em_campo.SetFocus()
 uo_g2.em_campo.text=""
 uo_g2.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G2"
ue_datawindow = "dw_ayuda_art_grupo2"
ue_filtro     = ""

end event

type uo_g3 from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 2048
integer y = 148
integer width = 142
integer height = 68
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g3.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g3.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo3
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g3.em_campo.text = descripcion
IF Trim(uo_g3.em_campo.text)="" THEN 
 IF Trim(uo_g3.em_codigo.text)<>"" Then uo_g3.em_campo.SetFocus()
 uo_g3.em_campo.text=""
 uo_g3.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G3"
ue_datawindow = "dw_ayuda_art_grupo3"
ue_filtro     = ""

end event

type uo_g4 from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 2213
integer y = 148
integer width = 142
integer height = 68
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g4.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g4.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo4
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g4.em_campo.text = descripcion
IF Trim(uo_g4.em_campo.text)="" THEN 
 IF Trim(uo_g4.em_codigo.text)<>"" Then uo_g4.em_campo.SetFocus()
 uo_g4.em_campo.text=""
 uo_g4.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G4"
ue_datawindow = "dw_ayuda_art_grupo4"
ue_filtro     = ""

end event

type ddlb_pt from dropdownlistbox within w_con_facturacion_por_colecciones
integer x = 2377
integer y = 144
integer width = 224
integer height = 336
integer taborder = 150
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","R","B","P"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_nc from dropdownlistbox within w_con_facturacion_por_colecciones
integer x = 2638
integer y = 144
integer width = 224
integer height = 484
integer taborder = 160
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","0","1","2","3","4","5"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_av from dropdownlistbox within w_con_facturacion_por_colecciones
integer x = 2898
integer y = 144
integer width = 224
integer height = 420
integer taborder = 170
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","1","2","3","4","5"}
borderstyle borderstyle = stylelowered!
end type

type uo_ct from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 3163
integer y = 148
integer width = 142
integer height = 68
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_ct.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_ct.em_codigo.text

select descripcion_abr
into :descripcion
from art_cortes
where empresa = :codigo_empresa
and codigo = :codigo;

uo_ct.em_campo.text = descripcion
IF Trim(uo_ct.em_campo.text)="" THEN 
 IF Trim(uo_ct.em_codigo.text)<>"" Then uo_ct.em_campo.SetFocus()
 uo_ct.em_campo.text=""
 uo_ct.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Cortes"
ue_datawindow = "dw_ayuda_art_cortes"
ue_filtro     = ""

end event

type uo_rl from u_em_campo_2 within w_con_facturacion_por_colecciones
event destroy ( )
integer x = 3346
integer y = 148
integer width = 142
integer height = 68
integer taborder = 140
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_rl.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_rl.em_codigo.text

select descripcion_abr
into :descripcion
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :codigo;

uo_rl.em_campo.text = descripcion
IF Trim(uo_rl.em_campo.text)="" THEN 
 IF Trim(uo_rl.em_codigo.text)<>"" Then uo_rl.em_campo.SetFocus()
 uo_rl.em_campo.text=""
 uo_rl.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Relieve"
ue_datawindow = "dw_ayuda_art_tipomoldura"
ue_filtro     = ""

end event

type ddlb_n from dropdownlistbox within w_con_facturacion_por_colecciones
integer x = 3525
integer y = 148
integer width = 279
integer height = 332
integer taborder = 150
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","S","N"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_con_facturacion_por_colecciones
integer x = 46
integer y = 2416
integer width = 1349
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "No incluye facturas ajenas a la activdad."
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_facturacion_por_colecciones
integer x = 46
integer y = 2464
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "Incluye todos los dtos excepto rappel y dtopp."
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_con_facturacion_por_colecciones
integer x = 18
integer y = 100
integer width = 1614
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_125 from groupbox within w_con_facturacion_por_colecciones
integer x = 3511
integer y = 100
integer width = 302
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "B. Cliente"
end type

type gb_20 from groupbox within w_con_facturacion_por_colecciones
integer x = 3333
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "RL"
end type

type gb_18 from groupbox within w_con_facturacion_por_colecciones
integer x = 3150
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "CT"
end type

type gb_16 from groupbox within w_con_facturacion_por_colecciones
integer x = 2885
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "AV"
end type

type gb_13 from groupbox within w_con_facturacion_por_colecciones
integer x = 2624
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "NC"
end type

type gb_11 from groupbox within w_con_facturacion_por_colecciones
integer x = 2363
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "PT"
end type

type gb_10 from groupbox within w_con_facturacion_por_colecciones
integer x = 2199
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G4"
end type

type gb_9 from groupbox within w_con_facturacion_por_colecciones
integer x = 2034
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G3"
end type

type gb_7 from groupbox within w_con_facturacion_por_colecciones
integer x = 1847
integer y = 100
integer width = 197
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G2"
end type

type gb_1 from groupbox within w_con_facturacion_por_colecciones
integer x = 1687
integer y = 100
integer width = 169
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G1"
end type

